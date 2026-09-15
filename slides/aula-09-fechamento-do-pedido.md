---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 09 — Fechamento do pedido

<div class="statement">Como evoluir `Pedido` para proteger uma nova regra sem refazer as responsabilidades que já funcionam?</div>

<!--
Retomar a Versão 8: Pedido cria e mantém ItemPedido; ItemPedido calcula subtotal; Produto fornece preço.
Hoje o novo requisito muda a permissão de inclusão.
-->

---

<div class="chapter">Ponto de partida</div>

## O pedido já calcula o total

```java
public void adicionarItem(Produto produto, int quantidade) {
    ItemPedido item = new ItemPedido(produto, quantidade);
    itens.add(item);
}

public double calcularTotal() {
    double total = 0.0;
    for (ItemPedido item : itens) {
        total += item.calcularSubtotal();
    }
    return total;
}
```

<div class="key-point">A Versão 8 distribui bem o cálculo. Toda inclusão ainda é aceita.</div>

---

<div class="chapter">Novo requisito</div>

## O pedido agora pode ser fechado

<div class="statement">Depois que um pedido é fechado, não podem ser adicionados novos itens.</div>

O que precisa mudar para o próprio `Pedido` fazer essa regra valer?

---

<!-- _class: activity code-focus -->

<div class="chapter">Ponto de partida</div>

## O requisito muda a sequência de uso

Considere teclado a `150.0` e mouse a `80.0`:

```java
Pedido pedido = new Pedido();
pedido.adicionarItem(teclado, 2);

// O cliente considera o pedido concluído.

pedido.adicionarItem(mouse, 1);
```

**Preveja:** total atual, total esperado após fechar e informação que falta ao `Pedido`.

<!--
Dar tempo para prever. O comentário ainda não muda o objeto.
-->

---

<div class="chapter">Ponto de partida</div>

## O comentário não muda o objeto

- o código atual calcula `380.0`;
- o requisito espera `300.0`;
- a segunda inclusão precisa ser impedida.

<div class="statement">Falta representar no próprio `Pedido` que ele foi fechado.</div>

---

<!-- _class: concept-key -->

<div class="chapter">Ponto de partida</div>

## A mudança começa pelo estado

Um pedido passa por dois estados relevantes:

```text
aberto ───────────────► fechado
       pedido.fechar()
```

O estado pertence a cada objeto `Pedido`.

---

<!-- _class: activity -->

<div class="chapter">Responsabilidade</div>

## Localize a decisão

Qual objeto deve decidir se `adicionarItem(Produto, int)` pode prosseguir?

1. `Main`, antes da chamada;
2. `ItemPedido`, antes de entrar na lista;
3. `Pedido`, dentro de `adicionarItem`.

Justifique usando o estado e as informações que cada objeto conhece.

<!--
Coletar justificativas. A resposta aparece somente depois da discussão.
-->

---

<div class="chapter">Responsabilidade</div>

## Quem deve proteger a inclusão?

- `Main` é cliente e pode esquecer a regra;
- `ItemPedido` não conhece o estado do pedido;
- `Pedido` recebe a solicitação e mantém a coleção.

<div class="key-point">A operação que altera a coleção deve proteger a regra.</div>

---

<div class="chapter">Estado do pedido</div>

## Um campo privado representa a situação

```java
private boolean fechado;
```

- `false`: o pedido está aberto;
- `true`: o pedido está fechado;
- cada `Pedido` possui seu próprio valor.
- `!fechado` significa “não está fechado”: é `true` somente enquanto aberto.

<div class="statement">Código externo solicita ações; não altera o campo diretamente.</div>

---

<!-- _class: java-focus code-focus -->

<div class="chapter">Estado do pedido</div>

## O pedido nasce aberto e pode fechar

```java
public Pedido() {
    itens = new ArrayList<>();
    fechado = false;
}

public void fechar() {
    fechado = true;
}
```

`fechar()` expressa uma transição do domínio.

---

<div class="chapter">Estado do pedido</div>

## Criar o estado ainda não basta

```java
pedido.fechar();
pedido.adicionarItem(mouse, 1);
```

Se `adicionarItem` não consultar `fechado`, o item continuará entrando.

<div class="key-point">O estado precisa proteger a operação que altera a coleção.</div>

---

<!-- _class: activity code-focus -->

<div class="chapter">Proteção da coleção</div>

## Em que ponto verificar?

```java
ItemPedido item = new ItemPedido(produto, quantidade);
itens.add(item);
```

A condição deve ser verificada antes ou depois dessas instruções?

O que uma tentativa recusada deve evitar?

---

<div class="chapter">Proteção da coleção</div>

## A guarda envolve a criação e a inclusão

```java
public void adicionarItem(Produto produto, int quantidade) {
    if (!fechado) {
        ItemPedido item = new ItemPedido(produto, quantidade);
        itens.add(item);
    }
}
```

