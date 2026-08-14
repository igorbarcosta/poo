---
icon: material/school-outline
---

# Aula 02 — Do procedural aos objetos

No laboratório anterior, resolvemos em Java um problema que já sabíamos resolver com nosso repertório procedural. Agora vamos observar como os dados e as operações desse problema podem ser organizados de outra maneira.

**Slides:** [Apresentação HTML](../slides/rendered/aula-02-do-procedural-aos-objetos.html) · [PDF](../slides/rendered/aula-02-do-procedural-aos-objetos.pdf)

!!! question "Pergunta central"

    Se descrição, preço e quantidade pertencem ao mesmo item, onde está o `Item` no nosso programa?

??? "Ver comentário"

    Na solução procedural, reconhecemos o item no problema, mas ele ainda não aparece como uma unidade explícita no código. Nesta aula, vamos investigar como representá-lo dessa forma.

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

No Laboratório 01, construímos uma solução procedural para registrar dois itens, calcular seus subtotais e obter o total da compra. Parte do código podia ter esta forma:

```java
String descricao1 = "Teclado";
double preco1 = 150.0;
int quantidade1 = 2;

String descricao2 = "Mouse";
double preco2 = 80.0;
int quantidade2 = 3;
```

Retome as questões deixadas ao final do laboratório:

- quais variáveis representam partes de uma mesma coisa?
- o que acontece com a organização do código quando aumentamos o número de itens?
- existe alguma forma de manter os dados e os comportamentos relacionados mais próximos?

??? "Ver possível resposta"

    `descricao1`, `preco1` e `quantidade1` representam partes do primeiro item; o segundo conjunto representa outro item. Quando a quantidade de itens cresce, aumentam a repetição e a necessidade de manter relacionados dados que continuam separados no código.

Uma possível tentativa de reduzir a repetição seria usar arrays paralelos:

```java
String[] descricoes = {"Teclado", "Mouse", "Monitor"};
double[] precos = {150.0, 80.0, 900.0};
int[] quantidades = {2, 3, 1};
```

Essa organização facilita repetir operações para vários itens, mas ainda depende de uma convenção: `descricoes[i]`, `precos[i]` e `quantidades[i]` precisam representar o mesmo item. Os arrays melhoraram a situação. Milagre eles ainda não fazem: agora temos três estruturas que precisam concordar sobre o significado de cada posição.

A unidade `Item` existe no problema, mas ainda não aparece explicitamente no código.

Mesmo quem não realizou o desafio opcional pode acompanhar a comparação:

- o que os arrays melhoram?
- o que ainda depende da posição para manter os dados relacionados?

??? "Ver resposta"

    Os arrays reduzem a repetição e facilitam percorrer vários itens. Porém, a relação entre descrição, preço e quantidade continua dependendo do mesmo índice em estruturas separadas.

Nosso objetivo não é corrigir uma solução procedural “errada”, mas investigar outra forma de tornar explícitas as unidades que reconhecemos no problema.

### Identificando uma unidade do problema

Em vez de começar pela estrutura do programa, vamos olhar para o problema. Se descrição, preço e quantidade pertencem ao mesmo item, podemos representar explicitamente essa unidade:

**ITEM DO PEDIDO**

- descrição;
- preço unitário;
- quantidade;
- calcular subtotal.

Os três primeiros elementos são informações sobre o item. O último é uma operação diretamente relacionada a elas. Podemos organizar o programa em torno de elementos que representam conceitos relevantes do problema.

Identificar substantivos pode ajudar a perceber conceitos do domínio, mas isso não significa transformar todo substantivo em classe. Se fosse assim, modelagem orientada a objetos seria uma modalidade de análise sintática. `ItemPedido` é relevante porque possui estado, comportamento relacionado a esse estado e uma responsabilidade coerente na solução.

### Objeto, estado, comportamento e classe

!!! conceito-chave "Conceito-chave — Objeto"

    Uma unidade da solução que reúne informações e operações relacionadas.

**Estado**

São as informações que caracterizam um objeto em determinado momento. Por exemplo:

- descrição: `Teclado`;
- preço unitário: `150.0`;
- quantidade: `2`.

**Comportamento**

É uma operação relacionada ao objeto e que pode utilizar seu estado. Para um item, `calcularSubtotal()` usa preço e quantidade.

!!! conceito-chave "Conceito-chave — Classe"

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

??? "Ver resposta"

    Há uma classe `ItemPedido` e três objetos criados a partir dela. A classe fornece a estrutura e os comportamentos comuns; descrição, preço e quantidade assumem valores próprios em cada objeto.

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

!!! tip "Java em foco — estrutura de um método"

    Leia `double calcularSubtotal()` por partes:

    - `double` é o tipo do valor que o método devolve;
    - `calcularSubtotal` é o nome do método;
    - `()` é a lista de parâmetros; como está vazia, o método não recebe valores;
    - `{ ... }` delimita o corpo, onde fica o trabalho realizado pelo método;
    - `return` indica o valor devolvido: neste caso, o resultado de `precoUnitario * quantidade`.

    Nem todo método precisa devolver um valor. Em `void aumentarQuantidade()`, `void` indica que o método não devolve um valor. Ele ainda pode realizar uma ação, como alterar a quantidade do objeto.

    Assim, `calcularSubtotal()` calcula e devolve um `double`; `aumentarQuantidade()` realiza uma ação e pode alterar o estado sem devolver um resultado.

