---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 14 — Do colaborador concreto ao contrato

<div class="statement">Como aceitar outras entregas sem fazer Pedido conhecer cada classe concreta?</div>

<!-- Núcleo de 90 minutos: impedimento e papel 20; contrato e encaixe 25;
testes e nova entrega 25; referência e fechamento 20. Inclui tempo para
previsão individual, coleta coletiva e leitura. Aprofundamentos ao final
podem ser saltados para a síntese. Não formalizar despacho, herança ou casting. -->

---

<div class="chapter">O problema que ficou aberto na Aula 12</div>

## Pedido já funciona com a entrega normal

```java
private EntregaNormal entrega;

public void fechar(EntregaNormal entrega) {
    if (!fechado && entrega != null) {
        this.entrega = entrega;
        fechado = true;
    }
}
```

Nasce aberto e sem entrega; guarda a escolha no primeiro fechamento válido.

<!-- Este é o código inicial, não a hipótese de campos e códigos da Aula 12.
calcularTotal soma apenas itens. Não há entrega no construtor. -->

---

<!-- _class: activity -->

<div class="chapter">Uma segunda classe para o mesmo trabalho</div>

## A expressa cabe neste fechamento?

`EntregaExpressa` também oferece `calcularCusto(Pedido)`.

```java
Pedido pedido = new Pedido();
EntregaExpressa expressa = new EntregaExpressa();

pedido.fechar(expressa);
```

Compila? Qual declaração determina se esse argumento é aceito?

<!-- Dar tempo antes de revelar. A assinatura exige EntregaNormal.
Ter método de mesmo nome não torna estas classes intercambiáveis. -->

---

<div class="chapter">O impedimento está no tipo declarado</div>

## Saber calcular ainda não basta para entrar

```java
public void fechar(EntregaNormal entrega)
```

O parâmetro exige `EntregaNormal`; o argumento é `EntregaExpressa`.

As duas sabem calcular custo, mas a chamada **não compila**.

Que capacidade Pedido realmente precisa solicitar?

---

<div class="chapter">Compare as alternativas conhecidas</div>

## A operação é comum; a regra de custo varia

Todas oferecem:

```java
public double calcularCusto(Pedido pedido)
```

| Classe | Resultado neste exemplo |
| --- | ---: |
| `EntregaNormal` | `10.0` |
| `EntregaExpressa` | `25.0` |
| `RetiradaLocal` | `0.0` |

<!-- Os custos são fixos neste recorte. O parâmetro permite receber o pedido,
embora essas regras não consultem seus dados. Não inventar novas fórmulas. -->

---

<!-- _class: activity -->

<div class="chapter">Descreva o papel antes da construção de Java</div>

## Complete sem citar uma classe

<div class="statement">“Para calcular o custo, Pedido precisa de algo capaz de...”</div>

Que operação esse colaborador deve oferecer? Que resultado deve devolver?

<!-- Pedir formulações e justificativas antes da definição.
Calcular o custo da entrega para este pedido, recebendo Pedido e devolvendo
double. A implementação e o valor podem variar. -->

---

<!-- _class: concept-key -->

<div class="chapter">A necessidade agora tem uma descrição</div>

## Conceito-chave — contrato

Um contrato descreve o que um objeto precisa oferecer para ocupar um papel na colaboração.

Aqui: **calcular o custo da entrega de um pedido**.

Classes diferentes podem cumprir esse papel com regras diferentes.

---

<div class="chapter">Dar um nome de tipo ao papel</div>

## Entrega.java declara o contrato

```java
public interface Entrega {
    double calcularCusto(Pedido pedido);
}
```

`Entrega` nomeia a capacidade comum. Ainda não calcula custo algum.

---

<!-- _class: java-focus -->

<div class="chapter">Leia a declaração que acabamos de construir</div>

## Java em foco — interface

```java
double calcularCusto(Pedido pedido);
```

- Resultado: `double`; parâmetro: `Pedido`.
- A assinatura termina em `;`, sem corpo neste contrato.
- Essa operação é pública mesmo sem escrever `public`.

As classes concretas precisam oferecer uma implementação pública compatível.

---

<div class="chapter">As classes assumem a promessa</div>

## A normal conserva sua regra

EntregaNormal.java:

```java
public class EntregaNormal implements Entrega {
    public double calcularCusto(Pedido pedido) {
        return 10.0;
    }
}
```

`implements Entrega` declara que a classe cumpre o contrato.

---

<div class="chapter">O mesmo contrato também admite outra regra</div>

## A expressa continua calculando 25.0

EntregaExpressa.java:

```java
public class EntregaExpressa implements Entrega {
    public double calcularCusto(Pedido pedido) {
        return 25.0;
    }
}
```

A classe mudou sua declaração, mantendo a implementação do cálculo.

