---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 20 — A estrutura de um jogo

<div class="statement">Ler o Megamania para evoluir seu jogo</div>

Como encontro, no exemplo, uma solução que me ajude a desenvolver meu jogo?

<!-- Fonte: roteiro Aula 20 e LessonDesign registrados no pacote teaching_materials.
90 minutos: cena e ciclo 12; movimento 18; disparo 18; impacto 22; transferência 20.
A previsão aritmética da borda pode ser abreviada; preservar tempo de elaboração.
Executar o exemplo na abertura se o ambiente estiver disponível. O deck mantém
o código necessário para seguir os percursos sem depender da IDE. Não implementar
novas mecânicas. A elaboração individual precede a coleta de hipóteses.
Notas não substituem as respostas projetadas após cada activity. -->

---

<div class="chapter">Do Lab 19 ao exemplo comum</div>

## Seu jogo já tem uma regra própria

Um objeto guarda estado, recebe uma operação e protege um limite.

No Megamania, uma ação atravessa vários objetos:

**a nave dispara → o projétil se move → um inimigo é atingido → a partida marca pontos.**

Vamos seguir essa execução e localizar as responsabilidades.

---

<div class="chapter">Observar antes de abrir os arquivos</div>

## Três ações vão guiar nossa leitura

| Ação | O que procurar no código |
| --- | --- |
| Mover | Quem muda a posição? |
| Disparar | Quem cria e mantém o projétil? |
| Atingir | Quem aplica o efeito e registra os pontos? |

**Exemplo Megamania → F5.** Enter inicia; A/D movem; espaço dispara; P pausa; R reinicia.

<!-- Reservar parte da abertura à observação. Cada percurso responderá à pergunta
correspondente; não antecipar um catálogo de todas as classes. -->

---

<div class="chapter">Da cena ao estado</div>

## O que precisa existir para vermos isso?

| Na tela | No programa |
| --- | --- |
| Nave em uma posição | `x` e `y` guardados na `Nave`. |
| Vários inimigos e tiros | Coleções de participantes em `Partida`. |
| Número no placar | `pontos` guardados em `Partida`. |

A figura representa o objeto. As formas são solicitadas pela apresentação.

O texto fixo **PONTOS** e o número ao lado têm origens diferentes.

---

<div class="chapter">Da cena ao estado</div>

## A mesma nave aparece mais à direita

<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1100 330" width="1100" height="330" role="img" aria-label="A mesma nave em duas posições"><title>A mesma nave em duas posições</title><g transform="translate(0 0)"><rect width="540" height="330" rx="12" fill="#111c30"/><text x="20" y="34" fill="#b7c9df" font-family="sans-serif" font-size="21">QUADRO INICIAL</text><text x="20" y="75" fill="#f2f6ff" font-family="sans-serif" font-size="19">PONTOS</text><text x="385" y="75" fill="#55d9ed" font-family="sans-serif" font-size="26">00000</text><path d="M20 90H520 M20 267H520" stroke="#60738f"/><g transform="translate(210 215)"><path d="M0 30 L22 0 L44 30Z" fill="#55d9ed"/><rect x="17" y="12" width="10" height="15" fill="white"/><rect x="7" y="29" width="6" height="8" fill="#ffb466"/><rect x="31" y="29" width="6" height="8" fill="#ffb466"/></g><g transform="translate(110 115)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><g transform="translate(240 115)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><g transform="translate(370 115)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><text x="20" y="307" fill="#f2f6ff" font-family="sans-serif" font-size="23">x = 458; y = 126</text></g><g transform="translate(560 0)"><rect width="540" height="330" rx="12" fill="#111c30"/><text x="20" y="34" fill="#b7c9df" font-family="sans-serif" font-size="21">DEPOIS DE MOVER À DIREITA</text><text x="20" y="75" fill="#f2f6ff" font-family="sans-serif" font-size="19">PONTOS</text><text x="385" y="75" fill="#55d9ed" font-family="sans-serif" font-size="26">00000</text><path d="M20 90H520 M20 267H520" stroke="#60738f"/><g transform="translate(275 215)"><path d="M0 30 L22 0 L44 30Z" fill="#55d9ed"/><rect x="17" y="12" width="10" height="15" fill="white"/><rect x="7" y="29" width="6" height="8" fill="#ffb466"/><rect x="31" y="29" width="6" height="8" fill="#ffb466"/></g><g transform="translate(110 115)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><g transform="translate(240 115)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><g transform="translate(370 115)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><text x="20" y="307" fill="#f2f6ff" font-family="sans-serif" font-size="23">x = 497; y = 126</text></g></svg>

