---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 13 — Como saber se ainda funciona?

<div class="statement">Como verificar automaticamente que uma mudança preservou comportamentos que já funcionavam?</div>

<!--
Ponte direta da Aula 12. Hoje, testes como descrição e verificação de
comportamento; JUnit é o meio mínimo. Perguntas à turma toda, com tempo de
formulação individual antes das respostas. Não antecipar interface.
-->

---

<div class="chapter">A mudança deixada pela Aula 12</div>

## Queremos aceitar outras entregas em Pedido

```java
pedido.fechar(new EntregaNormal());
```

Antes de mudar essa colaboração, queremos preservar:

- o total dos itens;
- o bloqueio de inclusões após fechar;
- o custo normal de R$ 10.

Vamos começar pela primeira expectativa e transformá-la em código.

---

<!-- _class: activity code-focus -->

<div class="chapter">A primeira regra que queremos proteger</div>

## Duas unidades de teclado devem somar quanto?

```java
Produto teclado = new Produto("Teclado", 150.0);
Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 2);

System.out.println(pedido.calcularTotal());
```

Qual valor esperamos? Se aparecer outro valor, quem percebe a diferença?

<!-- 300.0; a pessoa compara a saída com a expectativa que conhece.
Esta regra deverá continuar verdadeira depois da mudança de entrega. -->

---

<div class="chapter">A expectativa precisa aparecer no programa</div>

## Podemos escrever a comparação

```java
System.out.println(pedido.calcularTotal() == 300.0);
```

```text
true
```

O programa já compara com `300.0`.

Mas esta linha só informa `true` ou `false`; não identifica a regra que falhou.

---

<div class="chapter">Torne a divergência identificável</div>

## Informe o esperado e o observado

```java
double esperado = 300.0;
double observado = pedido.calcularTotal();

if (observado != esperado) {
    System.out.println("ERRO no total: esperado " + esperado
        + ", obtido " + observado);
}
```

A mensagem identifica esta verificação e os valores diferentes.

---

<!-- _class: activity -->

<div class="chapter">Leia a verificação que acabamos de escrever</div>

## O que ela informa em cada caso?

O preço continua `150.0` e a quantidade continua `2`.

1. O cálculo devolve `300.0`: o bloco de erro executa?
2. Um defeito faz o cálculo devolver `150.0`: qual mensagem aparece?

<!-- Nenhuma mensagem no primeiro caso. No segundo:
ERRO no total: esperado 300.0, obtido 150.0.
As entradas e o requisito são os mesmos; mudou o resultado da implementação. -->

---

<div class="chapter">Uma comparação detecta uma diferença</div>

## Já sabemos verificar esta regra

| Resultado do cálculo | Resultado da verificação |
| --- | --- |
| `300.0` | nenhuma mensagem de erro |
| `150.0` | esperado `300.0`, obtido `150.0` |

Agora queremos verificar também remoção, alteração e fechamento.

Como executar todas essas verificações e identificar quais falharam?

---

<div class="chapter">A estrutura que começaria a se repetir</div>

## Cada regra precisa de cenário e expectativa

Para trinta regras, repetiríamos preparação, comparação e mensagens.

Queremos executar o conjunto e receber um resultado para **cada teste**.

JUnit oferece essa organização. Vamos usar o mesmo cenário do teclado.

---

<div class="chapter">A comparação vira uma afirmação</div>

## O primeiro teste protege o total

```java
@Test
void calculaTotalDeUmItem() {
    Produto teclado = new Produto("Teclado", 150.0);
    Pedido pedido = new Pedido();
    pedido.adicionarItem(teclado, 2);

    assertEquals(300.0, pedido.calcularTotal());
}
```

A expectativa continua `300.0`; JUnit registra sucesso ou falha deste método.

---

<!-- _class: java-focus -->

<div class="chapter">Como ler a nova escrita</div>

## Java em foco — JUnit básico

`@Test` identifica um método que o executor deve executar.

`assertEquals(esperado, observado)` verifica a igualdade dos valores.

Se o total vier `150.0`, o teste falha e informa a diferença para `300.0`.

---

<div class="chapter">Onde escrever e executar o teste</div>

## Uma classe de testes, com os imports de JUnit

```java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class PedidoTest {
    @Test
    void calculaTotalDeUmItem() {
        // corpo do teste mostrado no slide anterior
    }
}
```

Execute a classe pelo executor de testes da IDE.

<!-- O trecho mostra a organização, não um teste vazio a executar.
Na demonstração, manter o corpo real do teste. Não ensinar Maven ou runner. -->

---

<!-- _class: activity -->

<div class="chapter">Identifique o que o teste faz</div>

## Prepare → execute → verifique

```java
Produto teclado = new Produto("Teclado", 150.0);
Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 2);

double total = pedido.calcularTotal();

assertEquals(300.0, total);
```

