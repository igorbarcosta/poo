---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 12 — Quando um colaborador começa a variar

<div class="statement">Como evoluir uma colaboração quando o objeto que realiza o trabalho pode variar?</div>

<!--
Abre a Unidade 02. Retomada muito curta; não anunciar mecanismo de solução.
Núcleo de 90 min: colaboração 25; segunda alternativa 30; terceira e conceitos 20;
verificações e fechamento 15. Perguntas à turma toda com formulação individual.
Revisão solicitada pelo professor: entrega no fechamento e Projeto 2 nos laboratórios.
-->

---

<div class="chapter">Do projeto que já funciona</div>

## Sabemos acrescentar regras

- Aula 09: `Pedido` protege o fechamento.
- Aula 10: localiza linhas; o item protege sua quantidade.
- Aula 11: o raciocínio funciona em outro domínio.

<div class="key-point">Agora chegou uma responsabilidade que ainda não existia.</div>

<!--
Recuperar em uma pergunta breve: quem calcula subtotal? Quem controla a coleção?
Respostas: ItemPedido; Pedido. Não reensinar as classes do Projeto 1.
-->

---

<div class="chapter">Novo requisito</div>

## O pedido precisa de uma forma de entrega

A escolha acontece **no fechamento**.

Por enquanto, só existe **entrega normal**.

Custo fixo: **R$ 10**.

Quem deveria conhecer essa regra?

<!--
Ouvir justificativas por responsabilidade antes de revelar a classe.
Manter calcularTotal como total dos itens; entrega consultada separadamente.
-->

---

<div class="chapter">Uma responsabilidade própria</div>

## Um objeto pode realizar esse trabalho

```java
public class EntregaNormal {
    public double calcularCusto(Pedido pedido) {
        return 10.0;
    }
}
```

Recebe o pedido como contexto. Nesta regra fixa, não precisa consultar seus dados.

---

<div class="chapter">Uma colaboração conhecida</div>

## Pedido mantém a referência necessária

```java
private EntregaNormal entrega;

public void fechar(EntregaNormal entrega) {
    if (!fechado && entrega != null) {
        this.entrega = entrega;
        fechado = true;
    }
}
```

O pedido nasce aberto. A entrega é escolhida no fechamento.

<!--
Trecho de Pedido. Mantém Pedido() e substitui fechar() por fechar(EntregaNormal).
Imports de List e ArrayList e operações da Versão 10 permanecem necessários.
A guarda exige colaborador existente e preserva a escolha após fechar. Consultar custo apenas depois do fechamento.
-->

---

<div class="chapter">Solicitar o comportamento</div>

## Pedido coordena o cálculo da entrega

```java
public double calcularCustoEntrega() {
    return entrega.calcularCusto(this);
}
```

`Pedido` precisa saber que a regra devolve `10.0`?

<!--
Não. Ele solicita o cálculo e devolve o resultado. A fórmula pertence à entrega.
-->

---

<!-- _class: java-focus -->

<div class="chapter">A referência enviada na chamada</div>

## Java em foco — o próprio pedido

```java
return entrega.calcularCusto(this);
```

`this` referencia o `Pedido` que executa o método.

O colaborador recebe esse mesmo pedido como argumento.

Nenhuma cópia é criada.

---

<div class="chapter">A nova dependência</div>

## Uma entrega, uma colaboração

<div class="poo-diagram poo-diagram--objects">
  <div class="poo-object"><div class="poo-object__header">Pedido</div></div>
  <div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">EntregaNormal</div></div>
</div>

```java
private EntregaNormal entrega;
```

Visão simplificada: a referência mantida no campo permite alcançar a entrega.

<!--
Usar componentes compartilhados, sem UML. O foco é o grafo, não o estado completo.
Os itens foram omitidos, não removidos do pedido.
-->

---

<!-- _class: activity -->

<div class="chapter">Explore antes de evoluir</div>

## A distribuição faz sentido?

1. Quem conhece a fórmula do frete?
2. Se ela mudar para R$ 12, onde esperamos alterar código?
3. Essa solução é adequada enquanto existe só entrega normal?

<!--
Dar tempo real de formulação individual e coletar justificativas.
Não chamar a solução de defeito nem antecipar outra representação.
-->

---

<div class="chapter">O que já conseguimos preservar</div>

## A regra pertence à entrega

`EntregaNormal` conhece o custo e pode mudar sua regra.

`Pedido` continua solicitando o mesmo cálculo.

<div class="key-point">A solução é adequada ao requisito atual.</div>

---

<!-- _class: activity code-focus -->

<div class="chapter">Previsão da execução</div>

## Dois resultados, duas responsabilidades

