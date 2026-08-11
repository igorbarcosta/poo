---
icon: material/flask-outline
---

# Laboratório 04 — Controlando alterações de estado

No laboratório anterior, você observou que diferentes referências podem permitir acesso ao mesmo objeto. Agora vamos evoluir o Projeto 1 para que `ItemPedido` controle as alterações realizadas em sua quantidade.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode:

    - esclarecer sintaxe e mensagens de erro;
    - ajudar a interpretar o comportamento observado;
    - auxiliar na compreensão de `private`, `public` e métodos.

    Ela não deve gerar a solução completa, decidir toda a implementação por você nem antecipar conteúdos ainda não estudados.

!!! warning "Laboratório acompanhado — presença requerida"

    Este laboratório é acompanhado porque introduz a proteção do estado e a alteração controlada por comportamentos.

## Objetivos

Ao final deste laboratório, você deverá ser capaz de:

- observar o problema causado por um campo diretamente exposto;
- tornar um campo privado;
- interpretar o efeito dessa mudança sobre código externo;
- substituir alteração direta por um comportamento controlado;
- consultar um campo privado por meio de uma operação apropriada;
- verificar que uma regra simples de alteração do estado é preservada.

## Projeto 1 — Versão 4: estado protegido

Use a versão anterior do Projeto 1 como base. Nesta evolução, você protegerá somente o campo `quantidade` e fará com que suas alterações passem pelo próprio `ItemPedido`.

## Atividade

### Incremento A — Observar o problema

Antes de proteger o campo, atribua uma quantidade inadequada a um dos itens:

```java
item.quantidade = -10;
```

Em seguida, calcule e apresente o subtotal:

```java
System.out.println(item.calcularSubtotal());
```

Observe que:

- o código compila;
- o objeto assume a quantidade informada;
- o comportamento utiliza esse estado e produz um subtotal afetado por ele.

O Java impediu que o objeto assumisse esse estado?

### Incremento B — Proteger `quantidade`

Em `ItemPedido`, altere:

```java
int quantidade;
```

para:

```java
private int quantidade;
```

Antes de corrigir `Main`, siga esta sequência:

1. compile o projeto;
2. leia as mensagens de erro;
3. identifique os trechos de `Main` que tentam acessar diretamente `quantidade`;
4. explique por que esses acessos deixaram de ser permitidos.

### Incremento C — Alterar por comportamento

Adicione a `ItemPedido` um método com esta assinatura:

```java
public void aumentarQuantidade(int unidades)
```

O método deve:

- receber um valor `int`;
- acrescentar esse valor à quantidade atual quando `unidades > 0`;
- manter a quantidade inalterada quando `unidades <= 0`.

Adapte `Main` para usar esse comportamento no lugar das atribuições diretas de quantidade. Não use exceções nem retorne códigos de erro.

!!! tip "Java em foco — valor inicial do campo"

    Neste exemplo, um campo `int` de um objeto começa com `0` quando nenhum valor foi atribuído explicitamente.

### Incremento D — Consultar a quantidade

Adicione um método com esta assinatura:

```java
public int getQuantidade()
```

O método deve apenas retornar a quantidade atual. Adapte `Main` para apresentá-la assim:

```java
System.out.println(item.getQuantidade());
```

Observe a diferença:

- `item.getQuantidade()` é permitido;
- `item.quantidade = 20` continua não sendo permitido.

**Não crie `setQuantidade` nesta atividade.** O objetivo é representar a mudança como um comportamento com intenção e regra, em vez de apenas substituir a atribuição direta por um setter genérico.

### Incremento E — Verificar a regra

Crie um item e defina seu preço unitário antes de verificar as alterações da quantidade:

```java
ItemPedido item = new ItemPedido();
item.precoUnitario = 150.0;
```

Em seguida, execute esta sequência:

1. consulte a quantidade inicial;
2. aumente a quantidade em `2` e consulte novamente;
3. tente aumentá-la em `-5` e consulte novamente;
4. aumente-a em `3` e faça uma nova consulta;
5. calcule o subtotal usando o estado atual.

Compare os resultados observados com os esperados:

| Operação | Quantidade esperada |
| --- | ---: |
| início | `0` |
| aumentar em `2` | `2` |
| aumentar em `-5` | `2` |
| aumentar em `3` | `5` |

Ao final, calcule e apresente o subtotal. Com preço unitário `150.0` e quantidade `5`, o resultado esperado é `750.0`.

Neste laboratório, não torne `descricao` e `precoUnitario` privados e não crie getters ou setters para esses campos. O foco é compreender a proteção de `quantidade`.

!!! success "Critérios de conclusão"

    Verifique se sua solução:

    - mantém `quantidade` como `private`;
    - não acessa diretamente `quantidade` a partir de `Main`;
    - possui `aumentarQuantidade(int unidades)`;
    - aumenta a quantidade somente quando `unidades > 0`;
    - mantém a quantidade inalterada quando `unidades <= 0`;
    - possui `getQuantidade()`;
    - consulta a quantidade por meio desse método;
    - continua calculando o subtotal com o estado interno;
    - produz os resultados esperados na sequência de verificação.

## Desafio opcional — Reduzindo quantidade com segurança

!!! tip "Quer aprofundar?"

    Explore como outro comportamento pode preservar uma regra sobre o estado do objeto.

Adicione a `ItemPedido` um método com esta assinatura:

```java
public void reduzirQuantidade(int unidades)
```

O método deve respeitar estas regras:

- `unidades` deve ser positivo;
- a quantidade não pode ficar negativa;
- se alguma regra for violada, a quantidade permanece inalterada.

Use o objeto que terminou o Incremento E com quantidade `5` ou prepare outro objeto chamando `aumentarQuantidade(5)`. Depois, verifique:

- reduzir `2` resulta em `3`;
- reduzir `10` mantém a quantidade em `3`;
- reduzir `-1` mantém a quantidade em `3`.

Não use exceções nem adicione retorno booleano. O objetivo é aprofundar a ideia de que o próprio comportamento preserva uma regra do estado.

!!! question "Para consolidar"

    1. Por que tornar um campo `private` não é, sozinho, suficiente para garantir um bom encapsulamento?
    2. Qual é a diferença entre permitir consultar a quantidade e permitir alterá-la diretamente?
    3. Por que `aumentarQuantidade(3)` comunica uma intenção diferente de `setQuantidade(3)`?

    Não é necessário entregar respostas escritas.

## Entrega

> **Projeto 1 — Versão 4: estado protegido**

Entregue sua própria versão do projeto conforme as orientações disponíveis no Google Classroom.

## Materiais relacionados

- [Aula 04 — Protegendo o estado dos objetos](aula-04-protegendo-o-estado-dos-objetos.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
