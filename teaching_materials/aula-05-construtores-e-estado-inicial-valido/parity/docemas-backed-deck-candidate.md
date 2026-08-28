---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 05 — Construtores e estado inicial válido

<div class="statement">Um objeto pode existir para Java e ainda não fazer sentido para o domínio.</div>

<!--
Retomar a Aula 04: protegemos mudanças posteriores, mas ainda não protegemos o nascimento do objeto.
-->

---

<div class="chapter">Trajetória</div>

## Três perguntas para hoje

1. Quando um objeto começa a fazer sentido?
2. Como exigir os dados no momento da criação?
3. Quem protege as regras do estado inicial?

---

<!-- bloco-didatico: 5.1 -->

<!-- _class: code-focus -->

<div class="chapter">Nascer incompleto</div>

## A preparação acontece em etapas

```java
ItemPedido item = new ItemPedido();
item.descricao = "Teclado";
item.precoUnitario = 150.0;
item.aumentarQuantidade(2);
```

<!--
Ler como uma sequência temporal. Não antecipar ainda o construtor com parâmetros.
-->

---

<!-- _class: activity code-focus -->

<div class="chapter">Nascer incompleto</div>

## Pare depois do `new`

```java
ItemPedido item = new ItemPedido();
```

Qual é o valor de cada campo nesse instante?

- `descricao`
- `precoUnitario`
- `quantidade`

<!-- Dar tempo para previsão individual e coletar hipóteses antes da resposta. -->

---

<div class="chapter">Nascer incompleto</div>

## O estado observado

| Campo | Valor padrão |
| --- | --- |
| `descricao` | `null` |
| `precoUnitario` | `0.0` |
| `quantidade` | `0` |

<div class="key-point">O objeto já existe, mas ainda não representa o item pretendido.</div>

---

<!-- _class: java-focus -->

<div class="chapter">Nascer incompleto</div>

## O mínimo de Java necessário

- campos numéricos começam em `0` ou `0.0`;
- campos de tipos de referência começam em `null`;
- `String` é um tipo de referência;
- `null` significa que a referência não aponta para um objeto.

<!-- Não ampliar para usos gerais de null. -->

---

<!-- _class: activity compact-code -->

<div class="chapter">Preparação em etapas</div>

## Qual item ficou incompleto?

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

<!-- Perguntar também o subtotal de itemB e se Java detecta a etapa ausente. -->

---

<div class="chapter">Preparação em etapas</div>

## O código compila mesmo assim

<div class="cards">
  <div class="concept-card"><strong>Preço de itemB</strong><br><code>0.0</code></div>
  <div class="concept-card"><strong>Quantidade</strong><br><code>3</code></div>
  <div class="concept-card"><strong>Subtotal</strong><br><code>0.0</code></div>
</div>

<div class="key-point">A linguagem conhece os tipos; a expectativa de completude pertence ao domínio.</div>

---

<div class="chapter">Preparação em etapas</div>

## O risco está na sequência externa

- uma etapa pode ser esquecida;
- o objeto pode circular cedo demais;
- cada cliente precisa conhecer a preparação;
- clientes diferentes podem preparar objetos de formas incompatíveis.

---

<!-- _class: concept-key -->

<div class="chapter">O problema identificado</div>

## Estado inicial

É o conjunto de valores que um objeto possui quando sua criação termina.

<div class="key-point">Proteger mudanças posteriores não basta se o objeto pode nascer inadequado ou incompleto.</div>

---

<div class="chapter">Uma necessidade</div>

## Se sabemos do que o item precisa...

<div class="statement">Por que não fornecer essas informações no próprio momento da criação?</div>

---

<!-- bloco-didatico: 5.2 -->

<!-- _class: code-focus -->

<div class="chapter">Criar e inicializar</div>

## A criação declara os dados necessários

```java
ItemPedido item =
    new ItemPedido("Teclado", 150.0, 2);
```

Descrição, preço e quantidade aparecem na expressão de criação.

---

<!-- _class: code-focus method-structure -->

<div class="chapter">Criar e inicializar</div>

## A classe recebe os valores

