---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 03 — Objetos, referências e identidade

<div class="statement">O que exatamente é copiado quando uma variável de objeto é atribuída a outra?</div>

<!--
Começar pela experiência concreta do Laboratório 02. Não definir referência nem identidade na abertura.
-->

---

<div class="chapter">Ponto de partida</div>

## No Laboratório 02...

- criamos objetos com `new`;
- atribuímos estado;
- chamamos comportamentos com `.`;
- usamos variáveis como `item1` e `item2`.

<!--
Retomada breve. Pedir um exemplo de cada ação antes de avançar.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Ponto de partida</div>

## Uma linha conhecida

```java
ItemPedido item1 = new ItemPedido();
item1.quantidade = 2;
```

<div class="key-point"><code>new ItemPedido()</code> cria um objeto.</div>

<!--
Confirmar apenas o conhecimento do Par 02. Ainda não desenhar setas.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Uma atribuição</div>

## Agora aparece outra variável

```java
ItemPedido item2 = item1;
```

**O que essa instrução fez?**

<!--
Recolher hipóteses: novo objeto, cópia dos dados, outro nome, mesma coisa. Não corrigir ainda.
-->

---

<!-- _class: activity -->

<div class="chapter">Uma atribuição</div>

## Preveja antes de executar

1. Quantos objetos existem?
2. Os dados foram copiados para um novo objeto?
3. Alterar `item2.quantidade` afeta o valor observado por `item1`?

<!--
Dar tempo para registro individual e comparação rápida em dupla. A incerteza faz parte da investigação.
-->

---

<!-- _class: code-focus compact-code -->

<div class="chapter">O experimento</div>

## Vamos observar

```java
ItemPedido item1 = new ItemPedido();
item1.quantidade = 2;

ItemPedido item2 = item1;
item2.quantidade = 7;

System.out.println(item1.quantidade);
```

<!--
Ler cada instrução sem antecipar o resultado. Pedir uma última confirmação das previsões.
-->

---

<div class="chapter">O experimento</div>

## O resultado

<div class="simulator">
  <div class="file-label">Console</div>
  <div class="console">7</div>
</div>

<div class="statement">A alteração foi feita usando <code>item2</code> e observada usando <code>item1</code>.</div>

<!--
Deixar o estranhamento aparecer. Perguntar quem previa 2 e por quê.
-->

---

<div class="chapter">O experimento</div>

## Se houve uma cópia independente...

Por que `item1.quantidade` também passou a mostrar `7`?

<!--
Esta pergunta cria a necessidade do modelo. Não responder com “porque são referências” sem investigação.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Investigando a linha</div>

## Três partes, papéis diferentes

```java
ItemPedido item1 = new ItemPedido();
```

<div class="cards">
<div class="concept-card"><strong><code>ItemPedido</code></strong>tipo da variável</div>
<div class="concept-card"><strong><code>item1</code></strong>variável</div>
</div>

<!--
Destacar oralmente que new cria o objeto. A variável e o objeto ainda precisam ser relacionados.
-->

---

<div class="chapter">Investigando a linha</div>

## A variável é o objeto?

<div class="statement">A variável e o objeto têm papéis diferentes no programa.</div>

- o objeto possui estado e comportamento;
- a variável permite chegar até ele.

<!--
Ouvir formulações da turma. Precisamos agora nomear o valor que faz essa ligação.
-->

---

<div class="chapter">Investigando a linha</div>

## Precisamos nomear essa relação

```text
item1 ─────► ItemPedido#1
```

O que a variável mantém para permitir o acesso ao objeto?

<!--
Construir a seta como modelo conceitual. Não falar em endereço físico, stack ou heap.
-->

---

<!-- _class: concept-key -->

<div class="chapter">O resultado observado</div>

## Referência

<div class="statement">Um valor que permite localizar e acessar um objeto. Uma variável de tipo de classe pode manter esse valor.</div>

<!--
Formalização curta, depois da necessidade. Reforçar que é um modelo suficiente para explicar o código.
-->

---

