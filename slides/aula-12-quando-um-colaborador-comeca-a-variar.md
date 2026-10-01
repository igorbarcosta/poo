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

<div class="chapter">Investigue com o repertório atual</div>

## Como manter as duas alternativas?

Proponha uma solução para pedidos normais e expressos coexistirem.

Que referências `Pedido` manteria?

Como saberia qual comportamento solicitar?

<!--
Dar espaço para hipóteses antes dos próximos frames. Campos separados,
indicador textual/numérico ou cálculos no pedido podem aparecer. Investigar
consequências sem rejeitar de imediato. Não exigir implementação completa.
-->

---

<div class="chapter">Uma proposta possível</div>

## Duas referências concretas

```java
private EntregaNormal entregaNormal;
private EntregaExpressa entregaExpressa;
```

Ainda precisamos indicar qual forma pertence àquele pedido.

Quem passa a conhecer as duas classes?

<!--
Trecho parcial. Pedido passa a conhecer ambas. Campos podem ser parte de
solução funcional; avaliar preparação e seleção, sem chamar de erro automático.
-->

---

<div class="chapter">Outra proposta possível</div>

## Guardar a escolha no pedido

```java
private int tipoEntrega;
```

Nesta hipótese: `1` significa normal, `2` significa expressa.

Um texto como `"NORMAL"` também poderia representar a escolha.

Quem precisa conhecer o significado dessas alternativas?

<!--
Escolha numérica só para analisar código usando sintaxe conhecida. Não ensinar
comparação de String nem consolidar convenção como arquitetura do projeto.
-->

---

<div class="chapter">Selecionar dentro do coordenador</div>

## Pedido decide a quem solicitar

```java
public double calcularCustoEntrega() {
    if (tipoEntrega == 1) {
        return entregaNormal.calcularCusto(this);
    } else {
        return entregaExpressa.calcularCusto(this);
    }
}
```

Hipótese: código válido e dois colaboradores já disponíveis.

---

<div class="chapter">Consequências das propostas</div>

## Que conhecimento chegou a Pedido?

| Proposta | Conhecimento necessário no pedido |
| --- | --- |
| campos e seleção | classes concretas e escolha entre elas |
| fórmulas no pedido | alternativas e regras de cada cálculo |

O pedido precisa conhecer os nomes das alternativas para continuar coordenando?

<!--
Avaliar cada hipótese levantada pela turma com o mesmo critério. Uma tabela
não estabelece que só existam essas alternativas ou uma única resposta correta.
-->

---

<div class="chapter">Reaplique o critério da Unidade 01</div>

## Uma condição pode proteger uma responsabilidade

```java
if (!fechado) {
    // Pedido autoriza uma edição de sua estrutura.
}
```

Isso continua fazendo sentido.

Agora investigamos quanto o pedido precisa conhecer sobre **quem calcula a entrega**.

---

<div class="chapter">O conjunto de alternativas cresceu</div>

## O cliente também pode retirar no local

```java
public class RetiradaLocal {
    public double calcularCusto(Pedido pedido) {
        return 0.0;
    }
}
```

Mais uma forma concreta de realizar a mesma responsabilidade.

<!--
Só revelar depois de compreender duas alternativas. Não transformar isso em
pedido para aumentar a cadeia de condições; perguntar sobre impacto completo.
-->

---

<!-- _class: activity -->

<div class="chapter">Preveja o impacto</div>

## Criar a classe basta?

Na proposta com campos concretos e seleção em `Pedido`:

1. criar `RetiradaLocal.java` já integra a alternativa?
2. onde precisamos adaptar referências, preparação e seleção?
3. a responsabilidade de `Pedido` mudou de novo?

---

<div class="chapter">O que a terceira opção revelou</div>

## A coordenação continua; as alternativas crescem

Só a classe nova não basta naquela proposta.

`Pedido` precisa ser adaptado para receber e selecionar a retirada.

O cliente também precisa solicitar a nova opção.

<div class="key-point">A tarefa continua sendo solicitar o custo da entrega.</div>

---

<div class="chapter">Separe o estável do variável</div>

## O que permanece? O que varia?

| Permanece | Varia |
| --- | --- |
| solicitar custo para um pedido | qual objeto responde |
| receber um resultado `double` | qual regra ele realiza |
| coordenação do pedido | classe concreta do colaborador |

`EntregaNormal` · `EntregaExpressa` · `RetiradaLocal`

---

<!-- _class: concept-key -->

<div class="chapter">Agora podemos nomear o fenômeno</div>

## Conceito-chave — ponto de variação

Uma parte do sistema em que esperamos alternativas de comportamento.

Aqui: **calcular o custo da entrega**.

Normal, expressa e retirada são formas concretas de realizar essa responsabilidade.

---

<div class="chapter">A necessidade declarada</div>

## O que esse campo está dizendo?

```java
private EntregaNormal entrega;
```

“Preciso de um objeto `EntregaNormal`.”

Essa frase descreve tudo de que o pedido realmente precisa?

---

<div class="chapter">Observe o uso</div>

## A necessidade pode ser descrita pelo trabalho

```java
return entrega.calcularCusto(this);
```

<div class="statement">“Preciso de algo capaz de calcular o custo da entrega para este pedido.”</div>

Ainda falta representar isso em Java.

---

<!-- _class: concept-key -->

<div class="chapter">Dar nome à dependência observada</div>

## Conceito-chave — acoplamento

Uma classe está acoplada a outra quando depende dela para realizar seu trabalho.

O campo e a operação de fechamento tornam `Pedido` dependente de `EntregaNormal`.

Essa dependência era adequada enquanto havia só essa alternativa.

---

<!-- _class: trap -->

<div class="chapter">Um cuidado com o diagnóstico</div>

## O que devemos investigar?

Dependências permitem colaboração. Condições podem expressar regras adequadas.

O critério desta aula:

<div class="statement">Pedido precisa conhecer cada implementação concreta para continuar solicitando o mesmo trabalho?</div>

---

<div class="chapter">Alguém ainda terá de escolher</div>

## E se Main criar a alternativa?

`Main` já monta os cenários e pode conhecer a opção escolhida.

Mas ainda precisa fornecer esse objeto a `Pedido`.

O campo `EntregaNormal` passaria a aceitar as outras classes só por mudar onde escolhemos?

<!--
Aprofundamento elástico. Não: localização da escolha não resolve o encaixe dos tipos.
Uma escolha concreta continua necessária em algum ponto; a pergunta é quanto
desse conhecimento precisa chegar ao coordenador.
-->

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

<div class="chapter">O problema continua aberto</div>

## Pedido precisa de...

<div class="statement">“Algo que calcule o custo da entrega.”</div>

Alternativas: `EntregaNormal`, `EntregaExpressa`, `RetiradaLocal`.

**Como representar essa necessidade em Java sem dizer qual classe concreta fará o trabalho?**

<!--
Encerrar sem responder. Duas pontes: Aula 13 verifica comportamentos;
Aula 14 retoma como representar a responsabilidade necessária. Não mostrar
assinatura, declaração ou nome do mecanismo formal neste deck.
-->