Esquema sem escala: dez atualizações de `0.01` s para a direita.
A posição muda; a nave continua sendo a mesma.

---

<div class="chapter">O ciclo fornecido pela engine</div>

## Como chegamos ao próximo quadro?

1. **Atualizar:** consultar comandos e alterar o estado dos objetos.
2. **Desenhar:** consultar o estado e solicitar formas e textos.
3. **Repetir:** posições sucessivas produzem o movimento visível.

A imagem anterior não guarda a posição da nave.
O próximo desenho usa os valores que continuam no modelo.

<!-- Recuperação do Lab 19; não abrir a infraestrutura da engine.
No exemplo: jogo iniciado, sem pausa e partida JOGANDO. -->

---

<!-- _class: tip -->

## Navegue seguindo uma chamada

Comece em **JogoMegamania.java**.

O código está em `exemplo-megamania/src/main/java/`
`br/edu/ifpb/jogos/megamania/`.

**F12:** ir para a definição do método chamado.
**Alt + ←:** voltar ao ponto anterior.

As regras ficam na subpasta `modelo/`.

<!-- Mostrar brevemente como partir de uma chamada, se houver IDE disponível.
O caminho foi quebrado em duas linhas para projeção; é um único diretório. -->

---

<div class="chapter">1 · Movimento — JogoMegamania.atualizar</div>

## Uma tecla vira uma direção

```java
int direcao = 0;
if (entrada.esquerda()) {
    direcao--;
}
if (entrada.direita()) {
    direcao++;
}
```

Esquerda: `-1`. Direita: `1`. Nenhuma ou ambas: `0`.

<!-- Premissa para este percurso: jogo iniciado, sem pausa, partida JOGANDO.
Este é um recorte do método; as verificações de início e pausa vêm antes. -->

---

<div class="chapter">1 · Movimento — da apresentação à nave</div>

## A partida encaminha a atualização

```java
// JogoMegamania.atualizar
partida.atualizar(segundos, direcao, entrada.acao());

// Partida.atualizar
nave.atualizar(segundos, direcao);
```

A nave recebe a direção. Ela não precisa consultar uma tecla.

---

<div class="chapter">1 · Movimento — JogoMegamania.desenhar</div>

## O desenho usa a posição resultante

```java
Nave nave = partida.getNave();

// Quando a nave deve ficar visível:
desenharNave(tela, nave.getX(), nave.getY());
```

Desenhar duas vezes sem atualizar preserva a posição.
O desenho consulta o estado; o movimento aconteceu antes.

<!-- O exemplo também alterna a visibilidade durante a proteção. Essa escolha
visual não altera posição nem vidas; não omitir a condição ao buscar o arquivo. -->

---

<div class="chapter">1 · Movimento — dentro de desenharNave</div>

## As coordenadas viram vértices da figura

```java
tela.triangulo(x, y,
        x + 22, y + 30,
        x + 44, y, Cor.CIANO);
```

`getX()` e `getY()` forneceram os parâmetros `x` e `y`.
Quando `x` muda, os três vértices se deslocam no próximo desenho.

A figura combina esse triângulo com outras formas.
Na tela lógica, `x` cresce à direita e `y` para cima.

---

<!-- _class: activity -->

<div class="chapter">1 · Movimento — da cena ao código</div>

## Explique a mudança entre os quadros

<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1100 330" width="1100" height="330" role="img" aria-label="A mesma nave em duas posições"><title>A mesma nave em duas posições</title><g transform="translate(0 0)"><rect width="540" height="330" rx="12" fill="#111c30"/><text x="20" y="34" fill="#b7c9df" font-family="sans-serif" font-size="21">QUADRO INICIAL</text><text x="20" y="75" fill="#f2f6ff" font-family="sans-serif" font-size="19">PONTOS</text><text x="385" y="75" fill="#55d9ed" font-family="sans-serif" font-size="26">00000</text><path d="M20 90H520 M20 267H520" stroke="#60738f"/><g transform="translate(210 215)"><path d="M0 30 L22 0 L44 30Z" fill="#55d9ed"/><rect x="17" y="12" width="10" height="15" fill="white"/><rect x="7" y="29" width="6" height="8" fill="#ffb466"/><rect x="31" y="29" width="6" height="8" fill="#ffb466"/></g><g transform="translate(110 115)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><g transform="translate(240 115)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><g transform="translate(370 115)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><text x="20" y="307" fill="#f2f6ff" font-family="sans-serif" font-size="23">x = 458; y = 126</text></g><g transform="translate(560 0)"><rect width="540" height="330" rx="12" fill="#111c30"/><text x="20" y="34" fill="#b7c9df" font-family="sans-serif" font-size="21">DEPOIS DE MOVER À DIREITA</text><text x="20" y="75" fill="#f2f6ff" font-family="sans-serif" font-size="19">PONTOS</text><text x="385" y="75" fill="#55d9ed" font-family="sans-serif" font-size="26">00000</text><path d="M20 90H520 M20 267H520" stroke="#60738f"/><g transform="translate(275 215)"><path d="M0 30 L22 0 L44 30Z" fill="#55d9ed"/><rect x="17" y="12" width="10" height="15" fill="white"/><rect x="7" y="29" width="6" height="8" fill="#ffb466"/><rect x="31" y="29" width="6" height="8" fill="#ffb466"/></g><g transform="translate(110 115)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><g transform="translate(240 115)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><g transform="translate(370 115)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><text x="20" y="307" fill="#f2f6ff" font-family="sans-serif" font-size="23">x = 497; y = 126</text></g></svg>

