---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 02 — Do procedural aos objetos

<div class="statement">Como tornar explícitas no código as unidades que já reconhecemos no problema?</div>

<!--
Começar pela experiência do Laboratório 01, sem definir POO. Retomar o que a turma efetivamente programou.
-->

---

<!-- _class: example code-focus -->

<div class="chapter">Problema inicial</div>

## No Laboratório 01...

```java
String descricao1 = "Teclado";
double preco1 = 150.0;
int quantidade1 = 2;

String descricao2 = "Mouse";
double preco2 = 80.0;
int quantidade2 = 3;
```

<!--
Pedir que reconheçam o código. Não apresentar a solução procedural como errada.
-->

---

<!-- _class: question -->

<div class="chapter">Problema inicial</div>

## Quando os itens aumentaram...

- O que começou a ficar difícil?
- Quais variáveis representam partes de uma mesma coisa?
- Como manter dados e operações relacionados mais próximos?

<!--
Esperar respostas e recuperar as questões finais do laboratório. Aceitar repetição, nomes e manutenção das relações como observações.
-->

---

<!-- _class: concept -->

<div class="chapter">Problema inicial</div>

## Os dados estão relacionados

<div class="cards">
<div class="concept-card"><strong>Item 1</strong><code>descricao1</code><br><code>preco1</code><br><code>quantidade1</code></div>
<div class="concept-card"><strong>Item 2</strong><code>descricao2</code><br><code>preco2</code><br><code>quantidade2</code></div>
</div>

<div class="key-point">Reconhecemos dois itens no problema, mesmo que seus dados estejam separados no código.</div>

<!--
Consolidar a leitura do código antes de provocar a pergunta central.
-->

---

<!-- _class: question -->

<div class="chapter">Problema inicial</div>

## Se descrição, preço e quantidade pertencem ao mesmo item, onde está o `Item` no nosso programa?

<!--
Deixar a pergunta existir. Não responder ainda com “classe” ou “objeto”.
-->

---

<!-- _class: example code-focus -->

<div class="chapter">Problema inicial</div>

## Uma possível evolução procedural

```java
String[] descricoes = {"Teclado", "Mouse"};
double[] precos = {150.0, 80.0};
int[] quantidades = {2, 3};
```

<!--
Apresentar como possibilidade, não como algo que todos deveriam ter feito. Não ensinar arrays.
-->

---

<!-- _class: question code-focus -->

<div class="chapter">Problema inicial</div>

## O que melhorou?

E o que ainda depende de uma convenção?

```text
descricoes[i]
precos[i]
quantidades[i]
```

<!--
Esperar a turma perceber que o índice precisa manter os três arrays alinhados.
-->

---

<!-- _class: concept -->

<div class="chapter">Problema inicial</div>

## A posição mantém a relação

<div class="columns">
<div class="concept-card"><strong>posição 0</strong><div class="state">"Teclado"<br>150.0<br>2</div></div>
<div class="concept-card"><strong>posição 1</strong><div class="state">"Mouse"<br>80.0<br>3</div></div>
</div>

<div class="key-point">Os arrays reduzem repetição, mas o mesmo índice ainda precisa representar o mesmo item.</div>

<!--
O benefício é real. A limitação é depender da posição em estruturas separadas.
-->

---

<!-- _class: section -->

<div class="chapter">Primeiros objetos</div>

## O `Item` existe no problema

<div class="statement">Mas ainda está implícito no código.</div>

<!--
Este é o ponto de descoberta que cria a necessidade do próximo conceito.
-->

---

<!-- _class: concept -->

<div class="chapter">Primeiros objetos</div>

## Tornando a unidade explícita

<div class="concept-card">
<strong>ItemPedido</strong>
<div class="state">descrição<br>preço unitário<br>quantidade</div>
</div>

<!--
Introduzir ItemPedido como conceito relevante da solução. Ainda não mostrar a classe Java.
-->

---

<!-- _class: concept definition -->

<div class="chapter">Primeiros objetos</div>

## Objeto

<div class="statement">Uma unidade da solução que reúne informações e operações relacionadas.</div>

<!--
Dar nome ao conceito somente depois de a necessidade ter surgido. Evitar definição formal excessiva.
-->

---

<!-- _class: concept -->

<div class="chapter">Primeiros objetos</div>

## O estado de um item

