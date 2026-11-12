# API da engine fornecida

O exemplo inicial já conecta entrada, atualização e desenho. Use-o como
referência enquanto cria as regras do seu jogo. A engine não conhece jogador,
pontuação, vitória ou derrota: esses conceitos pertencem ao seu modelo.

## Os três contratos

| Contrato | O que seu jogo faz |
| --- | --- |
| `Jogo` | Fornece título, atualiza o estado e desenha usando a tela recebida. |
| `Entrada` | Consulta direções e ações do teclado, sem acessar a biblioteca gráfica. |
| `Tela` | Solicita formas e texto, sem administrar janela ou renderizador. |

`MeuJogo` já implementa `Jogo`:

```java
String getTitulo();
void atualizar(double segundos, Entrada entrada);
void desenhar(Tela tela);
```

A engine chama `atualizar` e depois `desenhar` repetidamente. `segundos` é o
intervalo recebido naquela atualização. No exemplo, o deslocamento usa
velocidade × intervalo: os números do movimento não são uma regra universal
dos jogos. O passo recebido é limitado pela infraestrutura a 1/30 de segundo;
atrasos maiores são descartados para evitar saltos após travamentos.

Atualize as regras em `atualizar`. Use `desenhar` para representar o estado,
sem consumir itens, aplicar dano ou avançar regras apenas porque desenhou.

## Entrada de teclado

| Consulta | Teclas | Comportamento |
| --- | --- | --- |
| `esquerda()` | seta esquerda / A | `true` enquanto mantida |
| `direita()` | seta direita / D | `true` enquanto mantida |
| `cima()` | seta cima / W | `true` enquanto mantida |
| `baixo()` | seta baixo / S | `true` enquanto mantida |
| `acao()` | espaço | `true` enquanto mantida |
| `confirmou()` | Enter | `true` na atualização do pressionamento |
| `pausou()` | P | `true` na atualização do pressionamento |
| `reiniciou()` | R | `true` na atualização do pressionamento |

Esc fecha e F11 alterna tela cheia; a engine já trata essas duas teclas.
P e R ficam disponíveis como comandos: as regras do jogo definem seus efeitos.
Na base inicial, R cria um jogador novo; no Megamania, reinicia a partida.

## Tela e coordenadas

A área lógica mede **960 × 720**, independentemente do tamanho da janela.
A origem `(0, 0)` fica no canto inferior esquerdo. `x` cresce para a direita;
`y` cresce para cima. A engine mantém a proporção ao redimensionar a janela.

```java
tela.retangulo(x, y, largura, altura, cor);
tela.circulo(x, y, raio, cor);
tela.triangulo(x1, y1, x2, y2, x3, y3, cor);
tela.texto(texto, x, y, escala, cor);
```

Para retângulos, `(x, y)` é o canto inferior esquerdo; para círculos, é o centro.
No texto, `(x, y)` marca o início da linha pela sua referência superior de desenho.
Escala `1` usa tamanho lógico de aproximadamente vinte unidades.
Desenhos posteriores podem cobrir desenhos anteriores.

As cores disponíveis são `Cor.FUNDO`, `PAINEL`, `LINHA`, `BRANCO`, `CINZA`,
`CIANO`, `AZUL`, `LARANJA` e `VERMELHO`. A fonte já acompanha a engine com
sua licença; não é preciso instalar fontes.

O `Jogador` inicial preserva uma faixa de texto acima e outra abaixo da área
de movimento. Esses limites são regras do exemplo em `Jogador.java`, não
limites impostos pela engine a todos os jogos.

## Verificar sem abrir a janela

Uma classe que guarda vidas, posição, pontos ou outras regras pode ser criada
diretamente em um teste JUnit. `JogadorTest` já faz isso com o movimento.
Os testes não precisam chamar `Iniciar` ou `Janela.abrir`.

O pacote `modelo` do Megamania oferece exemplos de regras verificadas sem a
interface. O modelo não importa tipos de libGDX. Preserve essa separação
ao evoluir o seu domínio.
