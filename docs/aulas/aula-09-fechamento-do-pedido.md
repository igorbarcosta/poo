# Aula 09 — Fechamento do pedido

Na Versão 8 do Projeto 1, `Pedido` passou a criar e manter os itens que formam
sua estrutura. Cada item calcula o próprio subtotal com o preço fornecido por
`Produto`, e `Pedido` soma esses subtotais. O modelo já distribui bem o trabalho,
mas ainda aceita uma inclusão em qualquer momento.

Surge agora um requisito: **depois que um pedido é fechado, não podem ser
adicionados novos itens**. Vamos evoluir o modelo existente e descobrir que
partes precisam mudar para proteger essa regra.

!!! lesson-question "Pergunta central"

    Como `Pedido` pode impedir novas inclusões depois do fechamento sem refazer as responsabilidades dos objetos que já colaboram com ele?

!!! lesson-objectives "Objetivos"

    Ao final deste estudo, você deverá ser capaz de:

    - reconhecer aberto ou fechado como estado de cada `Pedido`;
    - justificar por que o próprio pedido deve controlar o fechamento e a inclusão;
    - prever o comportamento de tentativas de inclusão antes e depois de fechar;
    - explicar como um campo privado e operações públicas protegem a regra;
    - localizar o impacto da mudança sem redistribuir o cálculo do total.

<!-- bloco-didatico: 9.1 | estimativa: 25–30 min -->

## O que falta ao pedido que já calcula o total?

Na Versão 8, a parte relevante de `Pedido` pode ser lida assim:

```java
public class Pedido {
    private List<ItemPedido> itens;

    public Pedido() {
        itens = new ArrayList<>();
    }

    public void adicionarItem(Produto produto, int quantidade) {
        ItemPedido item = new ItemPedido(produto, quantidade);
        itens.add(item);
    }

    public double calcularTotal() {
        double total = 0.0;

        for (ItemPedido item : itens) {
            total += item.calcularSubtotal();
        }

        return total;
    }
}
```

Para compilar essa classe, os imports de `List` e `ArrayList` continuam sendo
necessários, como no [Laboratório 07](laboratorio-07-coordenando-itens-em-um-pedido.md).
O código acima mostra somente as operações que interessam à investigação.

Considere `Produto teclado = new Produto("Teclado", 150.0)` e
`Produto mouse = new Produto("Mouse", 80.0)`. Um cliente faz:

```java
Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 2);

// O cliente considera o pedido concluído.

pedido.adicionarItem(mouse, 1);
System.out.println(pedido.calcularTotal());
```

O comentário registra a intenção do cliente, mas não altera o estado de
`Pedido`. Para o objeto, as duas chamadas a `adicionarItem` são iguais: cada uma
cria um item e o guarda na lista. A segunda chamada ainda é aceita.

!!! activity "Atividade — preveja antes de mudar o modelo"

    Com os preços e quantidades acima, responda:

    1. qual total o código atual exibe?
    2. qual total deveria exibir se a segunda inclusão ocorresse depois de um fechamento efetivo?
    3. que informação o próprio `Pedido` ainda não possui para distinguir as duas situações?

??? "Ver resposta"

    1. `380.0`: o teclado contribui com `300.0` e o mouse com `80.0`.
    2. `300.0`: somente o item de teclado teria entrado antes do fechamento.
    3. Falta ao pedido um estado que indique se ele já foi fechado. O comentário em `Main` não fornece esse estado ao objeto.

O problema não está na soma nem no preço dos produtos. Falta representar uma
mudança no próprio pedido: ele começa aberto e, em algum momento, passa a
fechado. Para que essa mudança tenha efeito, precisamos decidir quem a controla
e quem consulta esse estado antes de incluir um item.

<!-- bloco-didatico: 9.2 | estimativa: 30–35 min -->

## Quem deve impedir uma inclusão depois do fechamento?

Uma primeira proposta é fazer `Main` lembrar se o pedido já foi concluído e
evitar a segunda chamada. Ela pode fazer esse trecho específico funcionar, mas
outro código que receba o mesmo `Pedido` ainda poderá chamar `adicionarItem`.
A regra dependeria da memória de cada cliente.

Outra proposta seria pedir a `ItemPedido` que decida se pode entrar. Porém, o
item não conhece o estado do pedido que o conterá. Na Versão 8, ele sequer
existe antes da chamada: é criado *dentro* de `adicionarItem`.