---

<!-- _class: activity -->

<div class="chapter">A retirada também precisa cumprir a promessa</div>

## Esta classe concreta compila?

RetiradaLocal.java, numa tentativa incompleta:

```java
public class RetiradaLocal implements Entrega {
}
```

O que falta? Ao completar, precisa devolver o mesmo valor da normal?

<!-- Não compila: falta implementar calcularCusto(Pedido) público com retorno
double. A classe não precisa devolver 10.0. Coletar antes do próximo frame. -->

---

<div class="chapter">Prometer exige oferecer a operação</div>

## A retirada cumpre o contrato com custo zero

```java
public class RetiradaLocal implements Entrega {
    public double calcularCusto(Pedido pedido) {
        return 0.0;
    }
}
```

O contrato exige a operação, sem fixar um valor único.

---

<div class="chapter">As classes já cumprem Entrega</div>

## Pedido ainda precisa aceitar esse papel

Antes:

```java
private EntregaNormal entrega;
public void fechar(EntregaNormal entrega)
```

Depois:

```java
private Entrega entrega;
public void fechar(Entrega entrega)
```

<!-- Recortes de declarações; as assinaturas sem corpo não são arquivos
executáveis. Mudar implements sozinho não altera a assinatura do cliente. -->

---

<div class="chapter">Muda o tipo; a regra de fechamento permanece</div>

## Pedido continua guardando a primeira escolha válida

```java
private Entrega entrega;

public void fechar(Entrega entrega) {
    if (!fechado && entrega != null) {
        this.entrega = entrega;
        fechado = true;
    }
}
```

O construtor continua sem entrega. A colaboração começa em `fechar(...)`.

---

<div class="chapter">A solicitação do trabalho permanece</div>

## Pedido continua delegando o cálculo

```java
public double calcularCustoEntrega() {
    return entrega.calcularCusto(this);
}
```

Consulta **depois de um fechamento válido**.

`this` fornece o próprio pedido ao colaborador. O total continua somando somente itens.

---

<!-- _class: activity -->

<div class="chapter">Retome a tentativa que abriu a aula</div>

## A mesma chamada agora funciona?

```java
Pedido pedido = new Pedido();
EntregaExpressa expressa = new EntregaExpressa();

pedido.fechar(expressa);
System.out.println(pedido.calcularCustoEntrega());
```

Agora compila? Qual valor aparece? Quem calcula esse valor?

<!-- Pausa de previsão. Agora expressa cumpre Entrega e Pedido aceita Entrega.
25.0, calculado por EntregaExpressa. Ambos os lados precisam estar ajustados. -->

---

<div class="chapter">O conflito inicial foi resolvido</div>

## A expressa entrou sem levar sua fórmula a Pedido

```text
25.0
```

- `EntregaExpressa` cumpre `Entrega`.
- `fechar` aceita uma referência do tipo `Entrega`.
- O custo continua sendo calculado pelo colaborador.

Aceitar a expressa resolveu o encaixe. E o que já funcionava?

---

<div class="chapter">A Aula 13 preparou a verificação dessa mudança</div>

## Execute novamente a suíte conhecida

| Teste | Expectativa preservada |
| --- | --- |
| `calculaTotalDeUmItem()` | `300.0` para duas unidades a `150.0` |
| `pedidoFechadoNaoAceitaNovosItens()` | inclusão recusada: total `150.0` |
| `entregaNormalCustaDezReais()` | custo normal `10.0` |

As entradas e expectativas continuam iguais. Os três testes devem passar.

<!-- Conferência da suíte real em IDE pode apoiar este momento; não é preciso
reconstruir os testes. Aulas usam Pedido; Laboratório 13 testou Lembrete. -->

---

<div class="chapter">Observe uma das expectativas preservadas</div>

## O teste da normal continua igual

```java
@Test
void entregaNormalCustaDezReais() {
    Pedido pedido = new Pedido();
    pedido.fechar(new EntregaNormal());

    assertEquals(10.0, pedido.calcularCustoEntrega());
}
```

O tipo do campo mudou. O comportamento público esperado permaneceu.

---

<div class="chapter">Outra classe agora cabe; a escolha ainda é conservada</div>

## Uma nova verificação protege o segundo fechamento

```java
@Test
void segundoFechamentoNaoTrocaEntrega() {
    Pedido pedido = new Pedido();
    pedido.fechar(new EntregaNormal());
    pedido.fechar(new EntregaExpressa());

    assertEquals(10.0, pedido.calcularCustoEntrega());
}
```

A expressa é um argumento aceito. A guarda ainda impede trocar a escolha.

---

<!-- _class: activity -->

<div class="chapter">Leia o alcance das verificações</div>

## Testes verdes demonstram o quê?

