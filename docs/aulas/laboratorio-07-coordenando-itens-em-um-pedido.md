# Laboratório 07 — Coordenando itens em um pedido

Na Versão 6 do Projeto 1, `Produto` e `ItemPedido` passaram a colaborar no cálculo do subtotal. Agora o projeto deverá representar um pedido com uma quantidade variável de itens e calcular o total sem copiar para `Pedido` as regras que já pertencem aos seus colaboradores.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode:

    - esclarecer mensagens de compilação;
    - ajudar você a ler a declaração de uma lista e o `for` aprimorado;
    - fazer perguntas que ajudem a acompanhar referências e chamadas.

    Ela não deve gerar a solução completa, tomar as decisões por você nem introduzir recursos ainda não estudados.

!!! warning "Laboratório acompanhado — presença requerida"

    Este laboratório é acompanhado porque introduz uma coleção de colaboradores e um percurso que distribui chamadas entre três tipos de objeto.

## Objetivos

Ao final deste laboratório, você deverá ser capaz de:

- representar uma quantidade variável de itens com `List` e `ArrayList`;
- adicionar a uma coleção referências para objetos existentes;
- percorrer objetos com o `for` aprimorado;
- implementar `Pedido` como coordenador do cálculo total;
- preservar em `ItemPedido` a responsabilidade pelo subtotal.

## Projeto 1 — Versão 7: o pedido coordena seus itens

Parta da **Versão 6** concluída no Laboratório 06. Crie uma cópia da versão anterior e preserve:

- `Produto` com descrição e preço;
- `ItemPedido` com uma referência para `Produto` e sua quantidade;
- as validações de estado já implementadas;
- `ItemPedido.calcularSubtotal()` consultando o preço do produto;
- os cenários de referências compartilhadas e identidades independentes.

Ao final, o projeto terá `Main.java`, `Produto.java`, `ItemPedido.java` e `Pedido.java`.

O novo requisito é:

> Um `Pedido` deve nascer com uma coleção vazia, receber itens existentes e calcular o total solicitando o subtotal de cada item.

Nesta versão, não implemente remoção de itens, quantidade máxima, desconto, fechamento, preço histórico nem tratamento de `null`. Também não devolva a coleção interna por meio de um getter.

Você entregará somente o código final. Previsões e explicações podem ficar em papel ou rascunho.

## Evolução do projeto

### Incremento A — Criar o responsável pelo conjunto

Crie `Pedido.java`. Importe `List` e `ArrayList`, declare uma lista privada de itens e faça todo pedido nascer com uma lista vazia.

??? tip "Dica"

    ```java
    import java.util.ArrayList;
    import java.util.List;

    public class Pedido {
        private List<ItemPedido> itens;

        public Pedido() {
            itens = new ArrayList<>();
        }
    }
    ```

Em `Main`, crie um pedido vazio. Antes de implementar qualquer cálculo, preveja qual deve ser o total desse pedido quando a operação existir e explique por que uma lista vazia é um estado inicial coerente.

??? "Ver resposta"

    - O total esperado é `0.0`, pois não existe subtotal a acumular.
    - A lista vazia permite que o objeto nasça pronto para receber itens, sem exigir um primeiro item artificial.

Ao final deste incremento, existe um objeto responsável pelo conjunto, mas ele ainda não consegue receber colaboradores.

### Incremento B — Adicionar referências existentes

Acrescente a `Pedido` uma operação que receba um `ItemPedido` existente e guarde sua referência na lista.

??? tip "Dica"

    ```java
    public void adicionarItem(ItemPedido item) {
        itens.add(item);
    }
    ```

Em `Main`, monte este cenário:

```java
Produto teclado = new Produto("Teclado", 150.0);
Produto mouse = new Produto("Mouse", 80.0);

ItemPedido itemTeclado = new ItemPedido(teclado, 2);
ItemPedido itemMouse = new ItemPedido(mouse, 1);

Pedido pedido = new Pedido();
pedido.adicionarItem(itemTeclado);
pedido.adicionarItem(itemMouse);
```

Antes de avançar, responda:

1. quantos novos objetos `ItemPedido` são criados pelas chamadas a `adicionarItem`;
2. se a lista mantém cópias ou referências para os itens existentes;
3. o que aconteceria se `itemTeclado` fosse adicionado novamente.

??? "Ver resposta"

    1. Nenhum `ItemPedido` é criado: não existe `new ItemPedido(...)` nessas chamadas.
    2. A lista mantém referências para os objetos existentes.
    3. Outra posição da lista apontaria para o mesmo `ItemPedido`; a lista não impede repetição automaticamente.

Não crie `getItens()`. O próximo incremento dará ao pedido o comportamento de que o código cliente realmente precisa, sem entregar sua coleção interna para modificação externa.

### Incremento C — Coordenar o cálculo total

