---
icon: material/school-outline
---

# Aula 02 — Do procedural aos objetos

No laboratório anterior, resolvemos em Java um problema que já sabíamos resolver com nosso repertório procedural. Agora vamos observar como os dados e as operações desse problema podem ser organizados de outra maneira.

!!! question "Pergunta central"

    Quando várias informações e operações representam a mesma coisa no problema, faz sentido mantê-las separadas no programa?

## Objetivos

Ao final deste encontro, você deverá ser capaz de:

- identificar dados que representam o estado de uma mesma entidade;
- distinguir classe e objeto em exemplos simples;
- reconhecer estado e comportamento de um objeto;
- compreender que objetos diferentes da mesma classe podem possuir estados diferentes;
- compreender a função inicial de `new` na criação de objetos;
- reconhecer que determinados comportamentos podem ser responsabilidade do próprio objeto;
- ler uma classe Java simples e relacionar sua estrutura com esses conceitos.

## Conteúdo

### Retomando o Laboratório 01

Uma solução para dois itens pode ter usado variáveis separadas:

```java
String descricao1 = "Teclado";
double preco1 = 150.0;
int quantidade1 = 2;

String descricao2 = "Mouse";
double preco2 = 80.0;
int quantidade2 = 3;
```

Quem realizou o desafio opcional pode ter usado arrays paralelos:

```java
String[] descricoes = {"Teclado", "Mouse", "Monitor"};
double[] precos = {150.0, 80.0, 900.0};
int[] quantidades = {2, 3, 1};
```

Essa solução não está errada. Em relação às variáveis independentes, ela facilita repetir operações para vários itens. Ainda assim, usa uma convenção importante: `descricoes[i]`, `precos[i]` e `quantidades[i]` representam o mesmo item porque ocupam a mesma posição. Se os arrays deixarem de estar alinhados, essa associação se perde.

Compare as duas possibilidades:

- o que melhorou com os arrays?
- o que ainda depende da posição para manter os dados de um item relacionados?
- onde o conceito de “item” aparece explicitamente em cada solução?
- como essas soluções evoluiriam se cada item passasse a possuir muitas outras informações?

Nosso objetivo não é corrigir uma solução procedural “errada”, mas investigar outra forma de tornar explícitas as unidades que reconhecemos no problema.

### Identificando uma unidade do problema

Em vez de começar pela estrutura do programa, vamos olhar para o domínio. Um item do pedido reúne:

**ITEM DO PEDIDO**

- descrição;
- preço unitário;
- quantidade;
- calcular subtotal.

Os três primeiros elementos são informações sobre o item. O último é uma operação diretamente relacionada a elas. Podemos organizar o programa em torno de elementos que representam conceitos relevantes do problema.

### Objeto, estado, comportamento e classe

**Objeto**

Representa uma entidade da solução que reúne informações e operações relacionadas.

**Estado**

São as informações que caracterizam um objeto em determinado momento. Por exemplo:

- descrição: `Teclado`;
- preço unitário: `150.0`;
- quantidade: `2`.

**Comportamento**

É uma operação relacionada ao objeto e que pode utilizar seu estado. Para um item, `calcularSubtotal()` usa preço e quantidade.

**Classe**

Define a estrutura e os comportamentos comuns aos objetos daquele tipo. Objetos da mesma classe podem possuir estados diferentes.

### Uma classe, vários objetos

Considere estas três instruções:

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = new ItemPedido();
ItemPedido item3 = new ItemPedido();
```

Discuta:

- quantas classes aparecem e quantos objetos foram criados?
- os objetos precisam possuir o mesmo estado?
- o que é comum à definição da classe e o que pertence a cada objeto?

Há uma classe `ItemPedido` e três objetos criados a partir dela. A classe fornece a estrutura comum; descrição, preço e quantidade assumem valores próprios em cada objeto.

### Primeira classe em Java

Em Java, podemos representar essa unidade do problema assim:

```java
public class ItemPedido {

    String descricao;
    double precoUnitario;
    int quantidade;