Qual informação mudou? Quem a alterou e quem a consultou?
Apenas desenhar novamente produziria esse deslocamento?

<!-- Dar tempo de elaboração. Usar o percurso já lido, sem calcular a fórmula. -->

---

<div class="chapter">1 · Movimento — conferência</div>

## O estado explica o novo desenho

- `x` da mesma nave passou de `458` para `497`; `y` ficou em `126`.
- `Nave.atualizar`, chamada pela partida, alterou a posição.
- `JogoMegamania.desenhar` consultou `getX()` e `getY()` e chamou `desenharNave`.
- Desenhar outra vez, sem atualizar, preservaria a posição.

Agora podemos abrir o cálculo que produz e limita o novo `x`.

---

<div class="chapter">1 · Movimento — Nave.atualizar</div>

## A nave altera e limita sua posição

```java
posicionar(
    Math.max(48, Math.min(868,
        getX() + direcao * 390 * segundos)),
    getY());
```

`direcao * 390 * segundos` calcula o deslocamento.

`Math.min` e `Math.max` mantêm `x` entre **48 e 868**.
`getY()` preserva a altura.

<!-- A quebra de linhas preserva a expressão do código real. Math.min escolhe
o menor valor; Math.max, o maior. Corpo fornece posicionar e consultas herdadas.
segundos é o intervalo fornecido pela engine, que limita o passo da atualização.
Não abrir discussão de relógio ou biblioteca gráfica. -->

---

<!-- _class: activity -->

<div class="chapter">1 · Movimento — previsão</div>

## A nave vai ultrapassar a borda?

A nave está em **x = 867**.
Recebe `0.01` segundo com direção `1`.

```java
Math.max(48, Math.min(868,
    getX() + direcao * 390 * segundos))
```

1. Qual será o novo `x`?
2. Quem impede a saída da área de jogo?

<!-- Dar tempo de cálculo e pedir justificativas antes de avançar. -->

---

<div class="chapter">1 · Movimento — conferência</div>

## O cálculo encontra o limite da nave

`867 + 1 * 390 * 0.01 = 870.9`

`Math.min(868, 870.9) = 868`

`Math.max(48, 868) = 868`

**Novo x: 868.** A proteção está em **Nave.atualizar**.

A partida solicita; a nave protege seu estado.

---

<div class="chapter">1 · Movimento — comparação com sua base</div>

## Uma responsabilidade a mais para coordenar

| Base individual | Megamania |
| --- | --- |
| `MeuJogo.atualizar` | `JogoMegamania.atualizar` |
| chama `Jogador.mover` | chama `Partida.atualizar` |
| jogador altera sua posição | partida encaminha para `Nave.atualizar` |

O Megamania coordena vários participantes e suas consequências.

A estrutura do seu jogo deve acompanhar as colaborações de que ele precisa.

---

<!-- _class: concept-key -->

## Seguir chamadas revela responsabilidades

**Entrada:** informa uma intenção.

**Coordenação:** encaminha a ação.

**Objeto do domínio:** altera e protege seu estado.

**Apresentação:** consulta o resultado para desenhá-lo.

---

<div class="chapter">2 · Disparo — o que a cena pede para explicar?</div>

## Aparecer e continuar em movimento

