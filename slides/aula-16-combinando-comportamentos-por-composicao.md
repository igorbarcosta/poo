---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 16 — Composição

<div class="statement">Combinando comportamentos</div>

Como acrescentar um comportamento a diferentes implementações sem repetir suas regras nem modificar o cliente?

<!-- Fonte pedagógica: Aula 16 e seu LessonDesign aprovados pelo professor.
Referência interna de 90 min: problema e construção, 20; referências e fluxo,
20; diagnóstico e evolução, 15; verificação, 20; transferência e síntese, 15.
Os tempos incluem leitura, previsão individual e discussão. Colher hipóteses
antes de avançar. O diagnóstico das propostas A/B é aprofundamento elástico;
preservar a verificação da colaboração e a ponte com o laboratório.
Não introduzir herança, cast, inspeção de tipos ou catálogo de padrões. -->

---

<div class="chapter">O ponto de chegada da Aula 15</div>

## O pedido conhece um contrato

```java
public interface Entrega {
    double calcularCusto(Pedido pedido);
}
```

| Implementação | Custo neste recorte |
| --- | ---: |
| `EntregaNormal` | `10.0` |
| `EntregaExpressa` | `25.0` |

Cada objeto conhece sua regra. O custo não depende dos itens neste recorte.

---

<div class="chapter">Uma nova necessidade para as duas modalidades</div>

## O seguro é opcional e acrescenta R$ 5

| Escolha | Cálculo esperado |
| --- | ---: |
| Normal sem seguro | `10.0` |
| Expressa sem seguro | `25.0` |
| Normal com seguro | `10.0 + 5.0` |
| Expressa com seguro | `25.0 + 5.0` |

O cálculo não cobra valores, não contrata serviços e não altera o pedido.

---

<!-- _class: activity -->

<div class="chapter">Antes de escolher uma implementação</div>

## Onde cada regra deve ficar?

**Proposta 1:** copiar o custo de cada modalidade para novas classes `EntregaNormalComSeguro` e `EntregaExpressaComSeguro`.

**Proposta 2:** fazer `Pedido` identificar a modalidade e calcular o acréscimo.

1. Se o custo normal mudar, o que precisará ser atualizado na proposta 1?
2. Que conhecimento novo o pedido recebe na proposta 2?
3. Quais duas tarefas podem ser separadas?

---

<div class="chapter">Separar a regra da modalidade do acréscimo</div>

## A entrega existente já sabe calcular a base

1. O custo normal estaria repetido em `EntregaNormal` e na classe que copiou sua fórmula. As duas precisariam acompanhar a mudança.
2. `Pedido` passaria a conhecer as modalidades e a regra do seguro.
3. Podemos separar **calcular o custo-base** de **acrescentar o seguro**.

O novo comportamento pode solicitar o cálculo a um objeto existente.

---

<div class="chapter">Construir a colaboração — guardar a escolha recebida</div>

## Uma entrega com seguro recebe sua base

```java
public class EntregaComSeguro implements Entrega {
    private Entrega entregaBase;

    public EntregaComSeguro(Entrega entregaBase) {
        this.entregaBase = entregaBase;
    }
    // calcularCusto aparece no próximo slide
}
```

O construtor conserva a referência recebida. Considere colaboradores diferentes de `null`.

<!-- Recorte de construção da classe, ainda incompleto: não é uma versão
compilável sem implementar calcularCusto. Cada tipo público tem seu arquivo. -->

---

<div class="chapter">Construir a colaboração — usar a base guardada</div>

## Solicitar o custo e acrescentar o seguro

Dentro de `EntregaComSeguro`:

```java
public double calcularCusto(Pedido pedido) {
    double custoBase = entregaBase.calcularCusto(pedido);
    return custoBase + 5.0;
}
```

O objeto alcançado por `entregaBase` calcula a modalidade.

O objeto com seguro acrescenta `5.0` ao resultado recebido.

---

<div class="chapter">Duas decisões diferentes na mesma classe</div>

