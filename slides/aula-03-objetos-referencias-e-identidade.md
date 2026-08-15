---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 03 — Objetos, referências e identidade

<div class="statement">Quando usamos uma variável para trabalhar com um objeto, o que essa variável realmente representa?</div>

<!--
Retomar brevemente o Laboratório 02. A pergunta central deve conduzir toda a aula.
-->

---

<!-- _class: code-focus -->

## Retomando o Laboratório 02

```java
ItemPedido item = new ItemPedido();
```

**Onde está o objeto?**

O que `item` representa?

<!--
Esperar hipóteses antes de avançar. Evitar dizer que a variável é o objeto.
-->

---

## Três partes, três papéis

```java
ItemPedido item = new ItemPedido();
```

<div class="cards">
<div class="concept-card"><strong>ItemPedido</strong>tipo da variável</div>
<div class="concept-card"><strong>item</strong>variável que mantém uma referência</div>
</div>

<div class="key-point"><code>new ItemPedido()</code> cria um novo objeto.</div>

<!--
Enfatizar: a variável permite acessar o objeto; ela não é o objeto. Não mencionar heap ou endereço de memória.
-->

---

<!-- _class: code-focus -->

## Valores simples

```java
int a = 10;
int b = a;
```

**O que foi copiado para `b`?**

<!--
Ouvir a resposta. O valor numérico 10 foi copiado.
-->

---

## A cópia é independente

<div class="simulator">
  <div class="file-label">Main.java</div>
  <pre><code>int a = 10;
int b = a;

b = 5;
System.out.println(a);</code></pre>
  <div class="console-label">Console</div>
  <div class="console">10</div>
</div>

Alterar `b` não altera o valor armazenado em `a`.

<!--
Perguntar por que o console mostra 10. Esta execução é simples e fiel; não há necessidade de abrir a IDE.
-->

---

<!-- _class: code-focus -->

## Agora, um tipo de classe

```java
ItemPedido a = new ItemPedido();
ItemPedido b = a;
```

**O que foi copiado para `b`?**

<!--
Não revelar ainda. Recolher hipóteses como “objeto”, “variável” e “referência”.
-->

---

## Atribuição copia o valor

<div class="columns">
<div>

### Tipo simples

```java
int b = a;
```

O valor é um número.

</div>
<div>

### Tipo de classe

```java
ItemPedido b = a;
```

O valor é uma referência.

</div>
</div>

<div class="key-point">O objeto não foi copiado.</div>

<!--
Evitar “b virou a” e “passagem por referência”. Atribuir uma referência copia o valor da variável.
-->

---

<!-- _class: concept-key -->

## Modelo central

<div class="statement">A variável não é o objeto.<br>Ela mantém uma referência que permite acessar o objeto.</div>

<!--
Pausa de consolidação. Se houver confusão, redesenhar a relação no quadro, sem falar de memória física.
-->

---

<!-- _class: code-focus -->

## Dois usos de `new`

```java
ItemPedido a = new ItemPedido();
ItemPedido b = new ItemPedido();
```

- Quantas variáveis?
- Quantos objetos?

<!--
Esperar respostas antes de mostrar o diagrama. Perguntar onde ocorre cada criação.
-->

---

## Dois usos de `new`

<div class="refs">
  <div class="var">a</div><div class="arrow">→</div><div class="object">objeto 1<br>ItemPedido</div>
  <div class="var">b</div><div class="arrow">→</div><div class="object">objeto 2<br>ItemPedido</div>
</div>

<!--
Existem duas variáveis e dois objetos. O diagrama é conceitual, não um mapa da memória.
-->

---

## Dois `new` → dois objetos

Cada expressão `new ItemPedido()` cria um novo objeto.

<div class="statement">Os objetos são distintos, mesmo sendo da mesma classe.</div>

<!--
Concluir sem avançar ainda para estado ou identidade formal.
-->

---

<!-- _class: code-focus -->

## Copiando uma referência

```java
ItemPedido a = new ItemPedido();
ItemPedido b = a;
```

- Quantas variáveis?
- Quantos objetos?

<!--
Esperar respostas. A segunda instrução não contém new.
-->

---

## Duas referências, um objeto

<div class="refs shared">
  <div class="var">a</div><div class="arrow">↘</div><div class="object">objeto<br>ItemPedido</div>
  <div class="var second">b</div><div class="arrow second-arrow">↗</div>
</div>

<!--
Se necessário, construir novamente no quadro a pedido da turma. Evitar dizer que a e b são o mesmo objeto.
-->

