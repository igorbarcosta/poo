---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 05 — Construtores e estado inicial válido

<div class="statement">Se um objeto precisa de certas informações para fazer sentido, por que permitimos que ele seja criado incompleto?</div>

<!--
Abrir retomando a consequência da Aula 04: já protegemos mudanças posteriores, mas ainda não protegemos o momento da criação.
-->

---

<div class="chapter">Trajetória</div>

## Hoje vamos investigar

<div class="sequence">
  <div class="step">objeto incompleto</div>
  <div class="arrow">→</div>
  <div class="step">criação inicializada</div>
  <div class="arrow">→</div>
  <div class="step">estado inicial coerente</div>
</div>

<!--
Não apresentar construtor como ponto de partida. A aula começa pelo problema e chega ao mecanismo.
-->

---

<!-- bloco-didatico: 5.1 -->

<!-- _class: code-focus -->

<div class="chapter">O objeto incompleto</div>

## Ao final do Laboratório 04...

```java
ItemPedido item = new ItemPedido();
item.descricao = "Teclado";
item.precoUnitario = 150.0;
item.aumentarQuantidade(2);
```

<!--
Ler linha por linha. A pergunta não é se o código funciona ao final, mas em que momento o objeto passa a representar o item pretendido.
-->

---

<!-- _class: activity code-focus -->

<div class="chapter">O objeto incompleto</div>

## Pare depois da primeira linha

```java
ItemPedido item = new ItemPedido();
```

Qual é o estado do objeto nesse momento?

- `descricao` = ?
- `precoUnitario` = ?
- `quantidade` = ?

<!--
Dar tempo real para formulação individual. Coletar hipóteses antes de avançar. Não revelar os valores padrão ainda.
-->

---

<div class="chapter">O objeto incompleto</div>

## O objeto já existe

| Campo | Valor nesse momento |
| --- | --- |
| `descricao` | `null` |
| `precoUnitario` | `0.0` |
| `quantidade` | `0` |

<div class="key-point">Existir para Java ainda não significa representar o item que queremos usar.</div>

<!--
Retomar as hipóteses. Distinguir existência do objeto de adequação ao domínio.
-->

---

<!-- _class: java-focus -->

<div class="chapter">O objeto incompleto</div>

## `null` e valores padrão

- campos numéricos começam em `0` ou `0.0`;
- campos que guardam referências começam em `null`;
- `String` é um tipo de referência;
- `null` indica que a referência não aponta para um objeto.

<!--
Manter curto. Não abrir usos, comparação ou riscos gerais de null. O apoio necessário agora é somente ler o estado inicial.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Preparação em etapas</div>

## Quando o item fica pronto?

```java
ItemPedido itemA = new ItemPedido();
itemA.descricao = "Teclado";
itemA.precoUnitario = 150.0;
itemA.aumentarQuantidade(2);
```

<!--
Percorrer a sequência. Perguntar em que linha o objeto passa a possuir todos os dados pretendidos.
-->

---

<!-- _class: activity compact-code -->

<div class="chapter">Preparação em etapas</div>

## E se uma etapa for esquecida?

```java
ItemPedido itemA = new ItemPedido();
itemA.descricao = "Teclado";
itemA.precoUnitario = 150.0;
itemA.aumentarQuantidade(2);
```

```java
ItemPedido itemB = new ItemPedido();
itemB.descricao = "Mouse";
itemB.aumentarQuantidade(3);
```

1. Qual objeto ficou incompleto?
2. O que `itemB.calcularSubtotal()` produz?
3. A linguagem percebe que faltou uma etapa?

<!--
Esperar elaboração individual e coletar justificativas. Não avançar enquanto a turma ainda estiver formulando respostas.
-->

---

<div class="chapter">Preparação em etapas</div>

## O segundo trecho compila

<div class="cards">
  <div class="concept-card"><strong>Preço</strong><code>0.0</code><br>permaneceu no valor padrão</div>
  <div class="concept-card"><strong>Quantidade</strong><code>3</code><br>foi alterada depois da criação</div>
  <div class="concept-card"><strong>Subtotal</strong><code>0.0</code><br>é calculado com esse estado</div>
</div>

<div class="key-point">Java conhece os tipos. A expectativa de que o item esteja completo pertence ao domínio.</div>

