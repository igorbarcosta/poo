# Laboratório 09 — Fechando um pedido

Na Versão 8 do Projeto 1, `Pedido` cria seus itens, mantém a coleção privada e
calcula o total por colaboração. A Aula 09 mostrou que essa estrutura ainda
permite uma inclusão depois que o cliente considera o pedido concluído. Agora
vamos fazer o próprio pedido reconhecer o fechamento e proteger sua operação de
inclusão.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode ajudar a interpretar erros de compilação, explicar uma condição `boolean` e fazer perguntas para você verificar o efeito de cada mudança. Ela não deve gerar a solução completa, decidir a implementação por você nem introduzir recursos ainda não estudados.

!!! warning "Laboratório acompanhado — presença requerida"

    Esta evolução altera uma operação já usada no projeto. Faça as previsões antes de executar e confira se as inclusões anteriores ao fechamento continuam funcionando.

## Objetivos

Ao final deste laboratório, você deverá ser capaz de:

- representar o fechamento como estado de cada `Pedido`;
- oferecer uma operação para fechar o pedido sem expor seu campo interno;
- impedir a criação e a inclusão de itens depois do fechamento;
- verificar que pedidos diferentes mantêm estados independentes; e
- preservar o cálculo do total por delegação aos itens.

## Projeto 1 — Versão 9: o pedido fechado recusa novos itens

Parta de uma cópia da **Versão 8** concluída no Laboratório 08. Preserve os
arquivos `Main.java`, `Produto.java`, `ItemPedido.java` e `Pedido.java`, com as
responsabilidades e validações já construídas. Em particular,
`Pedido.adicionarItem(Produto, int)` recebe um produto existente e uma
quantidade, cria o `ItemPedido` dentro da operação e o guarda na lista privada.

O novo requisito é:

> Depois que um pedido é fechado, não podem ser adicionados novos itens.

Todo pedido novo começa aberto. Uma operação pública `fechar()` deve permitir
fechá-lo. Enquanto estiver aberto, `adicionarItem(Produto, int)` continua
funcionando como na Versão 8; depois do fechamento, a operação não deve criar
nem adicionar outro `ItemPedido`. Sua assinatura continua com retorno `void`.
`calcularTotal()` deve continuar disponível e calculando os itens já presentes.

Não crie uma regra geral que proíba toda alteração possível no domínio. Nesta
versão, não implemente reabertura, remoção, preço histórico, tratamento de
`null`, comunicação da recusa por retorno ou exceção, nem novas regras para
pedido vazio, fechamento repetido ou alteração da quantidade de itens.

Você entregará somente o código-fonte final da Versão 9. Previsões e respostas
podem ficar em papel ou rascunho; não fazem parte da entrega.

## Evolução do projeto

Use a sequência **prever → modificar → executar → observar → compreender** em
cada incremento. Os resultados intermediários mostram o efeito da mudança que
acabou de ser feita; o projeto deve atender ao requisito completo ao final.

### Incremento A — Representar o fechamento

Em `Pedido`, acrescente um estado privado que indique se aquele pedido está
fechado. Faça um pedido novo começar aberto e ofereça a operação pública
`fechar()` para mudar esse estado. Não forneça um setter público para o campo.

Em `Main`, use dois produtos existentes ou crie este cenário:

```java
Produto teclado = new Produto("Teclado", 150.0);
Produto mouse = new Produto("Mouse", 80.0);

Pedido primeiro = new Pedido();
primeiro.adicionarItem(teclado, 2);
primeiro.fechar();
primeiro.adicionarItem(mouse, 1);
System.out.println(primeiro.calcularTotal());
```

Neste incremento, **ainda não altere `adicionarItem`**. Antes de executar,
preveja o total que o programa exibirá e explique o que esse resultado mostra
sobre o efeito atual de `fechar()`.

??? "Ver resposta"

    O total ainda é `380.0`: `300.0` do teclado mais `80.0` do mouse. `Pedido` já consegue registrar que foi fechado, mas `adicionarItem` ainda não consulta esse estado. Criar o estado foi uma mudança real no programa; falta conectá-lo à operação que altera a coleção.

Compile e execute. Se sua `Main` já exibir outros valores da Versão 8, confira
especificamente a saída desta sequência.

### Incremento B — Proteger a entrada dos itens

Agora evolua `Pedido.adicionarItem(Produto, int)`: quando o pedido estiver
fechado, a operação não deve criar nem guardar um item. Quando estiver aberto,
ela deve manter exatamente o comportamento anterior. Preserve a assinatura
`void` e a coleção privada.

??? tip "Dica"

    Verifique o estado antes da expressão `new ItemPedido(...)`. Uma condição `if (!fechado) { ... }` pode envolver a criação e a inclusão, deixando ambas fora da execução quando o pedido estiver fechado.

Antes de executar de novo, preveja:

1. o novo total de `primeiro`;
2. quantos itens essa sequência deve criar depois da mudança;
3. se `calcularTotal()` precisou ser alterado.

??? "Ver resposta"

    1. `300.0`: a tentativa de adicionar o mouse depois do fechamento é recusada.
    2. Apenas um `ItemPedido`, criado quando o teclado entrou antes do fechamento. A chamada posterior não deve executar `new ItemPedido(...)`.
    3. Não. O cálculo ainda percorre os itens presentes e solicita `calcularSubtotal()` a cada um.

Execute a mesma sequência do Incremento A. A saída dessa sequência deve mudar
de `380.0` para `300.0`. Confira no código que a condição protege **tanto** a
criação do item quanto sua inclusão na lista. Uma verificação apenas em `Main`
não atenderia ao requisito para outros clientes de `Pedido`.

### Incremento C — Conferir que cada pedido tem seu próprio estado

No mesmo `Main`, acrescente um segundo pedido usando o `Produto mouse` já
criado. Deixe-o aberto e adicione uma unidade de mouse. Exiba o total desse
segundo pedido depois do total de `primeiro`.

Antes de executar, preveja os dois valores e explique se fechar `primeiro`
poderia, por si só, fechar `segundo`.

??? "Ver resposta"

    Os valores são `300.0` para `primeiro` e `80.0` para o segundo pedido. `new Pedido()` cria outro objeto com seu próprio estado inicial aberto e sua própria coleção. Compartilhar o mesmo `Produto mouse` entre chamadas não compartilha o estado dos pedidos.

Execute e confira os resultados. Esse segundo pedido deve aceitar a inclusão
normalmente, mesmo depois de `primeiro` ter sido fechado. Não é necessário
adicionar uma relação entre os dois pedidos nem alterar `Produto` ou
`ItemPedido`.

## Verificação final

Com teclado a `150.0` e mouse a `80.0`, verifique no código final:

1. `primeiro` recebe duas unidades de teclado, é fechado e depois recebe uma
   tentativa de incluir uma unidade de mouse: total `300.0`;
2. outro pedido, ainda aberto, recebe uma unidade do mesmo mouse: total
   `80.0`.

??? "Ver o que os resultados mostram"

    O primeiro resultado mostra que o pedido fechado não recebeu o novo item e preservou o já existente. O segundo mostra que o estado de fechamento pertence a cada `Pedido`. Em ambos, o total continua vindo dos subtotais solicitados a `ItemPedido`.

!!! success "Critérios de conclusão"

    Confira se o código final:

    - compila e executa sem erros;
    - parte da Versão 8 e mantém os quatro arquivos Java do projeto;
    - faz cada `Pedido` nascer aberto e oferece `fechar()`;
    - não expõe o estado de fechamento para alteração direta;
    - mantém `adicionarItem(Produto, int)` com retorno `void`;
    - cria e adiciona itens enquanto o pedido está aberto;
    - não cria nem adiciona itens depois que o pedido é fechado;
    - mantém a lista privada e `calcularTotal()` delegando `calcularSubtotal()`;
    - produz `300.0` e `80.0` nos cenários de verificação.

### Antes de entregar, confira seu raciocínio

1. Por que a verificação fica em `Pedido.adicionarItem` e não apenas em `Main`?
2. Por que ela deve acontecer antes de criar `ItemPedido`?
3. Por que `ItemPedido.calcularSubtotal()` não precisa saber se o pedido está
   fechado?

??? "Ver uma explicação possível"

    1. Toda inclusão passa pela operação de `Pedido`; clientes diferentes não precisam repetir a regra.
    2. Assim, a chamada recusada não cria um objeto que não será adicionado.
    3. Fechar impede novas inclusões, mas não muda o subtotal dos itens já presentes. Cada item continua responsável por seu próprio cálculo.

## Desafio adicional — inclusão antes do fechamento

Se terminar o núcleo, monte um terceiro pedido com teclado (2 unidades) e mouse
(1 unidade), ambos adicionados **antes** de `fechar()`. Depois de fechar, tente
adicionar mais uma unidade de mouse. Preveja o total antes de executar.

??? "Ver resposta"

    O total deve continuar `380.0`. Os dois primeiros itens entraram enquanto o pedido estava aberto; a tentativa posterior não cria nem acrescenta um terceiro item. O desafio apenas combina casos já estudados e não integra os critérios obrigatórios.

## Entrega

> **Projeto 1 — Versão 9: o pedido fechado recusa novos itens**

Entregue somente os arquivos de código-fonte da **Versão 9**, conforme as
orientações disponíveis no [Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).
Não envie previsões, respostas, saídas copiadas, diagramas ou reflexões por
escrito.

## Materiais relacionados

- [Aula 09 — Fechamento do pedido](aula-09-fechamento-do-pedido.md)
- [Laboratório 08 — Mantendo relações no pedido](laboratorio-08-mantendo-relacoes-no-pedido.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