Como o exemplo declara `public class ItemPedido`, essa classe deve ficar no arquivo `ItemPedido.java`.

!!! tip "Java em foco — declarando a classe"

    O conceito que queremos representar é `ItemPedido`. Em Java:

    - `public class ItemPedido` declara uma classe chamada `ItemPedido`;
    - `String descricao`, `double precoUnitario` e `int quantidade` declaram campos com tipo e nome;
    - como a classe é pública, o arquivo se chama `ItemPedido.java`.

    A classe e seus campos são mecanismos de Java usados para expressar a estrutura que identificamos no problema.

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

!!! tip "Java em foco — `new`"

    O conceito é **criar um novo objeto**. Em Java, usamos `new ItemPedido()`.

    Leia, por enquanto, como: “crie um novo objeto do tipo `ItemPedido`”. `new` parece uma palavra importante demais para uma linha tão pequena, mas essa leitura basta hoje.

    Os parênteses fazem parte de um mecanismo ligado aos construtores. Construtores existem; só não precisamos abrir essa caixa agora.

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

!!! tip "Java em foco — chamando um comportamento"

    O conceito é **pedir ao objeto que execute um comportamento**. Em Java, o ponto liga o objeto ao método: `item.calcularSubtotal()` chama `calcularSubtotal` para aquele item.

    Os parênteses fazem parte da chamada. Neste caso ficam vazios porque o método não precisa receber valores: ele já usa o estado do próprio objeto.

Discuta as alternativas:

- quem já possui as informações necessárias?
- quem parece ser o responsável natural pelo cálculo?
- qual solução comunica melhor a intenção de calcular o subtotal do próprio item?

??? "Ver resposta"

    O próprio `ItemPedido` já conhece `precoUnitario` e `quantidade`. As três formas podem produzir o mesmo número, mas `item.calcularSubtotal()` comunica que calcular o subtotal é uma responsabilidade do item e permite que o comportamento use diretamente seu estado.

!!! info "Responsabilidade"

    Objetos não servem apenas para agrupar dados. Também precisamos decidir quais responsabilidades pertencem a cada objeto.

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

Em dupla, durante aproximadamente 5 a 7 minutos, discuta:

1. O que a classe representa?
2. Quais elementos representam estado?
3. Qual comportamento aparece?
4. Dois objetos `Produto` precisam possuir o mesmo preço?
5. Por que `calcularPrecoComDesconto` pode acessar `preco` sem recebê-lo como parâmetro?

??? "Ver resposta"

    `Produto` representa um produto. `nome` e `preco` formam seu estado, e `calcularPrecoComDesconto` é um comportamento. Objetos diferentes podem possuir preços diferentes. O método acessa `preco` porque usa o estado do próprio objeto.

Esta é uma atividade breve de compreensão e discussão em sala, não uma entrega formal.

## Atividade de modelagem

Uma biblioteca registra empréstimos. Para cada empréstimo, precisamos saber o livro, a data e se ele já foi devolvido. Um empréstimo pode ser devolvido.

Sem escrever uma classe Java completa, discuta:

1. Qual conceito poderia ser representado como objeto?
2. Quais informações representam seu estado?
3. Quais comportamentos poderiam fazer sentido?
4. Qual responsabilidade parece pertencer ao próprio objeto?

??? "Ver possível resposta"

    `Emprestimo` é uma possibilidade de objeto. Livro, data e situação da devolução podem compor seu estado, enquanto registrar a devolução pode ser um comportamento sob sua responsabilidade. Outras escolhas são possíveis se forem justificadas pelo estado, pelo comportamento e pelo papel do conceito na solução.

O objetivo é transferir as ideias da aula para outro problema, e não encontrar uma única resposta ou memorizar uma estrutura.

## Síntese

- representamos `ItemPedido` explicitamente porque ele é uma unidade relevante do problema;
- um objeto reúne um estado próprio e comportamentos relacionados;
- uma classe define a estrutura e os comportamentos comuns aos objetos daquele tipo;
- a mesma classe pode originar vários objetos, e `new` cria uma nova instância;
- `calcularSubtotal()` pode ser responsabilidade de `ItemPedido` porque usa o estado que o próprio objeto conhece;
- organizar objetos exige compreender e explicar as responsabilidades atribuídas a eles.

> Código que você não consegue explicar não é código que você domina.

## Preparação para o laboratório

Observe novamente:

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = new ItemPedido();
```

- quantos objetos foram criados?
- os dois objetos precisam possuir o mesmo estado?
- o que acontece quando alteramos apenas um deles?

??? "Ver resposta"

    Dois usos de `new ItemPedido()` criam dois objetos. Eles podem possuir estados diferentes; alterar o estado de um não altera automaticamente o estado do outro. O papel das variáveis usadas para acessar esses objetos será aprofundado na Aula 03.

Na aula, identificamos uma unidade que estava implícita na solução procedural e a representamos como objeto. No Laboratório 02, você fará essa transformação na solução construída anteriormente, criando objetos com estados próprios e um comportamento que calcula o subtotal.

## Material da aula

- [Laboratório 01 — Java mínimo e problema inicial](laboratorio-01-java-minimo-e-problema-inicial.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