Quando `fechado` é `true`, nenhuma instrução do bloco é executada.

---

<!-- _class: concept-key -->

<div class="chapter">Proteção da coleção</div>

## Conceito-chave — regra protegida pelo objeto

Depois que `Pedido` é fechado, `adicionarItem` não aumenta seu conjunto de itens.

<div class="statement">A regra fica no objeto que conhece seu estado e controla a mudança.</div>

---

<div class="chapter">Proteção da coleção</div>

## A tentativa recusada preserva o estado

Nesta versão:

- `adicionarItem` mantém retorno `void`;
- não há exceção;
- a lista continua igual;
- nenhum `ItemPedido` novo é criado.

Comunicar a recusa seria outra decisão sobre o contrato da operação.

---

<div class="chapter">Dois pedidos</div>

## O estado pertence a cada instância

```java
Pedido primeiro = new Pedido();
primeiro.adicionarItem(teclado, 2);
primeiro.fechar();
primeiro.adicionarItem(mouse, 1);

Pedido segundo = new Pedido();
segundo.adicionarItem(mouse, 1);
```

Fechar `primeiro` altera `segundo`?

---

<!-- _class: activity -->

<div class="chapter">Dois pedidos</div>

## Preveja os dois totais

Com teclado a `150.0` e mouse a `80.0`:

1. qual total `primeiro.calcularTotal()` devolve?
2. qual total `segundo.calcularTotal()` devolve?
3. quantos `ItemPedido` são criados pelas três chamadas?

<!--
Pedir que acompanhem criação e inclusão separadamente.
-->

---

<div class="chapter">Dois pedidos</div>

## A saída mostra dois estados independentes

```text
300.0
80.0
```

- `primeiro` rejeita a inclusão posterior ao fechamento;
- `segundo` continua aberto;
- a tentativa recusada não cria um terceiro item.

---

<div class="chapter">Impacto da mudança</div>

## O que muda no modelo?

| Parte | Consequência |
| --- | --- |
| `Pedido` | guarda o fechamento e protege a inclusão |
| cliente | solicita `fechar()` e verifica o cenário |
| `ItemPedido` | continua calculando o subtotal |
| `Produto` | continua fornecendo o preço |
| `calcularTotal()` | continua delegando aos itens |

---

<!-- _class: activity -->

<div class="chapter">Impacto da mudança</div>

## Diagnostique três propostas

1. verificar `fechado` apenas em `Main`;
2. verificar `fechado` dentro de `Pedido.adicionarItem`;
3. fazer `ItemPedido.calcularSubtotal()` devolver `0.0` depois do fechamento.

Qual proposta protege a inclusão? Qual altera uma responsabilidade que o requisito não pediu para mudar?

---

<div class="chapter">Impacto da mudança</div>

## Fechar não apaga itens existentes

**Proposta 2:** a guarda dentro de `Pedido.adicionarItem` protege toda chamada.

- **Proposta 1:** depende de cada cliente lembrar da verificação.
- **Proposta 3:** muda indevidamente o subtotal e exigiria que `ItemPedido` conhecesse o estado de `Pedido`.

Fechar impede novas inclusões. Não apaga itens, não zera subtotais e não proíbe toda mudança possível.

<div class="key-point">A proteção deve ser tão ampla quanto o requisito — e não mais ampla.</div>

---

<div class="chapter">Transferência</div>

## Uma turma pode encerrar inscrições

Uma `Turma` mantém estudantes inscritos e oferece `inscrever(estudante)`.

Depois do encerramento, novas inscrições não entram.

Quem deve proteger essa regra? O que acontece com estudantes já inscritos?

---

<div class="chapter">Transferência</div>

## A turma protege suas inscrições

`Turma` verifica seu estado dentro de `inscrever(estudante)`: ela recebe a solicitação e mantém a lista privada.

Os estudantes já inscritos permanecem. Encerrar inscrições impede novas entradas; não remove as anteriores.

---

<div class="chapter">Síntese</div>

## A evolução foi localizada

```text
Pedido
 ├── estado: aberto → fechado
 ├── fechar()
 ├── adicionarItem() protegido
 └── calcularTotal() por delegação
```

O requisito acrescentou uma transição e uma regra de entrada. O restante da colaboração permanece compreensível.

---

<!-- _class: synthesis -->

<div class="chapter">Síntese</div>

## Para levar ao laboratório

- prever antes de modificar;
- proteger a regra no objeto responsável;
- verificar antes de criar o novo item;
- comparar pedidos diferentes;
- confirmar o que mudou e o que permaneceu igual.

<div class="statement">No Laboratório 09, a Versão 8 evolui para um pedido que recusa novas inclusões depois do fechamento.</div>