<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1100 330" width="1100" height="330" role="img" aria-label="O mesmo tiro permanece entre quadros"><title>O mesmo tiro permanece entre quadros</title><g transform="translate(0 0)"><rect width="540" height="330" rx="12" fill="#111c30"/><text x="20" y="34" fill="#b7c9df" font-family="sans-serif" font-size="21">O TIRO JÁ FOI CRIADO</text><text x="20" y="75" fill="#f2f6ff" font-family="sans-serif" font-size="19">PONTOS</text><text x="385" y="75" fill="#55d9ed" font-family="sans-serif" font-size="26">00000</text><path d="M20 90H520 M20 267H520" stroke="#60738f"/><g transform="translate(245 215)"><path d="M0 30 L22 0 L44 30Z" fill="#55d9ed"/><rect x="17" y="12" width="10" height="15" fill="white"/><rect x="7" y="29" width="6" height="8" fill="#ffb466"/><rect x="31" y="29" width="6" height="8" fill="#ffb466"/></g><rect x="264" y="185" width="6" height="16" fill="#55d9ed"/><text x="20" y="307" fill="#f2f6ff" font-family="sans-serif" font-size="23">Um projétil perto da nave</text></g><g transform="translate(560 0)"><rect width="540" height="330" rx="12" fill="#111c30"/><text x="20" y="34" fill="#b7c9df" font-family="sans-serif" font-size="21">APÓS OUTRAS ATUALIZAÇÕES</text><text x="20" y="75" fill="#f2f6ff" font-family="sans-serif" font-size="19">PONTOS</text><text x="385" y="75" fill="#55d9ed" font-family="sans-serif" font-size="26">00000</text><path d="M20 90H520 M20 267H520" stroke="#60738f"/><g transform="translate(245 215)"><path d="M0 30 L22 0 L44 30Z" fill="#55d9ed"/><rect x="17" y="12" width="10" height="15" fill="white"/><rect x="7" y="29" width="6" height="8" fill="#ffb466"/><rect x="31" y="29" width="6" height="8" fill="#ffb466"/></g><rect x="264" y="120" width="6" height="16" fill="#55d9ed"/><text x="20" y="307" fill="#f2f6ff" font-family="sans-serif" font-size="23">O mesmo projétil mais acima</text></g></svg>

Criar o projétil, mantê-lo e desenhá-lo são passos diferentes.
Uma nova imagem não exige um novo objeto.

---

<div class="chapter">2 · Disparo — Partida.atualizar</div>

## A partida solicita um disparo

O espaço, consultado por `entrada.acao()`, mantém a solicitação enquanto pressionado.

```java
if (disparar) {
    Projetil novo = nave.tentarDisparar();
    if (novo != null) {
        projeteis.add(novo);
    }
}
```

A decisão está no método chamado da nave.

---

<div class="chapter">2 · Disparo — Nave.tentarDisparar</div>

## A nave pode recusar a solicitação

```java
public Projetil tentarDisparar() {
    if (!estaVivo() || esperaDisparo > 0) {
        return null;
    }
    esperaDisparo = 0.22;
    return new Projetil(
        getCentroX() - 3, getY() + getAltura(), true);
}
```

Sem vidas ou em recarga: recusa. Caso contrário: cria o projétil.

<!-- true identifica um projétil do jogador. As coordenadas definem a saída
do disparo. Não estudar trigonometria ou geometria de sprites. -->

---

<!-- _class: java-focus -->

## Java em foco — ausência de objeto

```java
Projetil novo = nave.tentarDisparar();
if (novo != null) {
    projeteis.add(novo);
}
```

`null`: a tentativa não devolveu uma referência a projétil.

`novo != null`: só inclui um objeto quando houve criação.

Chamar um método por uma referência `null` causaria uma falha.

---

<div class="chapter">2 · Disparo — Nave.atualizar</div>

## A recarga diminui nas atualizações

```java
esperaDisparo = Math.max(0, esperaDisparo - segundos);
```

A nave guarda a espera entre atualizações.

O comando pode continuar chegando; a nave só aceita outro disparo
quando a espera chega a zero e ela ainda está viva.

<!-- Ler o mecanismo existente no nível do roteiro. Não acrescentar nova regra
temporal nem exigir implementação de temporizador no projeto individual. -->

---

<!-- _class: activity -->

<div class="chapter">2 · Disparo — duas solicitações, sem atualização entre elas</div>

## Quantos projéteis são criados?

```java
Nave nave = new Nave();
Projetil primeiro = nave.tentarDisparar();
Projetil segundo = nave.tentarDisparar();
```

1. O que cada variável recebe?
2. A segunda chamada substitui o primeiro projétil?

<!-- Distinguir objeto criado, retorno de uma operação e variáveis locais. -->

---

<div class="chapter">2 · Disparo — conferência</div>

## Um objeto criado, uma tentativa recusada

| Variável | Resultado |
| --- | --- |
| `primeiro` | Referência ao projétil criado. |
| `segundo` | `null`, pois a nave está em recarga. |

Foi criado **um projétil**.

A segunda chamada não altera a referência em `primeiro`
nem substitui o objeto criado.

---

<div class="chapter">2 · Disparo — o campo em Partida</div>

## Quem mantém o projétil no jogo?

