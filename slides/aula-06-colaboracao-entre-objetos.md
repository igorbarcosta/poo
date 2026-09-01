---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 06 — Colaboração entre objetos

<div class="statement">Quando uma operação depende de informações que pertencem a objetos diferentes, quem deve fazer o quê?</div>

<!--
Retomar a Aula 05: ItemPedido já nasce com estado coerente, mas ainda concentra informações que não descrevem propriamente o item.
-->

---

<div class="chapter">Trajetória</div>

## Hoje vamos investigar

<div class="sequence">
  <div class="step">informação repetida</div>
  <div class="arrow">→</div>
  <div class="step">responsabilidades separadas</div>
  <div class="arrow">→</div>
  <div class="step">objetos colaborando</div>
</div>

<!--
Não iniciar por associação ou composição. O problema de repetição produz a necessidade da colaboração.
-->

---

<!-- bloco-didatico: 6.1 -->

<!-- _class: code-focus compact-code -->

<div class="chapter">Informação repetida</div>

## Dois itens do mesmo produto

```java
ItemPedido itemDaManha =
    new ItemPedido("Teclado", 150.0, 2);

ItemPedido itemDaTarde =
    new ItemPedido("Teclado", 150.0, 1);
```

<!--
Apresentar a cena: dois itens criados em momentos diferentes para o mesmo produto do catálogo. Pedir que localizem o que varia e o que se repete.
-->

---

<!-- _class: activity code-focus -->

<div class="chapter">Informação repetida</div>

## Se o preço mudar para `160.0`...

```java
ItemPedido itemDaManha =
    new ItemPedido("Teclado", 150.0, 2);

ItemPedido itemDaTarde =
    new ItemPedido("Teclado", 150.0, 1);
```

Quantos lugares precisam ser encontrados e atualizados?

<!--
Dar tempo para contagem individual. Perguntar também o que poderia acontecer se apenas um lugar fosse atualizado.
-->

---

<div class="chapter">Informação repetida</div>

## O programa pode terminar assim

| Objeto | Descrição | Preço | Quantidade |
| --- | --- | ---: | ---: |
| `itemDaManha` | Teclado | 150.0 | 2 |
| `itemDaTarde` | Teclado | 160.0 | 1 |

<div class="statement">Qual é o preço do teclado nesse modelo?</div>

<!--
O problema não é apenas digitação repetida. Há duas versões independentes de uma informação que deveria ser única nesta versão do catálogo.
-->

---

<div class="chapter">Informação repetida</div>

## O estado mistura duas coisas

<div class="cards">
  <div class="concept-card"><strong>Produto</strong>descrição<br>preço atual do catálogo</div>
  <div class="concept-card"><strong>Participação no pedido</strong>qual produto<br>quantidade daquele item</div>
</div>

<div class="key-point">Antes de mover campos, precisamos perguntar o que pertence a quem.</div>

---

<!-- _class: activity -->

<div class="chapter">Responsabilidades</div>

## O que pertence a quem?

No Projeto 1:

- um produto existe no catálogo antes de participar de um pedido;
- um item representa certa quantidade desse produto;
- nesta etapa, o item usa o preço atual do catálogo.

1. Quem conhece descrição e preço?
2. Quem conhece a quantidade?
3. O que o item precisa saber para identificar o produto?

<!--
Dar tempo individual e coletar justificativas. O contexto determina a resposta: ainda não estamos modelando uma compra fechada nem preço histórico.
-->

---

<div class="chapter">Responsabilidades</div>

## Uma distribuição possível

<div class="cards">
  <div class="concept-card"><strong>Produto</strong><div class="state">descricao<br>preco</div></div>
  <div class="concept-card"><strong>ItemPedido</strong><div class="state">produto<br>quantidade</div></div>
</div>

<div class="key-point"><code>ItemPedido</code> precisa conhecer qual <code>Produto</code> participa do item.</div>

---

<div class="chapter">Regra desta etapa</div>

## O preço atual pertence ao catálogo

O subtotal acompanha o preço atual mantido por `Produto`.

<div class="statement">Uma compra fechada que preserve o preço praticado exigiria outra decisão de modelagem.</div>

<!--
Explicitar o recorte para não transformar a localização do preço em regra universal. Não desenvolver preço histórico nesta aula.
-->

