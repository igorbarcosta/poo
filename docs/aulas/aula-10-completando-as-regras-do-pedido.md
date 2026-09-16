# Aula 10 — Completando as regras do pedido

Na Versão 9 do Projeto 1, `Pedido` cria e mantém seus itens, calcula o total
por colaboração e recusa novas inclusões depois de fechado. O modelo ainda não
permite corrigir uma quantidade nem retirar uma linha. Essas operações parecem
pequenas, mas só funcionam bem quando respeitam quem já é responsável pelo quê.

!!! lesson-question "Pergunta central"

    Como completar as operações de um pedido sem quebrar as responsabilidades que já construímos?

!!! lesson-objectives "Objetivos"

    Ao final deste estudo, você deverá ser capaz de:

    - reconhecer decisões de requisito que ainda faltam antes de implementar remoção ou alteração;
    - justificar por que `Pedido` localiza itens e protege sua coleção;
    - preservar em `ItemPedido` a responsabilidade por sua quantidade e seu subtotal;
    - usar identidade de referência para localizar a linha de um produto nesta versão; e
    - prever o efeito de remover, alterar quantidade e fechar um pedido.

<!-- bloco-didatico: 10.1 | estimativa: 25–30 min -->

## Remover qual item, exatamente?

Considere um pedido aberto com duas linhas: teclado, duas unidades a `150.0`, e
mouse, uma unidade a `80.0`. O total é `380.0`. Agora surge uma necessidade
natural: o cliente desistiu do mouse.

Uma primeira reação poderia ser entregar a coleção ao cliente:

```java
pedido.getItens().remove(...);
```

Antes mesmo de saber o argumento de `remove(...)`, o cliente passou a decidir
como a coleção de `Pedido` muda. Ele poderia remover uma linha depois do
fechamento, adicionar uma linha que o pedido não criou ou limpar a coleção
inteira. O objeto que representa o conjunto perderia o controle sobre suas
próprias regras.

!!! trap "Armadilha — usar a lista como API do pedido"

    `List` é o modo como `Pedido` armazena seus itens nesta implementação. Não é a operação de domínio que o cliente deve usar. O cliente solicita `removerItem(...)`; `Pedido` decide se e como sua coleção muda.

A frase “remover um item do pedido” ainda deixa perguntas em aberto:

- o item será localizado por produto, pela referência de um `ItemPedido` ou por posição na lista?
- se o mesmo produto aparecer em duas linhas, qual delas sai?
- remover reduz uma unidade ou elimina a linha inteira?
- o que acontece quando a linha não existe?
- um pedido fechado pode ser editado?

Índice é uma posição usada pela lista, não uma identidade expressiva para o
pedido. Como o cliente já possui referências para objetos `Produto` do catálogo,
esta versão usa o produto para localizar a linha e adota uma linha por **mesma
instância** de `Produto`. Remover elimina a linha inteira; se ela não existir,
nada muda.

!!! activity "Atividade — identifique a decisão escondida"

    Considere as duas chamadas abaixo. Elas fornecem o mesmo produto ao pedido?

    ```java
    Produto mouse = new Produto("Mouse", 80.0);
    pedido.adicionarItem(mouse, 1);

    Produto outroMouse = new Produto("Mouse", 80.0);
    pedido.removerItem(outroMouse);
    ```

    Nesta versão, `removerItem` deve localizar a linha? Por quê?

??? "Ver resposta"

    Não. As duas expressões `new Produto(...)` criam objetos com identidades diferentes. Nesta versão, o pedido localiza a linha pela mesma referência de `Produto` que recebeu na inclusão; seria necessário chamar `pedido.removerItem(mouse)`.

Essa escolha reaproveita identidade e referências já estudadas. Ela não afirma
que produtos com a mesma descrição nunca possam ser considerados iguais em outro
sistema. Não precisamos de `equals` nem de `hashCode` agora.

Para perguntar se uma linha corresponde ao produto recebido, `ItemPedido` pode
oferecer um comportamento pequeno e justificado:

```java
public boolean representa(Produto produto) {
    return this.produto == produto;
}
```

O método não expõe o campo `produto`. Ele responde à pergunta de que `Pedido`
precisa para localizar uma parte de sua própria coleção. A remoção fica no
objeto que mantém a lista:

```java
public void removerItem(Produto produto) {
    if (!fechado) {
        for (int indice = 0; indice < itens.size(); indice++) {
            ItemPedido item = itens.get(indice);

            if (item.representa(produto)) {
                itens.remove(indice);
                return;
            }
        }
    }
}
```

O `return` encerra a operação ao remover a linha. O percurso aparece porque o
pedido precisa encontrar a linha sobre a qual uma solicitação deve atuar; não
porque estamos estudando todas as operações de `List`.

!!! java-focus "Java em foco — remover durante um percurso"

    Para remover uma posição, esta operação percorre a lista com um índice interno: `itens.size()` informa quantas posições existem, `itens.get(indice)` obtém a referência naquela posição e `itens.remove(indice)` a remove. O índice é um detalhe de navegação usado dentro de `Pedido`; não é a identidade de uma linha para o cliente do pedido.

    O método retorna imediatamente após a remoção. Assim, não continua um percurso cuja estrutura acabou de mudar.

!!! conceito-chave "Conceito-chave — operação do conjunto"

    Quando uma operação precisa localizar e modificar uma parte de uma coleção, o objeto que mantém essa coleção deve coordenar a localização e decidir se a mudança é permitida. A parte encontrada continua responsável por suas próprias regras internas.

<!-- bloco-didatico: 10.2 | estimativa: 30–35 min -->

## Alterar quantidade não é alterar o estado de qualquer objeto

O cliente pediu quatro teclados, mas deveria ter pedido três. `Pedido` deve
decidir se a edição é permitida e encontrar a linha; isso não torna `Pedido`
dono da quantidade. Ela continua descrevendo aquele `ItemPedido`.

Compare duas propostas:

```java
// dentro de Pedido: proposta inadequada
item.quantidade = novaQuantidade;
```

```java
// dentro de Pedido: colaboração
item.alterarQuantidade(novaQuantidade);
```

A primeira nem deveria compilar se `quantidade` é privada. Torná-la pública só
para facilitar a escrita deslocaria para o cliente a proteção que cabe ao item.
A segunda permite que `ItemPedido` preserve sua regra:

```java
public void alterarQuantidade(int novaQuantidade) {
    if (novaQuantidade > 0) {
        quantidade = novaQuantidade;
    }
}
```

Nesta versão, uma linha existente sempre tem quantidade positiva. Quantidade
zero não é enviada para `ItemPedido`: ela significa remover a linha. Quantidade
negativa não altera o item.

!!! activity "Atividade — preveja duas operações relacionadas"

    Um pedido aberto contém teclado com quantidade `2` e mouse com quantidade
    `1`. Os preços são `150.0` e `80.0`. Preveja o total depois de cada sequência independente:

    1. `pedido.alterarQuantidade(teclado, 3);`
    2. `pedido.alterarQuantidade(mouse, 0);`
    3. `pedido.alterarQuantidade(teclado, -1);`

??? "Ver resposta"

    1. `530.0`: teclado contribui com `450.0` e mouse com `80.0`.
    2. `300.0`: quantidade zero remove a linha do mouse.
    3. `380.0`: quantidade negativa não é válida e não muda o pedido.

`Pedido.alterarQuantidade(...)` combina essas decisões sem escrever dentro do
item:

```java
public void alterarQuantidade(Produto produto, int novaQuantidade) {
    if (!fechado) {
        for (int indice = 0; indice < itens.size(); indice++) {
            ItemPedido item = itens.get(indice);

            if (item.representa(produto)) {
                if (novaQuantidade == 0) {
                    itens.remove(indice);
                } else {
                    item.alterarQuantidade(novaQuantidade);
                }
                return;
            }
        }
    }
}
```

