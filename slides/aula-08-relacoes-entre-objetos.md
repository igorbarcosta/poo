---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 08 — Relações entre objetos

<div class="statement">Quando um objeto precisa conhecer outro e quando essa relação faz parte da estrutura que ele deve manter?</div>

<!--
Retomar: Aula 06 introduziu ItemPedido → Produto; Aula 07 introduziu Pedido → itens.
Hoje não criamos uma nova estrutura do zero: vamos explicar por que ela existe e evitar relações a mais.
-->

---

<div class="chapter">Ponto de partida</div>

## O modelo já contém relações

```java
private Produto produto;       // em ItemPedido
private List<ItemPedido> itens; // em Pedido
```

Esses campos guardam referências.

<div class="key-point">Mas qual responsabilidade torna cada referência necessária?</div>

---

<!-- _class: activity -->

<div class="chapter">Ponto de partida</div>

## Leia a direção das relações

No modelo atual:

1. quem precisa alcançar `Produto` para calcular um subtotal?
2. quem precisa alcançar vários `ItemPedido` para calcular um total?
3. `Produto` precisa conhecer pedidos para fornecer seu preço?

<!--
Pedir justificativa, não apenas nomes. Coletar as hipóteses antes do próximo frame.
-->

---

<div class="chapter">Ponto de partida</div>

## Cada referência resolve uma necessidade

<div class="poo-diagram">
  <div class="poo-object poo-collection"><div class="poo-object__header">Pedido</div><div class="poo-slots"><div class="poo-slot poo-slot--ref">itens</div></div></div>
  <div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">ItemPedido</div><div class="poo-slots"><div class="poo-slot poo-slot--ref">produto</div><div class="poo-slot">quantidade</div></div></div>
  <div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">Produto</div><div class="poo-slots"><div class="poo-slot">preço</div></div></div>
</div>

- `Pedido` alcança os itens que coordena;
- `ItemPedido` alcança o produto que fornece o preço;
- `Produto` não precisa alcançar pedidos para cumprir seu papel atual.

---

<!-- _class: concept-key -->

<div class="chapter">Ponto de partida</div>

## Conceito-chave — associação entre objetos

Um objeto mantém uma referência para outro quando precisa colaborar com ele em alguma responsabilidade.

<div class="statement">A conhecer B não implica que B também conheça A.</div>

---

<div class="chapter">Estrutura do pedido</div>

## As duas relações têm o mesmo papel?

| Relação | Por que existe? |
| --- | --- |
| `ItemPedido` → `Produto` | solicitar o preço necessário ao subtotal |
| `Pedido` → `ItemPedido` | reunir itens e coordenar o total |

`Produto` pode existir no catálogo sem participar de pedido algum.

---

<!-- _class: activity -->

<div class="chapter">Estrutura do pedido</div>

## E se `Pedido` não mantivesse os itens?

Imagine que o campo `itens` desaparece.

1. quem teria de conhecer todos os itens para somar subtotais?
2. o que aconteceria com a ideia de que `Pedido` representa o conjunto?
3. o que um `Produto` perderia se não houvesse pedidos por enquanto?

---

<div class="chapter">Estrutura do pedido</div>

## O conjunto ficaria sem responsável

- algum código cliente teria de somar itens manualmente;
- a regra do conjunto ficaria fora de `Pedido`;
- `Produto` continuaria existindo e mantendo suas próprias informações.

<div class="key-point">`Pedido` não consulta itens por acaso: ele mantém a estrutura formada por eles.</div>

---

<!-- _class: concept-key -->

<div class="chapter">Estrutura do pedido</div>

## Conceito-chave — composição como responsabilidade estrutural

`Pedido` representa o todo e mantém os `ItemPedido` que formam sua estrutura.

`Produto` não é uma parte estrutural de um único pedido: pode ser usado em pedidos diferentes ou existir sem nenhum deles.

---

<div class="chapter">Estrutura do pedido</div>

## A criação em `Main` não decide tudo

```java
ItemPedido item = new ItemPedido(teclado, 2);
pedido.adicionarItem(item);
```

Criar o item antes de adicioná-lo pode ser útil para montar um cenário.

<div class="statement">O papel conceitual continua sendo: o item representa uma parte de um pedido; o produto pode existir independentemente.</div>

---

<div class="chapter">Estrutura do pedido</div>

## Manter a relação exige encapsulamento

```java
public void adicionarItem(ItemPedido item) {
    itens.add(item);
}
```

`Pedido` oferece uma operação para receber itens.

Ele não precisa devolver sua lista interna para qualquer código modificar.

---

<!-- _class: section -->

<div class="chapter">Direção e necessidade</div>

## Toda relação reversa ajuda o modelo?

```java
public class Produto {
    private double preco;
    private List<Pedido> pedidos;
}
```

Que responsabilidade atual exige que um produto alcance todos os pedidos em que aparece?

---

<!-- _class: activity -->

<div class="chapter">Direção e necessidade</div>

## Compare duas decisões

- **A.** `Pedido` mantém itens e cada item mantém seu produto.
- **B.** Além disso, cada produto mantém todos os pedidos em que aparece.

