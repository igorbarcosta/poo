---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 10 — Completando as regras do pedido

<div class="statement">Como completar as operações de um pedido sem quebrar as responsabilidades que já construímos?</div>

<!--
Retomar: Pedido cria e mantém ItemPedido; calcula total; pode ser fechado.
Hoje: editar o pedido sem expor a lista.
-->

---

<div class="chapter">Ponto de partida</div>

## O pedido já sabe incluir e fechar

```java
pedido.adicionarItem(teclado, 2);
pedido.adicionarItem(mouse, 1);
pedido.fechar();
```

Depois de fechar, uma nova inclusão é recusada.

Mas ainda não conseguimos corrigir uma quantidade nem retirar uma linha.

---

<div class="chapter">Nova necessidade</div>

## O cliente desistiu do mouse

Antes de fechar, o pedido contém:

| Produto | Quantidade | Subtotal |
| --- | ---: | ---: |
| Teclado | 2 | 300.0 |
| Mouse | 1 | 80.0 |

<div class="key-point">O total é 380.0. Como retirar somente a linha do mouse?</div>

---

<!-- _class: activity -->

<div class="chapter">Nova necessidade</div>

## “Remover um item” ainda deixa decisões

O item será identificado:

1. pelo produto?
2. pela referência de `ItemPedido`?
3. pela posição na lista?

E remover significa diminuir uma unidade ou eliminar a linha inteira?

<!--
Tempo de formulação individual; pedir justificativas antes de mostrar a escolha desta versão.
-->

---

<div class="chapter">Decisão da Versão 10</div>

## Uma linha por mesma referência de produto

Nesta versão:

- cada pedido possui no máximo uma linha para a mesma referência de `Produto`;
- remover elimina a linha inteira;
- produto ausente preserva o pedido;
- pedido fechado não pode ser editado.

São escolhas deste modelo pequeno, não regras universais de pedidos.

---

<!-- _class: trap -->

<div class="chapter">Encapsulamento</div>

## A lista não é a API do pedido

```java
pedido.getItens().remove(...);
```

Se o cliente receber a lista interna, poderá mudar o pedido sem passar pelas regras de fechamento ou de uma linha por produto.

<div class="statement">O cliente solicita uma operação de domínio; `Pedido` decide se sua coleção muda.</div>

---

<div class="chapter">Identificação</div>

## Mesmo estado não significa mesma identidade

```java
Produto mouse = new Produto("Mouse", 80.0);
pedido.adicionarItem(mouse, 1);

Produto outroMouse = new Produto("Mouse", 80.0);
pedido.removerItem(outroMouse);
```

As duas chamadas a `new Produto(...)` criam o mesmo produto para este pedido?

---

<!-- _class: activity -->

<div class="chapter">Identificação</div>

## Preveja a remoção

A chamada `pedido.removerItem(outroMouse)` deve remover a linha do mouse?

Justifique usando identidade e referências.

---

<div class="chapter">Identificação</div>

## A linha é localizada pela mesma referência

Não. `mouse` e `outroMouse` têm identidades diferentes.

```java
pedido.removerItem(mouse);
```

Nesta versão, é a mesma referência usada na inclusão que identifica a linha.

---

<div class="chapter">Colaboração</div>

## O item responde à pergunta necessária

```java
public boolean representa(Produto produto) {
    return this.produto == produto;
}
```

`ItemPedido` não entrega seu campo `produto`.

Ele responde somente se representa a referência que `Pedido` está procurando.

---

<div class="chapter">Remoção</div>

## Pedido percorre a coleção que mantém

```java
public void removerItem(Produto produto) {
    if (!fechado) {
        for (int indice = 0; indice < itens.size(); indice++) {
            ItemPedido item = itens.get(indice);

            if (item.representa(produto)) {
                itens.remove(indice);
                return;
            }
        }
    }
}
```

---

<!-- _class: java-focus -->

<div class="chapter">Remoção</div>

## Java em foco — remover durante o percurso

O índice existe apenas dentro de `Pedido`:

- `itens.size()` informa quantas posições há;
- `itens.get(indice)` obtém a referência daquela posição;
- `itens.remove(indice)` remove a posição encontrada;
- `return` encerra a operação após a remoção.

Índice navega na lista; não identifica uma linha para o cliente.

---

<!-- _class: concept-key -->

<div class="chapter">Remoção</div>

## Conceito-chave — operação do conjunto

Quem mantém uma coleção:

- localiza a parte sobre a qual a operação atua;
- decide se a mudança estrutural é permitida;
- preserva as regras do conjunto.

A parte localizada continua responsável por seu próprio estado.

---

<div class="chapter">Alteração</div>

## Agora precisamos corrigir uma quantidade

O pedido encontra a linha do teclado.