```java
// teclado: 150.0; mouse: 80.0
Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 2);
pedido.adicionarItem(mouse, 1);
pedido.fechar(new EntregaNormal());
System.out.println(pedido.calcularTotal());
System.out.println(pedido.calcularCustoEntrega());
```

Quais valores serão impressos? De onde vem cada um?

---

<div class="chapter">O sistema continua funcionando</div>

## Itens e entrega têm cálculos separados

```text
380.0
10.0
```

`calcularTotal()` continua somando subtotais dos itens.

`calcularCustoEntrega()` solicita a nova colaboração.

---

<div class="chapter">O requisito evoluiu</div>

## Alguns pedidos precisam de entrega expressa

```java
public class EntregaExpressa {
    public double calcularCusto(Pedido pedido) {
        return 25.0;
    }
}
```

Também calcula o custo da entrega. Usa outra regra.

---

<!-- _class: activity code-focus -->

<div class="chapter">Uma previsão de compilação</div>

## Podemos fornecer a nova entrega?

```java
// fechar recebe EntregaNormal.
EntregaExpressa expressa = new EntregaExpressa();
Pedido urgente = new Pedido();
urgente.fechar(expressa);
```

O compilador aceita essa chamada? Por quê?

<!--
Esperar previsão antes de revelar. Não substituir a pergunta por mensagem
decorada de um compilador específico.
-->

---

<div class="chapter">Onde está o limite?</div>

## O parâmetro pede uma classe concreta

```java
public void fechar(EntregaNormal entrega)
```

O argumento é `EntregaExpressa`.

No código mostrado, esse tipo não é aceito como `EntregaNormal`.

Ter `calcularCusto(Pedido)` nas duas classes não basta.

---

<div class="chapter">O que mudou para o pedido?</div>

## Ainda precisamos do mesmo comportamento

`Pedido` continua precisando **calcular o custo da entrega**.

Agora existem duas classes capazes de realizar esse trabalho.

A responsabilidade mudou ou mudou quem pode realizá-la?

<!--
Solicitar explicação pelas chamadas: calcularCusto(Pedido) devolve double em ambas.
Não confundir essa coincidência conceitual com compatibilidade de tipos Java.
-->

---

<div class="chapter">Uma diferença em relação à Aula 11</div>

## Trocar objetos não é sempre trocar classes

Na missão:

```java
Sensor temperatura = new Sensor("Temperatura", "°C");
Sensor umidade = new Sensor("Umidade", "%");
```

Dois objetos da mesma classe.

Agora: `EntregaNormal` e `EntregaExpressa` são classes diferentes.

<!--
Aprofundamento elástico: outro EntregaNormal também caberia na operação de fechamento atual.
Perguntar se duas instâncias normais resolvem o requisito expresso de outra regra.
-->

---

<!-- _class: activity -->

<div class="chapter">Normal e expressa precisam coexistir</div>

## Como guardar a entrega escolhida?

Cada pedido recebe **uma escolha no fechamento**:
normal custa R$ 10; expressa custa R$ 25.

Com os recursos que já conhecemos:

1. Que referências permitiriam alcançar os dois colaboradores?
2. Como registrar qual deles atende a este pedido?

<!-- Coletar hipóteses. Não exigir uma implementação completa. O próximo
recorte analisa uma proposta da turma sem torná-la versão oficial do projeto. -->

---

<div class="chapter">Hipótese com duas entregas — guardar referências</div>

## Dois campos permitem alcançar os colaboradores

```java
private EntregaNormal entregaNormal;
private EntregaExpressa entregaExpressa;
```

Suponha que os dois campos já apontem para objetos existentes.

Ainda falta registrar **qual entrega foi escolhida para este pedido**.

<!-- Estamos examinando outro recorte de Pedido. O campo único da solução
inicial deu lugar a estes dois campos nesta hipótese. -->

---

<div class="chapter">A mesma hipótese — registrar a escolha</div>

## Acrescentamos um indicador aos dois campos

```java
private int tipoEntrega;
```

No fechamento, esta hipótese guarda um código válido:

- `1`: usar `entregaNormal`;
- `2`: usar `entregaExpressa`.

Agora podemos decidir a qual objeto solicitar o custo.

<!-- O indicador completa a proposta anterior; não é uma alternativa aos
campos. São recortes de uma hipótese, não uma API nova prescrita ao projeto. -->

---

<div class="chapter">A mesma hipótese — solicitar o custo</div>

## A escolha guardada determina a chamada

```java
public double calcularCustoEntrega() {
    if (tipoEntrega == 1) {
        return entregaNormal.calcularCusto(this);
    } else {
        return entregaExpressa.calcularCusto(this);
    }
}
```

