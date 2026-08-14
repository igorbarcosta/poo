---
icon: material/flask-outline
---

# Laboratório 02 — Primeiros objetos em Java

No Laboratório 01, você criou uma solução procedural para registrar itens de uma compra. Na Aula 02, discutimos classe, objeto, estado, comportamento e responsabilidade. Agora vamos evoluir aquela solução para representar cada item como um objeto.

!!! question "Pergunta central"

    Como representar cada item da compra como uma unidade que reúne seu estado e seu comportamento?

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode ser usada para esclarecer sintaxe, interpretar erros, explicar construções e ajudar na compreensão. Não deve ser usada para gerar a solução completa da atividade.

!!! warning "Laboratório acompanhado — presença requerida"

    Este laboratório é acompanhado porque será nossa primeira construção efetiva de classes e objetos de domínio em Java.

## Objetivos

Ao final deste laboratório, você deverá ser capaz de:

- criar uma classe Java simples para representar um conceito do problema;
- criar objetos diferentes a partir da mesma classe;
- atribuir estados diferentes a esses objetos;
- implementar um comportamento que utiliza o estado do próprio objeto;
- evoluir uma solução procedural simples para uma primeira solução organizada em objetos.

## Projeto 1 — Versão 2: primeiros objetos

Use como ponto de partida a **Versão 1** produzida no Laboratório 01. Nesta versão, cada item da compra passará a ser representado por um objeto.

Trabalhe inicialmente com estes arquivos:

```text
Main.java
ItemPedido.java
```

Em `ItemPedido.java`, comece com a estrutura mínima:

```java
public class ItemPedido {
    // estado

    // comportamento
}
```

Neste laboratório, não use `private`, getters, setters, construtores explícitos ou `this`. Esses recursos serão introduzidos quando se tornarem necessários.

## Atividade

### Incremento A — Representar um item

Crie a classe `ItemPedido`. Cada objeto dessa classe deve manter:

- descrição, do tipo `String`;
- preço unitário, do tipo `double`;
- quantidade, do tipo `int`.

Ao final desta etapa, `ItemPedido.java` deve declarar os três elementos de estado. A forma de completar a estrutura inicial fica a seu cargo.

### Incremento B — Criar objetos

No método `main`, crie **dois objetos diferentes** da classe `ItemPedido`. Cada objeto deve manter seus próprios valores de descrição, preço unitário e quantidade.

Você pode usar estes dados:

| Item | Descrição | Preço unitário | Quantidade |
| --- | --- | ---: | ---: |
| 1 | Teclado | 150.00 | 2 |
| 2 | Mouse | 80.00 | 3 |

Altere diretamente a quantidade do primeiro objeto de `2` para `3`. Em seguida, exiba no console a quantidade dos dois objetos e verifique que o primeiro passou a ter `3`, enquanto o segundo continuou com `3`. Os números coincidem no final; os objetos, convenientemente, não precisam combinar entre si para chegar lá.

### Incremento C — Adicionar comportamento

Adicione à classe `ItemPedido` um método chamado `calcularSubtotal`. O método deve:

- retornar `double`;
- não receber parâmetros;
- calcular preço unitário × quantidade;
- utilizar o estado do próprio objeto.

Use o método nos dois objetos, exiba no console os subtotais retornados e verifique os resultados. Não é necessário criar outro método para esse cálculo no `Main`.

Com o estado produzido no incremento anterior, os subtotais esperados são:

- `450.0` para o teclado;
- `240.0` para o mouse.

### Incremento D — Exibir a compra

No `main`, exiba no console os dados dos dois objetos, incluindo:

- descrição;
- preço unitário;
- quantidade;
- subtotal.

Calcule também o valor total da compra e exiba-o no console. O total deve corresponder à soma dos subtotais dos dois itens.

Com os dados atuais, o total esperado é `690.0`.

Não é necessário que `ItemPedido` exiba seus próprios dados no console. Também não use `toString()` neste momento.

### Incremento E — Alterar o estado por meio de um comportamento

Adicione à classe `ItemPedido` um método chamado `aumentarQuantidade`, que:

- recebe um valor `int` chamado `unidades`;
- acrescenta esse valor à quantidade atual do próprio objeto.

Depois:

1. use o método para adicionar 2 unidades apenas ao objeto que representa o teclado;
2. exiba novamente a quantidade e o subtotal desse objeto;
3. exiba novamente a quantidade e o subtotal do mouse;
4. verifique que o teclado passou a ter quantidade `5` e subtotal `750.0`, enquanto o mouse permaneceu com quantidade `3` e subtotal `240.0`.

Não implemente validação de valores inválidos e não introduza encapsulamento. A sequência que interessa aqui é:

**estado → comportamento modifica o estado → outro comportamento utiliza o novo estado**

O método não faz mágica — uma notícia talvez decepcionante, mas útil. Ele altera o campo do objeto em que foi chamado; depois, `calcularSubtotal()` usa esse novo estado.

!!! success "Critérios de conclusão"

    Verifique se sua solução:

    - compila e executa sem erros;
    - possui `Main.java` e `ItemPedido.java`;
    - usa `ItemPedido` para representar descrição, preço unitário e quantidade;
    - cria dois objetos distintos, cada um com seus próprios dados;
    - define `calcularSubtotal()` sem parâmetros em `ItemPedido`;
    - calcula o subtotal utilizando o estado do próprio objeto;
    - chama comportamentos definidos em `ItemPedido` para calcular o subtotal e aumentar a quantidade;
    - exibe no console os dados e subtotais dos dois itens;
    - executa a solução e confere os resultados esperados antes e depois do aumento de quantidade;
    - exibe no console o total correto da compra;
    - permite que você explique por que `calcularSubtotal()` faz sentido como comportamento de `ItemPedido`.

Antes de entregar, explique com suas palavras: `ItemPedido` faz sentido como classe por qual motivo? Por que o cálculo do subtotal ficou nessa classe, e não repetido no `main`?

Código que você não consegue explicar não é código que você domina. O compilador, com sua conhecida falta de sensibilidade pedagógica, verifica outra coisa.

## Desafio opcional — Um requisito novo: desconto percentual

!!! tip "Quer aprofundar?"

    Concluiu, verificou os critérios e consegue explicar a solução? Evolua o requisito sem reescrever o projeto.

Agora alguns itens podem ter seu subtotal calculado com um desconto percentual. Evolua a solução para que seja possível:

- obter o subtotal normal de qualquer item, como antes;
- obter o subtotal de um item considerando um percentual informado no momento do cálculo;
- aplicar `10%` de desconto ao teclado e exibir o resultado `675.0`;
- aplicar `25%` de desconto ao mouse e exibir o resultado `180.0`;
- exibir o total promocional `855.0`, formado pelos dois subtotais com desconto.

Decida onde fica essa nova responsabilidade e dê um nome claro ao comportamento. Uma possibilidade seria um método como `calcularSubtotalComDesconto(double percentual)`, usando `0.10` para representar 10%, mas essa assinatura não é obrigatória se sua alternativa for coerente e permanecer dentro dos recursos já estudados.

Não substitua `calcularSubtotal()`: o requisito antigo continua existindo. Também não armazene o preço já descontado no campo `precoUnitario`; o mesmo objeto ainda deve conseguir calcular seu subtotal normal.

Ao terminar, explique:

- por que a responsabilidade pelo novo cálculo ficou no local escolhido;
- como o percentual entra no comportamento;
- como você verificou que o requisito novo não quebrou o cálculo anterior.

!!! success "Critérios do desafio"

    Verifique se sua solução:

    - preserva o cálculo do subtotal normal;
    - produz `675.0`, `180.0` e o total promocional `855.0` para os dados pedidos;
    - concentra o cálculo com desconto em um comportamento coerente, sem duplicá-lo para cada objeto;
    - permite explicar a decisão e a verificação realizadas.

!!! question "Para a próxima aula"

    Vamos retomar estas questões na Aula 03 — Objetos, referências e identidade. Não é necessário respondê-las por escrito.

    1. Quantos objetos são criados quando usamos `new ItemPedido()` duas vezes?
    2. O que exatamente uma variável como `item1` representa?
    3. Seria possível duas variáveis diferentes se referirem ao mesmo objeto?

## Entrega

> **Projeto 1 — Versão 2: primeiros objetos**

Entregue sua própria versão do projeto conforme as orientações disponíveis no Google Classroom.

## Materiais relacionados

- [Aula 02 — Do procedural aos objetos](aula-02-do-procedural-aos-objetos.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