<!--
Usar as respostas coletadas. Não apresentar o objeto como erro de Java: o programa está executável, mas não representa o item pretendido.
-->

---

<div class="chapter">Preparação em etapas</div>

## Criar agora, completar depois

- uma etapa pode ser esquecida;
- outro método pode receber o objeto cedo demais;
- cada cliente precisa conhecer a sequência de preparação;
- diferentes clientes podem preparar o mesmo tipo de maneiras incompatíveis.

<!--
Sintetizar os riscos que surgiram nos dois exemplos. Evitar prolongar a lista com novos cenários.
-->

---

<!-- _class: concept-key -->

<div class="chapter">O problema identificado</div>

## Estado inicial

É o conjunto de valores que um objeto possui quando sua criação termina.

<div class="key-point">Proteger mudanças posteriores não basta quando a criação ainda permite estados inadequados ou incompletos.</div>

---

<div class="chapter">Uma nova necessidade</div>

## Se já sabemos do que o item precisa...

<div class="statement">Por que não fornecer essas informações no próprio momento da criação?</div>

<!--
Deixar a pergunta produzir a transição para o bloco 5.2. Não nomear construtor antes de a necessidade estar clara.
-->

---

<!-- bloco-didatico: 5.2 -->

<!-- _class: code-focus -->

<div class="chapter">Criar e inicializar</div>

## Uma criação que declara os dados necessários

```java
ItemPedido item =
    new ItemPedido("Teclado", 150.0, 2);
```

<div class="key-point">Descrição, preço e quantidade aparecem na própria expressão de criação.</div>

---

<!-- _class: code-focus method-structure -->

<div class="chapter">Criar e inicializar</div>

## A classe precisa receber esses valores

```java
public ItemPedido(String descricaoRecebida,
                  double precoRecebido,
                  int quantidadeRecebida) {
    descricao = descricaoRecebida;
    precoUnitario = precoRecebido;
    quantidade = quantidadeRecebida;
}
```

<!--
Primeiro ler a estrutura inteira. Só depois nomear o mecanismo. Destacar que não há tipo de retorno.
-->

---

<!-- _class: concept-key -->

<div class="chapter">Criar e inicializar</div>

## Construtor

Um construtor define como o estado inicial de um objeto é preparado no momento de sua criação.

<div class="key-point">A classe explicita aquilo de que o objeto precisa ao nascer.</div>

---

<!-- _class: java-focus method-structure -->

<div class="chapter">Mecanismo de Java</div>

## Como reconhecer um construtor

```java
public ItemPedido(String descricao,
                  double precoUnitario,
                  int quantidade) {
    // preparação do estado inicial
}
```

- possui o mesmo nome da classe;
- não declara tipo de retorno, nem `void`;
- pode receber parâmetros;
- é executado durante a criação com `new`.

<!--
Não abrir sobrecarga, encadeamento ou outros usos. O laboratório depende somente desta forma básica.
-->

---

<!-- _class: activity code-focus -->

<div class="chapter">Impacto da mudança</div>

## O que acontece com o código antigo?

```java
ItemPedido item = new ItemPedido();
```

A classe agora declara apenas este construtor:

```java
ItemPedido(String descricao,
           double precoUnitario,
           int quantidade)
```

Esse código ainda compila? Por quê?

<!--
Dar tempo para previsão. Recuperar o significado dos três parâmetros antes de mostrar a resposta.
-->

---

<!-- _class: trap -->

<div class="chapter">Impacto da mudança</div>

## “Mas `new ItemPedido()` funcionava antes”

Quando uma classe não declara construtor, Java fornece implicitamente um construtor sem argumentos.

Depois que declaramos o construtor com três parâmetros, essa forma implícita deixa de ser fornecida.

<div class="key-point"><code>new ItemPedido()</code> já não corresponde ao construtor disponível.</div>

---

<div class="chapter">O caminho dos dados</div>

## Criação e declaração precisam se encontrar

```java
new ItemPedido("Teclado", 150.0, 2)
```

```java
public ItemPedido(String descricaoRecebida,
                  double precoRecebido,
                  int quantidadeRecebida)
```

<!--
Ler as duas linhas em correspondência. Não pedir memorização de definições ainda.
-->

---