## Cumprir o contrato e guardar o colaborador

| Declaração | Papel |
| --- | --- |
| `implements Entrega` | permite usar o objeto onde se espera uma entrega |
| `private Entrega entregaBase` | conserva outro objeto para solicitar o cálculo-base |

O método de `EntregaComSeguro` executa uma chamada a **outro objeto**, pelo campo `entregaBase`.

---

<!-- _class: activity -->

<div class="chapter">Consultas diretas às entregas; o pedido é só argumento</div>

## A mesma classe, duas combinações

```java
Pedido pedido = new Pedido();
Entrega normal = new EntregaNormal();
Entrega normalSegurada = new EntregaComSeguro(normal);
Entrega expressaSegurada =
        new EntregaComSeguro(new EntregaExpressa());
System.out.println(normalSegurada.calcularCusto(pedido));
System.out.println(expressaSegurada.calcularCusto(pedido));
System.out.println(normal.calcularCusto(pedido));
```

1. Quais valores aparecem? Quem calcula a base na segunda impressão?
2. Criar `normalSegurada` alterou a entrega normal?

---

<div class="chapter">A combinação usa a regra do colaborador escolhido</div>

## 15.0, 30.0 e 10.0

| Consulta | Cálculo | Resultado |
| --- | --- | ---: |
| Normal segurada | normal devolve `10.0`; seguro soma `5.0` | `15.0` |
| Expressa segurada | expressa devolve `25.0`; seguro soma `5.0` | `30.0` |
| Normal diretamente | a própria normal devolve seu custo | `10.0` |

Criar a combinação cria **outro objeto**, que guarda a normal. A regra e o estado da normal permanecem iguais.

---

<!-- _class: concept-key -->

<div class="chapter">Dar nome à colaboração observada</div>

## Composição de comportamentos e delegação

**Compor comportamentos:** combinar o trabalho de objetos para realizar uma responsabilidade maior.

**Delegar:** solicitar a um colaborador parte do trabalho necessário.

Aqui, a entrega-base calcula sua modalidade; `EntregaComSeguro` acrescenta o seguro ao resultado.

---

<div class="chapter">Relacionar ao que estudamos na Aula 08</div>

## Guardar a base não estabelece posse exclusiva

Na Aula 08, o foco eram as partes estruturais de um todo, como os itens de um pedido.

Agora, o foco é a **combinação de comportamentos** por colaboração.

```java
Entrega normal = new EntregaNormal();
Entrega segurada = new EntregaComSeguro(normal);
```

A variável `normal` ainda alcança a mesma entrega e permite usá-la diretamente.

---

<div class="chapter">Até aqui, consultamos entregas diretamente</div>

## Como fornecer a combinação ao pedido?

`EntregaComSeguro` cumpre `Entrega`. Pode ocupar o papel já esperado por `Pedido`:

```java
Entrega base = new EntregaExpressa();
Entrega segurada = new EntregaComSeguro(base);
Pedido pedido = new Pedido();
pedido.fechar(segurada);
```

Vamos acompanhar o cálculo **depois desse primeiro fechamento válido**.

---

<div class="chapter">O fechamento conserva a escolha — regra já conhecida</div>

## Pedido mantém sua implementação

```java
private Entrega entrega;
private boolean fechado;

public void fechar(Entrega entrega) {
    if (!fechado && entrega != null) {
        this.entrega = entrega;
        fechado = true;
    }
}
```

O pedido nasce aberto. O primeiro fechamento válido guarda a entrega recebida.

---

<div class="chapter">Estado após pedido.fechar(segurada)</div>

## Os campos conservam o caminho da colaboração

