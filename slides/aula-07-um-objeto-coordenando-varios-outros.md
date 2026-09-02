---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 07 — Um objeto coordenando vários outros

<div class="statement">Como um objeto pode coordenar vários colaboradores sem assumir as responsabilidades deles?</div>

<!--
Retomar a Aula 06: cada ItemPedido já calcula seu subtotal colaborando com Produto. Hoje o problema é o conjunto.
-->

---

<div class="chapter">Ponto de partida</div>

## Um item já sabe colaborar

```java
Produto teclado = new Produto("Teclado", 150.0);
ItemPedido itemTeclado = new ItemPedido(teclado, 2);

Produto mouse = new Produto("Mouse", 80.0);
ItemPedido itemMouse = new ItemPedido(mouse, 1);
```

<div class="key-point">Cada item sabe calcular o próprio subtotal.</div>

---

<!-- _class: activity code-focus -->

<div class="chapter">Ponto de partida</div>

## E se o pedido tiver três itens?

```java
double total = itemTeclado.calcularSubtotal()
             + itemMouse.calcularSubtotal();
```

O que precisaria mudar quando um novo item entrasse no pedido?

<!--
Dar tempo para a turma identificar que Main conhece o conjunto e a soma manualmente.
-->

---

<div class="chapter">Ponto de partida</div>

## O problema não está na soma

<div class="cards">
  <div class="concept-card"><strong>Main</strong>cria objetos e conhece cada item</div>
  <div class="concept-card"><strong>Pedido</strong>ainda não existe no modelo</div>
</div>

<div class="statement">Falta um responsável pelo conjunto.</div>

---

<!-- _class: activity -->

<div class="chapter">Responsabilidade</div>

## Quem deveria conhecer os itens?

1. `Produto`, porque fornece o preço;
2. `Main`, porque cria os objetos;
3. `Pedido`, porque representa o conjunto.

Escolha uma alternativa e justifique com o que cada objeto representa.

---

<div class="chapter">Responsabilidade</div>

## A decisão

`Pedido` representa a unidade que reúne os itens.

Ele deve:

- manter os itens;
- receber novos itens;
- coordenar o cálculo do total.

<div class="key-point">Cada `ItemPedido` continua responsável pelo próprio subtotal.</div>

---

<!-- _class: concept-key -->

<div class="chapter">Responsabilidade</div>

## Conceito-chave — objeto coordenador

Um objeto coordena colaboradores quando mantém o conjunto relevante e solicita a cada participante o comportamento necessário para cumprir uma responsabilidade do conjunto.

<div class="statement">Coordenar não é copiar o estado nem refazer o trabalho dos colaboradores.</div>

---

<div class="chapter">Representar o conjunto</div>

## Quantos campos cabem num pedido?

```java
private ItemPedido primeiroItem;
private ItemPedido segundoItem;
private ItemPedido terceiroItem;
```

Essa estrutura fixa antecipadamente o tamanho do pedido.

---

<div class="chapter">Representar o conjunto</div>

## Precisamos de uma coleção

Um único campo deve manter várias referências para objetos `ItemPedido`.

```java
List<ItemPedido> itens;
```

`List` expressa a coleção em sequência; `ItemPedido` expressa o tipo dos elementos.

---

<!-- _class: java-focus code-focus -->

<div class="chapter">Representar o conjunto</div>

## `List` e `ArrayList`

```java
import java.util.ArrayList;
import java.util.List;

private List<ItemPedido> itens;

public Pedido() {
    itens = new ArrayList<>();
}
```

`List` é o tipo da coleção. `ArrayList` é a implementação concreta criada com `new`.

---

<!-- _class: activity -->

<div class="chapter">Representar o conjunto</div>

## Uma lista vazia é um problema?

Um `Pedido` acabou de nascer e ainda não recebeu itens.

1. Qual total você espera?
2. Por que a lista vazia pode ser um estado coerente?

---

<div class="chapter">Representar o conjunto</div>

## O estado inicial pode ser coerente

- não há itens a percorrer;
- não há subtotal a acumular;
- o total é `0.0`;
- o pedido já está pronto para receber colaboradores.

---

<div class="chapter">Adicionar colaboradores</div>

## O pedido recebe referências

```java
pedido.adicionarItem(itemTeclado);
pedido.adicionarItem(itemMouse);
```

Essas chamadas precisam criar novos itens ou guardar referências para itens que já existem?

---

<div class="chapter">Adicionar colaboradores</div>

## O conjunto aponta para os objetos existentes

<div class="poo-diagram">
  <div class="poo-var">pedido</div><div class="poo-arrow"></div>
  <div class="poo-object poo-collection"><div class="poo-object__header">Pedido#1</div><div class="poo-slots"><div class="poo-slot poo-slot--ref">itens</div></div></div>
</div>

