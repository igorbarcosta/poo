# Aula 13 — Como saber se ainda funciona?

Na Aula 12, `Pedido` passou a colaborar com `EntregaNormal`. Essa solução funciona, mas uma segunda forma de entrega mostrou que a dependência de uma classe concreta terá de mudar. Antes de alterar essa colaboração, precisamos conservar evidências do que o pedido já faz corretamente.

**Slides:** [Apresentação HTML](../slides/rendered/aula-13-como-saber-se-ainda-funciona.html) · [PDF](../slides/rendered/aula-13-como-saber-se-ainda-funciona.pdf)

!!! lesson-question "Pergunta central"

    Como verificar automaticamente que uma mudança preservou comportamentos que já funcionavam?

!!! lesson-objectives "Objetivos"

    Ao final deste estudo, você deverá ser capaz de:

    - transformar uma expectativa de comportamento em uma verificação executável;
    - escrever testes JUnit básicos com cenário, ação e resultado esperado;
    - escolher nomes e cenários que comuniquem regras do sistema;
    - verificar o comportamento público, inclusive quando uma operação deve preservar o estado; e
    - explicar o alcance e o limite de um teste que passa.

<!-- Núcleo de 90 min: do console à comparação automática; primeiro teste e leitura;
cenários de estado e entrega; falha proposital, limite e síntese. Elasticidade:
comparar cenários independentes e escolher a próxima regra da Versão 10. -->

## Do resultado impresso à expectativa verificável

Retome uma regra conhecida do Projeto 1. Um teclado custa `150.0`; duas unidades somam `300.0`:

```java
Produto teclado = new Produto("Teclado", 150.0);
Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 2);

System.out.println(pedido.calcularTotal());
```

O console mostra `300.0`. Para conferir, alguém precisa saber o valor esperado e comparar as duas informações. Podemos começar a escrever essa expectativa no programa:

```java
System.out.println(pedido.calcularTotal() == 300.0);
```

A saída agora é `true`. A comparação está no código, mas ainda precisamos olhar o console para saber o resultado. Podemos fazer o próprio programa apontar quando a expectativa não é satisfeita:

```java
double esperado = 300.0;
double observado = pedido.calcularTotal();

if (observado != esperado) {
    System.out.println("ERRO: total esperado " + esperado
        + ", obtido " + observado);
}
```

!!! activity "Atividade — o que mudou na verificação?"

    1. Se `calcularTotal()` devolver `300.0`, o que o último trecho imprime?
    2. Se devolver `150.0`, o que acontece?
    3. Que trabalho ainda seria necessário para verificar trinta regras assim?

??? "Ver resposta"

    1. Nada: a condição do `if` é falsa.
    2. O programa imprime `ERRO: total esperado 300.0, obtido 150.0`.
    3. Teríamos de repetir comparações, mensagens e execução, além de localizar qual verificação falhou. Já sabemos **o que** queremos fazer; falta uma forma simples de organizar e executar muitas verificações.

!!! conceito-chave "Conceito-chave — comportamento como expectativa"

    Verificar um comportamento é preparar um cenário, observar uma operação e comparar o resultado com uma expectativa definida. A expectativa também precisa estar escrita no código para que a comparação seja automática.

## Uma estrutura para executar verificações

JUnit organiza essas verificações em métodos de teste. Considere a cópia do Projeto 1 usada nesta aula: `Pedido` nasce aberto, recebe itens e, quando for fechado, recebe uma `EntregaNormal`. O primeiro teste usa somente o cálculo dos itens:

```java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class PedidoTest {
    @Test
    void calculaTotalDeUmItem() {
        Produto teclado = new Produto("Teclado", 150.0);
        Pedido pedido = new Pedido();
        pedido.adicionarItem(teclado, 2);

        assertEquals(300.0, pedido.calcularTotal());
    }
}
```

!!! java-focus "Java em foco — o mínimo de JUnit"

    - Os `import` tornam disponíveis `@Test` e `assertEquals`.
    - `@Test` marca um método que o executor de testes deve executar.
    - `assertEquals(esperado, observado)` compara os dois valores e registra uma falha quando diferem.
    - O método recebe um nome que descreve o comportamento verificado. Não precisamos chamá-lo por `main`.

