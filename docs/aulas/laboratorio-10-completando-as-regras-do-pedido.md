# Laboratório 10 — Completando as regras do pedido

Na Versão 9 do Projeto 1, `Pedido` cria os itens que mantém, calcula seu total
e deixa de aceitar novas inclusões depois de fechado. Agora vamos completar as
operações para corrigir uma linha ou removê-la, sem entregar a coleção interna
para o código cliente.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode ajudar a interpretar erros de compilação, fazer perguntas sobre o percurso da lista e ajudar a conferir se uma operação ficou na classe responsável. Ela não deve gerar a solução completa, decidir as regras da versão nem introduzir recursos ainda não estudados.

!!! warning "Laboratório acompanhado — presença requerida"

    Esta evolução modifica regras já existentes em `Pedido`. Faça as previsões antes de executar e confirme que cálculo, encapsulamento e fechamento continuam preservados.

## Objetivos

Ao final deste laboratório, você deverá ser capaz de:

- localizar uma linha de pedido pela referência de seu `Produto`;
- remover e alterar linhas por operações públicas de `Pedido`;
- preservar em `ItemPedido` a validação da própria quantidade;
- interpretar quantidade zero como remoção da linha nesta versão; e
- impedir remoções e alterações depois do fechamento.

## Projeto 1 — Versão 10: operações coerentes com o pedido

Parta de uma cópia da **Versão 9** concluída no Laboratório 09. Preserve
`Main.java`, `Produto.java`, `ItemPedido.java` e `Pedido.java`: a lista
privada, o cálculo por delegação e a regra de que pedido fechado não recebe novas
inclusões.

Esta versão usa o `Produto` já existente para identificar uma linha. Duas
chamadas que recebem a **mesma referência** de produto correspondem à mesma
linha. O pedido deve manter no máximo uma linha para cada referência de
`Produto`; uma tentativa de adicionar de novo esse produto não cria outra linha.

As regras são:

- `removerItem(produto)` remove a linha inteira quando o pedido está aberto;
- se o produto não estiver no pedido, a remoção não altera nada;
- `alterarQuantidade(produto, novaQuantidade)` altera a linha encontrada quando a quantidade é positiva;
- quantidade zero remove a linha; quantidade negativa não altera o pedido; e
- depois de `fechar()`, adicionar, remover e alterar quantidade não modificam o pedido.

As operações podem continuar com retorno `void`. Você entregará somente o
código-fonte final; previsões e respostas não fazem parte da entrega.

## Evolução do projeto

Use a sequência **prever → modificar → executar → observar → compreender**.
Cada incremento muda o código e produz um comportamento observável.

### Incremento A — Dar ao item a pergunta de que o pedido precisa

Em `ItemPedido`, crie uma operação pública que receba um `Produto` e informe
se ele é a mesma referência mantida pela linha. Mantenha o campo `produto`
privado.

??? tip "Dica"

    A comparação de referências estudada na Aula 03 usa `==`. A operação pode devolver um `boolean`.

Em `Main`, crie teclado e mouse e adicione cada um a um pedido aberto. Antes de
avançar, preveja se `new Produto("Mouse", 80.0)` deve ser reconhecido como a
mesma linha de `mouse`.

??? "Ver resposta"

    Não. O novo `Produto` possui outra identidade. Nesta versão, a operação reconhece apenas a mesma referência `mouse` usada em `pedido.adicionarItem(mouse, 1)`.

Compile. Ao final, `ItemPedido` continua protegendo seus campos; apenas oferece
a pergunta mínima de que `Pedido` precisa para localizar uma parte de sua lista.

### Incremento B — Remover uma linha sem expor a coleção

Em `Pedido`, implemente uma operação pública que receba um `Produto`, percorra
a lista privada, localize a linha correspondente e a remova quando o pedido
estiver aberto. Se não encontrar a linha, o estado deve ser preservado. Não crie
`getItens()`.

Monte este cenário:

```java
Produto teclado = new Produto("Teclado", 150.0);
Produto mouse = new Produto("Mouse", 80.0);

Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 2);
pedido.adicionarItem(mouse, 1);
pedido.removerItem(mouse);

System.out.println(pedido.calcularTotal());
```

Antes de executar, preveja o total e o que acontece com uma segunda chamada a
`pedido.removerItem(mouse)`.

??? "Ver resposta"

    O total é `300.0`: a linha do mouse desaparece e permanecem duas unidades de teclado. A segunda chamada não encontra o mouse e preserva o total em `300.0`.

Execute. A busca deve encerrar ao encontrar a linha; a coleção continua privada.

### Incremento C — Alterar quantidade pela responsabilidade correta

Em `ItemPedido`, ofereça uma operação pública para alterar a quantidade apenas
quando o valor for positivo. Em `Pedido`, implemente uma operação que localize
a linha quando o pedido estiver aberto:

