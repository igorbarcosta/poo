# Validação da base de desenvolvimento

## Escopo executado

Esta preparação valida a distribuição inicial; não aprova os requisitos de
um laboratório nem afirma compatibilidade com todos os computadores da turma.

| Verificação | Resultado |
| --- | --- |
| Compilação e testes em Linux/WSL, JDK Temurin 25.0.5 | Passou: cinco testes do jogo inicial e 14 testes do Megamania, sem falhas. |
| ZIP extraído para pasta nova com espaços, Linux | Compilação, testes e geração dos dois executáveis passaram sem depender do caminho original. |
| ZIP extraído para pasta local nova com espaços, Windows, JDK Oracle 24.0.2 | `gradlew.bat --offline --console=plain --no-daemon verificar installDist :exemplo-megamania:installDist` passou; os mesmos 19 testes passaram. |
| Execução gráfica em Linux, tela virtual X11 de 1280 × 960 | Os dois jogos abriram e encerraram normalmente. |
| Jogo inicial a partir do ZIP | Movimento por seta, reinício por R e encerramento por Esc conferidos. |
| Megamania a partir do ZIP | Início por Enter, pausa estável, retomada e saída por Esc conferidos; disparos e reinício também exercitados e inspecionados. |
| Conteúdo do pacote | Wrapper, configuração da IDE, código, testes, fonte e licença presentes; sem caches, classes compiladas ou pastas geradas de IDE. |
| Permissões no ZIP | `gradlew` e `jogar.sh` têm permissão de execução Unix explícita, inclusive quando o ZIP for gerado no Windows. |
| Separação de dependências | Jogo inicial e Megamania não importam libGDX; ambos dependem da mesma engine. |
| Configuração do VS Code | JSONs de execução, testes, preferências e extensões conferidos; sem caminhos absolutos de JDK ou máquina do professor. |

Os testes foram executados com as dependências disponíveis em cache. Uma
máquina sem esse cache precisa de rede na primeira importação ou execução.
O ZIP não é uma distribuição completamente offline e não inclui JDK.

## Limites observados

- F5 e os botões de testes não foram exercitados dentro do VS Code do Windows.
  Conferir a importação e as duas configurações de execução na máquina da turma.
- A janela não foi exercitada no Windows ou macOS nesta preparação. A execução
  gráfica em Linux não substitui essa verificação.
- O cache Gradle pelo compartilhamento de rede WSL apresentou falha de locks
  no Windows; a validação passou com projeto e cache em pasta local do Windows.
  As instruções de início usam extração local.
- Nenhuma política do PowerShell foi alterada. O caminho de comandos da base
  usa o wrapper `.bat`, sem scripts PowerShell ou mudança de política de execução.

## Reproduzir

Use `gradlew.bat verificar prepararDistribuicao` no Windows ou
`./gradlew verificar prepararDistribuicao` no Linux/macOS. Extraia o ZIP para
uma pasta nova e siga os passos de [Preparação docente](PREPARACAO-DOCENTE.md).
Os cinco testes iniciais estão disponíveis para a evolução do projeto do aluno;
os 14 testes adicionais pertencem ao exemplo Megamania.