!!! activity "Atividade — localize a responsabilidade"

    Compare as propostas de verificar o fechamento em `Main`, em `ItemPedido` ou em `Pedido`. Qual delas protege a regra para toda chamada a `adicionarItem(Produto, int)`? Que informações esse objeto já reúne?

??? "Ver uma explicação possível"

    A verificação em `Pedido` protege todas as chamadas porque é sua operação `adicionarItem` que recebe a solicitação e mantém a coleção. O pedido conhece o próprio estado e o conjunto de itens. `Main` é apenas um cliente; `ItemPedido` conhece seu produto e sua quantidade, mas não o estado do pedido.

`Pedido` precisa, portanto, guardar se já foi fechado e oferecer uma operação
para efetuar essa transição. O cliente poderá solicitar `pedido.fechar()`, sem
escrever diretamente no campo interno.

!!! java-focus "Java em foco — um estado com dois valores"

    Um campo `boolean` pode guardar `false` ou `true`. Neste modelo, `false` significa que o pedido ainda está aberto; `true`, que foi fechado. Declarar `private boolean fechado;` mantém esse estado dentro de cada objeto `Pedido`.

    A condição `!fechado` significa “não está fechado”. Em `if (!fechado) { ... }`, o bloco executa somente enquanto o pedido está aberto.

O construtor pode deixar explícito que todo pedido nasce aberto. A operação de
fechamento muda apenas esse estado:

```java
private boolean fechado;

public Pedido() {
    itens = new ArrayList<>();
    fechado = false;
}

public void fechar() {
    fechado = true;
}
```

Acrescentar `fechado` ainda não impede uma inclusão: é preciso usá-lo na
operação que altera a coleção. O código atual cria o item antes de adicioná-lo.
Se a decisão for tomada somente depois de `new ItemPedido(...)`, um pedido
fechado ainda criará um objeto que não poderá aproveitar.

!!! activity "Atividade — onde fica a verificação?"

    Observe a ordem atual em `adicionarItem`: criar `ItemPedido` e depois adicioná-lo à lista. Em que ponto a condição sobre `fechado` deve ser verificada para que uma tentativa recusada não crie nem guarde um novo item?

??? "Ver resposta"

    A condição deve envolver a criação e a inclusão. Se o pedido já estiver fechado, nenhuma das duas instruções deve ser executada.

Uma implementação possível preserva a assinatura pública da Versão 8:

```java
public void adicionarItem(Produto produto, int quantidade) {
    if (!fechado) {
        ItemPedido item = new ItemPedido(produto, quantidade);
        itens.add(item);
    }
}
```

Enquanto `fechado` é `false`, a operação cria e guarda o item como antes. Depois
de `fechar()`, o bloco não executa: a lista permanece igual. `adicionarItem`
continua com retorno `void`; neste momento, a recusa é percebida pelo estado
preservado. Informar a recusa ao cliente seria outra decisão sobre a interface
da operação, ainda não exigida pelo requisito.

!!! conceito-chave "Conceito-chave — regra protegida pelo objeto"

    Quando uma alteração depende do estado de um objeto, a operação que realiza essa alteração deve preservar a regra. Aqui, depois que `Pedido` é fechado, `adicionarItem` não aumenta seu conjunto de itens. O cliente solicita ações; o pedido decide quais mudanças são permitidas.

Essa é uma invariante do comportamento da operação: em toda chamada a
`adicionarItem` feita enquanto o pedido está fechado, o conjunto de itens
permanece igual. A condição dentro de `Pedido` preserva a regra em qualquer
ponto do programa que utilize essa operação.

Essa regra é específica. Ela não afirma que *toda* propriedade de um pedido se
torna imutável depois de `fechar()`. Também não determina o que fazer com um
pedido vazio, uma segunda chamada a `fechar()` ou preços em outro momento. Essas
seriam perguntas adicionais, com requisitos próprios.

<!-- bloco-didatico: 9.3 | estimativa: 25–30 min -->

## O que realmente muda quando o pedido ganha uma regra?

Agora podemos executar uma sequência em dois pedidos. Os dois usam os mesmos
objetos `Produto` já criados; cada `Pedido` mantém sua coleção e seu próprio
estado de fechamento.