<div class="chapter">Referência</div>

## Uma variável, um acesso

<div class="poo-diagram">
  <div class="poo-var">item1</div><div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">ItemPedido#1</div><div class="poo-slots"><div class="poo-slot">quantidade = 2</div></div></div>
</div>

<!--
Ler o diagrama da esquerda para a direita: a variável mantém uma referência para o objeto.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Referência</div>

## O que a atribuição copia?

```java
ItemPedido item2 = item1;
```

<div class="key-point">O valor de <code>item1</code> é uma referência. É esse valor que a atribuição copia.</div>

<!--
Não dizer que “Java copia o objeto”. Separar com precisão a atribuição da criação.
-->

---

<div class="chapter">Referência</div>

## Duas variáveis, um objeto

<div class="poo-diagram poo-diagram--shared">
  <div class="poo-var">item1</div><div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">ItemPedido#1</div><div class="poo-slots"><div class="poo-slot">quantidade = 7</div></div></div>
  <div class="poo-var">item2</div><div class="poo-arrow"></div>
</div>

<!--
Pedir que contem variáveis e objetos separadamente.
-->

---

<div class="chapter">Referência</div>

## Agora o resultado faz sentido

```java
item2.quantidade = 7;
System.out.println(item1.quantidade); // 7
```

<div class="statement">A alteração ocorreu no único objeto acessado pelas duas variáveis.</div>

<!--
Voltar explicitamente ao estranhamento. Pedir uma explicação completa com variável, referência e objeto.
-->

---

<!-- _class: trap -->

<div class="chapter">Interpretação tentadora</div>

## Outra variável não significa outro objeto

<div class="statement"><code>ItemPedido item2 = item1;</code> não executa <code>new</code>.</div>

<div class="key-point">A instrução copia a referência; não cria uma cópia independente do objeto.</div>

<!--
Explicitar o caminho tentador e o princípio correto. Não alongar com clonagem ou cópia profunda.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Quantos objetos?</div>

## Cenário A — uma criação

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = item1;
```

Quantas variáveis? Quantos objetos?

<!--
Resposta esperada: duas variáveis, um objeto. A segunda linha não contém new.
-->

---

<div class="chapter">Quantos objetos?</div>

## Cenário A — duas referências

<div class="poo-diagram poo-diagram--shared">
  <div class="poo-var">item1</div><div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">ItemPedido#1</div></div>
  <div class="poo-var">item2</div><div class="poo-arrow"></div>
</div>

<div class="key-point">Duas variáveis. Um objeto.</div>

<!--
Consolidar antes de mudar uma única linha no cenário seguinte.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Quantos objetos?</div>

## Cenário B — duas criações

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = new ItemPedido();
```

Quantas variáveis? Quantos objetos?

<!--
Resposta esperada: duas variáveis, dois objetos. Pedir que apontem as duas criações.
-->

---

<div class="chapter">Quantos objetos?</div>

## Cenário B — objetos distintos

<div class="poo-diagram">
  <div class="poo-var">item1</div><div class="poo-arrow"></div><div class="poo-object"><div class="poo-object__header">ItemPedido#1</div></div>
  <div class="poo-var">item2</div><div class="poo-arrow"></div><div class="poo-object"><div class="poo-object__header">ItemPedido#2</div></div>
</div>

<div class="key-point">Duas variáveis. Dois objetos.</div>

<!--
Não introduzir identidade ainda; apenas estabilizar a contagem.
-->

---

<div class="chapter">Quantos objetos?</div>

## A pista está na criação

<div class="statement">Cada execução de <code>new ItemPedido()</code> cria um novo objeto.</div>

Contar variáveis e contar objetos são tarefas diferentes.

<!--
Essa heurística será aplicada na atividade e no laboratório.
-->

---

<!-- _class: compact-code -->

<div class="chapter">Objetos distintos</div>

## E se os valores forem iguais?

```java
ItemPedido item1 = new ItemPedido();
item1.descricao = "Teclado";
item1.quantidade = 2;

ItemPedido item2 = new ItemPedido();
item2.descricao = "Teclado";
item2.quantidade = 2;
```

