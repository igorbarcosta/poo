# Laboratório 06 — Conectando produtos e itens

Na Versão 5 do Projeto 1, cada `ItemPedido` passou a nascer com descrição, preço unitário e quantidade. Agora o projeto deverá separar as informações do produto daquelas que pertencem ao item e fazer os dois objetos colaborarem no cálculo do subtotal.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode:

    - ajudar a interpretar erros de compilação;
    - esclarecer como um objeto pode ser recebido por parâmetro e guardado em um campo;
    - fazer perguntas que ajudem você a acompanhar referências e chamadas de métodos.

    Ela não deve gerar a solução completa, tomar as decisões por você nem introduzir recursos ainda não estudados.

!!! warning "Laboratório acompanhado — presença requerida"

    Este laboratório é acompanhado porque reorganiza responsabilidades entre classes e altera novamente a forma de criar `ItemPedido`.

## Objetivos

Ao final deste laboratório, você deverá ser capaz de:

- separar o estado que pertence a `Produto` do estado que pertence a `ItemPedido`;
- declarar um campo cujo tipo é outra classe;
- receber um objeto como argumento e manter sua referência;
- implementar uma colaboração entre objetos;
- distinguir objetos compartilhados de objetos criados por expressões `new` diferentes.

## Projeto 1 — Versão 6: produtos e itens colaboram

Parta da **Versão 5** concluída no Laboratório 05. Crie uma cópia da versão anterior para trabalhar nesta evolução e preserve:

- os campos privados;
- a criação por construtor;
- a validação de valores numéricos não negativos;
- `calcularSubtotal()`, `aumentarQuantidade(int unidades)` e as operações de consulta;
- o cenário que permite comparar referências compartilhadas e objetos independentes.

Mantenha os arquivos Java na mesma pasta de código-fonte. Ao final, o projeto terá `Main.java`, `Produto.java` e `ItemPedido.java`.

O novo requisito é:

> Descrição e preço devem pertencer a `Produto`. Cada `ItemPedido` deve manter sua quantidade e uma referência para o produto correspondente. O subtotal do item deve usar o preço consultado no produto.

Nesta versão, considere que todo item recebe um `Produto` existente. Ausência de produto, `null`, preço histórico, vários itens dentro de `Pedido` e coleções ainda não fazem parte da atividade.

## Como conduzir a investigação

Em cada incremento, use como referência:

**prever → modificar → executar → observar → compreender**

Faça previsões breves antes das mudanças e compare-as com os resultados. Elas podem ficar em papel, rascunho ou conversa durante o acompanhamento. Você entregará somente o código final solicitado.

## Evolução do projeto

### Incremento A — Criar o objeto que representa um produto

Crie `Produto.java` com dois campos privados:

- `String descricao`;
- `double preco`.

Implemente um construtor que receba esses dois valores. Preserve a regra já conhecida: um preço negativo não deve entrar no estado do objeto. Adicione `getDescricao()` e `getPreco()` para consulta.

Antes de escrever o primeiro teste em `Main`, preveja o estado destes dois objetos:

```java
Produto teclado = new Produto("Teclado", 150.0);
Produto invalido = new Produto("Teste", -10.0);
```

Crie temporariamente os dois produtos, exiba suas descrições e preços e compare o resultado com a previsão. O teclado deve manter o preço `150.0`; o preço negativo não deve entrar no estado de `invalido`. Depois da verificação, remova o produto inválido e sua saída: ele não pertence ao cenário final.

Ao final deste incremento, descrição e preço já possuem um lugar próprio no modelo, ainda que `ItemPedido` continue temporariamente com a estrutura anterior.

### Incremento B — Fazer o item conhecer um produto

Agora reorganize `ItemPedido`. Substitua os campos `descricao` e `precoUnitario` por:

```java
private Produto produto;
```

Preserve o campo privado `quantidade`. Altere o construtor para receber um `Produto` e uma quantidade:

```java
public ItemPedido(Produto produto, int quantidade) {
    this.produto = produto;

    if (quantidade >= 0) {
        this.quantidade = quantidade;
    }
}
```

Adicione uma operação para consultar a referência mantida pelo item:

```java
public Produto getProduto() {
    return produto;
}
```

Remova de `ItemPedido` as operações de consulta que existiam apenas para seus antigos campos de descrição e preço. Antes de compilar, preveja quais pontos de `Main` deixarão de funcionar por ainda usarem o construtor e as consultas da Versão 5.

Compile sem corrigir `Main` ainda. Use as mensagens do compilador para localizar os pontos que dependiam da estrutura anterior. Neste incremento, a classe evolui de fato; o projeto pode permanecer temporariamente sem compilar até que seus clientes sejam adaptados.

### Incremento C — Adaptar as criações e implementar a colaboração

Em `Main`, crie primeiro os produtos necessários. Em seguida, forneça esses objetos ao construtor dos itens. Para o teclado, use este cenário mínimo:

```java
Produto teclado = new Produto("Teclado", 150.0);

ItemPedido itemPrincipal = new ItemPedido(teclado, 2);
ItemPedido itemObservado = itemPrincipal;
ItemPedido itemIndependente = new ItemPedido(teclado, 1);
```

Adapte as demais leituras de descrição e preço para consultar primeiro o produto do item. Por exemplo:

```java
itemPrincipal.getProduto().getDescricao()
itemPrincipal.getProduto().getPreco()
```

Por fim, altere `calcularSubtotal()` para que `ItemPedido` solicite ao produto o preço necessário:

```java
public double calcularSubtotal() {
    return produto.getPreco() * quantidade;
}
```

Antes de executar, preveja:

1. os subtotais de `itemPrincipal` e `itemIndependente`;
2. o resultado de `itemPrincipal == itemObservado`;
3. o resultado de `itemPrincipal == itemIndependente`;
4. o resultado de `teclado == itemPrincipal.getProduto()`;
5. o resultado de `itemPrincipal.getProduto() == itemIndependente.getProduto()`.

Exiba essas informações e execute o programa. Os subtotais devem ser `300.0` e `150.0`; as duas últimas comparações devem produzir `true`, pois os dois itens receberam a referência para o mesmo teclado.

Antes de avançar, acompanhe de onde vem cada valor usado em `calcularSubtotal()`: o preço é consultado no produto, enquanto a quantidade pertence ao próprio item.

### Incremento D — Distinguir compartilhamento de coincidência de estado

O programa já possui dois itens diferentes ligados ao mesmo produto. Acrescente agora outro produto e um item correspondente:

```java
Produto outroTeclado = new Produto("Teclado", 150.0);
ItemPedido itemOutroProduto = new ItemPedido(outroTeclado, 2);
```

Embora `teclado` e `outroTeclado` tenham descrições e preços iguais, foram criados por expressões `new Produto(...)` diferentes. Antes de executar, preveja o resultado de:

```java
System.out.println(teclado == outroTeclado);
System.out.println(itemPrincipal.getProduto() == itemOutroProduto.getProduto());
System.out.println(itemOutroProduto.calcularSubtotal());
```

Execute e confirme que as duas comparações produzem `false`, enquanto o subtotal é `300.0`. Preserve esse cenário no código final: ele mostra que ter o mesmo estado não transforma dois produtos em um único objeto.

!!! trap "Armadilha — criar o produto dentro de cada item"

    Não substitua o parâmetro `Produto` por descrição e preço para executar `new Produto(...)` dentro do construtor de `ItemPedido`. Isso criaria outro produto para cada item e impediria o compartilhamento explícito trabalhado nesta versão.

!!! success "Critérios de conclusão"

    Verifique se o código final:

    - compila e executa sem erros;
    - contém `Main.java`, `Produto.java` e `ItemPedido.java`;
    - mantém descrição e preço como campos privados de `Produto`;
    - impede preço negativo no estado inicial de `Produto`;
    - mantém produto e quantidade como campos privados de `ItemPedido`;
    - recebe um `Produto` e uma quantidade no construtor de `ItemPedido`;
    - impede quantidade negativa no estado inicial do item;
    - não mantém cópias de descrição ou preço em `ItemPedido`;
    - oferece as consultas necessárias sem criar setters;
    - calcula o subtotal em `ItemPedido` consultando o preço em `Produto`;
    - preserva `aumentarQuantidade(int unidades)` e sua regra;
    - mantém dois itens diferentes ligados ao mesmo objeto `Produto`;
    - mantém também o cenário com outro produto de mesmo estado e identidade diferente;
    - produz os subtotais e resultados de identidade previstos nos incrementos.

### Antes de entregar, você deve conseguir explicar

- por que descrição e preço pertencem a `Produto`, enquanto quantidade pertence a `ItemPedido`;
- o caminho argumento → parâmetro → campo quando um produto é fornecido ao item;
- por que passar um produto ao construtor não cria uma cópia;
- como `ItemPedido` colabora com `Produto` durante `calcularSubtotal()`;
- por que dois produtos com o mesmo estado ainda podem possuir identidades diferentes.

Essas explicações podem ser demonstradas oralmente durante o acompanhamento e não precisam ser enviadas.

## Desafio adicional — outra colaboração no mesmo modelo

Se concluir o núcleo, crie um produto diferente, como `Mouse` de preço `80.0`, e dois itens que compartilhem esse produto com quantidades distintas. Antes de executar, preveja as identidades compartilhadas e os subtotais.

O desafio não faz parte dos critérios obrigatórios nem exige mudar a estrutura das classes.

## Para consolidar

Um `Pedido` precisará reunir vários itens e calcular um total. Considere:

1. de quais colaboradores o pedido precisaria obter os subtotais;
2. por que o próprio produto não deveria calcular o total do pedido;
3. qual nova dificuldade aparece quando ainda não sabemos representar vários itens juntos.

Não implemente `Pedido` nem entregue respostas escritas. Essas perguntas deixam explícito o próximo problema do projeto sem antecipar sua solução.

## Entrega

> **Projeto 1 — Versão 6: produtos e itens colaboram**

Entregue somente os arquivos de código-fonte da **Versão 6**, conforme as orientações disponíveis no [Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).

Não envie previsões, respostas, tabelas, prints, diagramas, mensagens de erro ou reflexões por escrito.

## Materiais relacionados

- [Aula 06 — Colaboração entre objetos](aula-06-colaboracao-entre-objetos.md)
- [Laboratório 05 — Construindo objetos em estado válido](laboratorio-05-construindo-objetos-em-estado-valido.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
