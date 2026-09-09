# Laboratório 08 — Mantendo relações no pedido

Na Versão 7 do Projeto 1, `Pedido` passou a manter uma coleção de itens e a
coordenar o cálculo do total. A Aula 08 tornou explícito que essa coleção faz
parte da estrutura do pedido, enquanto `Produto` continua existindo
independentemente e é conhecido pelos itens que o utilizam.

Neste laboratório, vamos fazer o código expressar melhor essa distribuição de
responsabilidades: o pedido continuará recebendo produtos existentes, mas será
ele quem criará e manterá os itens que formam a sua própria estrutura.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode:

    - ajudar a interpretar erros de compilação após mudar a assinatura de um método;
    - fazer perguntas sobre as referências criadas em cada incremento;
    - ajudar a conferir se uma classe conhece apenas o que precisa conhecer.

    Ela não deve gerar a solução completa, decidir a distribuição de responsabilidades nem introduzir recursos ainda não estudados.

!!! warning "Laboratório acompanhado — presença requerida"

    Esta evolução reorganiza quem cria e mantém os objetos `ItemPedido`. Faça as previsões antes de adaptar o código cliente e use a compilação para localizar dependências da interface anterior.

## Objetivos

Ao final deste laboratório, você deverá ser capaz de:

- explicar por que `Pedido` deve criar e manter os itens que compõem sua estrutura;
- criar um `ItemPedido` dentro de uma operação de `Pedido` a partir de um `Produto` existente e uma quantidade;
- acompanhar quais referências continuam apontando para o mesmo `Produto`;
- adaptar código cliente depois de uma mudança na operação pública de `Pedido`;
- remover consultas públicas que não são necessárias para a colaboração atual;
- preservar o cálculo total por delegação a `ItemPedido`.

## Projeto 1 — Versão 8: o pedido mantém seus itens

Parta da **Versão 7** concluída no Laboratório 07. Preserve:

- `Produto` com descrição e preço protegidos;
- `ItemPedido` com produto, quantidade, validação e `calcularSubtotal()`;
- `Pedido` com a lista privada de itens e `calcularTotal()`;
- o cálculo por delegação: `Pedido` solicita o subtotal, e `ItemPedido` consulta o preço em `Produto`.

O novo requisito é:

> Para adicionar um produto a um pedido, o código cliente fornece um `Produto` existente e uma quantidade. `Pedido` cria e mantém o `ItemPedido` correspondente em sua própria coleção.

Nesta versão, não implemente remoção, busca, desconto, fechamento, preço
histórico, limites de quantidade, itens repetidos, tratamento de `null` nem uma
relação de `Produto` para os pedidos em que aparece. Essas decisões exigiriam
novos problemas de domínio e não pertencem a esta evolução.

Você entregará somente o código final. Previsões e explicações podem ficar em
papel ou rascunho.

## Como conduzir a investigação

Em cada incremento, use como referência:

**prever → modificar → executar → observar → compreender**

Cada incremento muda o código do projeto. Use as mensagens do compilador e as
saídas do programa para conferir a mudança; não entregue suas anotações.

## Evolução do projeto

### Incremento A — Fazer o pedido criar a parte que mantém

Em `Pedido`, substitua a operação que recebe um `ItemPedido` pronto por uma
operação que receba um `Produto` existente e uma quantidade. Dentro dela,
crie o item e adicione-o à lista privada:

```java
public void adicionarItem(Produto produto, int quantidade) {
    ItemPedido item = new ItemPedido(produto, quantidade);
    itens.add(item);
}
```

Antes de compilar, responda:

1. qual objeto `ItemPedido` é criado em cada chamada a essa nova operação?
2. a expressão `new ItemPedido(...)` cria outro `Produto`?
3. quais chamadas em `Main` deixarão de compilar temporariamente?

??? "Ver resposta"

    1. Cada chamada cria um novo `ItemPedido`, que passa a ser mantido na lista daquele `Pedido`.
    2. Nenhum. O argumento `produto` transmite a referência para um `Produto` já existente.
    3. As chamadas antigas que forneciam um `ItemPedido` precisarão ser adaptadas para fornecer um `Produto` e uma quantidade.

Compile antes de corrigir `Main`. Os erros mostram os clientes que ainda usam a
interface anterior. O projeto pode permanecer temporariamente sem compilar:
essa quebra é a evidência de que a operação pública mudou de fato.

Ao final deste incremento, `Pedido` mantém a criação da parte que entra em sua
estrutura. `Produto` continua sendo criado fora do pedido, pois também pode
existir no catálogo sem participar de pedido algum.

### Incremento B — Adaptar o código cliente à nova relação

Em `Main`, crie os produtos do cenário e passe cada produto, com sua quantidade,
diretamente ao pedido:

```java
Produto teclado = new Produto("Teclado", 150.0);
Produto mouse = new Produto("Mouse", 80.0);

Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 2);
pedido.adicionarItem(mouse, 1);
```

Remova as criações de `ItemPedido` que existiam apenas para fornecê-las ao
pedido. Não crie um `Produto` novo dentro de `adicionarItem`: os produtos do
catálogo continuam sendo colaboradores fornecidos ao pedido.

Antes de executar, preveja:

1. quantos objetos `Produto` existem no cenário mostrado?
2. quantos objetos `ItemPedido` foram criados pelas duas chamadas ao pedido?
3. qual valor `pedido.calcularTotal()` deve devolver?
4. o que aconteceria se `teclado` fosse usado em outra chamada a `adicionarItem`?

??? "Ver resposta"

    1. Existem dois produtos: um teclado e um mouse.
    2. Existem dois itens: um para cada chamada a `adicionarItem`.
    3. O total é `380.0`: `150.0 * 2 + 80.0 * 1`.
    4. A nova chamada criaria outro `ItemPedido`, mas os dois itens manteriam referências para o mesmo objeto `Produto` do teclado.