Neste teste, as primeiras linhas **preparam** produto e pedido; `calcularTotal()` **executa** a operação observada; `assertEquals` **verifica** o resultado. Podemos chamar esse percurso de *Prepare → execute → verifique* (Arrange → Act → Assert). Os comentários com esses nomes são opcionais: o código deve continuar legível sem um ritual de marcação.

!!! activity "Atividade — leia a história do teste"

    Sem executar o código, identifique o cenário, a ação observada e a expectativa. Se o preço do teclado passar a `160.0` sem mudança na expectativa, qual será o resultado?

??? "Ver resposta"

    O cenário é um pedido aberto com duas unidades de um produto de `150.0`; a ação observada é `calcularTotal()`; a expectativa é `300.0`. Com preço `160.0`, o total observado passa a `320.0` e o teste falha. A falha pede investigação: pode ter mudado o requisito, a entrada do teste ou o código do pedido.

Com trinta testes, JUnit executa os métodos e mostra quais passaram ou falharam. Isso deixa de depender de alguém conferir cada linha de saída, mas o valor da verificação ainda depende da qualidade dos cenários e das expectativas que escrevemos.

## O nome e a observação devem revelar a regra

Compare `teste1()` com `pedidoFechadoNaoAceitaNovosItens()`. O segundo nome comunica a regra que alguém espera preservar quando o código mudar. Para verificá-la, podemos observar o total antes e depois de tentar uma inclusão:

```java
@Test
void pedidoFechadoNaoAceitaNovosItens() {
    Produto teclado = new Produto("Teclado", 150.0);
    Produto mouse = new Produto("Mouse", 80.0);
    Pedido pedido = new Pedido();

    pedido.adicionarItem(teclado, 1);
    pedido.fechar(new EntregaNormal());
    pedido.adicionarItem(mouse, 1);

    assertEquals(150.0, pedido.calcularTotal());
}
```

O teste não consulta `fechado`, a lista privada, um índice nem o `if` usado por `Pedido`. Ele observa o efeito público da chamada. Se a implementação mudar e a regra continuar verdadeira, esse teste deve continuar passando.

!!! activity "Atividade — procure o menor cenário que demonstra a regra"

    1. Por que este teste precisa criar dois produtos?
    2. Se `Pedido` trocar a forma de percorrer os itens, o teste deveria falhar?
    3. O total de `150.0` demonstra que **toda** edição é recusada após o fechamento?

??? "Ver resposta"

    1. Um produto estabelece o total inicial; o outro é a nova inclusão que deve ser recusada. Eles têm preços diferentes para tornar a mudança observável.
    2. Não, se o comportamento público permanecer igual.
    3. Não. Este cenário verifica a tentativa de **adicionar**. Remoção e alteração de quantidade precisam de cenários próprios se quisermos protegê-las.

Uma chamada pode ser importante justamente porque **não** deve alterar o estado. Na Versão 10, uma quantidade negativa preserva o item:

```java
@Test
void quantidadeNegativaNaoAlteraItem() {
    Produto teclado = new Produto("Teclado", 150.0);
    Pedido pedido = new Pedido();

    pedido.adicionarItem(teclado, 2);
    pedido.alterarQuantidade(teclado, -1);

    assertEquals(300.0, pedido.calcularTotal());
}
```

O teste usa a **mesma referência** `teclado` nas duas chamadas, como exige a regra de identificação do projeto. A expectativa `300.0` verifica que a tentativa inválida não substituiu a quantidade válida.

### Para aprofundar: um total igual pode esconder uma mudança

<!-- aprofundamento-elastico -->

Considere um pedido aberto com um teclado e um fone, ambos de `150.0`. Queremos verificar que a remoção do teclado preserva o fone:

```java
Produto teclado = new Produto("Teclado", 150.0);
Produto fone = new Produto("Fone", 150.0);
Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 1);
pedido.adicionarItem(fone, 1);

pedido.removerItem(teclado);
assertEquals(150.0, pedido.calcularTotal());
```

