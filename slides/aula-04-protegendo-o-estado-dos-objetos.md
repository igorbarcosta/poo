---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 04 — Protegendo o estado dos objetos

<div class="statement">Se diferentes partes do programa acessam o mesmo objeto, quem deve controlar como seu estado pode mudar?</div>

<!--
Apresentar a pergunta sem responder. Ela nasce diretamente da consequência deixada pela Aula 03.
-->

---

<div class="chapter">Nossa investigação</div>

## O que vamos construir hoje

- diagnosticar o problema do estado exposto;
- compreender `private` como fronteira;
- controlar mudanças por comportamentos;
- distinguir encapsulamento de getters e setters automáticos.

<!--
Leitura breve. Os objetivos orientam a trajetória, mas não são conteúdo para exposição prolongada.
-->

---

<div class="chapter">De onde partimos</div>

## A descoberta da Aula 03

<div class="refs shared" style="grid-template-columns: 320px 75px 1fr; max-width: 1100px;">
  <div class="var">itemPrincipal</div><div class="arrow">↘</div><div class="object">objeto ItemPedido<div class="state-line">quantidade = 5</div></div>
  <div class="var second">itemObservado</div><div class="arrow second-arrow">↗</div>
</div>

<div class="key-point">Duas referências podem permitir acesso ao mesmo objeto.</div>

<!--
Retomada curta. Pedir que a turma conte variáveis e objetos, sem revisar toda a Aula 03.
-->

---

<div class="chapter">Uma consequência</div>

## O acesso também permite alterar

Se dois trechos chegam ao mesmo objeto, ambos podem tentar modificar seu estado.

**O que acontece quando uma dessas mudanças não faz sentido para o problema?**

<!--
Criar a nova tensão. Ainda não mencionar private nem encapsulamento.
-->

---

<!-- _class: compact-code -->

<div class="chapter">O cenário</div>

## Duas variáveis, um objeto

```java
ItemPedido itemPrincipal = new ItemPedido();
itemPrincipal.descricao = "Teclado";
itemPrincipal.precoUnitario = 150.0;
itemPrincipal.quantidade = 5;

ItemPedido itemObservado = itemPrincipal;
```

<!--
Ler somente o necessário: uma criação, duas variáveis e estado-base conhecido.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Uma alteração</div>

## Outro trecho decide a quantidade

```java
itemObservado.quantidade = -3;
```

O código ainda não foi executado.

<!--
Não antecipar resultado. Deixar claro que a próxima etapa exige previsão real.
-->

---

<!-- _class: activity -->

<div class="chapter">Antes de executar</div>

## Preveja e justifique

1. Qual quantidade será observada por `itemPrincipal`?
2. Qual será o resultado de `itemPrincipal.calcularSubtotal()`?
3. Quantos objetos existem?

Registre primeiro. Depois compare sua justificativa com a de um colega.

<!--
Dar tempo silencioso antes da conversa. Não avançar enquanto a turma ainda estiver formulando a previsão.
-->

---

<div class="chapter">A observação</div>

## O estado compartilhado mudou

<div class="cards">
<div class="concept-card"><strong>Quantidade observada</strong><code>itemPrincipal.quantidade</code><br><span class="result" style="font-size: 1.8em;">-3</span></div>
<div class="concept-card"><strong>Subtotal calculado</strong><code>itemPrincipal.calcularSubtotal()</code><br><span class="result" style="font-size: 1.8em;">-450.0</span></div>
</div>

<!--
Retomar as previsões. A resposta vem somente agora. Pedir que uma dupla explique o resultado antes da explicação docente.
-->

---

<div class="chapter">A observação</div>

## A alteração chegou ao único objeto

<div class="refs shared" style="grid-template-columns: 320px 75px 1fr; max-width: 1100px;">
  <div class="var">itemPrincipal</div><div class="arrow">↘</div><div class="object">objeto ItemPedido<div class="state-line">quantidade = -3</div></div>
  <div class="var second">itemObservado</div><div class="arrow second-arrow">↗</div>
</div>

<div class="key-point">A alteração foi feita por um nome e observada pelo outro.</div>

<!--
Usar o modelo de referências para explicar o resultado. Esta retomada muda a operação: resultado numérico vira explicação espacial.
-->

---

<div class="chapter">O problema</div>

## O Java aceita. O domínio não.