1. Qual responsabilidade atual exige B?
2. Qual decisão já permite calcular o total?
3. Quando uma relação reversa poderia fazer sentido?

---

<div class="chapter">Direção e necessidade</div>

## Conhecimento adicional também tem custo

No modelo atual, nenhuma responsabilidade de `Produto` exige alcançar pedidos.

Uma relação adicional criaria perguntas novas:

- quem a atualiza?
- em que momento?
- como evitar que apenas um dos lados seja atualizado?

---

<div class="chapter">Direção e necessidade</div>

## Dependência aparece nas chamadas

```java
total += item.calcularSubtotal();
```

```java
return produto.getPreco() * quantidade;
```

- `Pedido` precisa de `calcularSubtotal()`;
- `ItemPedido` precisa de `getPreco()`.

<div class="key-point">Uma dependência aparece quando uma responsabilidade precisa de uma operação ou informação de outro objeto.</div>

---

<!-- _class: trap -->

<div class="chapter">Direção e necessidade</div>

## Armadilha — espelhar toda relação

Uma referência de A para B não deve ser duplicada em B apenas para tornar a estrutura simétrica.

<div class="statement">A direção inversa só entra quando B também possui uma responsabilidade que exige alcançar A.</div>

---

<!-- _class: activity -->

<div class="chapter">Transferência</div>

## Uma biblioteca mantém empréstimos ativos

- `Livro` mantém título e autor;
- `Usuario` mantém seu nome;
- `Emprestimo` registra livro, usuário e data prevista;
- `Biblioteca` mantém empréstimos ativos.

Quais referências `Emprestimo` precisa manter? Qual relação é estrutural?

---

<div class="chapter">Transferência</div>

## Uma estrutura e duas associações

<div class="poo-diagram">
  <div class="poo-object poo-collection"><div class="poo-object__header">Biblioteca</div><div class="poo-slots"><div class="poo-slot poo-slot--ref">empréstimos ativos</div></div></div>
  <div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">Emprestimo</div><div class="poo-slots"><div class="poo-slot poo-slot--ref">livro</div><div class="poo-slot poo-slot--ref">usuario</div><div class="poo-slot">data prevista</div></div></div>
</div>

- `Biblioteca` → `Emprestimo` é estrutural;
- `Emprestimo` → `Livro` e `Emprestimo` → `Usuario` permitem representar os participantes;
- livro e usuário existem independentemente do empréstimo ativo.

---

<!-- _class: activity -->

<div class="chapter">Transferência</div>

## Agora surgem novas responsabilidades

- registrar a devolução de um empréstimo;
- contar os empréstimos **ativos** de um usuário;
- contar todos os empréstimos que esse usuário já realizou;
- mostrar retiradas anteriores de um livro.

Quais delas exigem uma relação adicional? Quais podem usar a estrutura que já existe?

<!--
Não responder de imediato. Pedir que distingam consulta de informação já mantida
de uma nova necessidade de preservar dados. A questão não é escolher uma lista
para todas as classes, mas justificar a responsabilidade.
-->

---

<div class="chapter">Transferência</div>

## Devolver muda a estrutura ativa

`Biblioteca` mantém os empréstimos ativos.

<div class="key-point">Por isso, ela deve coordenar a operação de devolução.</div>

O detalhe de encerrar ou retirar o registro será uma regra posterior.

Nesta aula, basta identificar: quem mantém a estrutura controla sua mudança.

---

<div class="chapter">Transferência</div>

## Contar ativos não exige lista em `Usuario`

```java
biblioteca.quantidadeEmprestimosAtivosDe(usuario);
```

`Biblioteca` já mantém os empréstimos ativos e pode consultar quais se referem ao usuário.

<div class="statement">Uma consulta nova não obriga, por si só, uma referência de `Usuario` para empréstimos.</div>

---

<div class="chapter">Transferência</div>

## Histórico revela uma decisão que ainda não existe

Se empréstimos devolvidos deixam o conjunto de ativos, ele não basta para responder:

<div class="statement">“Quantos empréstimos este usuário já realizou?”</div>

Agora o modelo precisa decidir se — e onde — preserva registros encerrados.

---

<div class="chapter">Transferência</div>

## Listas reversas são uma decisão, não um reflexo

`Usuario` ou `Livro` poderiam manter listas de empréstimos apenas se uma responsabilidade deles exigisse navegar por esses registros.

Antes de acrescentá-las, pergunte:

- que consulta ou comportamento a lista permite?
- quem a atualiza junto com a estrutura da biblioteca?
- ela duplica uma informação que já pode ser consultada?

---

<!-- _class: synthesis -->

## Síntese

- uma referência deve servir a uma responsabilidade;
- associações podem ter apenas uma direção;
- `Pedido` mantém a estrutura de itens que representa;
- `Produto` pode existir fora de pedidos;
- encapsulamento protege também as relações;
- dependências aparecem quando uma operação precisa de outra.

<div class="statement">Uma responsabilidade nova pode pedir uma relação nova — mas nunca automaticamente.</div>

Antes de acrescentar uma relação, pergunte: quem precisa conhecer quem — e para fazer o quê?
