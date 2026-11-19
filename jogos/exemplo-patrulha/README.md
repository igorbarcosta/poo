# Exemplo — Inimigo em patrulha

Na raiz da pasta `meu-jogo`, selecione **Exemplo — Inimigo em patrulha** em
**Executar e Depurar** e pressione **F5**. Alternativa no PowerShell:

```powershell
.\gradlew.bat patrulha
```

Linux/macOS: `./gradlew patrulha`. Abra sempre a raiz completa, não apenas esta
subpasta. Setas/WASD movem, R reinicia, Esc fecha e F11 alterna tela cheia.

O inimigo laranja percorre horizontalmente o trecho entre `x = 240` e
`x = 720`, a 120 unidades por segundo. O jogador ciano pode se mover
livremente; o painel indica contato, sem aplicar dano.

## Observe

1. Não pressione nenhuma tecla: o inimigo continua andando.
2. Acompanhe sua chegada à direita e depois à esquerda: a direção se inverte.
3. Mova o jogador até a trajetória e observe a indicação de contato.
4. Saia da trajetória: o inimigo continua seu comportamento.
5. R reinicia as posições e a direção da patrulha.

## O comportamento está aqui

| Classe/método | Responsabilidade |
| --- | --- |
| `modelo/Inimigo.atualizar` | Deslocamento e inversão nos limites. |
| `modelo/Partida.atualizar` | Atualização do jogador e do inimigo. |
| `Partida.emContato` | Consulta da sobreposição, sem dano. |
| `modelo/Jogador` | Movimento controlado pelo aluno. |
| `JogoPatrulha` | Entrada e desenho da direção e do contato. |

O inimigo recebe apenas o tempo decorrido; não consulta teclado nem janela.
`direcao` vale `1` ou `-1`. Se um passo ultrapassa uma borda, o excesso é
refletido para dentro do trecho antes da próxima atualização. Não há pausa,
perseguição ou sorteio: o comportamento é previsível e pode ser testado.

## Para adaptar ao seu jogo

- Para aproveitar só a patrulha, leve `Inimigo` e chame `atualizar(segundos)`
  no ciclo do seu modelo. Ela não depende de `Jogador` nem de `Partida`.
- Para executar o modelo completo, leve também `Jogador` e `Partida`.
- Ajuste os limites e a velocidade passados ao construtor em `Partida`.
  Atualize os marcadores gráficos se mudar a trajetória.
- Para uma patrulha vertical, adapte o estado e o desenho ao eixo y.
- Acrescentar dano ou perseguição é uma evolução separada: defina suas regras
  e seus testes antes de incorporar esses efeitos.

Uma experiência pequena é reduzir a velocidade pela metade. O percurso deve
levar o dobro do tempo sem mudar seus limites. `InimigoTest` verifica autonomia,
inversão, excesso de deslocamento, passos menores equivalentes e contato.

## Ler, testar e reaproveitar

O fonte começa em `src/main/java/br/edu/ifpb/jogos/exemplos/patrulha/`.
`IniciarPatrulha` apenas abre a janela. As regras estão em `modelo/` e os
testes em `src/test/java/`.

Para executar somente os testes deste exemplo, use
`.\gradlew.bat :exemplo-patrulha:test` na raiz. No Linux/macOS:
`./gradlew :exemplo-patrulha:test`.
Ao copiar classes para `src/main/java/meujogo/`, ajuste `package` e imports
para os nomes do seu projeto. Compare as dependências antes de copiar.
Não copie `build.gradle`, a engine ou as configurações do exemplo por cima
do seu projeto. Consulte o [catálogo](../EXEMPLOS.md) para o roteiro comum.