Implemente em `Pedido` uma operação `calcularTotal()` que:

- comece com total `0.0`;
- percorra todos os itens com o `for` aprimorado;
- solicite `calcularSubtotal()` a cada item;
- acumule e devolva o total.

??? tip "Dica"

    ```java
    public double calcularTotal() {
        double total = 0.0;

        for (ItemPedido item : itens) {
            total += item.calcularSubtotal();
        }

        return total;
    }
    ```

Antes de executar, preveja:

1. o subtotal solicitado ao item do teclado;
2. o subtotal solicitado ao item do mouse;
3. o total do pedido com os dois itens;
4. o total de um novo pedido vazio;
5. quantas vezes `Produto.getPreco()` participa do cálculo do pedido com dois itens.

Em `Main`, exiba `pedido.calcularTotal()` e `new Pedido().calcularTotal()`. Execute e compare os resultados.

??? "Ver resposta"

    1. O item do teclado devolve `300.0`.
    2. O item do mouse devolve `80.0`.
    3. O pedido devolve `380.0`.
    4. O pedido vazio devolve `0.0`.
    5. `Produto.getPreco()` participa duas vezes: uma durante o subtotal de cada item.

O percurso pertence a `Pedido`, porque ele conhece o conjunto. O cálculo de cada subtotal continua em `ItemPedido`, que conhece sua quantidade e solicita o preço a `Produto`.

!!! trap "Armadilha — o coordenador refazendo o subtotal"

    Não multiplique preço e quantidade dentro de `Pedido`. Uma expressão como `item.getProduto().getPreco() * item.getQuantidade()` faz o coordenador conhecer detalhes da regra do item. Use `item.calcularSubtotal()`.

## Verificação final

Execute também um pedido com um único item e confirme que o mesmo método funciona sem qualquer alteração em `Pedido`.

??? "Ver resultado esperado"

    - Um pedido contendo somente `itemMouse` devolve `80.0`.
    - O código de `Pedido.calcularTotal()` permanece igual para zero, um ou vários itens.

!!! success "Critérios de conclusão"

    Verifique se o código final:

    - compila e executa sem erros;
    - contém `Main.java`, `Produto.java`, `ItemPedido.java` e `Pedido.java`;
    - preserva as responsabilidades e validações da Versão 6;
    - mantém uma `List<ItemPedido>` privada em `Pedido`;
    - inicializa a lista com `new ArrayList<>()` no construtor;
    - adiciona itens existentes sem criar cópias;
    - não fornece um getter para modificar a coleção interna;
    - percorre os itens com o `for` aprimorado;
    - solicita `calcularSubtotal()` a cada item;
    - devolve `380.0` para o cenário principal e `0.0` para um pedido vazio;
    - não reproduz em `Pedido` a multiplicação do subtotal.

### Antes de entregar, você deve conseguir explicar

- por que `Pedido` mantém a coleção;
- por que `itens.add(item)` não cria nem copia um item;
- qual objeto percorre a coleção;
- como a chamada passa por `Pedido`, `ItemPedido` e `Produto`;
- por que coordenar não significa absorver o trabalho dos colaboradores.

??? "Ver uma explicação possível"

    - `Pedido` mantém a coleção porque representa o conjunto de itens.
    - `itens.add(item)` guarda a referência recebida; não há expressão `new` nem operação de cópia.
    - `Pedido` percorre a coleção porque conhece o conjunto completo.
    - `Pedido` solicita o subtotal a `ItemPedido`, que solicita o preço a `Produto` e combina esse valor com sua quantidade.
    - Coordenar é organizar essas solicitações; cada colaborador continua responsável pela regra que depende de seu próprio estado.

Use a explicação expansível para conferir seu raciocínio. Essa autoavaliação não faz parte da entrega.

## Desafio adicional — observar aliasing dentro da coleção

Se concluir o núcleo, adicione `itemTeclado` a um pedido, altere sua quantidade por uma operação pública já existente e calcule novamente o total. Antes de executar, preveja se o pedido observará a alteração.

??? "Ver resposta"

    Sim. A variável e a posição da lista permitem chegar ao mesmo `ItemPedido`; portanto, o próximo cálculo usa o estado atualizado. Não é necessário mudar `Pedido`.

O desafio não faz parte dos critérios obrigatórios.

## Entrega

> **Projeto 1 — Versão 7: o pedido coordena seus itens**

Entregue somente os arquivos de código-fonte da **Versão 7**, conforme as orientações disponíveis no [Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).

Não envie previsões, respostas, prints, diagramas ou reflexões por escrito.

## Materiais relacionados

- [Aula 07 — Um objeto coordenando vários outros](aula-07-um-objeto-coordenando-varios-outros.md)
- [Laboratório 06 — Conectando produtos e itens](laboratorio-06-conectando-produtos-e-itens.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