Execute e exiba `pedido.calcularTotal()`. O resultado precisa ser `380.0`.
Crie também um segundo pedido com o mesmo produto e uma quantidade diferente;
confirme que cada pedido mantém seus próprios itens, enquanto o produto pode
ser compartilhado entre eles.

### Incremento C — Manter a colaboração pela interface necessária

Revise `ItemPedido`. Para o cálculo atual, `Pedido` precisa apenas solicitar
`calcularSubtotal()`. Ele não precisa receber diretamente o produto nem a
quantidade de cada item.

Sua Versão 7 possui consultas como estas; remova-as:

```java
public Produto getProduto() {
    return produto;
}

public int getQuantidade() {
    return quantidade;
}
```

Remova ou adapte em `Main` as saídas criadas apenas para inspecionar essas
consultas. Preserve `calcularSubtotal()` e as operações públicas que o seu
cenário ainda usa para alterar quantidade de acordo com as regras já estudadas.

Antes de compilar, responda:

1. qual operação `Pedido` ainda precisa chamar em cada item para calcular o total?
2. por que remover essas consultas não obriga `Pedido` a refazer a multiplicação?
3. qual classe continua conhecendo o preço e qual continua conhecendo a quantidade?

??? "Ver resposta"

    1. `Pedido` precisa chamar `item.calcularSubtotal()`.
    2. A regra permanece em `ItemPedido`, que já combina sua quantidade com o preço solicitado ao produto.
    3. `Produto` continua conhecendo o preço; cada `ItemPedido` continua conhecendo sua própria quantidade.

Compile e execute novamente. Confirme que o pedido continua devolvendo `380.0`
sem acessar diretamente o estado interno dos itens. A colaboração funciona
porque cada objeto expõe o comportamento de que o outro realmente precisa.

!!! trap "Armadilha — devolver o caminho inteiro até o estado"

    Não substitua `item.calcularSubtotal()` por uma sequência como `item.getProduto().getPreco() * item.getQuantidade()`. Essa alternativa espalha em `Pedido` uma regra que pertence a `ItemPedido` e volta a exigir consultas que o cálculo não precisa expor.

## Verificação final

Monte e execute os dois cenários abaixo:

1. um pedido com teclado (2 unidades) e mouse (1 unidade), cujo total é `380.0`;
2. outro pedido que recebe o mesmo `Produto teclado` com 1 unidade, cujo total é `150.0`.

Os dois pedidos devem conter itens próprios. As chamadas que usam `teclado`
devem alcançar o mesmo objeto `Produto`, sem criar uma cópia do produto em cada
pedido.

!!! success "Critérios de conclusão"

    Verifique se o código final:

    - compila e executa sem erros;
    - contém `Main.java`, `Produto.java`, `ItemPedido.java` e `Pedido.java`;
    - mantém `List<ItemPedido>` privada em `Pedido`;
    - recebe `Produto` e quantidade em `Pedido.adicionarItem(...)`;
    - cria `ItemPedido` dentro dessa operação e o adiciona à coleção privada;
    - não cria `Produto` dentro de `Pedido`;
    - adapta `Main` para não criar itens apenas para entregá-los ao pedido;
    - mantém `calcularTotal()` delegando `calcularSubtotal()` a cada item;
    - não expõe a lista interna;
    - não usa, para o cálculo atual, consultas que entreguem produto e quantidade do item;
    - devolve `380.0` e `150.0` nos cenários de verificação.

### Antes de entregar, você deve conseguir explicar

- por que `Pedido` cria e mantém os itens que entram em sua estrutura;
- por que `Produto` continua sendo criado fora do pedido;
- quantos itens e produtos são criados nas duas chamadas principais;
- por que dois pedidos podem usar o mesmo produto sem compartilhar os mesmos itens;
- por que `Pedido` solicita `calcularSubtotal()` em vez de acessar produto e quantidade diretamente.

??? "Ver uma explicação possível"

    - O pedido representa o conjunto e mantém os itens que o compõem.
    - O produto pertence ao catálogo e pode existir sem pedido; por isso ele é recebido como colaborador existente.
    - Cada chamada a `adicionarItem` cria um item; criar ou passar um produto não cria cópia automática dele.
    - Cada pedido executa sua própria criação de itens, embora esses itens possam apontar para o mesmo produto.
    - `calcularSubtotal()` preserva no item a regra que combina preço e quantidade.

## Desafio adicional — confira uma relação que não é necessária

Uma proposta sugere acrescentar a `Produto` uma lista de pedidos em que ele
aparece. Sem implementar essa lista, explique qual comportamento atual de
`Produto` precisaria dela. Se não encontrar um comportamento, registre por que
essa relação acrescentaria manutenção sem resolver o requisito do laboratório.

??? "Ver resposta"

    No modelo atual, nenhum comportamento de `Produto` precisa alcançar pedidos: ele mantém e fornece suas próprias informações. A relação inversa exigiria manter duas direções sincronizadas sem contribuir para o cálculo total nem para a criação dos itens.

O desafio não faz parte dos critérios obrigatórios nem exige alterar o código.

## Entrega

> **Projeto 1 — Versão 8: o pedido mantém seus itens**

Entregue somente os arquivos de código-fonte da **Versão 8**, conforme as
orientações disponíveis no [Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).

Não envie previsões, respostas, prints, diagramas ou reflexões por escrito.

## Materiais relacionados

- [Aula 08 — Relações entre objetos](aula-08-relacoes-entre-objetos.md)
- [Laboratório 07 — Coordenando itens em um pedido](laboratorio-07-coordenando-itens-em-um-pedido.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