<!--
Perguntar o que podemos dizer sobre os estados e sobre a quantidade de objetos.
-->

---

<div class="chapter">Objetos distintos</div>

## Estados equivalentes

<div class="columns">
<div class="poo-object"><div class="poo-object__header">ItemPedido#1</div><div class="poo-slots"><div class="poo-slot">descricao = "Teclado"</div><div class="poo-slot">quantidade = 2</div></div></div>
<div class="poo-object"><div class="poo-object__header">ItemPedido#2</div><div class="poo-slots"><div class="poo-slot">descricao = "Teclado"</div><div class="poo-slot">quantidade = 2</div></div></div>
</div>

<div class="key-point">Os valores observados são iguais.</div>

<!--
Confirmar estado sem concluir que se trata do mesmo objeto.
-->

---

<div class="chapter">Objetos distintos</div>

## Duas perguntas diferentes

1. Os objetos possuem os mesmos valores?
2. As variáveis permitem acesso ao mesmo objeto?

<div class="statement">Estado responde à primeira pergunta. Ainda precisamos nomear a segunda.</div>

<!--
Criar a necessidade de identidade. Esperar a turma distinguir “igual” de “o mesmo”.
-->

---

<!-- _class: concept-key -->

<div class="chapter">Dois objetos</div>

## Identidade

<div class="statement">Distingue um objeto dos demais. Objetos criados separadamente continuam distintos, mesmo quando possuem o mesmo estado.</div>

<!--
Formalização como ponto de chegada. Relacionar aos dois usos de new.
-->

---

<div class="chapter">Identidade</div>

## Mesmo estado, identidades diferentes

<div class="poo-diagram">
  <div class="poo-var">item1</div><div class="poo-arrow"></div><div class="poo-object"><div class="poo-object__header">ItemPedido#1</div><div class="poo-slots"><div class="poo-slot">descricao = "Teclado"</div><div class="poo-slot">quantidade = 2</div></div></div>
  <div class="poo-var">item2</div><div class="poo-arrow"></div><div class="poo-object"><div class="poo-object__header">ItemPedido#2</div><div class="poo-slots"><div class="poo-slot">descricao = "Teclado"</div><div class="poo-slot">quantidade = 2</div></div></div>
</div>

<!--
Pedir que expliquem por que igualdade de estado não elimina as duas criações.
-->

---

<div class="chapter">Identidade</div>

## Como verificar se é o mesmo objeto?

Até aqui, usamos o diagrama e contamos execuções de `new`.

Qual mecanismo Java responde diretamente a essa pergunta?

<!--
Agora existe uma necessidade concreta para ==. Não fazer revisão geral de operadores.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Identidade</div>

## Primeiro cenário

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = item1;

System.out.println(item1 == item2);
```

**Qual resultado esperamos?**

<!--
Esperar true e exigir justificativa pela referência copiada.
-->

---

<div class="chapter">Identidade</div>

## O mesmo objeto

<div class="result">true</div>

<div class="poo-diagram poo-diagram--shared">
  <div class="poo-var">item1</div><div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">ItemPedido#1</div></div>
  <div class="poo-var">item2</div><div class="poo-arrow"></div>
</div>

<!--
O resultado não depende dos campos; depende de as referências corresponderem ao mesmo objeto.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Identidade</div>

## Segundo cenário

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = new ItemPedido();

System.out.println(item1 == item2);
```

**Qual resultado esperamos?**

<!--
Esperar false e pedir que localizem as duas criações.
-->

---

<div class="chapter">Identidade</div>

## Objetos distintos

<div class="result">false</div>

<div class="poo-diagram">
  <div class="poo-var">item1</div><div class="poo-arrow"></div><div class="poo-object"><div class="poo-object__header">ItemPedido#1</div></div>
  <div class="poo-var">item2</div><div class="poo-arrow"></div><div class="poo-object"><div class="poo-object__header">ItemPedido#2</div></div>