Recorte para pedidos fechados: código `1` ou `2`, colaboradores disponíveis.

---

<!-- _class: activity -->

<div class="chapter">Execute mentalmente a hipótese</div>

## Dois pedidos, duas escolhas

| Pedido fechado | Escolha guardada |
| --- | --- |
| `normal` | `tipoEntrega = 1` |
| `urgente` | `tipoEntrega = 2` |

```java
System.out.println(normal.calcularCustoEntrega());
System.out.println(urgente.calcularCustoEntrega());
```

Quais valores aparecem? Qual classe decide **quem** fará cada cálculo?

<!-- Normal 10.0; urgente 25.0. Pedido lê o indicador e seleciona o objeto.
As regras de custo continuam nas entregas. Dar tempo antes do próximo slide. -->

---

<div class="chapter">A hipótese atende às duas opções</div>

## Funciona, mas Pedido conhece cada alternativa

```text
10.0
25.0
```

`Pedido` conhece os dois tipos, os códigos `1` e `2` e a seleção.

As entregas continuam responsáveis pelos valores de cada custo.

---

<div class="chapter">O requisito muda outra vez</div>

## Agora também podemos retirar no local

```java
public class RetiradaLocal {
    public double calcularCusto(Pedido pedido) {
        return 0.0;
    }
}
```

O cliente quer escolher retirada no fechamento do pedido.

---

<!-- _class: activity -->

<div class="chapter">Use a mesma hipótese para investigar o impacto</div>

## Criar RetiradaLocal.java é suficiente?

`Pedido` ainda tem dois campos e seleciona entre os códigos `1` e `2`.

1. Onde guardaríamos a referência para a retirada?
2. Como representaríamos essa terceira escolha?
3. Qual método precisaria solicitar o custo ao novo objeto?

<!-- Campo RetiradaLocal, código 3 e seleção em calcularCustoEntrega.
A preparação no fechamento e o cliente também precisariam aceitar essa escolha.
Não presumir que acrescentar somente um else resolve toda a integração. -->

---

<div class="chapter">A hipótese cresce — referência e escolha</div>

## Pedido ganha conhecimento da terceira opção

```java
private RetiradaLocal retirada;
```

Além dos dois colaboradores anteriores, precisamos fornecer a retirada.

A convenção passa a ter três códigos: `1` normal, `2` expressa, `3` retirada.

O fechamento e o código que monta o pedido também precisam aceitar essa escolha.

---

<div class="chapter">A hipótese cresce — seleção</div>

## O mesmo método precisa de outro caminho

```java
public double calcularCustoEntrega() {
    if (tipoEntrega == 1) {
        return entregaNormal.calcularCusto(this);
    } else if (tipoEntrega == 2) {
        return entregaExpressa.calcularCusto(this);
    } else {
        return retirada.calcularCusto(this);
    }
}
```

Recorte: código `1`, `2` ou `3`; colaboradores já disponíveis.

---

<!-- _class: concept-key -->

<div class="chapter">O que a terceira opção revelou</div>

## Conceito-chave — ponto de variação

O trabalho solicitado continua sendo **calcular o custo da entrega**.

Quem realiza esse trabalho pode variar:
`EntregaNormal`, `EntregaExpressa` ou `RetiradaLocal`.

Esse trabalho com alternativas é o ponto de variação que encontramos.

---

<div class="chapter">Volte à solução inicial — uma entrega normal</div>

## O campo inicial limita quem pode colaborar

```java
private EntregaNormal entrega;

public void fechar(EntregaNormal entrega) {
    // guarda a escolha no primeiro fechamento válido
}
```

O tipo pede `EntregaNormal`, embora o pedido precise apenas de alguém
capaz de calcular o custo.

<!-- Volta explícita ao código inicial que retomaremos nas Aulas 13 e 14.
Este trecho não pertence à hipótese de campos e códigos examinada acima. -->

---

<!-- _class: concept-key -->

<div class="chapter">Nomear a dependência que observamos</div>

## Conceito-chave — acoplamento

`Pedido` depende de `EntregaNormal` para realizar seu trabalho.

O campo e o parâmetro de `fechar` nomeiam essa classe concreta.

Essa dependência atendia ao requisito inicial.
A entrega expressa revelou seu limite.

---

<!-- _class: trap -->

<div class="chapter">Compare o motivo de cada condição</div>

## Qual mudança faz cada trecho crescer?

| Trecho em Pedido | O que ele decide |
| --- | --- |
| `if (!fechado)` | se o pedido permite uma edição |
| `if (tipoEntrega == 1)` | qual classe de entrega será chamada |