<div class="cards">
<div class="concept-card"><strong>Linguagem</strong><code>-3</code> é um valor possível de <code>int</code>.<br>A atribuição é aceita.</div>
<div class="concept-card"><strong>Item de pedido</strong>Quantidade negativa não representa um estado válido.</div>
</div>

<!--
Separar verificação de tipo de validade no problema. Não transformar validade em outro conceito-chave.
-->

---

<div class="chapter">O problema</div>

## Quem deve decidir?

Se `quantidade` pertence ao estado de `ItemPedido`, por que qualquer trecho externo pode escolher livremente seu valor?

<div class="statement">Precisamos criar uma fronteira sem impedir toda mudança legítima.</div>

<!--
Ouvir respostas. Esta pergunta prepara o mecanismo Java e a necessidade posterior do comportamento.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Criando uma fronteira</div>

## O campo passa a ser privado

```java
public class ItemPedido {
    String descricao;
    double precoUnitario;
    private int quantidade;

    public double calcularSubtotal() {
        return precoUnitario * quantidade;
    }
}
```

<!--
Destacar apenas a mudança em quantidade. Os métodos da própria classe continuam usando o campo.
-->

---

<div class="chapter">Criando uma fronteira</div>

## Antes e depois de `private`

<div class="cards">
<div class="concept-card"><strong>Antes</strong><code>itemObservado.quantidade = -3;</code><br><br>acesso externo permitido</div>
<div class="concept-card"><strong>Depois</strong><code>itemObservado.quantidade = -3;</code><br><br>acesso externo bloqueado</div>
</div>

<!--
Pedir que antecipem se o problema será percebido na compilação ou apenas na execução.
-->

---

<div class="chapter">Criando uma fronteira</div>

## O erro é uma evidência

<div class="simulator">
  <div class="file-label">Compilação</div>
  <div class="console">quantidade has private access in ItemPedido</div>
</div>

<div class="statement">O código externo ainda conhece o objeto, mas perdeu o acesso direto ao campo.</div>

<!--
Não tratar o erro apenas como obstáculo. Ele revela quais trechos dependiam do estado exposto.
-->

---

<!-- _class: java-focus -->

<div class="chapter">Mecanismo necessário</div>

## `private` e `public`

- `private` restringe o acesso à própria classe;
- `public` disponibiliza uma classe ou operação para uso externo;
- métodos de `ItemPedido` continuam acessando `quantidade`;
- código externo usa somente o que a classe disponibiliza.

<!--
Explicar somente controle de acesso no nível necessário ao laboratório. Não abrir package, protected ou outros modificadores.
-->

---

<!-- _class: java-focus compact-code -->

<div class="chapter">Mecanismo necessário</div>

## E se não houver modificador?

```java
private int quantidade;  // própria classe
        int quantidade;  // mesmo pacote
public  int quantidade;  // acesso externo
```

Sem modificador ocorre acesso de pacote (`package-private`).

<!--
Relacionar ao código anterior: Main e ItemPedido estão, no exemplo simples, em um contexto que permite o acesso de pacote. Isso não torna public opcional nem a ausência de modificador equivalente a private. Mencionar apenas que protected existe e ficará para quando houver necessidade; não abrir packages.
-->

---

<div class="chapter">Escopo da mudança</div>

## Uma fronteira por vez

```java
String descricao;
double precoUnitario;
private int quantidade;
```

Nesta etapa, apenas `quantidade` será protegida.

<!--
Explicitar o recorte. Descrição e preço permanecem temporariamente expostos para evitar antecipar a próxima decisão curricular.
-->

---

<div class="chapter">Uma nova necessidade</div>

## Como realizar uma mudança legítima?

Bloquear a atribuição direta impede o valor inválido.

Mas também impede que o pedido aumente de `5` para `7`.

<!--
O mecanismo resolveu uma parte e criou outra necessidade. Pedir propostas antes de mostrar o método.
-->

---

<div class="chapter">Mudança com intenção</div>

## Escolher o estado × solicitar uma operação

<div class="cards">
<div class="concept-card"><strong>Atribuição direta</strong><code>item.quantidade = 5;</code><br><br>código externo escolhe o estado</div>
<div class="concept-card"><strong>Comportamento</strong><code>item.aumentarQuantidade(5);</code><br><br>código externo solicita uma operação</div>
</div>

<!--
O contraste não é apenas sintático. Perguntar quem toma a decisão em cada caso.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Mudança com intenção</div>