<div class="poo-diagram" role="img" aria-label="O campo entrega do Pedido aponta para EntregaComSeguro. O campo entregaBase dessa combinação aponta para EntregaExpressa." style="grid-template-columns: 268px 42px 322px 42px 270px; gap: 16px; max-width: 1108px; align-items: start;">
  <div class="poo-object"><div class="poo-object__header">Pedido</div><div class="poo-slots"><div class="poo-slot poo-slot--ref">entrega</div><div class="poo-slot">fechado = true</div></div></div>
  <div class="poo-arrow" style="margin-top: 74px;"></div>
  <div class="poo-object"><div class="poo-object__header">EntregaComSeguro</div><div class="poo-slots"><div class="poo-slot poo-slot--ref">entregaBase</div></div></div>
  <div class="poo-arrow" style="margin-top: 74px;"></div>
  <div class="poo-object" style="min-height: 112px;"><div class="poo-object__header">EntregaExpressa</div></div>
</div>

`pedido`, `segurada` e `base` alcançam, respectivamente, esses três objetos.

As setas partem dos campos de referência. Não há cópia da entrega expressa.

<!-- Variáveis locais foram omitidas do desenho para concentrar o foco nos
campos que sustentam a delegação. As correspondências estão explícitas no texto. -->

---

<!-- _class: activity -->

<div class="chapter">Mesmo pedido fechado com a expressa segurada</div>

## Reconstrua o cálculo completo

Dentro de `Pedido`:

```java
public double calcularCustoEntrega() {
    return entrega.calcularCusto(this);
}
```

Agora, `Main` executa `pedido.calcularCustoEntrega()` e imprime o resultado.

1. Quais objetos recebem os dois cálculos pelo contrato `Entrega`?
2. Que valor cada entrega devolve e que valor será impresso?
3. A entrega-base recebe outro pedido ou o mesmo objeto?

---

<div class="chapter">Mesmo cenário — seguir as chamadas e as devoluções</div>

## O pedido devolve o resultado da combinação

```text
Pedido solicita calcularCusto(this) à EntregaComSeguro
EntregaComSeguro solicita calcularCusto(pedido) à expressa
EntregaExpressa devolve 25.0
EntregaComSeguro acrescenta 5.0 e devolve 30.0
Pedido devolve 30.0; Main imprime 30.0
```

Os dois receptores são **EntregaComSeguro** e **EntregaExpressa**.

O argumento repassado é o **mesmo Pedido**: `this` foi recebido e encaminhado.

---

<div class="chapter">Duas chamadas pelo mesmo contrato</div>

## O polimorfismo participa das duas etapas

| Onde está a chamada? | Referência usada | Objeto alcançado |
| --- | --- | --- |
| `Pedido` | `entrega` | `EntregaComSeguro` |
| `EntregaComSeguro` | `entregaBase` | `EntregaExpressa` |

O contrato permite cada chamada. O objeto alcançado executa a implementação da sua classe.

É assim que o mesmo pedido chega ao custo-base sem conhecer a modalidade.

---

<!-- _class: activity -->

<div class="chapter">Continue com os mesmos objetos e o pedido fechado</div>

## Reatribuir base remonta a colaboração?

```java
base = new EntregaNormal();
System.out.println(pedido.calcularCustoEntrega());

pedido.fechar(base);
System.out.println(pedido.calcularCustoEntrega());
```

1. Quais são os dois valores impressos?
2. O que aconteceu com `entregaBase` da combinação e `entrega` do pedido?

---

<div class="chapter">Reatribuição local e novo fechamento são operações distintas</div>

## Ambos continuam em 30.0

| Operação | Efeito |
| --- | --- |
| `base = new EntregaNormal()` | muda somente a variável local |
| `pedido.fechar(base)` | a guarda recusa outro fechamento |

`entregaBase` continua apontando para a **expressa**.

`entrega` continua apontando para a **combinação com seguro**.

A composição conserva as regras de estado que o pedido já possuía.

---

<!-- _class: activity -->

<div class="chapter">Diagnóstico — substitua somente o corpo de calcularCusto</div>

## Um resultado certo pode esconder uma falha

O construtor ainda recebe e guarda `entregaBase` nas duas propostas.

```java
// A
return 10.0 + 5.0;
```

```java
// B
Entrega normal = new EntregaNormal();
return normal.calcularCusto(pedido) + 5.0;
```

