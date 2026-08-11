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

Altere a quantidade de apenas um dos objetos. Em seguida, apresente novamente a quantidade dos dois objetos e verifique que apenas o objeto escolhido teve seu estado modificado.

### Incremento C — Adicionar comportamento

Adicione à classe `ItemPedido` um método chamado `calcularSubtotal`. O método deve:

- retornar `double`;
- não receber parâmetros;
- calcular preço unitário × quantidade;
- utilizar o estado do próprio objeto.

Use o método nos dois objetos e verifique os resultados. Não é necessário criar outro método para esse cálculo no `Main`.

### Incremento D — Apresentar a compra

No `main`, apresente para os dois objetos:

- descrição;
- preço unitário;
- quantidade;
- subtotal.

Calcule e apresente também o valor total da compra. O total deve corresponder à soma dos subtotais dos dois itens.

Não é necessário que `ItemPedido` imprima seus próprios dados. Também não use `toString()` neste momento.

!!! success "Critérios de conclusão"

    Verifique se sua solução:

    - compila e executa sem erros;
    - possui `Main.java` e `ItemPedido.java`;
    - usa `ItemPedido` para representar descrição, preço unitário e quantidade;
    - cria dois objetos distintos, cada um com seus próprios dados;
    - define `calcularSubtotal()` sem parâmetros em `ItemPedido`;
    - calcula o subtotal utilizando o estado do próprio objeto;
    - apresenta os dados e subtotais dos dois itens;
    - apresenta corretamente o total da compra.

## Desafio opcional — Alterando o estado por meio de um comportamento

!!! tip "Quer aprofundar?"

    Concluiu a atividade principal? Use este desafio para explorar como o comportamento de um objeto pode modificar seu próprio estado.

Adicione à classe `ItemPedido` um método chamado `aumentarQuantidade`, que:

- recebe um valor `int` chamado `unidades`;
- acrescenta esse valor à quantidade atual do próprio objeto.

Depois:

1. use o método para adicionar 2 unidades a apenas um dos objetos;
2. apresente novamente a quantidade desse objeto;
3. apresente novamente seu subtotal;
4. verifique que o outro objeto não foi alterado.

Não implemente validação de valores inválidos e não introduza encapsulamento. O objetivo é observar esta sequência:

**estado → comportamento modifica o estado → outro comportamento utiliza o novo estado**

!!! success "Critérios do desafio"

    Verifique se sua solução:

    - acrescenta as unidades à quantidade do objeto escolhido;
    - atualiza o subtotal de acordo com o novo estado;
    - mantém o outro objeto inalterado.

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