<div class="key-point">`add` guarda a referência recebida. Não aparece `new ItemPedido(...)`.</div>

---

<!-- _class: activity -->

<div class="chapter">Adicionar colaboradores</div>

## Acompanhe as referências

Depois de adicionar `itemTeclado` e `itemMouse`:

- quantos objetos `ItemPedido` foram criados pelas chamadas?
- o que a lista guarda?
- o que acontece se o mesmo item for adicionado novamente?

---

<div class="chapter">Adicionar colaboradores</div>

## Uma coleção também contém referências

```text
[0] → itemTeclado
[1] → itemMouse
```

- as chamadas a `adicionarItem` não criam itens;
- a lista guarda referências existentes;
- uma segunda adição cria outra posição para a mesma identidade.

---

<div class="chapter">Coordenar o percurso</div>

## Como calcular sem listar item por item?

```java
double total = 0.0;

for (ItemPedido item : itens) {
    total += item.calcularSubtotal();
}
```

O pedido conhece o conjunto. O item conhece o subtotal.

---

<!-- _class: java-focus code-focus -->

<div class="chapter">Coordenar o percurso</div>

## Leia o `for` aprimorado

```java
for (ItemPedido item : itens) {
    total += item.calcularSubtotal();
}
```

Leia: “para cada `ItemPedido`, chamado temporariamente de `item`, presente em `itens`”.

<div class="key-point">A cada repetição, `item` recebe a referência para o próximo objeto.</div>

---

<div class="chapter">Coordenar o percurso</div>

## O fluxo de responsabilidades

<div class="sequence">
  <div class="step">Pedido percorre</div><div class="arrow">→</div>
  <div class="step">ItemPedido calcula</div><div class="arrow">→</div>
  <div class="step">Produto fornece preço</div>
</div>

O pedido não precisa conhecer a multiplicação interna do subtotal.

---

<!-- _class: activity -->

<div class="chapter">Coordenar o percurso</div>

## Preveja o percurso

Com dois itens no pedido:

1. quantas chamadas a `calcularSubtotal()` acontecem?
2. quantas chamadas a `getPreco()` acontecem?
3. quem conhece o conjunto de subtotais?
4. qual é o total?

---

<div class="chapter">Coordenar o percurso</div>

## Uma chamada por colaborador

- `calcularSubtotal()` é chamado duas vezes;
- `getPreco()` é chamado duas vezes;
- `Pedido` conhece o conjunto de subtotais;
- o total é `300.0 + 80.0 = 380.0`;
- um pedido vazio devolve `0.0`.

---

<!-- _class: section -->

<div class="chapter">Coordenar não é fazer</div>

## Duas soluções podem devolver `380.0`

```java
// solução colaborativa
total += item.calcularSubtotal();
```

```java
// solução que invade a regra do item
total += item.getProduto().getPreco()
       * item.getQuantidade();
```

Qual delas preserva melhor a distribuição de responsabilidades?

---

<!-- _class: trap -->

<div class="chapter">Coordenar não é fazer</div>

## Armadilha — o coordenador refaz o subtotal

`Pedido` precisa saber quais colaboradores participarão e qual operação solicitar.

Ele não precisa aprender como preço e quantidade são combinados.

<div class="statement">Coordenar ≠ absorver a responsabilidade dos colaboradores.</div>

---

<!-- _class: activity -->

<div class="chapter">Transferência</div>

## A mesma ideia em outro domínio

Uma `Turma` reúne vários `Aluno`. Cada aluno conhece suas notas e a regra de aprovação. A turma precisa contar quantos alunos estão aprovados.

1. Quem mantém a lista?
2. Qual operação a turma solicita?
3. Quem percorre a coleção?
4. Por que a turma não recalcula a média?

---

<div class="chapter">Transferência</div>

## A responsabilidade continua distribuída

```text
Pedido                 Turma
  percorre ItemPedido    percorre Aluno
  solicita calcularSubtotal()  solicita estaAprovado()
```

- `Turma` mantém a lista e conta os resultados;
- `Aluno` conhece seu estado e a regra de aprovação;
- `Turma` não acessa notas para refazer a decisão.

---

<!-- _class: synthesis -->

## Síntese

- `Pedido` mantém uma coleção de referências para seus itens;
- `ArrayList` é o objeto concreto que armazena a sequência;
- adicionar um item existente não cria cópia;
- `Pedido` percorre e coordena;
- `ItemPedido` calcula o subtotal;
- `Produto` fornece o preço;
- coordenar significa organizar chamadas sem absorver responsabilidades.

---

<!-- _class: section lead -->

## Próximo passo

No Laboratório 07, o Projeto 1 ganhará `Pedido`, uma coleção de itens e o cálculo coordenado do total.

<div class="statement">Tente construir o responsável pelo conjunto antes de abrir as dicas.</div>