1. Que resultado cada proposta produz com normal? E com expressa?
2. Por que B falha, mesmo chamando outro objeto? Qual campo deveria usar?

<!-- Aprofundamento elástico já previsto no LessonDesign. Se necessário,
conduzir como diagnóstico coletivo curto, preservando sua resposta seguinte. -->

---

<div class="chapter">Diagnóstico — o colaborador recebido foi ignorado</div>

## As duas propostas sempre devolvem 15.0

| Base recebida | Proposta A | Proposta B | Esperado |
| --- | ---: | ---: | ---: |
| Normal | `15.0` | `15.0` | `15.0` |
| Expressa | `15.0` | `15.0` | `30.0` |

B cria sua própria normal e ignora a escolha recebida.

A chamada necessária é `entregaBase.calcularCusto(pedido)`.

---

<!-- _class: activity -->

<div class="chapter">Retome a implementação correta; surge outra modalidade</div>

## E uma entrega agendada com seguro?

`EntregaAgendada` cumpre `Entrega` e devolve `15.0`, como na Aula 14.

1. Qual deve ser seu custo com seguro?
2. Que regra a modalidade oferece e como montar a combinação?
3. O que precisa mudar em `EntregaComSeguro` e `Pedido`?

---

<div class="chapter">A modalidade oferece a base; a montagem faz a escolha</div>

## Agendada segurada custa 20.0

A modalidade implementa `calcularCusto(Pedido)` devolvendo `15.0`.

```java
Entrega baseAgendada = new EntregaAgendada();
Entrega agendadaSegurada = new EntregaComSeguro(baseAgendada);
Pedido outroPedido = new Pedido();
outroPedido.fechar(agendadaSegurada);
```

`EntregaComSeguro` continua somando `5.0` à base; `Pedido` continua solicitando pelo contrato. Suas implementações permanecem iguais.

---

<div class="chapter">A combinação funciona; agora precisamos protegê-la</div>

## Um teste consulta o pedido fechado

Em `EntregaComSeguroTest`, com JUnit Jupiter configurado:

```java
@Test
void acrescentaSeguroAoCustoExpresso() {
    Pedido pedido = new Pedido();
    pedido.fechar(new EntregaComSeguro(new EntregaExpressa()));

    assertEquals(30.0, pedido.calcularCustoEntrega());
}
```

A expectativa percorre pedido → combinação → entrega-base.

<!-- Retomar os imports já conhecidos: org.junit.jupiter.api.Test e
import static org.junit.jupiter.api.Assertions.assertEquals. O arquivo
completo está no roteiro; cada trecho de teste pertence à mesma classe. -->

---

<div class="chapter">Outro teste consulta duas vezes e confere a base</div>

## O acréscimo não deve se acumular

```java
@Test
void consultasNaoAcumulamSeguroNemAlteramBase() {
    Pedido pedido = new Pedido();
    Entrega base = new EntregaNormal();
    Entrega segurada = new EntregaComSeguro(base);

    assertEquals(15.0, segurada.calcularCusto(pedido));
    assertEquals(15.0, segurada.calcularCusto(pedido));
    assertEquals(10.0, base.calcularCusto(pedido));
}
```

O seguro integra cada resultado; não é um saldo que cresce entre consultas.

---

<!-- _class: activity -->

<div class="chapter">Compare os dois testes com as propostas A e B</div>

## Os dois cenários detectam os mesmos defeitos?

As versões defeituosas eram:

- **A:** devolver `10.0 + 5.0`;
- **B:** criar uma normal e solicitar seu custo, ignorando a base recebida.

1. O teste com **expressa segurada**, que espera `30.0`, detecta A e B?
2. O teste com **normal segurada**, que espera `15.0`, `15.0` e base `10.0`, também as detecta sozinho?

---

<div class="chapter">Escolher os dados determina o que o teste consegue distinguir</div>

## Com normal, as versões defeituosas parecem corretas