---

<!-- _class: concept-key -->

## Uma referência também é um valor

<div class="statement">Duas variáveis podem manter referências que permitem acesso ao mesmo objeto.</div>

<!--
Destacar que copiar a referência não cria nem copia o objeto.
-->

---

<!-- _class: activity code-focus -->

## Preveja antes de executar

```java
ItemPedido a = new ItemPedido();
ItemPedido b = a;

a.quantidade = 2;
b.quantidade = 7;

System.out.println(a.quantidade);
```

**O que será apresentado? Por quê?**

<!--
Esperar respostas. Não revelar o resultado ainda. Perguntar quantos objetos existem.
-->

---

## Execução simulada

<div class="simulator">
  <div class="file-label">Main.java</div>
  <pre><code>ItemPedido a = new ItemPedido();
ItemPedido b = a;

a.quantidade = 2;
b.quantidade = 7;

System.out.println(a.quantidade);</code></pre>
  <div class="console-label">Console</div>
  <div class="console">7</div>
</div>

<!--
Confirmar a previsão sem abrir a IDE. Perguntar novamente por que a consulta por a observa 7.
-->

---

## O estado pertence ao objeto

<div class="refs shared">
  <div class="var">a</div><div class="arrow">↘</div><div class="object">ItemPedido<div class="state-line">quantidade = 7</div></div>
  <div class="var second">b</div><div class="arrow second-arrow">↗</div>
</div>

<div class="key-point">A alteração ocorreu no único objeto acessado por <code>a</code> e <code>b</code>.</div>

<!--
As duas referências permitem observar o mesmo estado. Pedir uma explicação completa, não apenas “porque b recebeu a”.
-->

---

<!-- _class: compact-code -->

## Dois objetos com os mesmos valores

```java
ItemPedido a = new ItemPedido();
a.descricao = "Teclado";
a.quantidade = 2;

ItemPedido b = new ItemPedido();
b.descricao = "Teclado";
b.quantidade = 2;
```

<!--
Antes do próximo slide, perguntar o que é igual e o que pode ser diferente.
-->

---


## Estado × identidade

<div class="columns">
<div class="identity-card"><strong>objeto 1</strong><div class="state">descrição = "Teclado"<br>quantidade = 2</div></div>
<div class="identity-card"><strong>objeto 2</strong><div class="state">descrição = "Teclado"<br>quantidade = 2</div></div>
</div>

- Possuem o mesmo estado?
- São o mesmo objeto?

<!--
Esperar as duas respostas. O primeiro “sim” não implica o segundo.
-->

---

## Mesmo estado, identidades diferentes

<div class="cards">
<div class="concept-card"><strong>Estado</strong>valores que o objeto possui naquele momento</div>
<div class="concept-card"><strong>Identidade</strong>se estamos falando do mesmo objeto ou de objetos diferentes</div>
</div>

<div class="key-point">Dois objetos podem ter o mesmo estado e continuar distintos.</div>

<!--
Consolidar a distinção conceitual. Não introduzir cópia ou clonagem.
-->

---

<!-- _class: code-focus -->

## Primeiro cenário

```java
ItemPedido a = new ItemPedido();
ItemPedido b = new ItemPedido();

a == b
```

**`true` ou `false`? Por quê?**

<!--
Não revelar ainda. Perguntar quantos objetos foram criados.
-->

---

## Dois objetos distintos

<div class="result">false</div>

<div class="refs">
  <div class="var">a</div><div class="arrow">→</div><div class="object">objeto 1</div>
  <div class="var">b</div><div class="arrow">→</div><div class="object">objeto 2</div>
</div>

<!--
O resultado é false porque as referências correspondem a objetos distintos.
-->

---

<!-- _class: code-focus -->

## Segundo cenário

```java
ItemPedido a = new ItemPedido();
ItemPedido b = a;

a == b
```

**`true` ou `false`? Por quê?**

<!--
Não revelar imediatamente. Perguntar por quê, não apenas true ou false.
-->

---

## O mesmo objeto

<div class="result">true</div>

<div class="refs shared">
  <div class="var">a</div><div class="arrow">↘</div><div class="object">objeto<br>ItemPedido</div>
  <div class="var second">b</div><div class="arrow second-arrow">↗</div>
</div>

<!--
O resultado é true porque as duas referências correspondem ao mesmo objeto.
-->

---

<!-- _class: java-focus -->

## `==` e referências