<div class="chapter">O caminho dos dados</div>

## Vamos acompanhar apenas um valor

<div class="sequence">
  <div class="step"><strong>150.0</strong><br>argumento</div>
  <div class="arrow">→</div>
  <div class="step"><strong>precoRecebido</strong><br>parâmetro</div>
  <div class="arrow">→</div>
  <div class="step"><strong>precoUnitario</strong><br>campo</div>
</div>

<!--
Apontar o valor na chamada, o nome que o recebe e o campo onde ele passa a integrar o estado.
-->

---

<div class="chapter">O caminho dos dados</div>

## Três papéis diferentes

<div class="cards">
  <div class="concept-card"><strong>Argumento</strong>valor ou expressão fornecida na chamada</div>
  <div class="concept-card"><strong>Parâmetro</strong>variável declarada para receber o valor</div>
  <div class="concept-card"><strong>Campo</strong>parte do estado em que o valor pode ser armazenado</div>
</div>

<div class="key-point">argumento → parâmetro → campo</div>

---

<!-- _class: code-focus -->

<div class="chapter">Cada criação</div>

## O construtor é o mesmo

```java
ItemPedido teclado =
    new ItemPedido("Teclado", 150.0, 2);

ItemPedido mouse =
    new ItemPedido("Mouse", 80.0, 3);
```

<div class="key-point">Cada execução recebe argumentos diferentes e prepara o estado de um novo objeto.</div>

<!--
Conectar com identidade: duas execuções de new continuam criando dois objetos distintos. Não reabrir toda a Aula 03.
-->

---

<!-- _class: code-focus method-structure -->

<div class="chapter">Quando os nomes coincidem</div>

## Campo e parâmetro com o mesmo nome

```java
public ItemPedido(String descricao,
                  double precoUnitario,
                  int quantidade) {
    this.descricao = descricao;
    this.precoUnitario = precoUnitario;
    this.quantidade = quantidade;
}
```

<!--
Perguntar o que aparece duas vezes em cada atribuição. A ambiguidade concreta produz a necessidade de this.
-->

---

<div class="chapter">Quando os nomes coincidem</div>

## Leia os dois lados

```java
this.descricao = descricao;
```

<div class="columns">
<div>

### `this.descricao`

campo do objeto atual

</div>
<div>

### `descricao`

parâmetro recebido

</div>
</div>

<!--
Manter o foco somente na distinção entre campo e parâmetro. Não ampliar para outros significados de this.
-->

---

<!-- _class: tip -->

<div class="chapter">Quando os nomes coincidem</div>

## Siga o valor

<div class="sequence">
  <div class="step"><strong>150.0</strong><br>argumento</div>
  <div class="arrow">→</div>
  <div class="step"><strong>precoUnitario</strong><br>parâmetro</div>
  <div class="arrow">→</div>
  <div class="step"><strong>this.precoUnitario</strong><br>campo</div>
</div>

---

<!-- _class: activity code-focus -->

<div class="chapter">Acompanhe a criação</div>

## Antes de responder

```java
new ItemPedido("Mouse", 80.0, 3)
```

1. Qual será o estado do objeto ao final do construtor?
2. O que aconteceria com `descricao = descricao;`?
3. A qual `descricao` cada lado se refere?

<!--
Dar tempo real para hipótese individual. Coletar respostas e contrastar justificativas antes do próximo frame.
-->

---

<div class="chapter">Acompanhe a criação</div>

## Estado ao final do construtor

| Campo | Valor |
| --- | --- |
| `descricao` | `"Mouse"` |
| `precoUnitario` | `80.0` |
| `quantidade` | `3` |

<div class="key-point">O caminho completo foi: argumento → parâmetro → campo.</div>

<!--
Primeiro validar a resposta sobre o estado. Em seguida, retomar a hipótese sobre a atribuição sem this.
-->

---

<!-- _class: trap code-focus -->

<div class="chapter">Acompanhe a criação</div>

## `descricao = descricao;`

```java
public ItemPedido(String descricao) {
    descricao = descricao;
}
```

Os dois nomes se referem ao parâmetro.

<div class="key-point">O campo permanece sem receber o valor. <code>this.descricao</code> torna explícito o campo do objeto atual.</div>