```java
// Campo que mantém a coleção:
private final List<Projetil> projeteis = new ArrayList<>();

// Inclusão após um disparo aceito:
projeteis.add(novo);
```

A partida continua tendo acesso ao projétil após a chamada.

---

<div class="chapter">2 · Disparo — ler o campo sem confundir seus efeitos</div>

## A lista continua sendo a mesma

`private`: restringe o acesso direto ao campo.

`final`: impede reatribuir o campo a outra lista.

`add` e `remove`: ainda podem alterar o conteúdo da lista.

**Uma lista estável pode manter participantes diferentes ao longo da partida.**

---

<div class="chapter">2 · Disparo — da atualização ao desenho</div>

## Cada tiro fornece sua posição ao retângulo

```java
// Partida.atualizar, para cada projétil:
projetil.atualizar(segundos);
```

Em **JogoMegamania.desenhar**, recorte da forma principal:

```java
for (Projetil projetil : partida.getProjeteis()) {
    Cor cor = projetil.isDoJogador() ? Cor.CIANO : Cor.LARANJA;
    tela.retangulo(projetil.getX(), projetil.getY(), 6, 16, cor);
}
```

`?` escolhe a cor: jogador em ciano; inimigo em laranja.
O mesmo participante fornece posições diferentes em quadros sucessivos.

<!-- Código completo também desenha um contorno. Projetil.atualizar muda
sua posição e o marca inativo ao sair da área; limpeza no percurso 3. -->

---

<!-- _class: activity -->

<div class="chapter">2 · Disparo — diagnóstico de uma alteração</div>

## E se a lista começasse vazia a cada atualização?

Imagine substituir a coleção por uma lista nova em toda atualização.

O que aconteceria com os projéteis que estavam em movimento?

Justifique usando quem guarda, atualiza e desenha esses objetos.

<!-- Hipótese de mudança estrutural, não código compilável com o campo final.
Examinar a consequência da perda das referências, sem editar o exemplo. -->

---

<div class="chapter">2 · Disparo — diagnóstico</div>

## O percurso perderia seus participantes anteriores

A nova lista não guardaria as referências aos disparos anteriores.

A partida deixaria de atualizá-los por essa coleção.
A apresentação deixaria de encontrá-los nela para desenhar.

**Manter os objetos entre atualizações permite a continuidade da ação.**

---

<div class="chapter">3 · Impacto — da cena às consequências</div>

## Um acerto muda mais que a imagem do inimigo

<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1100 330" width="1100" height="330" role="img" aria-label="Um acerto muda participantes e placar"><title>Um acerto muda participantes e placar</title><g transform="translate(0 0)"><rect width="540" height="330" rx="12" fill="#111c30"/><text x="20" y="34" fill="#b7c9df" font-family="sans-serif" font-size="21">ANTES DO ACERTO</text><text x="20" y="75" fill="#f2f6ff" font-family="sans-serif" font-size="19">PONTOS</text><text x="385" y="75" fill="#55d9ed" font-family="sans-serif" font-size="26">00000</text><path d="M20 90H520 M20 267H520" stroke="#60738f"/><g transform="translate(245 215)"><path d="M0 30 L22 0 L44 30Z" fill="#55d9ed"/><rect x="17" y="12" width="10" height="15" fill="white"/><rect x="7" y="29" width="6" height="8" fill="#ffb466"/><rect x="31" y="29" width="6" height="8" fill="#ffb466"/></g><g transform="translate(100 120)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><g transform="translate(245 120)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><rect x="260" y="163" width="6" height="16" fill="#55d9ed"/><text x="20" y="307" fill="#f2f6ff" font-family="sans-serif" font-size="23">Inimigo e tiro ainda na cena</text></g><g transform="translate(560 0)"><rect width="540" height="330" rx="12" fill="#111c30"/><text x="20" y="34" fill="#b7c9df" font-family="sans-serif" font-size="21">APÓS A LIMPEZA E O DESENHO</text><text x="20" y="75" fill="#f2f6ff" font-family="sans-serif" font-size="19">PONTOS</text><text x="385" y="75" fill="#55d9ed" font-family="sans-serif" font-size="26">00100</text><path d="M20 90H520 M20 267H520" stroke="#60738f"/><g transform="translate(245 215)"><path d="M0 30 L22 0 L44 30Z" fill="#55d9ed"/><rect x="17" y="12" width="10" height="15" fill="white"/><rect x="7" y="29" width="6" height="8" fill="#ffb466"/><rect x="31" y="29" width="6" height="8" fill="#ffb466"/></g><g transform="translate(100 120)" fill="#ffb466"><rect x="7" y="7" width="24" height="18"/><rect y="10" width="8" height="12"/><rect x="30" y="10" width="8" height="12"/><rect x="6" y="25" width="7" height="7"/><rect x="25" y="25" width="7" height="7"/><rect x="11" y="13" width="5" height="5" fill="#111c30"/><rect x="23" y="13" width="5" height="5" fill="#111c30"/></g><text x="20" y="307" fill="#f2f6ff" font-family="sans-serif" font-size="23">Ambos saíram das coleções</text></g></svg>