1. **Sim, o teste com expressa detecta as duas.** A e B devolvem `15.0`, mas a expectativa é `30.0`.
2. **Não, o teste com normal não as detecta sozinho.** As duas consultas devolvem `15.0`, e a normal original continua devolvendo `10.0`.

Um resultado esperado em um cenário não demonstra que a colaboração foi respeitada.

---

<div class="chapter">Além do custo, queremos observar como a base foi usada</div>

## Fornecer uma entrega que registra a chamada

Em `EntregaRegistrada.java` — campos e construtor:

```java
public class EntregaRegistrada implements Entrega {
    private double custo;
    private int quantidadeCalculos;
    private Pedido ultimoPedido;

    public EntregaRegistrada(double custo) {
        this.custo = custo;
    }
    // operação e consultas aparecem no próximo slide
}
```

<!-- Código de apoio fornecido, não nova API de testes. O recorte ainda não
compila sozinho sem a operação. O contador de instância começa em zero. -->

---

<div class="chapter">Continuação de EntregaRegistrada — observar sem modalidade real</div>

## Registrar antes de devolver o custo

```java
public double calcularCusto(Pedido pedido) {
    quantidadeCalculos++;
    ultimoPedido = pedido;
    return custo;
}
public int getQuantidadeCalculos() {
    return quantidadeCalculos;
}
public Pedido getUltimoPedido() {
    return ultimoPedido;
}
```

O teste pode consultar a quantidade e a referência do pedido recebido.

---

<div class="chapter">Usar o colaborador de registro em um teste novo</div>

## Conferir resultado, quantidade e identidade

```java
@Test
void delegaUmaVezComOMesmoPedido() {
    Pedido pedido = new Pedido();
    EntregaRegistrada base = new EntregaRegistrada(40.0);
    Entrega segurada = new EntregaComSeguro(base);
    double custo = segurada.calcularCusto(pedido);

    assertEquals(45.0, custo);
    assertEquals(1, base.getQuantidadeCalculos());
    assertEquals(true, base.getUltimoPedido() == pedido);
}
```

`==` verifica se as referências alcançam o mesmo pedido.

---

<!-- _class: activity -->

<div class="chapter">Mesmo teste: base de 40.0, um cálculo e o mesmo pedido</div>

## E se a combinação chamar a base duas vezes?

Uma versão solicita `calcularCusto(pedido)` **duas vezes** à base e devolve apenas o segundo resultado mais `5.0`.

A base de registro devolve `40.0` nas duas chamadas.

1. Qual seria o custo final? A expectativa `45.0` passaria?
2. Qual das outras expectativas falharia e com que valor observado?

---

<div class="chapter">Resultado igual; colaboração diferente</div>

## O contador revela a chamada duplicada

1. O custo seria **45.0**. A primeira expectativa passaria.
2. `base.getQuantidadeCalculos()` devolveria **2**, em vez do `1` esperado. Essa expectativa falharia.

A identidade do pedido ainda poderia estar correta.

Observar a colaboração permite detectar um defeito que o custo final esconderia.

---

<div class="chapter">Até aqui, a combinação devolveu um valor</div>

## Retome o jogo da Aula 15

```java
public interface Efeito {
    void aplicarEm(Personagem personagem);
}
```

O personagem começa com **50 pontos**. `Pocao` recupera **20**; `Armadilha` retira **10**.

Dentro de `Personagem`:

```java
public void receber(Efeito efeito) {
    efeito.aplicarEm(this);
}
```

---

<!-- _class: activity -->

<div class="chapter">Transferência — delegar um efeito e depois recuperar 5</div>

## Como distribuir as duas ações?

Proponha `EfeitoComRecuperacao`, que recebe um `Efeito` na criação.

1. Que contrato deve cumprir para ser recebido pelo personagem?
2. Que colaborador guarda e o que solicita a ele?
3. Que ação solicita ao personagem **depois** da delegação?
4. Com personagens novos de `50`, qual vida resulta da combinação com poção? E com armadilha?