<div class="concept-card">
<strong>ItemPedido</strong>
<div class="state">descricao = "Teclado"<br>precoUnitario = 150.0<br>quantidade = 2</div>
</div>

<div class="key-point">Estado: informações que caracterizam o objeto em determinado momento.</div>

<!--
Relacionar estado aos dados que já existiam na solução procedural.
-->

---

<!-- _class: question -->

<div class="chapter">Primeiros objetos</div>

## Um objeto apenas guarda dados?

O que esse item precisa saber fazer com o próprio estado?

<!--
Esperar ideias. Conduzir para calcular o subtotal, sem ainda discutir responsabilidade em profundidade.
-->

---

<!-- _class: concept -->

<div class="chapter">Primeiros objetos</div>

## Comportamento

```java
calcularSubtotal()
```

<div class="sequence">
  <span>preço unitário</span>
  <strong>×</strong>
  <span>quantidade</span>
  <strong>→</strong>
  <span>subtotal</span>
</div>

<div class="key-point">Comportamento: uma operação relacionada ao objeto que pode usar seu estado.</div>

<!--
Não transformar ainda em discussão completa de responsabilidade; ela será retomada como clímax.
-->

---

<!-- _class: concept -->

<div class="chapter">Primeiros objetos</div>

## Estado + comportamento

<div class="cards">
<div class="concept-card"><strong>Estado</strong>descrição<br>preço unitário<br>quantidade</div>
<div class="concept-card"><strong>Comportamento</strong><code>calcularSubtotal()</code></div>
</div>

<div class="key-point"><code>ItemPedido</code> representa uma unidade relevante para esta solução.</div>

<!--
Ressaltar oralmente: substantivos podem sugerir conceitos, mas nem todo substantivo deve virar classe.
-->

---

<!-- _class: question -->

<div class="chapter">Primeiros objetos</div>

## Todo substantivo vira classe?

<!--
Esperar uma resposta breve. Não transformar em catálogo de heurísticas de modelagem.
-->

---

<!-- _class: concept -->

<div class="chapter">Primeiros objetos</div>

## O nome é apenas uma pista

<div class="statement"><code>ItemPedido</code> importa porque possui estado, comportamento e um papel coerente na solução.</div>

<div class="key-point">Identificar substantivos ajuda a perceber conceitos — não decide automaticamente as classes.</div>

<!--
Consolidar sem aprofundar design. Voltar imediatamente ao exemplo central.
-->

---

<!-- _class: concept definition -->

<div class="chapter">Da ideia ao Java</div>

## Classe

<div class="statement">Define a estrutura e os comportamentos comuns aos objetos daquele tipo.</div>

<!--
Introduzir classe depois de objeto, estado e comportamento terem função clara.
-->

---

<!-- _class: example code-focus -->

<div class="chapter">Da ideia ao Java</div>

## Primeira representação em Java

```java
public class ItemPedido {

    String descricao;
    double precoUnitario;
    int quantidade;
}
```

<!--
Ler conceitualmente. Não gastar tempo com chaves, ponto e vírgula ou convenções de nome.
-->

---

<!-- _class: example -->

<div class="chapter">Da ideia ao Java</div>

## A estrutura agora está explícita

<div class="concept-card">
<strong>ItemPedido</strong>
<div class="state">String descricao<br>double precoUnitario<br>int quantidade</div>
</div>

<div class="key-point">A classe reúne a estrutura comum dos itens.</div>

<!--
Relacionar cada campo aos dados separados do início da aula.
-->

---

<!-- _class: example code-focus -->

<div class="chapter">Da ideia ao Java</div>

## Criando o primeiro objeto

```java
ItemPedido item1 = new ItemPedido();

item1.descricao = "Teclado";
item1.precoUnitario = 150.0;
item1.quantidade = 2;
```

<!--
Tratar como criação e preenchimento de um objeto. Não explicar variável, referência ou identidade; isso pertence à Aula 03.
-->

---

<!-- _class: example -->

<div class="chapter">Da ideia ao Java</div>

## Estado do objeto usado por `item1`

<div class="concept-card">
<strong>objeto ItemPedido</strong>
<div class="state">descricao = "Teclado"<br>precoUnitario = 150.0<br>quantidade = 2</div>
</div>

<!--
Representação conceitual do objeto e de seu estado. Evitar setas que antecipem referências.
-->

---

<!-- _class: example code-focus -->