Quais linhas preparam o cenário, executam o cálculo e verificam a expectativa?

<!-- Preparação: produto, pedido e inclusão. Ação observada: calcularTotal.
Verificação: assertEquals. Arrange/Act/Assert nomeia esse percurso, sem exigir
comentários. O total verde ainda não verifica fechamento nem entrega. -->

---

<div class="chapter">Um nome também informa</div>

## Qual teste ajuda a próxima pessoa?

```java
void teste1() { ... }
```

```java
void pedidoFechadoNaoAceitaNovosItens() { ... }
```

O segundo nome indica o comportamento a preservar.

---

<!-- _class: activity -->

<div class="chapter">Escolha uma história</div>

## Como demonstrar essa regra?

> Pedido fechado não aceita novos itens.

Que estado inicial precisamos montar?

Que chamada tenta violar a regra?

Qual observação pública mostraria o resultado?

<!--
Um item de 150 antes do fechamento; tentar adicionar outro de 80 depois;
consultar calcularTotal e esperar 150. Coletar propostas antes do código.
-->

---

<div class="chapter">Um cenário que distingue resultados</div>

## O pedido fechado preserva o total

```java
Produto teclado = new Produto("Teclado", 150.0);
Produto mouse = new Produto("Mouse", 80.0);
Pedido pedido = new Pedido();

pedido.adicionarItem(teclado, 1);
pedido.fechar(new EntregaNormal());
pedido.adicionarItem(mouse, 1);

assertEquals(150.0, pedido.calcularTotal());
```

<!--
O mouse tem preço diferente para tornar uma inclusão indevida visível.
-->

---

<div class="chapter">O teste vê o comportamento</div>

## Precisamos abrir Pedido por dentro?

O teste não lê:

- o campo `fechado`;
- a lista privada;
- um índice ou um `if`.

Ele observa `calcularTotal()` depois da tentativa de inclusão.

---

<!-- _class: activity -->

<div class="chapter">Separe regra e implementação</div>

## Quando esse teste deveria quebrar?

1. Se `Pedido` trocar a forma de percorrer os itens?
2. Se aceitar o mouse mesmo depois do fechamento?
3. Ele também verifica remoção após fechar?

<!--
1: não, se o comportamento ficar igual. 2: sim, total iria para 230.
3: não, essa operação não foi executada; precisa de outro cenário.
-->

---

<div class="chapter">Uma chamada sem mudança também importa</div>

## Quantidade negativa preserva o item

```java
Produto teclado = new Produto("Teclado", 150.0);
Pedido pedido = new Pedido();

pedido.adicionarItem(teclado, 2);
pedido.alterarQuantidade(teclado, -1);

assertEquals(300.0, pedido.calcularTotal());
```

A mesma referência de produto identifica a linha.

---

<div class="chapter">O efeito esperado pode ser nenhum</div>

## Recusar também é comportamento

A operação foi chamada.

O estado observável deve permanecer igual.

<div class="key-point">Testar uma regra não exige que o valor final mude.</div>

---

<div class="chapter">Aprofundamento — testar a remoção</div>

## Prepare dois produtos com o mesmo preço

```java
Produto teclado = new Produto("Teclado", 150.0);
Produto fone = new Produto("Fone", 150.0);
Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 1);
pedido.adicionarItem(fone, 1);
```

O pedido está aberto e contém uma unidade de cada produto.

---

<!-- _class: activity -->

<div class="chapter">Execute a remoção no pedido que acabamos de preparar</div>

## O total detecta a remoção do produto errado?

```java
pedido.removerItem(teclado);
assertEquals(150.0, pedido.calcularTotal());
```

Se um defeito remover o **fone** em vez do teclado, esta verificação falha?

<!-- Dar tempo para comparar os dois estados. Não é uma mudança de regra:
estamos supondo um defeito na implementação. -->

---

<div class="chapter">Dois estados passam pela mesma comparação</div>

## O total é igual, mas o produto restante é diferente

| Depois de removerItem(teclado) | O que restou | Total |
| --- | --- | ---: |
| implementação correta | um fone | `150.0` |
| defeito: remove o fone | um teclado | `150.0` |

`assertEquals(150.0, ...)` passa nos dois casos.

Precisamos de uma observação que distinga **qual produto permaneceu**.

---

<!-- _class: activity -->

<div class="chapter">Continue o mesmo cenário por uma operação pública</div>

## Tente alterar a quantidade do fone

```java
pedido.alterarQuantidade(fone, 2);
assertEquals(300.0, pedido.calcularTotal());
```

1. Qual total aparece se o fone permaneceu?
2. Qual total aparece se o defeito deixou apenas o teclado?

<!-- Correto: fone com 2 unidades, 300.0. Defeito: fone ausente, nenhuma
quantidade é alterada, teclado continua com 1 unidade, 150.0. -->