```java
public ItemPedido(String descricaoRecebida,
                  double precoRecebido,
                  int quantidadeRecebida) {
    descricao = descricaoRecebida;
    precoUnitario = precoRecebido;
    quantidade = quantidadeRecebida;
}
```

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
    // prepara o estado inicial
}
```

- tem o mesmo nome da classe;
- não declara retorno, nem `void`;
- pode receber parâmetros;
- executa durante a criação com `new`.

---

<!-- _class: activity code-focus -->

<div class="chapter">Impacto da mudança</div>

## A forma antiga ainda compila?

```java
ItemPedido item = new ItemPedido();
```

A classe agora declara apenas:

```java
ItemPedido(String descricao,
           double precoUnitario,
           int quantidade)
```

Formule uma hipótese e justifique.

---

<!-- _class: trap -->

<div class="chapter">Impacto da mudança</div>

## O construtor implícito deixou de existir

Sem construtor declarado, Java fornece implicitamente uma forma sem argumentos.

Ao declarar o construtor de três parâmetros, essa forma deixa de ser fornecida.

<div class="key-point"><code>new ItemPedido()</code> não corresponde ao construtor disponível.</div>

---

<div class="chapter">O caminho dos dados</div>

## Chamada e declaração se encontram

```java
new ItemPedido("Teclado", 150.0, 2)
```

```java
public ItemPedido(String descricaoRecebida,
                  double precoRecebido,
                  int quantidadeRecebida)
```

---

<div class="chapter">O caminho dos dados</div>

## Acompanhe um valor

<div class="sequence">
  <div class="step"><strong>150.0</strong><br>argumento</div>
  <div class="arrow">→</div>
  <div class="step"><strong>precoRecebido</strong><br>parâmetro</div>
  <div class="arrow">→</div>
  <div class="step"><strong>precoUnitario</strong><br>campo</div>
</div>

---

<div class="chapter">O caminho dos dados</div>

## Três papéis

<div class="cards">
  <div class="concept-card"><strong>Argumento</strong><br>valor fornecido na chamada</div>
  <div class="concept-card"><strong>Parâmetro</strong><br>variável que recebe o valor</div>
  <div class="concept-card"><strong>Campo</strong><br>parte do estado do objeto</div>
</div>

<div class="key-point">argumento → parâmetro → campo</div>

---

<!-- _class: code-focus -->

<div class="chapter">Cada criação</div>

## O construtor é o mesmo; os objetos não

```java
ItemPedido teclado =
    new ItemPedido("Teclado", 150.0, 2);

ItemPedido mouse =
    new ItemPedido("Mouse", 80.0, 3);
```

Cada execução prepara o estado de um novo objeto.

---

<!-- _class: code-focus method-structure -->

<div class="chapter">Nomes que coincidem</div>

## Campo e parâmetro

```java
public ItemPedido(String descricao,
                  double precoUnitario,
                  int quantidade) {
    this.descricao = descricao;
    this.precoUnitario = precoUnitario;
    this.quantidade = quantidade;
}
```

---

<!-- _class: concept-key -->

<div class="chapter">Nomes que coincidem</div>

## O papel de `this`

- `this.descricao`: campo do objeto atual;
- `descricao`: parâmetro recebido pelo construtor.

<div class="key-point"><code>this</code> resolve a ambiguidade concreta entre campo e parâmetro com o mesmo nome.</div>

---

<!-- _class: tip -->

<div class="chapter">Nomes que coincidem</div>

## Siga o valor

Escolha um argumento, localize o parâmetro que o recebe e veja em qual campo ele é armazenado.

<div class="sequence">
  <div class="step"><strong>150.0</strong></div>
  <div class="arrow">→</div>
  <div class="step"><strong>precoUnitario</strong></div>
  <div class="arrow">→</div>
  <div class="step"><strong>this.precoUnitario</strong></div>
</div>

---

<!-- _class: activity code-focus -->

<div class="chapter">Nomes que coincidem</div>

## Acompanhe esta criação

```java
new ItemPedido("Mouse", 80.0, 3)
```

1. Qual será o estado final?
2. O que faria `descricao = descricao;`?
3. A qual nome cada lado se refere?

<!-- Coletar hipóteses antes de fechar o papel de this. -->

---

<div class="chapter">Uma nova tensão</div>

## Exigir dados basta?

```java
ItemPedido item =
    new ItemPedido("", -100.0, -4);