    double calcularSubtotal() {
        return precoUnitario * quantidade;
    }
}
```

Leia o código conceitualmente:

- `class ItemPedido` define a classe;
- os três campos representam o estado de cada objeto;
- `calcularSubtotal()` representa um comportamento;
- esse comportamento utiliza o estado do próprio objeto.

Como o exemplo declara `public class ItemPedido`, essa classe deve ficar no arquivo `ItemPedido.java`.

!!! tip "Java em foco — nomes e maiúsculas"

    Em Java, seguiremos estas convenções:

    - **classes:** PascalCase — `ItemPedido`, `ContaBancaria`, `Produto`;
    - **variáveis e campos:** camelCase — `precoUnitario`, `quantidade`;
    - **métodos:** camelCase — `calcularSubtotal`, `adicionarItem`;
    - **maiúsculas e minúsculas importam:** `ItemPedido` e `itemPedido` são identificadores diferentes.

    Para métodos, prefira nomes que expressem claramente uma ação ou comportamento.

!!! tip "Java em foco — blocos e indentação"

    - `{` e `}` delimitam os blocos da classe e do método;
    - a indentação não define os blocos em Java, mas deve ser consistente para tornar a estrutura legível.

Compare as duas chamadas:

```java
calcularSubtotal(preco, quantidade);
```

```java
item.calcularSubtotal();
```

Na segunda forma, não precisamos passar novamente preço e quantidade porque o próprio objeto já mantém essas informações.

!!! tip "Java em foco — instruções"

    Nas instruções apresentadas, `;` marca o final. Uma instrução pode ocupar uma linha ou ser quebrada para facilitar a leitura. Nos dois casos abaixo, o significado é o mesmo:

    ```java
    double subtotal = precoUnitario * quantidade;
    ```

    ```java
    double subtotal =
        precoUnitario * quantidade;
    ```

### Criando objetos

Para criar e preencher um objeto, precisamos apenas do seguinte neste momento:

```java
ItemPedido item1 = new ItemPedido();

item1.descricao = "Teclado";
item1.precoUnitario = 150.0;
item1.quantidade = 2;
```

Podemos criar outro objeto da mesma classe com um estado diferente:

```java
ItemPedido item2 = new ItemPedido();

item2.descricao = "Mouse";
item2.precoUnitario = 80.0;
item2.quantidade = 3;
```

`new ItemPedido()` cria uma nova instância da classe. Por enquanto, essa ideia é suficiente; o papel das variáveis e referências será retomado posteriormente.

### Primeira noção de responsabilidade

Considere três formas de organizar o mesmo cálculo. Na segunda alternativa, suponha que `calcularSubtotal` seja um método auxiliar definido em `Main`.

```java
double subtotal = item.precoUnitario * item.quantidade;
```

```java
double subtotal = calcularSubtotal(item);
```

```java
double subtotal = item.calcularSubtotal();
```

Discuta as alternativas:

- quem já possui as informações necessárias?
- quem parece ser o responsável natural pelo cálculo?
- qual solução comunica melhor a intenção de calcular o subtotal do próprio item?

As três formas podem produzir o mesmo número. A terceira comunica que calcular o subtotal é uma responsabilidade do item e permite que o comportamento use diretamente seu estado.

!!! info "Responsabilidade"

    Orientação a objetos não consiste apenas em colocar dados dentro de classes. Também envolve decidir quais responsabilidades pertencem a cada objeto.

## Atividade de compreensão

Analise esta classe em um domínio diferente:

```java
class Produto {
    String nome;
    double preco;

    double calcularPrecoComDesconto(double percentual) {
        return preco - preco * percentual;
    }
}
```

Discuta com um colega:

1. O que a classe representa?
2. Quais elementos representam estado?
3. Qual comportamento aparece?
4. Dois objetos `Produto` precisam possuir o mesmo preço?
5. Por que `calcularPrecoComDesconto` pode acessar `preco` sem recebê-lo como parâmetro?

Esta é uma atividade breve de compreensão e discussão em sala, não uma entrega formal.

## Atividade de modelagem

Uma biblioteca registra empréstimos. Para cada empréstimo, precisamos saber o livro, a data e se ele já foi devolvido. Um empréstimo pode ser devolvido.

Sem escrever uma classe Java completa, discuta:

1. Qual conceito poderia ser representado como objeto?
2. Quais informações representam seu estado?
3. Quais comportamentos poderiam fazer sentido?
4. Qual responsabilidade parece pertencer ao próprio objeto?

O objetivo é transferir as ideias da aula para outro problema, e não encontrar uma única resposta ou memorizar uma estrutura.

## Síntese

- uma classe define estado e comportamentos comuns;
- objetos da mesma classe podem manter estados diferentes;
- `new` cria uma nova instância;
- um comportamento pode usar o estado do próprio objeto;
- organizar objetos também envolve decidir responsabilidades.

## Preparação para o laboratório

Observe novamente:

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = new ItemPedido();
```

- quantos objetos foram criados?
- os dois objetos precisam possuir o mesmo estado?
- o que acontece quando alteramos apenas um deles?

No Laboratório 02, você usará essas ideias para transformar a solução procedural do Laboratório 01 em uma primeira solução baseada em objetos.

## Material da aula

- [Laboratório 01 — Java mínimo e problema inicial](laboratorio-01-java-minimo-e-problema-inicial.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