</div>

<!--
Mesmo que o estado seja preenchido com valores iguais, as identidades continuam diferentes.
-->

---

<!-- _class: java-focus -->

<div class="chapter">Comparação</div>

## `==` entre referências

<div class="statement"><code>item1 == item2</code> verifica se as duas referências correspondem ao mesmo objeto.</div>

- mesmo objeto → `true`;
- objetos distintos → `false`.

<!--
Limitar ao mecanismo necessário. Dizer explicitamente que comparação de conteúdo será retomada no futuro; não introduzir equals.
-->

---

<!-- _class: compact-code -->

<div class="chapter">Aplicação</div>

## Reúna as pistas

```java
ItemPedido a = new ItemPedido();
a.quantidade = 2;

ItemPedido b = a;

ItemPedido c = new ItemPedido();
c.quantidade = 2;

b.quantidade = 4;
```

<!--
Leitura silenciosa. Não avançar para as perguntas até todos localizarem as duas expressões new.
-->

---

<!-- _class: activity -->

<div class="chapter">Aplicação</div>

## Desenhe, preveja e justifique

1. Quantos objetos existem?
2. Quais variáveis acessam o mesmo objeto?
3. Quais quantidades serão observadas por `a`, `b` e `c`?
4. Quanto produzem `a == b` e `a == c`?

<!--
Atividade em dupla. Pedir um diagrama com setas e justificativa usando new, referência, estado e identidade.
-->

---

<div class="chapter">Aplicação</div>

## O diagrama explica o código

<div class="poo-diagram poo-diagram--shared">
  <div class="poo-var">a</div><div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">ItemPedido#1</div><div class="poo-slots"><div class="poo-slot">quantidade = 4</div></div></div>
  <div class="poo-var">b</div><div class="poo-arrow"></div>
</div>

<div class="poo-diagram" style="margin-top: 0.55em;">
  <div class="poo-var">c</div><div class="poo-arrow"></div><div class="poo-object"><div class="poo-object__header">ItemPedido#2</div><div class="poo-slots"><div class="poo-slot">quantidade = 2</div></div></div>
</div>

<!--
Foram criados dois objetos. a e b acessam o primeiro; c acessa o segundo.
-->

---

<div class="chapter">Aplicação</div>

## As previsões se conectam

<div class="cards">
<div class="concept-card"><strong>Estado observado</strong><code>a.quantidade</code> → 4<br><code>b.quantidade</code> → 4<br><code>c.quantidade</code> → 2</div>
<div class="concept-card"><strong>Identidade</strong><code>a == b</code> → true<br><code>a == c</code> → false</div>
</div>

<!--
Pedir que uma dupla explique primeiro os estados e outra explique as comparações.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Transferência</div>

## O domínio mudou. O modelo não.

```java
Conta contaPrincipal = new Conta();
Conta contaParaConsulta = contaPrincipal;
```

Se uma operação feita por `contaParaConsulta` alterar o objeto, o que será observado por `contaPrincipal`?

<!--
Não implementar Conta. Verificar se a turma transfere o modelo sem depender dos nomes do exemplo central.
-->

---

<!-- _class: synthesis -->

<div class="chapter">Fechamento</div>

## Da atribuição à identidade

<div class="sequence">
  <span><code>new</code> cria</span>
  <strong>→</strong>
  <span>variável mantém referência</span>
  <strong>→</strong>
  <span>atribuição copia referência</span>
  <strong>→</strong>
  <span>identidade distingue</span>
  <strong>→</strong>
  <span><code>==</code> verifica</span>
</div>

<!--
Recuperar a história, inclusive o primeiro resultado 7. Não apenas recitar definições.
-->

---

<div class="chapter">Próximo passo</div>

## Se duas partes acessam o mesmo objeto...

```java
item.quantidade = -200;
```

Qualquer uma deveria poder alterar diretamente seu estado?

<!--
Deixar a pergunta aberta para a Aula 04. Não mencionar private, getters ou encapsulamento como resposta.
-->