## O objeto preserva a regra

```java
public void aumentarQuantidade(int unidades) {
    if (unidades > 0) {
        quantidade += unidades;
    }
}
```

<div class="key-point">A mudança só acontece quando <code>unidades &gt; 0</code>.</div>

<!--
Ler parâmetro, condição e alteração do campo. void, método e chamada já foram preparados no Par 02.
-->

---

<div class="chapter">Verificando a regra</div>

## Três solicitações, dois resultados

```java
ItemPedido item = new ItemPedido();  // quantidade começa em 0
item.aumentarQuantidade(2);          // quantidade passa a 2
item.aumentarQuantidade(-10);        // quantidade permanece 2
```

O valor inicial `0` é o padrão de um campo `int` sem inicialização explícita.

<!--
Pedir previsões linha a linha. A informação sobre zero é operacional, não uma nova pausa de Java.
-->

---

<!-- _class: tip compact-code -->

<div class="chapter">Um contraste importante</div>

## Campo não é variável local

```java
class ItemPedido {
    int quantidade;  // campo: começa em 0
}
```

```java
void exemplo() {
    int quantidade;
    System.out.println(quantidade); // não compila
}
```

<!--
Evitar a generalização “todo int começa em zero”. Não aprofundar as regras completas de inicialização de Java.
-->

---

<div class="chapter">Outra necessidade</div>

## Como observar o resultado?

Depois de proteger o campo, isto também deixa de compilar:

```java
System.out.println(item.quantidade);
```

Consultar o estado não precisa devolver a liberdade de alterá-lo.

<!--
Criar a necessidade do getter antes de apresentá-lo. Não transformar getter no centro da aula.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Consulta controlada</div>

## Uma operação para consultar

```java
public int getQuantidade() {
    return quantidade;
}
```

```java
System.out.println(item.getQuantidade());
```

<!--
Ler rapidamente: retorno int, nenhum parâmetro, devolve o estado atual. Esses mecanismos já foram preparados antes.
-->

---

<div class="chapter">Capacidades diferentes</div>

## Consultar não é alterar

<div class="cards">
<div class="concept-card"><strong>Consulta</strong><code>getQuantidade()</code><br><br>informa o estado atual</div>
<div class="concept-card"><strong>Mudança</strong><code>aumentarQuantidade(...)</code><br><br>solicita uma alteração com regra</div>
</div>

<!--
Pedir exemplos de código externo que precise apenas consultar. Consolidar a diferença sem alongar o getter.
-->

---

<div class="chapter">Capacidades do objeto</div>

## Se existe aumentar, precisa existir diminuir?

Não criamos operações porque elas parecem simétricas.

<div class="statement">Uma operação pública representa uma capacidade necessária para o problema.</div>

<!--
Não responder imediatamente. Recolher hipóteses sobre quando reduzir faria ou não parte do problema.
-->

---

<!-- _class: activity -->

<div class="chapter">Capacidades do objeto</div>

## Uma nova operação, novas decisões

Quantidade atual: **5**

- reduzir `2` → ?
- reduzir `10` → ?
- reduzir `-2` → ?

O problema realmente precisa oferecer essa operação?

<!--
Discutir sem implementar. A operação só faz sentido se representar uma capacidade necessária e traz regras próprias. Conectar ao desafio opcional do Lab 04 sem revelar implementação nem torná-lo obrigatório.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Voltando às referências</div>

## O objeto continua compartilhado

```java
itemObservado.aumentarQuantidade(2);
System.out.println(itemPrincipal.getQuantidade());
```

Se a quantidade era `5`, o que será exibido?

<!--
Esperar a previsão e exigir uma justificativa com referência, objeto e comportamento. Não revelar antes da discussão breve.
-->

---

<div class="chapter">Voltando às referências</div>

## A fronteira não muda a identidade

<div class="refs shared" style="grid-template-columns: 320px 75px 1fr; max-width: 1100px;">
  <div class="var">itemPrincipal</div><div class="arrow">↘</div><div class="object">objeto ItemPedido<div class="state-line">quantidade privada = 7</div></div>
  <div class="var second">itemObservado</div><div class="arrow second-arrow">↗</div>
</div>

<div class="key-point">As duas referências chegam ao mesmo objeto; o acesso externo acontece pelas operações disponíveis.</div>