<div class="chapter">Da ideia ao Java</div>

## Criando outro objeto

```java
ItemPedido item2 = new ItemPedido();

item2.descricao = "Mouse";
item2.precoUnitario = 80.0;
item2.quantidade = 3;
```

<!--
Perguntar antes de avançar se o segundo objeto precisa ter os mesmos valores.
-->

---

<!-- _class: question -->

<div class="chapter">Da ideia ao Java</div>

## Uma classe, vários objetos

- Quantas classes aparecem?
- Quantos objetos foram criados?
- Os objetos precisam possuir o mesmo estado?

<!--
Esperar respostas. Não discutir ainda identidade nem o papel das variáveis.
-->

---

<!-- _class: example -->

<div class="chapter">Da ideia ao Java</div>

## Estrutura comum, estados próprios

<div class="columns">
<div class="concept-card"><strong>objeto usado por <code>item1</code></strong><div class="state">"Teclado"<br>150.0<br>2</div></div>
<div class="concept-card"><strong>objeto usado por <code>item2</code></strong><div class="state">"Mouse"<br>80.0<br>3</div></div>
</div>

<div class="key-point">Uma classe pode originar vários objetos com estados diferentes.</div>

<!--
Resposta: uma classe e dois objetos. Manter o foco em classe, objeto e estado.
-->

---

<!-- _class: example code-focus -->

<div class="chapter">Da ideia ao Java</div>

## Acrescentando comportamento

```java
public class ItemPedido {
    String descricao;
    double precoUnitario;
    int quantidade;

    double calcularSubtotal() {
        return precoUnitario * quantidade;
    }
}
```

<!--
O código ocupa o slide. Mostrar que o método usa os campos do próprio objeto.
-->

---

<!-- _class: question code-focus -->

<div class="chapter">Responsabilidade</div>

## Primeira possibilidade

```java
item.precoUnitario * item.quantidade
```

**Quem está realizando esse cálculo?**

<!--
Esperar respostas. O código externo acessa e combina diretamente os dados.
-->

---

<!-- _class: example -->

<div class="chapter">Responsabilidade</div>

## O código externo faz o cálculo

<div class="sequence">
  <span>acessa o preço</span>
  <strong>→</strong>
  <span>acessa a quantidade</span>
  <strong>→</strong>
  <span>calcula</span>
</div>

<!--
Não classificar como “errado”. Apenas tornar explícito quem executa e organiza a operação.
-->

---

<!-- _class: question code-focus -->

<div class="chapter">Responsabilidade</div>

## Segunda possibilidade

```java
calcularSubtotal(item)
```

**Onde ficou a responsabilidade pelo cálculo?**

<!--
Explicar oralmente que se trata de um método auxiliar disponível no contexto atual, por exemplo em Main.
-->

---

<!-- _class: example -->

<div class="chapter">Responsabilidade</div>

## Um método auxiliar recebe o item

```java
double calcularSubtotal(ItemPedido item) {
    return item.precoUnitario * item.quantidade;
}
```

<div class="key-point">O cálculo foi nomeado, mas o método ainda precisa receber o item e acessar seu estado.</div>

<!--
Não aprofundar static ou organização de classes. O foco continua sendo responsabilidade.
-->

---

<!-- _class: question code-focus -->

<div class="chapter">Responsabilidade</div>

## Terceira possibilidade

```java
item.calcularSubtotal()
```

**Quem já possui os dados necessários?**

<!--
Pausa central da aula. Esperar a turma formular que o próprio item conhece preço e quantidade.
-->

---

<!-- _class: concept -->

<div class="chapter">Responsabilidade</div>

## O próprio objeto já possui os dados

- `precoUnitario`
- `quantidade`

<div class="key-point">O objeto pode usar seu próprio estado para calcular o subtotal.</div>

<!--
Esta é a resposta essencial. Dar tempo para a conclusão se estabilizar.
-->

---

<!-- _class: example -->

<div class="chapter">Responsabilidade</div>

## O comportamento usa o próprio estado

```java
double calcularSubtotal() {
    return precoUnitario * quantidade;
}
```

<div class="execution-result"><code>item1.calcularSubtotal()</code><strong>→ <code>300.0</code></strong></div>

<!--
Execução conceitual fiel para item1: 150.0 × 2. Não é necessário abrir a IDE.
-->

---

<!-- _class: takeaway -->