<div class="statement">Neste contexto, <code>==</code> verifica se duas referências correspondem ao mesmo objeto.</div>

<!--
Limitar a discussão à identidade. Não introduzir equals.
-->

---

<!-- _class: compact-code -->

## Atividade principal

```java
ItemPedido a = new ItemPedido();
a.quantidade = 2;

ItemPedido b = a;

ItemPedido c = new ItemPedido();
c.quantidade = 2;

b.quantidade = 4;
```

<!--
Dar tempo para leitura silenciosa antes de mostrar as perguntas.
-->

---

<!-- _class: activity -->

## Façam a previsão

1. Quantos objetos foram criados?
2. Quais variáveis compartilham o mesmo objeto?
3. Quais quantidades serão observadas por `a`, `b` e `c`?

<!--
Discussão em dupla. Esperar respostas antes de avançar; desenhar hipóteses no quadro se houver divergência.
-->

---

## Primeiro: quantos objetos?

<div class="refs shared">
  <div class="var">a</div><div class="arrow">↘</div><div class="object">objeto 1<div class="state-line">quantidade = 4</div></div>
  <div class="var second">b</div><div class="arrow second-arrow">↗</div>
</div>

<div class="refs" style="margin-top: 0.65em;">
  <div class="var">c</div><div class="arrow">→</div><div class="object">objeto 2<div class="state-line">quantidade = 2</div></div>
</div>

<!--
Foram criados dois objetos, pois há dois usos de new. a e b compartilham o objeto 1; c referencia o objeto 2.
-->

---

## Depois: quais valores?

<div class="simulator">
  <div class="file-label">Main.java — consultas</div>
  <pre><code>System.out.println(a.quantidade);
System.out.println(b.quantidade);
System.out.println(c.quantidade);</code></pre>
  <div class="console-label">Console</div>
  <div class="console">4<br>4<br>2</div>
</div>

<div class="key-point"><code>b.quantidade = 4</code> alterou o estado do objeto acessado por <code>a</code> e <code>b</code>.</div>

<!--
Comparar com as previsões. Pedir que expliquem 4, 4 e 2 usando referências, identidade e estado.
-->

---

<!-- _class: code-focus -->

## Transferindo o modelo

```java
Conta conta1 = new Conta();
Conta conta2 = conta1;
```

Se uma operação usando `conta2` modificar o objeto, o que será observado ao acessá-lo por `conta1`?

<!--
Não implementar Conta. Verificar se os estudantes transferem o modelo sem depender de ItemPedido.
-->

---

## O domínio mudou. O modelo não.

<div class="refs shared">
  <div class="var">conta1</div><div class="arrow">↘</div><div class="object">objeto<br>Conta<div class="state-line">estado alterado</div></div>
  <div class="var second">conta2</div><div class="arrow second-arrow">↗</div>
</div>

<div class="key-point">A alteração é observável por ambas as referências porque existe um único objeto.</div>

<!--
Pedir que o estudante formule a explicação completa. Não introduzir regras bancárias nem novo comportamento.
-->

---

## Síntese — criação e acesso

<div class="sequence">
  <span><code>new</code> cria um objeto</span>
  <strong>→</strong>
  <span>a variável mantém uma referência</span>
  <strong>→</strong>
  <span>a referência permite acessar o objeto</span>
</div>

<div class="key-point">Atribuir uma referência a outra variável não copia o objeto.</div>

<!--
Retomar o modelo central em sequência visual.
-->

---

<!-- _class: synthesis -->

## Síntese — estado e identidade

<div class="cards">
<div class="concept-card"><strong>Estado</strong>pode ser observado e alterado por diferentes referências ao mesmo objeto</div>
<div class="concept-card"><strong>Identidade</strong>objetos diferentes continuam distintos mesmo com valores iguais</div>
</div>

<div class="key-point"><code>==</code> foi usado aqui para verificar identidade.</div>

<!--
Não ampliar a semântica de == nem introduzir comparação de conteúdo.
-->

---

<!-- _class: code-focus -->

## Um problema fica em aberto

```java
item.quantidade = -200;
```

Na estrutura atual, quem possui uma referência pode alterar diretamente o estado.

<!--
Não resolver. Não mencionar private. Preparar a pergunta final.
-->

---


## Se o objeto é responsável pelo próprio estado, qualquer parte do programa deveria poder alterá-lo diretamente?

<!--
Deixar a pergunta em aberto. Ela será retomada na Aula 04. Não responder com encapsulamento ou private.
-->
