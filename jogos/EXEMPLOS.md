# Exemplos para observar e adaptar

Os quatro exemplos pequenos são independentes. Todos usam a mesma engine,
um jogador ciano, formas simples e os controles da base. Megamania continua
disponível como referência de um jogo mais completo.

## Escolher e executar

Abra a raiz completa da pasta `meu-jogo`. Em **Executar e Depurar**, selecione
um exemplo e pressione **F5**. Não é necessário alterar código, Gradle ou a
configuração da janela para trocar de exemplo.

| Configuração F5 | Pasta e guia | Alternativa no PowerShell |
| --- | --- | --- |
| Exemplo — Mapa e câmera | [exemplo-mapa](exemplo-mapa/README.md) | `.\gradlew.bat mapa` |
| Exemplo — Salas conectadas | [exemplo-salas](exemplo-salas/README.md) | `.\gradlew.bat salas` |
| Exemplo — Chave e porta | [exemplo-chave-porta](exemplo-chave-porta/README.md) | `.\gradlew.bat chave-porta` |
| Exemplo — Inimigo em patrulha | [exemplo-patrulha](exemplo-patrulha/README.md) | `.\gradlew.bat patrulha` |

Linux/macOS: use `./gradlew` no lugar de `.\gradlew.bat`. Setas/WASD movem,
R reinicia, Esc fecha e F11 alterna tela cheia. Enter interage nas salas e na
porta. Pare a execução anterior antes de abrir outro exemplo.

O suporte Java do VS Code precisa concluir a importação dos projetos. Se as
novas opções não aparecerem na sua cópia antiga, abra o novo ZIP em **outra
pasta**, somente para consulta. Preserve seu jogo e suas configurações atuais.

## Estudar um comportamento

1. Execute e observe o roteiro do README daquele exemplo.
2. Abra a classe `Jogo...` e siga a chamada de atualização até `modelo/`.
3. Localize quem guarda o estado, quem aplica a regra e quem desenha o resultado.
4. Execute os testes do exemplo. Eles criam o modelo sem abrir uma janela.
5. Faça uma pequena alteração sugerida no guia e compare o resultado.

Os exemplos pequenos não dependem uns dos outros nem do Megamania. As classes
de mesmo nome em pastas distintas pertencem a pacotes diferentes. Essa repetição
permite ler cada demonstração inteira sem procurar uma biblioteca de regras
compartilhadas.

## Levar para seu jogo

Escolha o comportamento de que você precisa. Não é necessário incorporar os
quatro exemplos ou substituir seu projeto por um deles.

- Leia no guia as classes necessárias e as adaptações previstas.
- Ao copiar uma classe para `src/main/java/meujogo/`, ajuste `package` e imports.
  Se você já tem um `Jogador`, adapte a colaboração ao seu objeto existente;
  não crie um segundo jogador sem necessidade.
- Integre a atualização ao ciclo existente e o desenho à apresentação existente.
  Use os mesmos objetos nos dois caminhos e inclua seu estado no reinício.
- Adapte os testes ao seu domínio e preserve as regras que já funcionavam.
- Não copie `engine/`, `build.gradle`, `settings.gradle` ou `.vscode` por cima do
  projeto em andamento. Eles fornecem a execução dos exemplos, não sua mecânica.

## Conferir os exemplos

**Terminal → Executar Tarefa → Verificar todos os jogos e exemplos**, ou:

```powershell
.\gradlew.bat verificar
```

Para conferir um só, por exemplo: `.\gradlew.bat :exemplo-mapa:test`.
Linux/macOS: `./gradlew :exemplo-mapa:test`. A configuração de JUnit já vem
preparada. Os exemplos usam a engine e as dependências já existentes na base.
