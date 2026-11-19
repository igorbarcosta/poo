# Exemplo — Mapa e câmera

Na raiz da pasta `meu-jogo`, selecione **Exemplo — Mapa e câmera** em
**Executar e Depurar** e pressione **F5**. Alternativa no PowerShell:

```powershell
.\gradlew.bat mapa
```

Linux/macOS: `./gradlew mapa`. Abra sempre a raiz completa, não apenas esta
subpasta. Setas/WASD movem, R reinicia, Esc fecha e F11 alterna tela cheia.

O mundo mede **2400 × 1600**. A faixa visível do mundo mede 960 × 490;
os painéis superior e inferior continuam fixos. Os marcos A, B e C são
referências visuais, sem colisão: este exemplo isola a câmera.

## Observe

1. Caminhe para a direita e para cima até o cenário começar a deslizar.
2. Compare a posição do jogador no mundo com a posição da câmera no painel.
3. Procure B no centro do mapa e C próximo ao canto superior direito.
4. Alcance as bordas: a câmera para sem mostrar área além do mundo.
5. Pressione R: mundo e câmera voltam ao início.

## O comportamento está aqui

| Classe/método | Responsabilidade |
| --- | --- |
| `modelo/Mundo` | Dimensões do mapa e referência ao jogador. |
| `modelo/Jogador.mover` e `posicionar` | Movimento limitado ao mundo. |
| `modelo/Camera.acompanhar` | Região do mundo que será observada. |
| `Camera.paraTelaX` e `paraTelaY` | Conversão para coordenadas de desenho. |
| `JogoMapa.desenhar` | Desenho do mundo convertido e dos painéis fixos. |

A câmera subtrai sua origem das posições do mundo. O eixo y recebe também
`110`, início da faixa de observação. Ela acompanha o centro do jogador e
limita sua origem para não ultrapassar as bordas. Os painéis são desenhados
por último e cobrem formas do mundo fora dessa faixa.

## Para adaptar ao seu jogo

- Preserve as posições e colisões do seu modelo em coordenadas do mundo.
- Aproveite `Camera`, adaptando a referência ao seu jogador e as dimensões
  lidas de `Mundo`. Para copiar esse modelo inteiro, leve `Mundo` e `Jogador`
  também; eles pertencem ao pacote `modelo` deste exemplo.
- Use a conversão em **todos** os desenhos do mundo: jogador, cenário e demais
  participantes. Desenhe placar e controles sem essa conversão.
- Ajuste as dimensões em `Mundo` e a área visível em `Camera`; a área visível
  deste exemplo pressupõe um mundo maior que ela nos dois eixos.
- Mudar o tamanho do mundo não exige mudar `Tela`, a engine ou a janela.

Uma experiência pequena é mover o marco B. Sua posição de mundo deve permanecer
fixa enquanto sua posição na tela muda quando a câmera se desloca.
Confira `CameraTest`: centralização, bordas, distância entre marcos e preservação
da posição do jogador. Não use a posição já convertida em testes de colisão.

## Ler, testar e reaproveitar

O fonte começa em `src/main/java/br/edu/ifpb/jogos/exemplos/mapa/`.
`IniciarMapa` apenas abre a janela. As regras estão em `modelo/` e os
testes em `src/test/java/`.

Para executar somente os testes deste exemplo, use
`.\gradlew.bat :exemplo-mapa:test` na raiz. No Linux/macOS:
`./gradlew :exemplo-mapa:test`.
Ao copiar classes para `src/main/java/meujogo/`, ajuste `package` e imports
para os nomes do seu projeto. Compare as dependências antes de copiar.
Não copie `build.gradle`, a engine ou as configurações do exemplo por cima
do seu projeto. Consulte o [catálogo](../EXEMPLOS.md) para o roteiro comum.