Quem deve guardar a nova quantidade?

```java
// proposta inadequada, dentro de Pedido
item.quantidade = novaQuantidade;
```

---

<!-- _class: activity -->

<div class="chapter">Alteração</div>

## Escolha a responsabilidade

Compare:

```java
item.quantidade = novaQuantidade;
```

```java
item.alterarQuantidade(novaQuantidade);
```

Qual preserva o encapsulamento? Por quê?

---

<div class="chapter">Alteração</div>

## A quantidade continua pertencendo ao item

```java
public void alterarQuantidade(int novaQuantidade) {
    if (novaQuantidade > 0) {
        quantidade = novaQuantidade;
    }
}
```

`ItemPedido` protege a quantidade positiva e continua calculando seu subtotal.

---

<div class="chapter">Alteração</div>

## Zero muda a estrutura do pedido

Para a Versão 10:

| Nova quantidade | Consequência |
| ---: | --- |
| positiva | `ItemPedido` atualiza sua quantidade |
| zero | `Pedido` remove a linha |
| negativa | o estado é preservado |

A regra de zero pertence a `Pedido`, porque remove uma parte de sua coleção.

---

<div class="chapter">Alteração</div>

## Pedido coordena sem escrever no item

```java
if (item.representa(produto)) {
    if (novaQuantidade == 0) {
        itens.remove(indice);
    } else {
        item.alterarQuantidade(novaQuantidade);
    }
    return;
}
```

`Pedido` decide o efeito estrutural. `ItemPedido` decide se aceita a quantidade.

---

<!-- _class: activity -->

<div class="chapter">Alteração</div>

## Preveja três consequências

Pedido aberto: teclado ×2 a 150.0; mouse ×1 a 80.0.

1. alterar teclado para 3;
2. alterar mouse para 0;
3. alterar teclado para -1.

Quais totais resultam em cada cenário independente?

---

<div class="chapter">Alteração</div>

## Os resultados mostram regras diferentes

1. teclado para 3 → **530.0**;
2. mouse para 0 → **300.0**;
3. teclado para -1 → **380.0**.

Quantidade zero remove uma linha. Quantidade negativa não altera o estado.

---

<div class="chapter">Fechamento</div>

## Fechar deve proteger qual mudança?

A Aula 09 já decidiu:

> pedido fechado não recebe novas inclusões.

Agora remover e alterar quantidade também mudam estrutura ou total.

Devem continuar permitidas depois de `fechar()`?

---

<!-- _class: activity -->

<div class="chapter">Fechamento</div>

## Localize a guarda correta

Qual proposta protege a regra para qualquer cliente?

1. `Main` consulta o fechamento antes de cada chamada;
2. `Pedido` consulta `fechado` em suas operações de edição;
3. `ItemPedido` recebe um `Pedido` para consultar o fechamento.

---

<div class="chapter">Fechamento</div>

## O pedido fechado preserva seu estado

A proposta 2 protege toda solicitação de edição.

- `Main` é só um cliente e pode esquecer a regra;
- `ItemPedido` não precisa conhecer o pedido;
- `Pedido` já conhece o fechamento e a coleção.

<div class="key-point">Depois de fechado, não adiciona, remove nem altera quantidades.</div>

---

<div class="chapter">Fechamento</div>

## Preveja o resultado depois de fechar

```java
pedido.adicionarItem(teclado, 2);
pedido.adicionarItem(mouse, 1);
pedido.fechar();

pedido.removerItem(mouse);
pedido.alterarQuantidade(teclado, 3);
System.out.println(pedido.calcularTotal());
```

Qual valor é exibido? Quantas linhas permanecem?

---

<div class="chapter">Fechamento</div>

## Nenhuma edição posterior é aceita

```text
380.0
```

As duas linhas permanecem: teclado ×2 e mouse ×1.

Fechar pertence a cada objeto `Pedido`; outro pedido aberto continua editável.

---

<div class="chapter">Impacto</div>

## O que realmente mudou?

| Parte | Responsabilidade final |
| --- | --- |
| `Produto` | descrição e preço |
| `ItemPedido` | produto, quantidade válida e subtotal |
| `Pedido` | coleção, localização e regras de edição |
| cliente | solicita operações e observa efeitos |

`calcularTotal()` continua delegando subtotais aos itens.

---

<!-- _class: synthesis -->

<div class="chapter">Síntese</div>

## Para levar ao Laboratório 10

- localizar a linha pela mesma referência de `Produto`;
- manter a coleção privada em `Pedido`;
- delegar a quantidade válida para `ItemPedido`;
- interpretar quantidade zero como remoção;
- preservar itens e quantidades depois de fechar.

<div class="statement">Completar o modelo é acrescentar operações sem deslocar as responsabilidades que já funcionam.</div>
