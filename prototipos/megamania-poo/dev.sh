#!/usr/bin/env bash
# Desenvolvimento no Linux/macOS, sem dependências além das usadas por gradlew.
set -u
set -o pipefail

cd -- "$(dirname -- "$0")" || exit 1

if (( $# > 1 )) || { (( $# == 1 )) && [[ "$1" != base ]]; }; then
    echo "Uso: ./dev.sh [base]" >&2
    exit 1
fi

jogo_pid=

parar_jogo() {
    if [[ -n "$jogo_pid" ]]; then
        kill "$jogo_pid" 2>/dev/null || true
        wait "$jogo_pid" 2>/dev/null || true
        jogo_pid=
    fi
}

trap parar_jogo EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

# O conteúdo detecta também arquivos criados, removidos e salvamentos rápidos.
estado_fontes() {
    {
        find src/main -type f -exec cksum {} +
        cksum build.gradle settings.gradle gradle/wrapper/gradle-wrapper.properties
    } | LC_ALL=C sort | cksum
}

echo "[dev] Observando src/main e configuração do Gradle. Ctrl+C para encerrar."
echo "[dev] Cada alteração salva recompila e abre uma partida nova."
estado_aplicado=

while true; do
    estado=$(estado_fontes) || exit 1
    if [[ "$estado" != "$estado_aplicado" ]]; then
        # Aguarda os arquivos estabilizarem antes de compilar um salvamento.
        sleep 1
        estado_estavel=$(estado_fontes) || exit 1
        if [[ "$estado" != "$estado_estavel" ]]; then
            continue
        fi

        parar_jogo
        estado_aplicado=$estado
        echo "[dev] Compilando o código salvo..."
        if ./gradlew --console=plain installDist; then
            # Uma edição durante a compilação exige outra compilação antes de abrir.
            estado_atual=$(estado_fontes) || exit 1
            if [[ "$estado_atual" != "$estado_aplicado" ]]; then
                continue
            fi
            echo "[dev] Abrindo o jogo atualizado."
            ./build/install/megamania-poo/bin/megamania-poo "$@" &
            jogo_pid=$!
        else
            echo "[dev] Compilação falhou. Corrija o código e salve para tentar novamente." >&2
        fi
    fi

    if [[ -n "$jogo_pid" ]] && ! kill -0 "$jogo_pid" 2>/dev/null; then
        wait "$jogo_pid"
        resultado=$?
        jogo_pid=
        echo "[dev] Jogo encerrado."
        exit "$resultado"
    fi
    sleep 1
done