Um acerto isolado, sem outros impactos nessa atualização.
Precisamos explicar **o efeito, os 100 pontos e os dois desaparecimentos**.

---

<div class="chapter">3 · Impacto — Partida.atualizar</div>

## Mover não significa acertar

Após atualizar o projétil do jogador, a partida investiga os inimigos:

```java
for (Inimigo inimigo : inimigos) {
    if (projetil.tentarAtingir(inimigo)) {
        pontos += inimigo.getPontos();
    }
}
```

O retorno da tentativa controla o acréscimo de pontos.

---

<div class="chapter">3 · Impacto — Projetil.tentarAtingir</div>

## O projétil verifica a tentativa

```java
public boolean tentarAtingir(Alvo alvo) {
    if (!ativo || !alvo.estaVivo()
            || !alvo.colideCom(this)) {
        return false;
    }
    alvo.receberImpacto();
    ativo = false;
    return true;
}
```

Só aceita com projétil ativo, alvo vivo e sobreposição dos corpos.

<!-- this fornece ao alvo a referência ao próprio projétil. Corpo.colideCom
implementa a geometria da sobreposição. Não abrir outra investigação geométrica. -->

---

<div class="chapter">3 · Impacto — o parâmetro Alvo</div>

## O contrato permite solicitar o impacto

```java
public interface Alvo {
    boolean colideCom(Corpo corpo);
    void receberImpacto();
    boolean estaVivo();
}
```

**Nave** e **Inimigo** cumprem o contrato.
Ambos herdam de **Corpo** a implementação de `colideCom`.

O objeto concreto determina o efeito de `receberImpacto()`.

---

<div class="chapter">3 · Impacto — Inimigo.receberImpacto</div>

## O alvo altera seu próprio estado

```java
public void receberImpacto() {
    vivo = false;
}
```

O inimigo fica morto. A nave usa outra regra: vidas e proteção.

O projétil solicita a operação comum sem copiar a regra de cada alvo.

---

<!-- _class: activity -->

<div class="chapter">3 · Impacto — cenário independente, sem janela</div>

## Dois alvos sobrepostos, um projétil

```java
Inimigo primeiro = new Inimigo(100, 200);
Inimigo segundo = new Inimigo(100, 200);
Projetil tiro = new Projetil(110, 205, true);

boolean a = tiro.tentarAtingir(primeiro);
boolean b = tiro.tentarAtingir(segundo);
```

Os dois inimigos estão vivos; o tiro está ativo e se sobrepõe a ambos.

Quais são os retornos `a` e `b`? Quais inimigos ficam vivos?

<!-- Os retângulos se sobrepõem nas duas tentativas. Guardas e estado, além da
geometria, decidem o resultado. Reservar tempo para rastrear a sequência. -->

---

<div class="chapter">3 · Impacto — conferência</div>

## A primeira tentativa desativa o projétil

| Tentativa | Retorno | Consequência |
| --- | --- | --- |
| `tiro.tentarAtingir(primeiro)` | `true` | Primeiro morto; tiro inativo. |
| `tiro.tentarAtingir(segundo)` | `false` | Segundo continua vivo. |

**a = true; b = false.** A segunda tentativa encontra `ativo == false`.

Esse caso já é verificado em **PartidaTest**, sem abrir a janela.

<!-- Teste: umProjetilNaoAtingeDoisAlvosSobrepostos. É possível examinar as
asserções na IDE, mas a conclusão e sua justificativa permanecem projetadas. -->

---

<div class="chapter">3 · Impacto — de volta a Partida.atualizar</div>

## A partida registra a consequência coletiva

```java
if (projetil.tentarAtingir(inimigo)) {
    pontos += inimigo.getPontos();
}
```

`Inimigo.getPontos()` devolve **100**.

O inimigo conhece seu valor. A partida mantém o placar.
Uma tentativa recusada não executa o acréscimo.

---

<div class="chapter">3 · Impacto — depois de investigar os acertos</div>

## Ficar morto não retira o objeto da lista

O inimigo altera `vivo`. O projétil altera `ativo`.

Depois dos impactos, a partida limpa as coleções:

```java
for (int i = inimigos.size() - 1; i >= 0; i--) {
    if (!inimigos.get(i).estaVivo()) {
        inimigos.remove(i);
    }
}
```