Para preservar uma linha por produto, `adicionarItem` só cria uma linha se o
pedido estiver aberto, a quantidade for positiva e o produto ainda não estiver
representado na lista. Outro sistema poderia acumular quantidades ou aceitar
linhas repetidas; aqui a regra simples evita ambiguidade sem novas classes.

<!-- bloco-didatico: 10.3 | estimativa: 25–30 min -->

## O fechamento protege também as operações que corrigem o pedido?

Agora há duas novas formas de mudar total e estrutura: remover uma linha e
alterar sua quantidade. Se continuassem permitidas depois do fechamento, o
pedido poderia ser modificado mesmo quando a inclusão já está bloqueada.

Para esta versão, a regra é direta: **pedido fechado não aceita adição,
remoção nem alteração de quantidade**. Por isso, cada operação de edição de
`Pedido` consulta `fechado`. `ItemPedido` não precisa conhecer o pedido; ele só
recebe uma alteração que o pedido aberto já autorizou.

!!! activity "Atividade — diagnostique a responsabilidade"

    Considere três propostas para impedir alteração depois de `pedido.fechar()`:

    1. `Main` verifica se o pedido foi fechado antes de chamar a operação.
    2. `Pedido.alterarQuantidade(...)` e `Pedido.removerItem(...)` verificam `fechado`.
    3. `ItemPedido.alterarQuantidade(...)` recebe um `Pedido` para consultar se ele foi fechado.

    Qual protege a regra para qualquer cliente? Qual acrescenta uma relação desnecessária?

??? "Ver resposta"

    A proposta 2 protege todas as solicitações porque elas passam por `Pedido`, que conhece a coleção e seu próprio estado. A proposta 1 depende de cada cliente lembrar da regra. A proposta 3 faz `ItemPedido` conhecer `Pedido` só para decidir uma alteração estrutural que pertence ao pedido.

Considere agora:

```java
Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 2);
pedido.adicionarItem(mouse, 1);
pedido.fechar();

pedido.removerItem(mouse);
pedido.alterarQuantidade(teclado, 3);
System.out.println(pedido.calcularTotal());
```

!!! activity "Atividade — siga o estado depois do fechamento"

    Qual valor é exibido? Quantas linhas permanecem no pedido?

??? "Ver resposta"

    `380.0`, com duas linhas. Depois de `fechar()`, nem a remoção do mouse nem a alteração do teclado são permitidas; as duas operações preservam o estado.

| Parte do modelo | Responsabilidade ao final da Versão 10 |
| --- | --- |
| `Produto` | mantém e fornece descrição e preço; não conhece pedidos nem itens |
| `ItemPedido` | mantém produto e quantidade, reconhece seu produto por referência, protege quantidade positiva e calcula subtotal |
| `Pedido` | mantém a coleção privada, localiza linhas, cria, remove e coordena alterações permitidas, protege o fechamento e calcula o total por delegação |
| `Main` ou outro cliente | cria produtos, solicita operações de domínio e observa seus efeitos; não modifica lista ou campos internos |
| `calcularTotal()` | permanece igual: percorre as linhas presentes e solicita seus subtotais |

!!! synthesis "Síntese"

    Completar um modelo significa preservar as responsabilidades ao acrescentar operações:

    - cada linha é localizada pela mesma referência de `Produto` usada na inclusão;
    - `Pedido` mantém a coleção privada, localiza linhas e decide se a edição é permitida;
    - `ItemPedido` preserva a quantidade positiva e calcula seu próprio subtotal;
    - quantidade zero remove a linha, e quantidade negativa preserva o estado; e
    - um pedido fechado preserva itens e quantidades, enquanto `Produto` e `calcularTotal()` permanecem com as responsabilidades que já tinham.

Essas regras agora são claras o bastante para serem verificadas sistematicamente
na próxima aula. Antes disso, o [Laboratório 10](laboratorio-10-completando-as-regras-do-pedido.md)
aplica a evolução ao Projeto 1.

## Material da aula

- [Aula 09 — Fechamento do pedido](aula-09-fechamento-do-pedido.md)
- [Laboratório 09 — Fechando um pedido](laboratorio-09-fechamento-do-pedido.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