```

Todos os argumentos foram fornecidos. O objeto nasceu em um estado aceitável?

---

<!-- bloco-didatico: 5.3 -->

<div class="chapter">Estado inicial coerente</div>

## Tipos corretos, valores inadequados

- `-100.0` é um `double` válido para Java;
- `-4` é um `int` válido para Java;
- preço e quantidade negativos não servem ao domínio de `ItemPedido`.

<div class="key-point">Receber todos os dados não garante coerência.</div>

---

<div class="chapter">Estado inicial coerente</div>

## Duas regras simples

- `precoUnitario >= 0`
- `quantidade >= 0`

O valor `0` continua aceito nesta etapa.

<!-- Não ampliar para validação textual, exceções ou políticas de comunicação de falha. -->

---

<!-- _class: code-focus method-structure -->

<div class="chapter">Estado inicial coerente</div>

## A classe preserva as regras

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

---

<div class="chapter">Estado inicial coerente</div>

## E quando o argumento é negativo?

O campo permanece no valor padrão:

- preço negativo → `precoUnitario` permanece `0.0`;
- quantidade negativa → `quantidade` permanece `0`.

Isso preserva a regra, mas ainda não comunica a rejeição ao cliente.

---

<!-- _class: trap -->

<div class="chapter">Limite deliberado</div>

## Não vamos resolver toda política de erro agora

O foco é reconhecer quem deve preservar a regra.

Exceções, mensagens, validação textual e outras formas de rejeitar argumentos ficam fora do escopo desta aula.

---

<!-- _class: activity compact-code -->

<div class="chapter">Responsabilidade</div>

## Onde a regra deve ficar?

**A — cada cliente valida antes de criar**

```java
ItemPedido item =
    new ItemPedido(descricao, precoInicial, quantidadeInicial);
```

**B — a classe preserva a regra ao criar**

```java
ItemPedido item =
    new ItemPedido(descricao, preco, quantidade);
```

Qual alternativa concentra a regra em todos os pontos de criação?

---

<!-- _class: concept-key -->

<div class="chapter">Responsabilidade</div>

## Invariante

Uma invariante é uma regra que deve permanecer verdadeira para o estado do objeto.

Para `ItemPedido` nesta etapa:

```text
precoUnitario >= 0
quantidade >= 0
```

---

<div class="chapter">Responsabilidade</div>

## A trajetória até aqui

<div class="sequence">
  <div class="step">construtor<br>organiza a criação</div>
  <div class="arrow">→</div>
  <div class="step">validação<br>filtra argumentos</div>
  <div class="arrow">→</div>
  <div class="step">objeto<br>protege seu estado</div>
</div>

---

<!-- aprofundamento-elastico: encurtar conforme o ritmo da turma -->

<!-- _class: activity code-focus -->

<div class="chapter">Transferência</div>

## E em uma `Reserva`?

```java
Reserva reserva = new Reserva(4, 180.0);
```

1. Que dados ela precisa receber ao nascer?
2. `-2` pessoas faria sentido?
3. Uma diária negativa deveria entrar no estado?
4. Quem deve preservar essas regras?

<!-- Não implementar Reserva. Fechar coletivamente se houver tempo. -->

---

<!-- _class: synthesis -->

<div class="chapter">Síntese</div>

## Do objeto incompleto ao estado inicial válido

- o problema da criação incompleta produz a necessidade do construtor;
- argumentos chegam aos parâmetros e alimentam campos;
- `this` distingue campo e parâmetro quando os nomes coincidem;
- a classe preserva invariantes durante a criação;
- `0` permanece aceito nas regras numéricas desta etapa.

---

<div class="chapter">Próximo passo</div>

## Laboratório 05

Vamos evoluir a Versão 4 para que `ItemPedido`:

- exija os três dados na criação;
- adapte todos os pontos de criação;
- deixe de depender de preparação externa direta;
- preserve as invariantes numéricas desde o nascimento.

<div class="key-point">A aula construiu o porquê; o laboratório consolidará o mecanismo no projeto.</div>

---

<div class="chapter">Continuidade do projeto</div>

## Cada item já cuida de si

Um `Pedido`, porém, precisará trabalhar com vários itens.

<div class="statement">Quem deve cuidar da colaboração e do conjunto formado por eles?</div>