---

<!-- _class: trap -->

<div class="chapter">Responsabilidades</div>

## “Então a quantidade também vai para `Produto`”

O mesmo teclado pode aparecer:

- com quantidade `2` em um item;
- com quantidade `1` em outro item.

<div class="key-point">A quantidade descreve uma participação específica no pedido, não o produto em si.</div>

---

<div class="chapter">Uma nova necessidade</div>

## Separar resolve a duplicação...

<div class="sequence">
  <div class="step"><strong>Produto</strong><br>conhece o preço</div>
  <div class="connector">precisam<br>colaborar</div>
  <div class="step"><strong>ItemPedido</strong><br>conhece a quantidade</div>
</div>

<div class="statement">Como calcular o subtotal se nenhum objeto conhece sozinho todos os valores?</div>

<!--
Usar a separação como causa do bloco seguinte: agora os objetos não podem mais trabalhar isoladamente.
-->

---

<!-- bloco-didatico: 6.2 -->

<!-- _class: code-focus compact-code -->

<div class="chapter">Um objeto Produto</div>

## O estado que descreve o produto

```java
public class Produto {
    private String descricao;
    private double preco;

    public Produto(String descricao, double preco) {
        this.descricao = descricao;
        if (preco >= 0) {
            this.preco = preco;
        }
    }

    public double getPreco() {
        return preco;
    }
}
```

<!--
Ler apenas os elementos necessários: estado do produto, construtor já conhecido e consulta do preço.
-->

---

<!-- _class: code-focus compact-code -->

<div class="chapter">Um item conhece um produto</div>

## `Produto` também pode ser tipo de campo

```java
public class ItemPedido {
    private Produto produto;
    private int quantidade;

    public ItemPedido(Produto produto, int quantidade) {
        this.produto = produto;
        if (quantidade >= 0) {
            this.quantidade = quantidade;
        }
    }

    public Produto getProduto() {
        return produto;
    }
}
```

<!--
Perguntar o que há de novo na declaração dos campos e parâmetros. Não apresentar Produto como valor copiado. Nesta aula, considerar um Produto existente; ausência de produto e null permanecem fora do recorte.
-->

---

<!-- _class: java-focus code-focus -->

<div class="chapter">Mecanismo de Java</div>

## Um tipo de classe também pode ser tipo de campo

```java
private Produto produto;
```

- `Produto` é o tipo;
- `produto` é o nome do campo;
- o campo pode manter uma referência para um objeto `Produto`.

<div class="key-point">A declaração não executa <code>new</code> nem cria outro produto.</div>

---

<div class="chapter">Objetos conectados</div>

## O campo permite chegar ao produto

<div class="cards">
  <div class="concept-card"><strong>objeto ItemPedido</strong><div class="state">produto → referência<br>quantidade = 2</div></div>
  <div class="concept-card"><strong>objeto Produto</strong><div class="state">descricao = "Teclado"<br>preco = 150.0</div></div>
</div>

<div class="key-point">O campo não contém uma cópia da descrição e do preço.</div>

<!--
Ler produto como um campo que guarda referência. Recuperar a distinção entre campo, referência e objeto sem reabrir toda a Aula 03.
-->

---

<!-- _class: concept-key -->

<div class="chapter">Objetos conectados</div>

## Colaboração entre objetos

Objetos colaboram quando um deles solicita a outro uma informação ou um comportamento necessário para cumprir sua própria responsabilidade.

<div class="key-point">Cada participante contribui com aquilo que conhece ou sabe fazer.</div>

---

<div class="chapter">Responsabilidade pelo subtotal</div>

## Quem conhece o quê?

<div class="cards">
  <div class="concept-card"><strong>Produto</strong>conhece o preço<br>não conhece a quantidade do item</div>
  <div class="concept-card"><strong>ItemPedido</strong>conhece a quantidade<br>sabe qual produto participa</div>
</div>

<div class="statement">O item pode pedir ao produto a informação que lhe falta.</div>

---

<!-- _class: code-focus -->

<div class="chapter">Responsabilidade pelo subtotal</div>

## O cálculo continua no item

```java
public double calcularSubtotal() {
    return produto.getPreco() * quantidade;
}
```