```java
Pedido primeiro = new Pedido();
primeiro.adicionarItem(teclado, 2);
primeiro.fechar();
primeiro.adicionarItem(mouse, 1);

Pedido segundo = new Pedido();
segundo.adicionarItem(mouse, 1);

System.out.println(primeiro.calcularTotal());
System.out.println(segundo.calcularTotal());
```

!!! activity "Atividade — acompanhe dois estados independentes"

    Antes de conferir a saída, preveja:

    1. o total exibido para `primeiro` e para `segundo`;
    2. quantos `ItemPedido` são criados pelas três chamadas a `adicionarItem`;
    3. por que o fechamento de `primeiro` não impede a inclusão em `segundo`.

??? "Ver resposta"

    1. A saída é `300.0` e depois `80.0`.
    2. São criados dois itens: o teclado entra em `primeiro` e o mouse entra em `segundo`. A tentativa de adicionar mouse ao pedido fechado não cria um item.
    3. `primeiro` e `segundo` são objetos diferentes. Cada um possui seu próprio campo `fechado` e sua própria lista.

O resultado não exige reescrever `calcularTotal()`. O método continua
percorrendo os itens que o pedido mantém e solicitando o subtotal de cada um.
`ItemPedido` continua combinando a quantidade com o preço pedido a `Produto`.

| Parte do modelo | Efeito deste requisito |
| --- | --- |
| `Pedido` | passa a guardar o fechamento e a proteger a entrada de novos itens |
| `Main` ou outro cliente | pode solicitar `fechar()` e observar o resultado das operações |
| `ItemPedido` | continua responsável pelo subtotal |
| `Produto` | continua fornecendo o preço ao item |
| Lista e `calcularTotal()` | a lista permanece privada; o método público de cálculo continua por delegação |

!!! activity "Atividade — diagnostique uma evolução"

    Três propostas tentam atender ao requisito:

    1. verificar `fechado` apenas em `Main`, antes de chamar `adicionarItem`;
    2. verificar `fechado` dentro de `Pedido.adicionarItem`, antes de criar o item;
    3. alterar `ItemPedido.calcularSubtotal()` para devolver `0.0` quando o pedido estiver fechado.

    Qual protege a inclusão para qualquer cliente? Qual proposta muda uma responsabilidade que o requisito não pediu para mudar?

??? "Ver resposta"

    A proposta 2 protege a regra no ponto por onde entram todos os novos itens. A proposta 1 depende de cada cliente lembrar da verificação. A proposta 3 muda indevidamente o subtotal: fechar não apaga itens existentes nem transforma seu valor em zero. Além disso, `ItemPedido` não conhece o estado de `Pedido` neste modelo.

### Para aprofundar: uma regra próxima, mas diferente

<!-- aprofundamento-elastico -->

Considere uma turma que aceita inscrições enquanto está aberta. Depois que as
inscrições são encerradas, não devem entrar novos estudantes. A turma mantém
sua lista privada e oferece `inscrever(estudante)`.

!!! activity "Atividade — transfira a decisão"

    Onde deve ficar a verificação de que as inscrições foram encerradas? Encerrar inscrições deveria fazer os estudantes já inscritos desaparecerem da lista?

??? "Ver uma explicação possível"

    A própria `Turma` deve verificar seu estado dentro de `inscrever`, porque mantém a lista e recebe toda solicitação de inclusão. Os estudantes já inscritos permanecem: a regra impede novas entradas, não remove as anteriores.

## Fechando a trajetória

!!! synthesis "Síntese"

    O novo requisito faz `Pedido` ganhar um estado e controlar uma transição. A guarda em `adicionarItem` impede a criação e a inclusão de novos itens depois do fechamento. A coleção continua privada; `calcularTotal()` continua delegando os subtotais a `ItemPedido`, que colabora com `Produto`. Uma evolução bem localizada preserva o que já cumpria sua responsabilidade.

No [Laboratório 09](laboratorio-09-fechamento-do-pedido.md), essa evolução será
aplicada à Versão 8 do Projeto 1. As previsões da aula ajudam a verificar tanto
o que a mudança deve impedir quanto o que ela deve preservar.

## Material da aula

- [Aula 08 — Relações entre objetos](aula-08-relacoes-entre-objetos.md)
- [Laboratório 08 — Mantendo relações no pedido](laboratorio-08-mantendo-relacoes-no-pedido.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