- para quantidade positiva, solicite a alteração ao `ItemPedido` encontrado;
- para quantidade zero, remova essa linha;
- para quantidade negativa, preserve o pedido.

Não escreva diretamente no campo `quantidade` a partir de `Pedido`. O pedido
decide que a linha pertence à coleção e que zero a remove; o item protege sua
quantidade positiva.

Antes de executar, acrescente novamente o mouse com uma unidade e preveja o
total depois de cada cenário independente:

1. alterar o teclado de `2` para `3`;
2. alterar o mouse de `1` para `0`;
3. tentar alterar o teclado para `-1`.

??? "Ver resposta"

    1. `530.0`, com teclado em três unidades e mouse em uma.
    2. `300.0`, pois o mouse é removido.
    3. `380.0` no cenário inicial: quantidade negativa não modifica a linha nem o pedido.

Execute os cenários separadamente ou recrie o pedido antes de cada um.
`Pedido.calcularTotal()` deve permanecer igual: ele só percorre as linhas
presentes e solicita seus subtotais.

### Incremento D — Fazer o fechamento valer para toda edição

Revise as operações que mudam a coleção ou a quantidade. Depois de
`pedido.fechar()`, `adicionarItem`, `removerItem` e `alterarQuantidade`
devem preservar exatamente o estado que já existia.

```java
Pedido fechado = new Pedido();
fechado.adicionarItem(teclado, 2);
fechado.adicionarItem(mouse, 1);
fechado.fechar();

fechado.removerItem(mouse);
fechado.alterarQuantidade(teclado, 3);
fechado.adicionarItem(mouse, 2);

System.out.println(fechado.calcularTotal());
```

Antes de executar, preveja o valor final e explique por que `ItemPedido` não
precisa receber uma referência para `Pedido`.

??? "Ver resposta"

    O valor é `380.0`. O pedido fechado mantém teclado com duas unidades e mouse com uma; as três operações posteriores são recusadas. A decisão fica em `Pedido`, que conhece o fechamento e recebe toda solicitação de edição. `ItemPedido` preserva apenas a regra de sua própria quantidade.

Execute e crie também outro pedido aberto com os mesmos produtos. Ele ainda deve
aceitar suas próprias operações: o fechamento pertence a cada objeto `Pedido`.

## Verificação final

!!! success "Critérios de conclusão"

    Verifique se o código final:

    - compila e executa sem erros;
    - mantém `Main.java`, `Produto.java`, `ItemPedido.java` e `Pedido.java`;
    - mantém a `List<ItemPedido>` privada e não oferece getter para modificá-la;
    - mantém no máximo uma linha por mesma referência de `Produto`;
    - remove a linha encontrada, sem alterar o pedido quando ela não existe;
    - altera uma quantidade positiva delegando ao `ItemPedido`;
    - remove a linha quando a nova quantidade é zero e preserva o estado quando ela é negativa;
    - preserva adição, remoção e alteração depois de `fechar()`; e
    - mantém `calcularTotal()` delegando subtotais aos itens.

### Antes de entregar, confira seu raciocínio

1. Por que o cliente não deve receber a lista para chamar `remove` diretamente?
2. Por que `Pedido` localiza a linha, mas `ItemPedido` altera sua própria quantidade?
3. Por que `mouse` e `new Produto("Mouse", 80.0)` não identificam a mesma linha?
4. O que permanece igual em `calcularTotal()` depois desta evolução?

??? "Ver uma explicação possível"

    1. A lista é estado interno do pedido; expô-la permite contornar as regras de fechamento e de uma linha por produto.
    2. O pedido conhece o conjunto e as regras estruturais; o item conhece a quantidade que mantém.
    3. Cada `new` cria uma identidade diferente, e a versão localiza por referência.
    4. O pedido continua percorrendo as linhas presentes e solicitando `calcularSubtotal()` a cada uma.

## Desafio adicional — uma inclusão repetida

Em um pedido aberto, tente adicionar teclado com duas unidades e, depois, a mesma
referência `teclado` com uma unidade. Preveja o total.

??? "Ver resposta"

    O total permanece `300.0`. Nesta versão, a segunda chamada não cria outra linha para a mesma referência. A regra torna a identificação usada por remoção e alteração não ambígua; ela não acumula quantidades automaticamente.

O desafio não faz parte dos critérios obrigatórios.

## Entrega

> **Projeto 1 — Versão 10: operações coerentes com o pedido**

Entregue somente os arquivos de código-fonte da **Versão 10**, conforme as
orientações disponíveis no [Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).
Não envie previsões, respostas, saídas copiadas, diagramas ou reflexões por
escrito.

## Materiais relacionados

- [Aula 10 — Completando as regras do pedido](aula-10-completando-as-regras-do-pedido.md)
- [Aula 09 — Fechamento do pedido](aula-09-fechamento-do-pedido.md)
- [Laboratório 09 — Fechando um pedido](laboratorio-09-fechamento-do-pedido.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
