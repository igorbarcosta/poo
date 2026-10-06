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

<div class="chapter">A colaboração que vamos mudar</div>

## Pedido já funciona com entrega normal

```java
Pedido pedido = new Pedido();
pedido.fechar(new EntregaNormal());
```

Depois, queremos aceitar outras formas de entrega.

<div class="key-point">Como preservar o que já estava correto?</div>

<!--
Retomar apenas a tensão final da Aula 12. O pedido recebe a entrega no
fechamento; não apresentar nenhuma alternativa antiga de API.
-->

---

<div class="chapter">Uma regra conhecida</div>

## Duas unidades de teclado

```java
Produto teclado = new Produto("Teclado", 150.0);
Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 2);

System.out.println(pedido.calcularTotal());
```

Como você confere que o resultado está correto?

---

<!-- _class: activity -->

<div class="chapter">Antes da ferramenta</div>

## Preveja e compare

O teclado custa **150.0**. O pedido contém **duas unidades**.

1. Que valor deve aparecer?
2. Quem compara esse valor com o resultado impresso?

<!--
Resposta: 300.0; uma pessoa conhece a expectativa e olha a saída.
Perguntar se imprimir 300.0, sozinho, registra o que era esperado.
-->

---

<div class="chapter">O primeiro resultado</div>

## O console mostra um valor

```text
300.0
```

Nós sabemos que é o esperado porque fizemos a conta.

O programa ainda não conhece essa expectativa.

---

<div class="chapter">Escreva a expectativa</div>

## O programa pode fazer a comparação

```java
System.out.println(
    pedido.calcularTotal() == 300.0
);
```

```text
true
```

Melhorou. O que ainda precisamos fazer?

<!--
Ainda precisamos executar e olhar a saída. O exemplo usa valores inteiros
representáveis exatamente em double; não abrir aula de precisão numérica.
-->

---

<div class="chapter">Uma verificação mais explícita</div>

## Esperado e observado no código

```java
double esperado = 300.0;
double observado = pedido.calcularTotal();

if (observado != esperado) {
    System.out.println("ERRO: esperado " + esperado
        + ", obtido " + observado);
}
```

Agora o programa aponta a divergência.

---

<!-- _class: activity -->

<div class="chapter">Siga o desvio</div>

## O que aparece no console?

Com `esperado = 300.0`:

1. se o método devolver `300.0`;
2. se o método devolver `150.0`.

O que mudaria se tivéssemos **trinta regras**?

<!--
Resposta: no primeiro caso não imprime; no segundo imprime erro com esperado
300.0 e obtido 150.0. Trinta regras exigiriam muitas comparações e mensagens.
-->

---

<div class="chapter">A necessidade surgiu</div>

## Muitas verificações, uma mesma estrutura

Para cada regra, queremos:

<div class="sequence"><span>preparar</span><span class="arrow">→</span><span>observar</span><span class="arrow">→</span><span>comparar</span></div>

Também queremos executar tudo e saber **qual cenário falhou**.

---

<!-- _class: concept-key -->

<div class="chapter">O que estamos automatizando</div>

## Conceito-chave — expectativa executável

Um teste prepara um cenário, observa uma operação e compara o resultado com uma expectativa definida.

A expectativa fica escrita no código.

---

<div class="chapter">Uma estrutura para essa tarefa</div>

## JUnit reúne verificações em métodos

```java
@Test
void calculaTotalDeUmItem() {
    Produto teclado = new Produto("Teclado", 150.0);
    Pedido pedido = new Pedido();
    pedido.adicionarItem(teclado, 2);

    assertEquals(300.0, pedido.calcularTotal());
}
```

O cenário da Unidade 01 continua o mesmo.

---

<!-- _class: java-focus -->

<div class="chapter">O mínimo para ler o teste</div>

## Java em foco — JUnit básico

`@Test` marca uma verificação para o executor.

`assertEquals(esperado, observado)` compara os valores.

Se diferirem, o teste falha e JUnit mostra qual método falhou.

<!--
Mostrar os imports no próximo frame. Não entrar em runner, Maven, ciclo de vida
ou outros recursos de JUnit.
-->

---

<div class="chapter">A classe de teste</div>

## O que precisamos importar

```java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class PedidoTest {
    @Test
    void calculaTotalDeUmItem() {
        // cenário, ação e verificação
    }
}
```

O executor chama o método de teste. Não usamos `main` para isso.

---

<!-- _class: activity -->

<div class="chapter">Leia antes de executar</div>

## Que história o teste conta?

```java
Produto teclado = new Produto("Teclado", 150.0);
Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 2);

assertEquals(300.0, pedido.calcularTotal());
```

Qual é o cenário? Qual operação observamos? O que esperamos?

<!--
Cenário: pedido com duas unidades de teclado a 150. Operação observada:
calcularTotal. Expectativa: 300.0.
-->

---

<div class="chapter">Três movimentos no mesmo teste</div>

## Prepare → execute → verifique

```java
Produto teclado = new Produto("Teclado", 150.0);
Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 2);

double total = pedido.calcularTotal();

assertEquals(300.0, total);
```

Arrange → Act → Assert é um nome útil, não uma exigência de comentários.

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

<!-- _class: activity -->

<div class="chapter">Aprofundamento</div>

## Um total igual conta a história inteira?

Um pedido contém teclado de `150.0` e mouse de `80.0`.

Depois de uma operação, o total continua `230.0`.

Podemos concluir que cada linha permaneceu igual?

<!--
Não necessariamente. Estados diferentes podem somar o mesmo total.
Neste encontro, escolher cenários em que uma violação da regra produza uma
diferença observável. Não abrir discussão de getters ou detalhes internos.
-->

---

<div class="chapter">Escolha a evidência adequada</div>

## O cenário deve distinguir o erro

O mesmo total pode resultar de estados diferentes.

Nos nossos exemplos, cada operação proibida teria um efeito numérico visível.

Para outra regra, talvez precisemos de outro cenário ou de mais uma operação pública.

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

<div class="chapter">Vamos provocar uma falha</div>

## E se a regra for alterada por engano?

```java
public double calcularCusto(Pedido pedido) {
    return 20.0;
}
```

O teste ainda espera `10.0`.

---

<!-- _class: activity -->

<div class="chapter">Preveja a suíte</div>

## Qual teste ficará vermelho?

- total de duas unidades de teclado;
- inclusão após fechamento;
- custo da entrega normal.

Qual diferença JUnit mostrará?

<!--
Somente o teste do custo deve falhar nesse recorte; esperado 10.0,
observado 20.0. Restaurar 10.0 e executar novamente.
-->

---

<div class="chapter">Vermelho → verde</div>

## A falha identifica uma divergência

```text
esperado: 10.0
obtido:   20.0
```

Restauramos `return 10.0;` e executamos os testes outra vez.

Agora o cenário protegido passa.

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