Os testes de custo normal e segundo fechamento passaram.

1. Quais comportamentos esses dois cenários verificaram?
2. Eles também verificaram o custo expresso e toda edição de itens?

<!-- 10.0 normal e conservação da primeira escolha. Não verificam todas as
regras. Pedir justificativa pelo cenário e pela observação de cada teste. -->

---

<div class="chapter">A mudança foi verificada nos cenários escolhidos</div>

## Cada teste protege uma expectativa

Os dois testes verificam custo normal e conservação da escolha.

A suíte retomada também verifica total simples e uma inclusão recusada.

Outras operações exigem seus próprios cenários.

Agora chegou uma entrega que Pedido ainda não conhece.

---

<div class="chapter">Ponha o benefício do contrato à prova</div>

## Entrega agendada: custo fixo de R$ 15

EntregaAgendada.java:

```java
public class EntregaAgendada implements Entrega {
    public double calcularCusto(Pedido pedido) {
        return 15.0;
    }
}
```

Essa classe cumpre o papel que Pedido já solicita.

---

<!-- _class: activity -->

<div class="chapter">Use a implementação nova no mesmo ponto</div>

## Qual é o impacto em Pedido?

```java
Pedido pedido = new Pedido();
pedido.fechar(new EntregaAgendada());

System.out.println(pedido.calcularCustoEntrega());
```

Que valor aparece? Precisamos mudar campo, fechamento ou consulta em Pedido?

<!-- 15.0; nenhuma dessas partes muda. Não revelar antes da previsão.
Algum cliente ainda precisa escolher e criar a entrega concreta. -->

---

<div class="chapter">O novo objeto já cabe no contrato</div>

## A saída é 15.0; Pedido permaneceu igual

| Parte do programa | Impacto da entrega agendada |
| --- | --- |
| `EntregaAgendada.java` | nova classe que cumpre `Entrega` |
| `Main` ou outro cliente | escolhe, cria e fornece o objeto |
| `Entrega.java` | conserva a operação do contrato |
| `Pedido.java` | conserva campo, fechamento e consulta |

A escolha concreta continua existindo fora de Pedido.

---

<!-- _class: concept-key -->

<div class="chapter">Nomeie o ganho que acabamos de observar</div>

## Conceito-chave — depender de uma capacidade

Pedido depende do contrato `Entrega`, que expressa a capacidade estável de calcular o custo.

As classes concretas podem variar sem que Pedido precise nomear cada uma.

---

<div class="chapter">Compare os objetos recebidos no fechamento</div>

## A consulta é a mesma; os resultados variam

Em cada pedido fechado:

```java
pedido.calcularCustoEntrega()
```

| Colaborador | Resultado |
| --- | ---: |
| `EntregaNormal` | `10.0` |
| `EntregaExpressa` | `25.0` |
| `EntregaAgendada` | `15.0` |

Como um campo do tipo Entrega pode alcançar esses objetos diferentes?

---

<!-- _class: activity -->

<div class="chapter">Recupere variável, referência e objeto</div>

## O que foi criado? Qual é o tipo declarado?

```java
Entrega entrega = new EntregaExpressa();
```

1. Qual é a classe do objeto criado por `new`?
2. Qual é o tipo declarado da variável?
3. Declarar `Entrega` mudou a classe do objeto?

<!-- Recuperação da Aula 03. Objeto EntregaExpressa, variável Entrega,
nenhuma transformação do objeto. Dar tempo para justificar. -->

---

<div class="chapter">A referência conhece o contrato</div>

## O objeto continua concreto

```java
Entrega entrega = new EntregaExpressa();
```

<div class="poo-diagram">
  <div class="poo-var">entrega</div><div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">EntregaExpressa#1</div></div>
</div>

- Tipo declarado da variável: `Entrega`.
- Classe do objeto: `EntregaExpressa`.
- A seta significa **aponta para**; a variável guarda uma referência.

<!-- #1 distingue a instância no desenho; não é endereço. Não criamos
new Entrega(): a interface declara o papel, as classes fornecem objetos. -->

---

<div class="chapter">O contrato permite expressar a colaboração</div>

## Podemos fornecer essa referência ao pedido

```java
Entrega entrega = new EntregaExpressa();
Pedido pedido = new Pedido();
pedido.fechar(entrega);
```

O campo guarda uma referência para o objeto concreto escolhido.

O tipo `Entrega` permite solicitar `calcularCusto(Pedido)` por essa referência.

<!-- Se o núcleo estiver concluído, saltar os três aprofundamentos para a
síntese. Eles têm função de diagnóstico, não introduzem mecanismos novos. -->

---

<!-- aprofundamento-elastico -->

<div class="chapter">Para aprofundar — uma operação fora do contrato</div>

## A expressa pode oferecer mais operações