<!--
Resultado: 7. Contrastar com o início: compartilhar referência continua valendo, mas não concede acesso direto ao campo privado.
-->

---

<!-- _class: code-focus -->

<div class="chapter">Uma solução plausível</div>

## E se criarmos um setter?

```java
public void setQuantidade(int novaQuantidade) {
    quantidade = novaQuantidade;
}
```

O campo está privado. O estado está realmente protegido?

<!--
Recolher a primeira resposta, sem corrigi-la. A formulação é plausível e prepara o Peer Instruction.
-->

---

<!-- _class: activity -->

<div class="chapter">Diagnóstico</div>

## Setter × comportamento intencional

As duas soluções protegem o estado da mesma forma?

1. responda individualmente;
2. discuta a justificativa com um colega;
3. responda novamente;
4. prepare uma explicação para o fechamento coletivo.

<!--
Realizar a primeira votação antes da conversa e a segunda depois. Não revelar a conclusão enquanto a discussão estiver em andamento.
-->

---

<!-- _class: trap -->

<div class="chapter">Diagnóstico</div>

## Campo privado não garante encapsulamento

<div class="cards">
<div class="concept-card"><strong><code>setQuantidade(...)</code></strong>sem regra, o código externo continua escolhendo qualquer valor final</div>
<div class="concept-card"><strong><code>aumentarQuantidade(...)</code></strong>expressa uma intenção e o objeto verifica a mudança solicitada</div>
</div>

<div class="key-point">O contexto decide quais operações são apropriadas; setters não são sempre inadequados, mas o nome sozinho não garante proteção.</div>

<!--
Fechamento coletivo. Não demonizar setters em qualquer contexto; analisar esta decisão específica e sua regra.
-->

---

<div class="chapter">Transferindo o raciocínio</div>

## Protegemos a quantidade. E o resto?

```java
item.precoUnitario = -200.0;
item.descricao = "";
```

O problema terminou quando protegemos `quantidade`?

<!--
Suspender a resposta. O contraste permanece no mesmo objeto e prepara a atividade seguinte.
-->

---

<!-- _class: activity -->

<div class="chapter">Transferindo o raciocínio</div>

## Que outros estados ainda exigem decisões?

1. preço negativo representa um estado válido?
2. descrição vazia representa um estado válido?
3. quem deveria decidir isso?

Não implemente a refatoração completa.

<!--
Transferir a responsabilidade para outros campos sem pedir private, getters, setters, validações ou construtores. O objetivo é ampliar o modelo, não resolver a classe inteira.
-->

---

<!-- _class: concept-key -->

<div class="chapter">Ponto de chegada</div>

## Encapsulamento

<div class="statement">O objeto controla como seu estado pode ser consultado e alterado.</div>

- campos privados ajudam a estabelecer a fronteira;
- operações públicas oferecem capacidades ao código externo;
- comportamentos podem preservar regras;
- encapsular não é gerar getters e setters automaticamente.

<!--
Formalizar somente agora. Relacionar cada linha a uma evidência já observada na investigação.
-->

---

<div class="chapter">Uma questão futura</div>

## A alteração foi rejeitada. Quem chamou sabe disso?

```java
item.aumentarQuantidade(-10);
```

Hoje garantimos que o estado permanece válido.

<div class="statement">Como comunicar a rejeição é outra decisão de projeto.</div>

<!--
Reconhecer a dúvida sem apresentar exceptions, boolean, Result, Optional, códigos ou classes de erro. O foco desta aula é impedir a alteração inválida.
-->

---

<!-- _class: synthesis -->

<div class="chapter">Fechamento</div>

## Quem controla o estado?

- `private` estabelece uma fronteira contra o acesso direto;
- código externo solicita operações em vez de escolher livremente o estado;
- comportamentos podem preservar regras de mudança;
- consulta e alteração são capacidades diferentes;
- encapsulamento organiza esse controle de forma intencional.

<!--
Responder à pergunta central. Não recapitular todos os exemplos nem repetir a definição palavra por palavra.
-->

---

<div class="chapter">Próximo passo</div>

## E o estado inicial?

```java
ItemPedido item = new ItemPedido();
```

Como garantir que um objeto já nasça com os dados necessários e em um estado válido?

<div class="statement">Construtores entrarão nessa história depois. Ainda não precisamos estudá-los agora.</div>

<!--
Deixar a questão aberta como ponte. Não ensinar sintaxe de construtores.
-->