Existe outro percurso equivalente para os projéteis inativos.

---

<!-- _class: java-focus -->

## Java em foco — remover de trás para a frente

```java
for (int i = inimigos.size() - 1; i >= 0; i--) {
    if (!inimigos.get(i).estaVivo()) {
        inimigos.remove(i);
    }
}
```

`size() - 1`: último índice. `get(i)`: referência na posição.

`remove(i)` desloca as posições seguintes. Os índices menores,
ainda por visitar, permanecem válidos. Lista vazia: o corpo não executa.

---

<div class="chapter">3 · Impacto — quem avalia o resultado da partida?</div>

## A limpeza prepara a decisão de término

```java
if (!nave.estaVivo() || invasoresChegaram()) {
    estado = Estado.DERROTA;
} else if (inimigos.isEmpty()) {
    estado = Estado.VITORIA;
}
```

`isEmpty()`: a lista está vazia.
`invasoresChegaram()`: um inimigo alcançou a altura da nave.

A derrota é verificada primeiro e tem precedência.

---

<div class="chapter">3 · Impacto — ler o estado da partida</div>

## Um tipo reúne os estados possíveis

Em **Partida**:

```java
public enum Estado {
    JOGANDO,
    VITORIA,
    DERROTA
}
```

`enum` define valores nomeados. O campo `estado` guarda um por vez.

---

<!-- _class: activity -->

<div class="chapter">3 · Impacto — o último inimigo</div>

## Quem decide a vitória?

Resta **um inimigo**. Um projétil do jogador o atinge.

A nave continua viva e **não há invasão**.

Quem decide a vitória e em que momento da atualização?

Use a sequência: **impacto → limpeza → avaliação do estado**.

---

<div class="chapter">3 · Impacto — conferência</div>

## A partida decide depois da limpeza

1. O inimigo recebe o impacto e fica morto.
2. A partida o remove da coleção.
3. Sem derrota e com a lista vazia, passa a `VITORIA`.

Nas atualizações seguintes, a partida encerra o método sem avançar
as regras, pois seu estado já não é `JOGANDO`.

A apresentação consulta esse estado para mostrar o painel.

---

<div class="chapter">3 · Impacto — o próximo desenho</div>

## Quem faz o placar mostrar 00100?

Em **JogoMegamania.desenhar**:

```java
tela.texto(String.format("%05d", partida.getPontos()),
        556, 659, 1.5, Cor.CIANO);
```

A partida alterou os pontos. A apresentação consulta o novo valor.

`%05d` exibe o inteiro com pelo menos cinco dígitos:
`100` aparece como **00100**. A formatação não acrescenta pontos.

---

<div class="chapter">3 · Impacto — o próximo desenho</div>

## Por que o inimigo e o tiro desapareceram?

| Após a atualização | No desenho seguinte |
| --- | --- |
| Inimigo morto removido de `inimigos`. | O laço não encontra esse inimigo. |
| Tiro inativo removido de `projeteis`. | O laço não encontra esse tiro. |

A engine limpa o quadro anterior; a apresentação desenha a cena atual.

Sair da coleção não apaga outras referências ao objeto.

---

<!-- _class: synthesis -->

## Uma consequência atravessa vários objetos

**Projétil:** verifica e solicita o impacto.

**Alvo:** aplica seu efeito particular.

**Partida:** registra pontos, remove e avalia o término.

**Apresentação:** representa o resultado.

---

<div class="chapter">O mapa construído pelos três percursos</div>

## Onde procurar uma responsabilidade

| Parte | O que encontramos |
| --- | --- |
| Engine | Janela, ciclo, teclado e desenho fornecidos. |
| `JogoMegamania` | Entrada, apresentação, início e pausa. |
| `Partida` | Participantes, coordenação, pontos e término. |
| `Nave`, `Inimigo`, `Projetil` | Estados e comportamentos próprios. |

A partida coordena; as regras dos participantes continuam nos objetos.

---

<div class="chapter">O mesmo contrato integra jogos diferentes</div>

## A engine recebe um Jogo

```java
public interface Jogo {
    String getTitulo();
    void atualizar(double segundos, Entrada entrada);
    void desenhar(Tela tela);
}
```

**MeuJogo** e **JogoMegamania** cumprem esse contrato.

`Partida` pode funcionar sem importar teclado, janela ou biblioteca gráfica.

---

<div class="chapter">Transferência — escolher o percurso relevante</div>

## O que você quer fazer no seu jogo?