<div class="key-point"><code>ItemPedido</code> obtém o preço sem copiar esse valor para seu estado.</div>

---

<div class="chapter">Leia a colaboração</div>

## Da esquerda para a direita

<div class="sequence">
  <div class="step"><strong>produto</strong><br>acessa a referência</div>
  <div class="arrow">→</div>
  <div class="step"><strong>getPreco()</strong><br>solicita o preço</div>
  <div class="arrow">→</div>
  <div class="step"><strong>quantidade</strong><br>completa o cálculo</div>
</div>

<!--
Explicitar que o preço vem do colaborador e a quantidade vem do próprio item.
-->

---

<!-- _class: activity code-focus -->

<div class="chapter">Leia a colaboração</div>

## Quem deve fazer o quê?

```java
Produto teclado = new Produto("Teclado", 150.0);
ItemPedido item = new ItemPedido(teclado, 3);

double subtotal = item.calcularSubtotal();
```

1. Qual consulta o item faz?
2. Qual valor o produto devolve?
3. Qual estado pertence ao próprio item?
4. Qual subtotal esperamos?

<!--
Dar tempo individual. Coletar leituras do fluxo antes de revelar o resultado. O contexto e todos os valores estão projetados.
-->

---

<div class="chapter">Leia a colaboração</div>

## O fluxo completo

<div class="sequence">
  <div class="step"><code>item</code><br>quantidade 3</div>
  <div class="arrow">→</div>
  <div class="step"><code>produto.getPreco()</code><br>150.0</div>
  <div class="arrow">→</div>
  <div class="step"><strong>subtotal</strong><br>450.0</div>
</div>

<div class="key-point">O produto fornece seu preço; o item preserva a responsabilidade pelo subtotal.</div>

---

<!-- bloco-didatico: 6.3 -->

<!-- _class: activity code-focus -->

<div class="chapter">Objetos como argumentos</div>

## Quantos objetos existem?

```java
Produto teclado = new Produto("Teclado", 150.0);
ItemPedido item = new ItemPedido(teclado, 2);
```

1. Quantos objetos do modelo foram criados?
2. Quantas referências chegam ao `Produto` depois da segunda linha?
3. O argumento `teclado` cria uma cópia?

<!--
Dar tempo de previsão e coletar justificativas. Pedir que apontem as expressões new antes de contar objetos.
-->

---

<div class="chapter">Objetos como argumentos</div>

## Duas expressões `new`

<div class="cards">
  <div class="concept-card"><strong>new Produto(...)</strong>cria um objeto <code>Produto</code></div>
  <div class="concept-card"><strong>new ItemPedido(...)</strong>cria um objeto <code>ItemPedido</code></div>
</div>

<div class="key-point">O argumento <code>teclado</code> não contém outra expressão <code>new Produto(...)</code>.</div>

---

<!-- _class: code-focus method-structure -->

<div class="chapter">Objetos como argumentos</div>

## A referência entra pelo construtor

```java
public ItemPedido(Produto produto, int quantidade) {
    this.produto = produto;
    // preparação da quantidade
}
```

<div class="sequence">
  <div class="step"><strong>teclado</strong><br>argumento</div>
  <div class="arrow">→</div>
  <div class="step"><strong>produto</strong><br>parâmetro</div>
  <div class="arrow">→</div>
  <div class="step"><strong>this.produto</strong><br>campo</div>
</div>

---

<div class="chapter">Objetos como argumentos</div>

## Duas referências, o mesmo produto

<div class="refs shared wide-vars">
  <div class="var">teclado</div><div class="arrow">↘</div><div class="object">objeto Produto<div class="state-line">"Teclado", 150.0</div></div>
  <div class="var second">item.produto</div><div class="arrow second-arrow">↗</div>
</div>

<div class="key-point">A variável e o campo permitem chegar ao mesmo objeto.</div>

---

<!-- _class: code-focus -->

<div class="chapter">Identidade compartilhada</div>

## Podemos verificar

```java
System.out.println(
    teclado == item.getProduto()
);
```

<div class="execution-result"><strong>resultado</strong><code>true</code></div>

<!--
Relacionar o true ao diagrama: há duas referências, mas uma única identidade de Produto.
-->

---

<!-- _class: concept-key -->