---

<div class="chapter">A segunda observação distingue o defeito</div>

## Agora o teste percebe qual produto foi removido

| Implementação | Após alterar o fone para 2 | Verificação |
| --- | ---: | --- |
| correta | `300.0` | passa |
| removeu o fone por engano | `150.0` | falha |

Observamos operações públicas, sem ler a lista privada.

O cenário precisa tornar o defeito que queremos detectar observável.

---

<div class="chapter">Volte à entrega da Aula 12</div>

## Proteja o custo que já funciona

```java
@Test
void entregaNormalCustaDezReais() {
    Pedido pedido = new Pedido();
    pedido.fechar(new EntregaNormal());

    assertEquals(10.0, pedido.calcularCustoEntrega());
}
```

Quando a dependência mudar, este cenário deve continuar passando.

---

<div class="chapter">Antes da experiência, identifique a suíte</div>

## Vamos executar estes três testes

| Método de teste | Expectativa |
| --- | --- |
| `calculaTotalDeUmItem()` | duas unidades somam `300.0` |
| `pedidoFechadoNaoAceitaNovosItens()` | inclusão recusada: total `150.0` |
| `entregaNormalCustaDezReais()` | custo da entrega `10.0` |

Os três cenários foram apresentados nesta aula.

---

<div class="chapter">Altere somente a regra da entrega normal</div>

## Um defeito em EntregaNormal.java

```java
public class EntregaNormal {
    public double calcularCusto(Pedido pedido) {
        return 20.0; // deveria continuar sendo 10.0
    }
}
```

Produtos, quantidades e expectativas dos testes continuam iguais.

---

<!-- _class: activity -->

<div class="chapter">Preveja antes de executar os três testes</div>

## Quais verificações detectam essa mudança?

1. `calculaTotalDeUmItem()`
2. `pedidoFechadoNaoAceitaNovosItens()`
3. `entregaNormalCustaDezReais()`

Para cada teste, preveja **passa ou falha**.
No teste que falha, indique esperado e observado.

<!-- Passa, passa, falha. Os totais continuam somando apenas itens.
O último compara 10.0 com 20.0. Formular hipóteses antes de revelar. -->

---

<div class="chapter">Execute e compare com a previsão</div>

## A suíte localiza a expectativa que deixou de ser atendida

| Verificação | Resultado |
| --- | --- |
| total dos itens | passa |
| inclusão após fechamento | passa |
| custo da entrega normal | falha: esperado `10.0`, obtido `20.0` |

Restaure `return 10.0;` em `EntregaNormal` e execute novamente.

Os três testes voltam a passar.

---

<div class="chapter">O que esse verde demonstra?</div>

## Uma evidência delimitada

<div class="statement">Neste cenário, o comportamento observado corresponde à expectativa codificada.</div>

E se a expectativa estiver errada? E se faltar um cenário importante?

---

<!-- _class: activity -->

<div class="chapter">Defina o alcance do teste</div>

## O que podemos concluir?

1. O teste da entrega normal passa. A entrega expressa funciona?
2. Todos os testes escritos passam. Não há mais bugs?
3. Que regra da Versão 10 ainda vale proteger?

<!--
1: não, expressa não foi exercitada. 2: não, cobertura dos cenários e
expectativas pode ser incompleta. 3: remoção, alteração válida, zero,
negativo, fechamento e inclusão repetida são opções justificáveis.
-->

---

<div class="chapter">Laboratório 13</div>

## Teste o Projeto 2 que já funciona

- contador inicial e avisos por e-mail;
- sequência com e-mail, SMS e painel;
- dois lembretes independentes;
- uma regra de contagem escolhida por você.

Qual teste você mais gostaria de ter antes de mudar `Lembrete`?

<!--
O laboratório continua a Versão 1 do Projeto 2, concluída no Laboratório 12.
Os testes JUnit observam o contador; formatos impressos ainda são conferidos no
console. Nível 1 — Tutor. A prática não acrescenta funcionalidades novas.
-->

---

<!-- _class: synthesis -->

<div class="chapter">A pergunta agora é executável</div>

## Síntese

- Teste = cenário + operação observada + expectativa.
- Bons nomes explicam a regra protegida.
- Observamos comportamento público, inclusive quando nada deve mudar.
- Passar oferece evidência sobre os cenários escritos.

---

<div class="chapter">Antes da próxima mudança</div>

## Podemos perguntar de novo

<div class="key-point">Comportamento atual → teste → mudança → teste novamente</div>

<div class="statement">Você continua fazendo aquilo que combinamos?</div>

<!--
Retomar o campo private EntregaNormal entrega sem resolver aqui.
Aula 14: como depender da responsabilidade calcular entrega em vez da classe
concreta EntregaNormal? Não introduzir interface neste deck.
-->