Foi a **nova entrega** que exigiu ampliar a segunda seleção.

O diagnóstico depende da responsabilidade que cada condição expressa.

---

<div class="chapter">Na solução inicial, mude somente quem cria o objeto</div>

## Criar a expressa em Main resolve o encaixe?

```java
EntregaExpressa expressa = new EntregaExpressa();
Pedido pedido = new Pedido();
pedido.fechar(expressa);
```

`fechar` ainda recebe `EntregaNormal`. Esta chamada continua sem compilar.

Precisamos representar em `Pedido` a capacidade comum às entregas.

<!-- Aprofundamento: Main pode escolher e criar objetos; deslocar a criação
não modifica o tipo do parâmetro. Não apresentar interface antes da Aula 14. -->

---

<div class="chapter">Uma segunda preocupação</div>

## Vamos mudar uma colaboração que funciona

Mesmo que a entrega expressa passe a funcionar...

Como saber se preservamos o total, as edições permitidas e o fechamento?

Que verificações do Projeto 1 precisamos repetir?

<!--
Coletar evidências propostas: inclusão, remoção, quantidade, fechamento,
normal 10. Não ensinar ferramenta de teste nem antecipar solução da colaboração.
-->

---

<!-- _class: activity code-focus -->

<div class="chapter">Previsão antes da mudança estrutural</div>

## Registre os resultados esperados

```java
pedido.adicionarItem(teclado, 2);
pedido.adicionarItem(mouse, 1);
System.out.println(pedido.calcularTotal());
pedido.removerItem(mouse);
System.out.println(pedido.calcularTotal());
pedido.alterarQuantidade(teclado, 3);
System.out.println(pedido.calcularTotal());
```

Teclado: R$ 150; mouse: R$ 80. Quais três valores são esperados?

<!--
Mesmo cenário executável da página; criação Pedido(). A entrega será escolhida no fechamento.
Produtos nas mesmas referências em cada chamada. Saída 380, 300, 450.
-->

---

<div class="chapter">Continue o mesmo cenário</div>

## E depois de fechar?

```java
pedido.fechar(new EntregaNormal());
pedido.adicionarItem(mouse, 1);
pedido.removerItem(teclado);
pedido.alterarQuantidade(teclado, 1);

System.out.println(pedido.calcularTotal());
System.out.println(pedido.calcularCustoEntrega());
```

Quais valores devem continuar corretos?

<!--
Formulação individual antes de revelar. Total 450; entrega 10.
Não acrescentar congelamento de preço nem outra regra financeira.
-->

---

<div class="chapter">Evidências que podemos repetir</div>

## O comportamento esperado está explícito

```text
380.0 → 300.0 → 450.0 → 450.0
Entrega normal: 10.0
```

Também precisamos verificar zero, negativo e inclusão repetida.

Repetir e automatizar essas verificações prepara a próxima aula.

<!--
O cenário não cobre tudo, nem um total igual comprova cada detalhe estrutural.
Próxima aula: verificar comportamento. Só depois retomar a expressão da necessidade comum.
-->

---

<div class="chapter">Laboratório 12 — em casa</div>

## Projeto 2 começa com lembretes

Nas aulas, continuamos com `Pedido`. Nos laboratórios,
evoluímos um sistema de lembretes e notificações.

1. evoluir o canal de e-mail existente;
2. permitir também SMS;
3. acrescentar um painel local.

Onde o código precisa mudar a cada nova alternativa?

<!--
Nível 1 — Tutor. Simulação no console, sem envio real. Entrega apenas código.
Manter em Lembrete mensagem/contador e nos notificadores os formatos.
Versão 1 do Projeto 2, continuado nos laboratórios da unidade. Apresentar cenário antes do código; não entregar solução formal para o limite encontrado.
-->

---

<!-- _class: synthesis -->

<div class="chapter">Da Unidade 01 à Unidade 02</div>

## Até aqui, quem realiza cada responsabilidade

- Unidade 01: objetos colaboram.
- Aula 12: o colaborador pode ser de outra classe.
- Queremos depender do trabalho necessário sem espalhar as alternativas.
- Antes de mudar a estrutura, precisamos verificar o que já funciona.

---

<div class="chapter">A próxima mudança precisa preservar o comportamento</div>

## Antes de mudar Pedido, como saber se ainda funciona?

```java
private EntregaNormal entrega;
```

Queremos mudar essa dependência para aceitar outras entregas.

<div class="statement">Como saber se a mudança que fizermos preservou o total, as edições e o fechamento?</div>

<!-- Encerrar nesta necessidade imediata. A Aula 13 transforma expectativas
em testes; a Aula 14 retoma a representação da capacidade comum em Java. -->