```java
public class EntregaExpressa implements Entrega {
    public double calcularCusto(Pedido pedido) {
        return 25.0;
    }

    public void priorizarNaFila() {
        // comportamento específico desta classe
    }
}
```

`priorizarNaFila()` não foi declarado em `Entrega`.

---

<!-- _class: activity -->

<div class="chapter">Para aprofundar — o tipo limita a chamada disponível</div>

## O objeto tem o método. A chamada compila?

```java
Entrega entrega = new EntregaExpressa();
entrega.priorizarNaFila();
```

E se a variável fosse declarada como `EntregaExpressa`?

<!-- Não compila por Entrega: operação fora do contrato. Compila por
EntregaExpressa. O objeto não perdeu o método. Não propor casting. -->

---

<div class="chapter">Para aprofundar — o objeto preserva suas operações</div>

## Muda o que podemos solicitar pela referência

```java
Entrega entrega = new EntregaExpressa();
entrega.priorizarNaFila(); // não compila
```

```java
EntregaExpressa expressa = new EntregaExpressa();
expressa.priorizarNaFila(); // compila
```

O primeiro tipo não declara essa operação; o segundo a oferece.

---

<!-- _class: activity -->

<div class="chapter">Para aprofundar — tipo aceito e regra de estado</div>

## A interface permite trocar a escolha depois de fechar?

```java
Pedido pedido = new Pedido();
pedido.fechar(new EntregaNormal());
pedido.fechar(new EntregaExpressa());

System.out.println(pedido.calcularCustoEntrega());
```

Preveja a saída. Que condição explica o resultado?

<!-- 10.0. A guarda !fechado bloqueia a segunda tentativa; aceitar o tipo
não autoriza a transição de estado. Retomar o teste com outra operação cognitiva. -->

---

<div class="chapter">Para aprofundar — o primeiro fechamento foi conservado</div>

## Aceitar o argumento não autoriza substituir a entrega

```java
if (!fechado && entrega != null) {
    this.entrega = entrega;
    fechado = true;
}
```

Na segunda chamada, `!fechado` é falso. O custo permanece **10.0**.

O contrato ampliou os tipos aceitos; a regra de estado permaneceu.

---

<!-- _class: activity -->

<div class="chapter">Para aprofundar — o contrato responde a uma necessidade</div>

## Precisamos de uma interface para cada classe?

Criaríamos `ProdutoInterface` ou `ItemPedidoInterface` apenas porque aprendemos `interface`?

Que necessidade concreta procuraríamos antes dessa decisão?

<!-- Não há essa necessidade no problema atual. Procurar um papel necessário
a um cliente e motivo para depender desse papel, como variações na mesma
colaboração. Não prescrever nomes, novas interfaces, SOLID ou padrões. -->

---

<div class="chapter">Para aprofundar — reconheça o motivo da abstração</div>

## Ter uma classe não exige uma interface correspondente

No caso de Entrega, já havia:

- um trabalho estável que Pedido precisava solicitar;
- classes diferentes para realizar esse trabalho;
- um impedimento para usá-las no mesmo ponto.

Essa necessidade ainda não foi mostrada para Produto ou ItemPedido.

---

<!-- _class: synthesis -->

<div class="chapter">Do impedimento à colaboração por contrato</div>

## O que a evolução conseguiu preservar e ampliar?

- `Entrega` nomeia o papel; `implements` declara quem o cumpre.
- Pedido aceita esse papel e mantém a regra de fechamento.
- Os testes verificam os comportamentos escolhidos.
- A entrega agendada entra sem modificar Pedido.
- A referência usa o contrato; o objeto continua concreto.

---

<div class="chapter">Transfira a decisão para o Projeto 2</div>

## No Laboratório 14, o papel será enviar mensagens

| Nas aulas | No laboratório |
| --- | --- |
| `Pedido` solicita custo | `Lembrete` solicita envio |
| contrato `Entrega` | contrato `Notificador` |
| entrega escolhida no fechamento | canal inicial recebido na criação |

Mudar o tipo de colaborador não decide quando o modelo deve recebê-lo.

<!-- Partir da solução final do Lab 13. Preservar mensagem, canal inicial,
contagem e saídas. Não apresentar a implementação do laboratório. -->

---

<div class="chapter">A pergunta que os resultados deixaram</div>

## Como Java escolhe qual cálculo executar?

Em Pedido, a chamada continua:

```java
return entrega.calcularCusto(this);
```

O contrato é o mesmo; os objetos e os resultados podem ser diferentes.

**Como Java sabe qual implementação executar?**

<!-- Entrada da Aula 15: Polimorfismo. Encerrar sem explicar o mecanismo
de escolha do corpo; contrato e objeto concreto já sustentam a pergunta. -->