<!--
Relacionar à hipótese da turma. Não apresentar this como palavra obrigatória em toda atribuição: ele responde à coincidência dos nomes.
-->

---

<div class="chapter">Uma nova tensão</div>

## Agora exigimos todos os argumentos

```java
ItemPedido item =
    new ItemPedido("", -100.0, -4);
```

<div class="statement">Receber todos os dados significa nascer em um estado aceitável?</div>

<!--
Deixar a pergunta em aberto. A criação está completa do ponto de vista da assinatura, mas os valores provocam o bloco 5.3.
-->

---

<!-- bloco-didatico: 5.3 -->

<!-- _class: activity -->

<div class="chapter">Dados completos?</div>

## Examine o estado proposto

```java
new ItemPedido("", -100.0, -4)
```

- os três argumentos foram fornecidos;
- os três tipos estão corretos;
- o objeto deveria incorporar esses três valores?

<!--
Coletar hipóteses. Separar correção de tipo de coerência no domínio. Não discutir ainda políticas de erro ou validação textual.
-->

---

<div class="chapter">Dados completos?</div>

## O tipo não conhece a regra do problema

<div class="cards">
  <div class="concept-card"><strong>Java</strong><code>-100.0</code> é um <code>double</code><br><code>-4</code> é um <code>int</code></div>
  <div class="concept-card"><strong>ItemPedido</strong>preço e quantidade negativos não representam estados adequados</div>
</div>

<div class="key-point">Inicializar os campos não garante, por si só, que os valores façam sentido.</div>

---

<div class="chapter">Regras desta etapa</div>

## Duas invariantes numéricas simples

- `precoUnitario >= 0`
- `quantidade >= 0`

O valor `0` permanece aceito.

<div class="key-point">A validação textual da descrição não será aprofundada agora.</div>

<!--
Explicitar o recorte. Não inventar regras adicionais para descrição, preço ou quantidade.
-->

---

<!-- _class: code-focus compact-code method-structure -->

<div class="chapter">Proteger a criação</div>

## O construtor avalia os valores

```java
public ItemPedido(String descricao,
                  double precoUnitario,
                  int quantidade) {
    this.descricao = descricao;

    if (precoUnitario >= 0) {
        this.precoUnitario = precoUnitario;
    }

    if (quantidade >= 0) {
        this.quantidade = quantidade;
    }
}
```

<!--
Ler um if por vez. Relacionar a condição à regra do domínio, não somente à sintaxe.
-->

---

<!-- _class: activity code-focus -->

<div class="chapter">Preveja o estado</div>

## Depois desta criação...

```java
ItemPedido item =
    new ItemPedido("Teste", -10.0, -2);
```

Quais valores ficam nos campos?

- `descricao` = ?
- `precoUnitario` = ?
- `quantidade` = ?

<!--
Esperar previsão antes de avançar. Pedir que a justificativa acompanhe cada condição do construtor.
-->

---

<div class="chapter">Preveja o estado</div>

## Os valores negativos não entram

| Campo | Estado final |
| --- | --- |
| `descricao` | `"Teste"` |
| `precoUnitario` | `0.0` |
| `quantidade` | `0` |

<div class="key-point">Quando a condição falha, o campo numérico permanece com seu valor padrão.</div>

<!--
Comparar com as previsões. Ressaltar que esta política preserva a regra, mas ainda não comunica a rejeição.
-->

---

<div class="chapter">Limite da solução atual</div>

## Preservar a regra não comunica a falha

```java
new ItemPedido("Teste", -10.0, -2)
```

- o objeto não incorpora números negativos;
- preço e quantidade permanecem em zero;
- quem chamou não recebe uma informação sobre a rejeição.

<div class="key-point">Hoje o foco é preservar o estado. Outras políticas exigem repertório que ainda não introduzimos.</div>

<!--
Não antecipar exceções, retornos alternativos ou fábricas. Apenas reconhecer conscientemente a limitação.
-->

---

<!-- _class: activity compact-code -->

<div class="chapter">Onde a regra deve ficar?</div>

## Proposta A — cada cliente verifica

```java
double precoInicial = 0.0;
if (preco >= 0) precoInicial = preco;

int quantidadeInicial = 0;
if (quantidade >= 0) quantidadeInicial = quantidade;

ItemPedido item =
    new ItemPedido(descricao, precoInicial, quantidadeInicial);
```