<div class="chapter">Responsabilidade</div>

## Responsabilidade

<div class="statement">Objetos não servem apenas para agrupar dados.<br>Também decidimos quais responsabilidades pertencem a cada objeto.</div>

<!--
Clímax conceitual. Retomar as três alternativas e pedir por que a terceira comunica melhor a intenção.
-->

---

<!-- _class: activity compact-code -->

<div class="chapter">Aplicação</div>

## Atividade em dupla — `Produto`

```java
class Produto {
    String nome;
    double preco;

    double calcularPrecoComDesconto(double percentual) {
        return preco - preco * percentual;
    }
}
```

<!--
Dar 5 a 7 minutos. Primeiro, permitir leitura silenciosa do código.
-->

---

<!-- _class: activity -->

<div class="chapter">Aplicação</div>

## Expliquem o código

1. O que a classe representa?
2. Quais elementos formam o estado?
3. Qual comportamento aparece?
4. Objetos diferentes precisam ter o mesmo preço?
5. Por que o método acessa `preco` sem recebê-lo?

<!--
Atividade em dupla. Esperar antes de avançar. O objetivo é explicação, não implementação.
-->

---

<!-- _class: concept -->

<div class="chapter">Aplicação</div>

## Discussão da atividade

<div class="cards">
<div class="concept-card"><strong>Estado</strong><code>nome</code><br><code>preco</code></div>
<div class="concept-card"><strong>Comportamento</strong><code>calcularPrecoComDesconto(...)</code></div>
</div>

<div class="key-point">O método acessa <code>preco</code> porque utiliza o estado do próprio objeto.</div>

<!--
Objetos Produto podem ter preços diferentes. Pedir que uma dupla explique a conclusão com suas palavras.
-->

---

<!-- _class: activity -->

<div class="chapter">Aplicação</div>

## Transferência — biblioteca

Um empréstimo registra:

- o livro;
- a data;
- se já foi devolvido.

Um empréstimo pode ser devolvido.

**Qual estado, comportamento e responsabilidade aparecem?**

<!--
Atividade aberta e secundária. Pode ser pulada se o tempo estiver curto sem quebrar a narrativa. Não exigir classe Java completa.
-->

---

<!-- _class: concept -->

<div class="chapter">Aplicação</div>

## Uma possível modelagem

<div class="cards">
<div class="concept-card"><strong>Estado de Emprestimo</strong>livro<br>data<br>situação da devolução</div>
<div class="concept-card"><strong>Comportamento</strong>registrar a devolução</div>
</div>

<div class="key-point">O importante é justificar o conceito por seu estado, comportamento e papel na solução.</div>

<!--
Possível resposta, não gabarito único. Se a atividade anterior foi pulada, este slide também pode ser omitido.
-->

---

<!-- _class: takeaway -->

<div class="chapter">Síntese</div>

## Da solução procedural aos objetos

<div class="sequence">
  <span>dados relacionados</span>
  <strong>→</strong>
  <span>objeto explícito</span>
  <strong>→</strong>
  <span>estado + comportamento</span>
  <strong>→</strong>
  <span>responsabilidades</span>
</div>

<!--
Recuperar a história completa, não apenas definições isoladas.
-->

---

<!-- _class: concept -->

<div class="chapter">Síntese</div>

## O que precisamos conseguir explicar

- Por que representar explicitamente um `ItemPedido`?
- O que são objeto, estado, comportamento e classe neste exemplo?
- Como uma classe pode originar vários objetos?
- Por que `calcularSubtotal()` pode pertencer a `ItemPedido`?

<div class="key-point">Código que você não consegue explicar não é código que você domina.</div>

<!--
Usar como síntese dialogada. Se houver tempo, pedir uma explicação completa a diferentes estudantes.
-->

---

<!-- _class: concept -->

<div class="chapter">Síntese</div>

## Hoje

Identificamos uma unidade que estava implícita na solução procedural e a representamos como objeto.

<!--
Não mostrar a implementação completa do laboratório.
-->

---

<!-- _class: section -->

<div class="chapter">Próximo passo</div>

## No Laboratório 02, vamos transformar a solução construída anteriormente usando essa nova organização.

<!--
Encerrar com o próximo passo concreto: criar ItemPedido, objetos com estados próprios e comportamento de subtotal. Não antecipar referências, identidade ou encapsulamento.
-->
