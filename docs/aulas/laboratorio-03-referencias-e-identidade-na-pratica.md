---
icon: material/flask-outline
---

# Laboratório 03 — Referências e identidade na prática

Na Aula 03, distinguimos objeto, variável, referência, identidade e estado. Agora vamos observar essas ideias no Projeto 1 por meio de pequenos experimentos.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode esclarecer sintaxe, explicar mensagens de erro, ajudar a interpretar um comportamento observado e fazer perguntas que apoiem sua compreensão. Não deve gerar a solução completa nem fornecer respostas prontas às previsões.

!!! warning "Laboratório acompanhado — presença requerida"

    Este laboratório é acompanhado porque trabalha um modelo mental fundamental sobre referências e identidade.

## Objetivos

Ao final deste laboratório, você deverá ser capaz de:

- distinguir a criação de um objeto da cópia de uma referência;
- prever efeitos de alterações feitas por diferentes referências;
- utilizar `==` para verificar identidade;
- explicar resultados observados em experimentos com objetos e referências.

## Projeto 1 — Versão 2: referências e identidade

Use a versão anterior do Projeto 1 como base. Esta evolução não acrescenta uma grande funcionalidade: ela consolida o modelo mental necessário para que o projeto continue evoluindo corretamente.

!!! info "Como trabalhar"

    Em cada experimento, siga o ciclo **prever → executar → explicar**. Registre ou formule sua previsão antes de executar. Depois, compare o resultado observado e explique o comportamento usando referência, identidade e estado.

## Atividade

### Incremento A — Dois objetos independentes

Crie `item1` e `item2` usando duas expressões `new ItemPedido()`. Atribua inicialmente os mesmos valores aos dois:

- descrição: `Teclado`;
- preço unitário: `150.0`;
- quantidade: `2`.

Antes de executar, preveja:

- quantos objetos existem;
- se eles possuem a mesma identidade;
- qual será o resultado de `item1 == item2`.

Depois:

1. altere apenas a quantidade de `item2`;
2. apresente as quantidades dos dois objetos;
3. apresente o resultado de `item1 == item2`;
4. compare os resultados com suas previsões;
5. explique por que apenas um objeto foi alterado.

!!! info "Ideia a observar"

    Mesmo estado não significa mesma identidade.

### Incremento B — Duas referências para o mesmo objeto

Use `item1` com quantidade inicial `2` e crie outra variável:

```java
ItemPedido outroItem = item1;
```

Antes de alterar o estado, preveja:

- quantos objetos existem;
- qual será o resultado de `item1 == outroItem`;
- quais serão os valores observados em `item1.quantidade` e `outroItem.quantidade` depois de executar `outroItem.quantidade = 7`.

Use esta tabela para registrar a previsão e o resultado:

| Observação | Previsão | Resultado observado |
| --- | --- | --- |
| `item1.quantidade` |  |  |
| `outroItem.quantidade` |  |  |
| `item1 == outroItem` |  |  |

Siga esta sequência:

1. registre na tabela suas previsões antes da alteração;
2. atribua `7` a `outroItem.quantidade`;
3. apresente `item1.quantidade`;
4. apresente `outroItem.quantidade`;
5. apresente o resultado de `item1 == outroItem`;
6. compare as previsões com os resultados;
7. explique por que os valores observados fazem sentido.

### Incremento C — Comparar as duas situações

Experimente separadamente os casos abaixo.

**Caso 1**

```java
ItemPedido a = new ItemPedido();
a.quantidade = 2;

ItemPedido b = new ItemPedido();
b.quantidade = 2;
```

**Caso 2**

```java
ItemPedido a = new ItemPedido();
a.quantidade = 2;

ItemPedido b = a;
```

Para cada caso, atribua `7` a `b.quantidade`. Antes de executar, preveja; depois, execute e explique:

- quantos objetos foram criados;
- o resultado de `a == b`;
- o valor observado em `a.quantidade` depois da atribuição.

Ao final, você deve conseguir explicar claramente a diferença entre criar um novo objeto e criar uma nova referência para um objeto existente.

!!! success "Critérios de conclusão"

    Verifique se sua experimentação:

    - demonstra um caso com dois objetos distintos;
    - demonstra um caso com duas referências para o mesmo objeto;
    - altera o estado por uma referência e observa corretamente o efeito pela outra;
    - utiliza `==` para verificar identidade;
    - registra as previsões solicitadas antes das execuções e as compara com os resultados observados;
    - explica por que os resultados dos dois casos são diferentes.

## Desafio opcional — Quantos nomes, quantos objetos?

!!! tip "Quer aprofundar?"

    Use este desafio para praticar o modelo de referências com três variáveis.

Considere:

```java
ItemPedido a = new ItemPedido();
ItemPedido b = a;
ItemPedido c = b;
```

Antes de executar, preveja:

- quantos objetos existem;
- quais comparações entre `a`, `b` e `c` com `==` resultarão em `true`;
- o que será observado por `a` e `b` se a quantidade for alterada usando `c`.

Depois, execute as comparações e a alteração, verifique suas previsões e explique os resultados.

!!! question "Para a próxima aula"

    Vamos retomar estas questões na Aula 04 — Protegendo o estado dos objetos. Não é necessário respondê-las por escrito.

    1. Se duas partes do programa possuem referências para o mesmo objeto, ambas podem modificar seu estado atual?
    2. Todo valor deveria poder ser atribuído diretamente aos campos de um objeto?
    3. Quem deveria ser responsável por decidir se uma alteração de estado é válida?

## Entrega

> **Projeto 1 — Versão 2: referências e identidade**

Entregue sua própria versão do projeto conforme as orientações disponíveis no Google Classroom.

## Materiais relacionados

- [Aula 03 — Objetos, referências e identidade](aula-03-objetos-referencias-e-identidade.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