| Intenção | Referência para investigar |
| --- | --- |
| Aceitar ou recusar uma operação | Solicitação e decisão em `tentarDisparar`. |
| Manter participantes na cena | Inclusão e atualização de `projeteis`. |
| Aplicar um efeito entre objetos | `tentarAtingir` e `receberImpacto`. |
| Mostrar uma consequência coletiva | Pontos e estado em `Partida`. |

Escolha pelo comportamento que precisa desenvolver.

---

<!-- _class: activity -->

<div class="chapter">Transferência — jogo de exploração</div>

## Uma coleta precisa acontecer uma só vez

O personagem encontra um recurso disponível.
Recolher aumenta seu saldo e torna o recurso indisponível.
Uma segunda tentativa deve preservar o saldo.

1. Qual percurso do Megamania ajuda a investigar essa interação?
2. Quais responsabilidades e resultados precisam ser verificados?

<!-- Dar tempo para uma análise individual antes de coletar propostas.
Aceitar alternativas que protejam as regras, sem impor uma hierarquia. -->

---

<div class="chapter">Transferência — uma análise possível</div>

## Condição, efeito e consequência

O percurso do **impacto** ajuda a separar essas decisões.

- Verificar se o recurso está disponível.
- Acrescentar o saldo e tornar o recurso indisponível.
- Recusar a repetição, preservando o saldo.

Verifique **coleta aceita e tentativa repetida**, observando ambos os estados.

Os objetos podem colaborar sem declarar que um recurso é um `Alvo`.

---

<!-- _class: activity -->

<div class="chapter">Transferência — seu projeto do Lab 19</div>

## Delimite uma evolução pequena

Identifique no seu jogo:

1. Um comportamento desejado e seu resultado observável.
2. Um trecho do Megamania que ajude a desenvolvê-lo.
3. Quem solicita, quem decide e quem guarda o resultado.
4. Um cenário permitido e uma recusa ou limite verificáveis sem janela.

São anotações de estudo, sem nova entrega.

<!-- Reservar elaboração e discussão no bloco de transferência. Se alguém já
implementou a evolução pretendida, pedir que rastreie a colaboração atual e
identifique como verificá-la. Não prescrever nova mecânica para toda a turma. -->

---

<div class="chapter">Transferência — critérios para conferir seu recorte</div>

## Seu recorte deve permitir prever o resultado

**Exemplo: coleta de um recurso**

1. Recolher acrescenta uma unidade e torna o recurso indisponível.
2. A referência é o percurso do impacto.
3. A coordenação solicita; recurso e personagem protegem seus estados.
4. Primeira tentativa acrescenta uma unidade; repetição preserva o saldo.

Seu domínio pode ser outro. Localize os participantes e os efeitos exatos.

---

<div class="chapter">Continuidade do projeto individual</div>

## Continue a partir do que já funciona

Preserve sua regra e seus testes do Lab 19.

Siga uma execução do exemplo antes de incorporar um trecho.

**IA Nível 3 — Colaborador:** pode auxiliar na leitura e na geração de código.
Você continua responsável por compreender, verificar e modificar o que incorpora.

<!-- Não definir o Lab 20, prazo, nota ou artefato de entrega. O foco desta
aula é aprender a localizar e adaptar uma referência para o próprio jogo. -->

---

<!-- _class: synthesis -->

## Consultar código com uma intenção

- Parta de uma ação e acompanhe chamadas e estado.
- Localize regras individuais e consequências coletivas.
- Adapte a colaboração ao domínio do seu jogo.
- Confira o resultado e os limites da operação.

**O exemplo passa a ser uma referência que você sabe investigar.**

---

<div class="chapter">Aprofundamento opcional · pontuação</div>

## E se o placar ignorasse o retorno?

O código atual só acrescenta pontos quando a tentativa retorna `true`:

```java
if (projetil.tentarAtingir(inimigo)) {
    pontos += inimigo.getPontos();
}
```

Somar apenas por sobreposição poderia contar o segundo alvo mesmo
com o projétil já inativo. A condição geométrica não substitui a regra completa.

<!-- Apêndice elástico, fora do fechamento obrigatório. Retomar o cenário dos
dois inimigos sobrepostos e conferir a análise com as hipóteses dos estudantes. -->

---

<div class="chapter">Aprofundamento opcional · reinício</div>

## Reiniciar substitui a partida

Em **JogoMegamania.atualizar**, no tratamento de R:

```java
partida = new Partida();
iniciou = true;
pausado = false;
return;
```

O campo passa a referenciar uma nova partida com novos participantes.
O reinício restaura o estado; alterações no código exigem executar de novo.

<!-- Relacionar à regra e ao reinício feitos no Lab 19. Não afirmar que o new
modificou ou apagou o objeto antigo; houve reatribuição do campo. -->
