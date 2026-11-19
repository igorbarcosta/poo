# Exemplo — Salas conectadas

Na raiz da pasta `meu-jogo`, selecione **Exemplo — Salas conectadas** em
**Executar e Depurar** e pressione **F5**. Alternativa no PowerShell:

```powershell
.\gradlew.bat salas
```

Linux/macOS: `./gradlew salas`. Abra sempre a raiz completa, não apenas esta
subpasta. Setas/WASD movem, R reinicia, Esc fecha e F11 alterna tela cheia.

O jogador alterna entre duas salas. Cada sala possui um interruptor; sua
luz continua no estado em que foi deixada quando você sai e volta.

## Observe

1. Vá até o quadrado laranja central e pressione Enter para alternar a luz.
2. Na sala 1, vá até a porta azul à direita e pressione Enter.
3. A sala 2 começa com sua própria luz desligada. Seu interruptor é independente.
4. Use a porta à esquerda para voltar e confira a luz da primeira sala.
5. Enter fora da porta ou do interruptor não produz efeito. R reinicia tudo.

## O comportamento está aqui

| Classe/método | Responsabilidade |
| --- | --- |
| `modelo/Sala` | Número, estado da luz e posição da porta. |
| `modelo/Partida.interagir` | Escolha entre porta e interruptor; transição. |
| `modelo/Jogador` | Posição e consulta de sobreposição. |
| `JogoSalas.atualizar` | Tradução do Enter em uma solicitação. |
| `JogoSalas.desenhar` | Representação apenas da sala atual. |

`Partida` cria as duas salas uma vez e mantém suas referências. Entrar em outra
sala troca a referência `atual`; não recria as salas. O mesmo jogador muda de
posição para chegar afastado da porta. Enter é consultado com `confirmou()`:
um pressionamento produz uma solicitação, sem transição repetida a cada quadro.

## Para adaptar ao seu jogo

- Leve `Sala`, `Partida` e `Jogador` se quiser executar o modelo inteiro.
  Para integrar a um jogo existente, adapte `Partida` ao seu personagem e
  substitua o estado da luz pelas informações que cada ambiente precisa guardar.
- Acrescente salas mantidas pelo coordenador. Defina a sala de destino e
  a posição de chegada para cada passagem.
- Ao desenhar, consulte apenas a sala atual. Preservar uma sala fora da tela
  não significa atualizá-la ou desenhá-la sempre.
- Defina explicitamente o que persiste entre salas e o que R restaura.

Uma experiência pequena é mudar a posição de chegada da sala 2. Confira que
ela não coincide com a porta; pressionar Enter novamente ali não deve trazer
o jogador de volta. `PartidaTest` verifica transição, identidade das salas,
persistência e interação fora das regiões válidas.

## Ler, testar e reaproveitar

O fonte começa em `src/main/java/br/edu/ifpb/jogos/exemplos/salas/`.
`IniciarSalas` apenas abre a janela. As regras estão em `modelo/` e os
testes em `src/test/java/`.

Para executar somente os testes deste exemplo, use
`.\gradlew.bat :exemplo-salas:test` na raiz. No Linux/macOS:
`./gradlew :exemplo-salas:test`.
Ao copiar classes para `src/main/java/meujogo/`, ajuste `package` e imports
para os nomes do seu projeto. Compare as dependências antes de copiar.
Não copie `build.gradle`, a engine ou as configurações do exemplo por cima
do seu projeto. Consulte o [catálogo](../EXEMPLOS.md) para o roteiro comum.