<!-- Recuperação de cinco pontos ocorre depois do efeito-base. Cenários
independentes, sem novos limites de vida ou morte. Dar tempo para esboço. -->

---

<div class="chapter">Mesmo contrato, outra consequência da chamada</div>

## Cumprir Efeito, delegar e recuperar

| Decisão | Solução |
| --- | --- |
| Contrato público | `implements Efeito` |
| Colaborador guardado | campo `Efeito efeitoBase`, recebido no construtor |
| Primeira ação | `efeitoBase.aplicarEm(personagem)` |
| Ação seguinte | `personagem.recuperarVida(5)` |

**Poção:** `50 → 70 → 75`. **Armadilha:** `50 → 40 → 45`.

O mesmo personagem recebido é repassado ao efeito-base.

---

<div class="chapter">Expressar a solução proposta em Java</div>

## Uma combinação que altera estado

```java
public class EfeitoComRecuperacao implements Efeito {
    private Efeito efeitoBase;
    public EfeitoComRecuperacao(Efeito efeitoBase) {
        this.efeitoBase = efeitoBase;
    }
    public void aplicarEm(Personagem personagem) {
        efeitoBase.aplicarEm(personagem);
        personagem.recuperarVida(5);
    }
}
```

`void` permite delegação. O personagem controla a vida por suas operações públicas.

---

<div class="chapter">O código de montagem escolhe a combinação</div>

## Usar a armadilha com recuperação

```java
Personagem personagem = new Personagem();
Efeito armadilha = new Armadilha();
Efeito combinado = new EfeitoComRecuperacao(armadilha);

personagem.receber(combinado);
System.out.println(personagem.getVida()); // 45
```

O personagem recebe o objeto combinado pelo contrato; esse objeto delega a primeira ação à armadilha.

---

<div class="chapter">Transferir do jogo para o Projeto 2</div>

## E se a ação for enviar uma mensagem?

O contrato do projeto continua sendo:

```java
public interface Notificador {
    void enviar(String mensagem);
}
```

Um objeto pode acrescentar informação **antes** de solicitar o envio ao canal escolhido.

O lembrete continua responsável pela mensagem original e pela contagem dos avisos.

---

<!-- _class: java-focus -->

<div class="chapter">O mecanismo mínimo para preparar o texto do envio</div>

## Construir um texto com prefixo

```java
String prefixo = "[URGENTE] ";
String mensagem = "Revisar colaboração";
String mensagemDoEnvio = prefixo + mensagem;
```

- Resultado: `"[URGENTE] Revisar colaboração"`.
- O espaço final pertence ao prefixo.
- `mensagem` continua contendo `"Revisar colaboração"`.

---

<!-- _class: synthesis -->

<div class="chapter">Da nova necessidade à colaboração verificável</div>

## Combinar sem repetir a regra-base

- Cumprir um contrato e guardar um colaborador desse contrato são papéis diferentes.
- A delegação usa o objeto recebido; a nova classe realiza seu acréscimo.
- O código de montagem escolhe os objetos; o cliente usa o contrato.
- Referências e regras de estado conservam a colaboração.
- Testes verificam resultados, argumentos e quantidade de chamadas.

---

<div class="chapter">Laboratório 16 — continuar a solução do Laboratório 15</div>

## Acrescentar informação antes do envio

Criar `NotificadorComPrefixo` no Projeto 2:

- Receber prefixo e destino; delegar **um único envio** por chamada.
- Usar a combinação em aviso alternativo, lista e canal inicial.
- Preservar `Lembrete`, os canais, a mensagem e os contadores.
- Observar texto e quantidade com `NotificadorRegistro` e ampliar os testes.

**IA Nível 1 — Tutor. Entrega: somente os arquivos Java.**

<!-- O laboratório especifica sete cenários novos, incluindo prefixo vazio
e prefixo sem espaço final. Não entregar a implementação da nova classe.
No Main, o primeiro lembrete chega a 15 avisos; o segundo tem contador 1.
O roteiro do laboratório fornece estados, saídas e verificações completas. -->