O que acontece quando outro cliente esquece essa verificação?

<!--
Apresentar primeiro apenas a proposta A. Dar tempo para localizar duplicação de responsabilidade e risco de esquecimento.
-->

---

<!-- _class: activity code-focus -->

<div class="chapter">Onde a regra deve ficar?</div>

## Proposta B — a classe preserva a regra

```java
ItemPedido item =
    new ItemPedido(descricao, preco, quantidade);
```

Considere que o construtor valida preço e quantidade.

1. Qual proposta concentra a regra em todos os pontos de criação?
2. Quem conhece melhor os estados aceitáveis de `ItemPedido`?

<!--
Coletar escolhas e justificativas. Fechar em torno de responsabilidade, sem transformar a discussão em comparação de políticas de falha.
-->

---

<div class="chapter">Responsabilidade</div>

## A regra acompanha o objeto

<div class="sequence">
  <div class="step">qualquer cliente fornece valores</div>
  <div class="arrow">→</div>
  <div class="step">o construtor avalia</div>
  <div class="arrow">→</div>
  <div class="step">o estado preserva as regras</div>
</div>

<div class="key-point">A criação e as mudanças posteriores pertencem a momentos diferentes, mas a responsabilidade continua com a classe.</div>

---

<!-- _class: concept-key -->

<div class="chapter">Responsabilidade</div>

## Invariante

Uma invariante é uma regra que deve permanecer verdadeira para o estado do objeto.

- `precoUnitario >= 0`
- `quantidade >= 0`

<div class="key-point">A classe protege essas regras durante a criação e nas mudanças posteriores.</div>

---

<!-- aprofundamento-elastico: Reserva -->

<!-- _class: activity code-focus -->

<div class="chapter">Transferência</div>

## A ideia continua em outro domínio?

```java
Reserva reserva = new Reserva(4, 180.0);
```

1. Quais informações uma reserva precisa receber na criação?
2. `-2` pessoas deveria fazer parte do estado?
3. Uma diária negativa deveria fazer parte do estado?
4. Quem deveria proteger essas regras?
5. Que resultado rápido mostraria que a proteção funcionou?

<!--
Aprofundamento elástico. Se o tempo estiver curto, coletar apenas as duas últimas respostas e seguir para a síntese. Não implementar Reserva.
-->

---

<div class="chapter">Transferência</div>

## O domínio mudou. A responsabilidade não.

<div class="cards">
  <div class="concept-card"><strong>ItemPedido</strong>protege preço e quantidade</div>
  <div class="concept-card"><strong>Reserva</strong>deveria proteger pessoas e diária</div>
</div>

**Evidência rápida:** tentar criar uma reserva com valor negativo e observar que esse valor não foi incorporado ao estado.

<div class="key-point">Os clientes fornecem valores; a classe conhece e preserva as regras de seu estado.</div>

<!--
Usar somente se a transferência foi conduzida. Fechar a aplicação sem propor uma implementação completa de Reserva.
-->

---

<!-- _class: synthesis -->

<div class="chapter">Fechamento</div>

## Da criação vazia ao estado inicial coerente

<div class="sequence">
  <div class="step">o objeto podia nascer incompleto</div>
  <div class="arrow">→</div>
  <div class="step">o construtor exige os dados</div>
  <div class="arrow">→</div>
  <div class="step">a classe protege invariantes</div>
</div>

---

<div class="chapter">Fechamento</div>

## O que precisamos conseguir explicar

- por que configurar o objeto em etapas permite estados incompletos;
- o caminho argumento → parâmetro → campo;
- por que `this.campo` e o parâmetro têm papéis diferentes;
- por que receber todos os dados não garante coerência;
- quem deve preservar as regras do estado inicial.

---

<div class="chapter">Próximo passo</div>

## No Laboratório 05

Vamos evoluir a Versão 4 do Projeto 1:

- criar objetos com descrição, preço e quantidade;
- adaptar os pontos que ainda usam criação vazia;
- proteger todos os campos;
- preservar as invariantes também durante a criação.

<!--
Encerrar conectando diretamente com o laboratório, sem antecipar Pedido, coleções ou colaboração entre objetos.
-->