<div class="chapter">Objetos como argumentos</div>

## Passar um objeto como argumento

O parâmetro recebe uma referência para o objeto existente.

<div class="key-point">A passagem não executa <code>new</code> nem cria automaticamente uma cópia independente.</div>

---

<!-- _class: trap -->

<div class="chapter">Objetos como argumentos</div>

## “O construtor recebeu um produto, então copiou o objeto”

O construtor guardou a referência recebida:

```java
this.produto = produto;
```

<div class="key-point">Copiar uma referência não é copiar o objeto.</div>

---

<!-- aprofundamento-elastico: Quarto e Reserva -->

<!-- _class: activity code-focus -->

<div class="chapter">Transferência</div>

## A mesma ideia em uma pousada

Um `Quarto` conhece seu número e o valor da diária. Uma `Reserva` conhece a quantidade de noites para aquele quarto.

```java
Quarto quarto = new Quarto(12, 180.0);
Reserva reserva = new Reserva(quarto, 3);

double total = reserva.calcularTotal();
```

<!--
Aprofundamento elástico. A cena, o significado e a ordem dos argumentos estão explícitos antes das perguntas.
-->

---

<!-- _class: activity -->

<div class="chapter">Transferência</div>

## Distribua as responsabilidades

1. Quem conhece o valor da diária?
2. Quem conhece a quantidade de noites?
3. Quem calcula o total da estadia?
4. Qual informação precisa solicitar ao colaborador?
5. Quantos objetos são criados pelo trecho?

<!--
Coletar propostas e justificativas. Se o tempo estiver curto, priorizar as perguntas 3 e 4 e seguir para o fechamento.
-->

---

<div class="chapter">Transferência</div>

## O domínio mudou. A colaboração não.

<div class="cards">
  <div class="concept-card"><strong>Quarto</strong>número<br>valor da diária</div>
  <div class="concept-card"><strong>Reserva</strong>quarto<br>quantidade de noites<br>cálculo do total</div>
</div>

<div class="key-point"><code>Reserva</code> solicita ao <code>Quarto</code> a diária necessária para cumprir sua responsabilidade.</div>

<!--
Usar somente se a transferência foi conduzida. Não implementar as classes completas.
-->

---

<div class="chapter">Próxima tensão</div>

## O modelo ainda representa um único item

Um pedido real reúne vários objetos `ItemPedido`.

<div class="statement">Quem deverá manter esse conjunto e coordenar operações sobre todos os itens?</div>

<!--
Abrir a necessidade futura sem ensinar coleção antes de ela ser necessária.
-->

---

<div class="chapter">Próxima tensão</div>

## Ainda não vamos resolver isso

- a colaboração simples entre dois objetos é o núcleo desta aula;
- vários itens exigirão representar e percorrer um conjunto;
- `Pedido` e coleções ficam para a continuidade do Projeto 1.

<div class="key-point">Uma nova necessidade ficou visível; não precisamos antecipar o mecanismo.</div>

---

<!-- _class: synthesis -->

<div class="chapter">Fechamento</div>

## De campos repetidos a objetos que colaboram

<div class="sequence">
  <div class="step">cada objeto mantém o estado que lhe pertence</div>
  <div class="arrow">→</div>
  <div class="step">o item guarda uma referência para o produto</div>
  <div class="arrow">→</div>
  <div class="step">o item solicita o preço de que precisa</div>
</div>

---

<div class="chapter">Fechamento</div>

## O que precisamos conseguir explicar

- por que descrição e preço foram separados da quantidade;
- como um campo pode manter referência para outro objeto;
- por que o subtotal continua sendo responsabilidade do item;
- como ler `produto.getPreco()` dentro do cálculo;
- por que passar `teclado` ao construtor não cria uma cópia.

---

<div class="chapter">Continuidade do projeto</div>

## Agora temos uma colaboração simples

<div class="cards">
  <div class="concept-card"><strong>Produto</strong>descrição e preço atual</div>
  <div class="concept-card"><strong>ItemPedido</strong>produto, quantidade e subtotal</div>
  <div class="concept-card"><strong>Em aberto</strong>um pedido com vários itens</div>
</div>

<!--
Encerrar sem prometer uma estrutura ainda não definida para o Laboratório 06.
-->