Se um defeito remover o **fone** em vez do teclado, essa verificação falha? Que operação pública permitiria distinguir os dois estados?

??? "Ver resposta e continuar o cenário"

    A verificação passa nos dois casos: tanto um fone quanto um teclado somam `150.0`. Ela verifica o total, mas não distingue qual produto permaneceu. Podemos continuar o cenário com a **mesma referência** de `fone`:

    ```java
    pedido.alterarQuantidade(fone, 2);
    assertEquals(300.0, pedido.calcularTotal());
    ```

    - Na implementação correta, o fone permaneceu e passa a ter duas unidades: total `300.0`.
    - Na implementação defeituosa, o fone foi removido. A alteração não encontra sua linha, e o teclado permanece com uma unidade: total `150.0`. A segunda verificação falha.

    O teste continua usando operações públicas. A observação adicional distingue o defeito que a primeira comparação deixava passar.

## Proteger a entrega antes de mudar a colaboração

Na Aula 12, `Pedido` passou a receber a entrega no fechamento. Antes de mudar a dependência concreta, podemos registrar o custo que já funciona:

```java
@Test
void entregaNormalCustaDezReais() {
    Pedido pedido = new Pedido();
    pedido.fechar(new EntregaNormal());

    assertEquals(10.0, pedido.calcularCustoEntrega());
}
```

Esse teste descreve uma expectativa do pedido fechado com entrega normal. Se mais tarde o campo deixar de ser `EntregaNormal` para aceitar outras formas de entrega, ainda queremos que o mesmo cenário produza `10.0`.

Para ver a proteção funcionando, imagine alterar provisoriamente a regra de `EntregaNormal`:

```java
public double calcularCusto(Pedido pedido) {
    return 20.0;
}
```

Agora a execução do teste deve indicar uma diferença equivalente a:

```text
esperado: 10.0
obtido:   20.0
```

Ao restaurar o custo `10.0`, o teste volta a passar. Essa passagem de falha para sucesso mostra que o teste consegue detectar **essa** alteração errada.

!!! activity "Atividade — delimite a evidência"

    1. Se o teste da entrega normal passar, isso prova que retirada local e entrega expressa funcionam?
    2. Se todos os testes que escrevemos passarem, podemos afirmar que o sistema não contém bugs?
    3. Antes de modificar `private EntregaNormal entrega;`, que outras regras da Versão 10 você escolheria proteger?

??? "Ver uma análise possível"

    1. Não. O teste executa somente um pedido fechado com entrega normal.
    2. Não. Cada teste compara o comportamento observado com a expectativa codificada **naquele cenário**. Outros cenários ou expectativas podem estar ausentes ou errados.
    3. Bons candidatos são remoção, alteração válida, quantidade zero, quantidade negativa e bloqueio de edições após o fechamento. Escolha cenários cujos resultados sejam observáveis pelas operações públicas do pedido.

!!! synthesis "Síntese"

    - Um teste registra uma expectativa executável sobre um cenário concreto.
    - Nome, cenário e verificação podem explicar a regra que desejamos preservar.
    - Testar o comportamento público permite mudar a implementação sem exigir que o teste conheça seus detalhes.
    - Uma suíte que passa oferece evidência limitada aos cenários e expectativas escritos.

```text
comportamento atual → teste → mudança → executar os testes novamente
```

O [Laboratório 13](laboratorio-13-protegendo-os-avisos-do-lembrete.md) transfere essa forma de verificar comportamento ao Projeto 2, sobre a solução de lembretes concluída no Laboratório 12. Depois, retomaremos a questão deixada pela Aula 12: **como fazer `Pedido` depender da responsabilidade “calcular entrega”, em vez de depender de `EntregaNormal`?**

## Materiais relacionados

- [Aula 12 — Quando um colaborador começa a variar](aula-12-quando-um-colaborador-comeca-a-variar.md)
- [Laboratório 10 — Completando as regras do pedido](laboratorio-10-completando-as-regras-do-pedido.md)
- [Laboratório 13 — Protegendo os avisos do lembrete](laboratorio-13-protegendo-os-avisos-do-lembrete.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
