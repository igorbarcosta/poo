---
icon: material/school-outline
---

# Aula 03 — Objetos, referências e identidade

Na Aula 02, usamos `new` para criar objetos com estados diferentes. Agora vamos tornar explícito o papel das variáveis que usamos para acessar esses objetos.

!!! question "Pergunta central"

    Quando usamos uma variável para trabalhar com um objeto, o que essa variável realmente representa?

## Objetivos

Ao final deste encontro, você deverá ser capaz de:

- distinguir objeto de variável de referência;
- compreender o papel de `new` na criação de novos objetos;
- explicar que uma variável de tipo de classe mantém uma referência para um objeto;
- prever o efeito de atribuir uma referência a outra variável;
- reconhecer quando duas variáveis se referem ao mesmo objeto;
- distinguir identidade de estado;
- utilizar `==`, neste contexto, para verificar se duas referências apontam para o mesmo objeto;
- explicar pequenos trechos de código envolvendo referências e alteração de estado.

## Conteúdo

### Retomando o Laboratório 02

Considere novamente:

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = new ItemPedido();
```

Discuta:

- quantos objetos foram criados e onde ocorre essa criação?
- `item1` é o objeto ou cumpre outro papel?
- o que `new ItemPedido()` faz em cada instrução?

As duas expressões `new ItemPedido()` criam dois objetos. `item1` e `item2` são variáveis usadas para acessar esses objetos.

### Variável, referência e objeto

Observe as três partes desta instrução:

```java
ItemPedido item1 = new ItemPedido();
```

- `ItemPedido` é o tipo da variável;
- `item1` é uma variável que mantém uma referência;
- `new ItemPedido()` cria um novo objeto.

Também poderíamos separar a declaração da atribuição:

```java
ItemPedido item1;
item1 = new ItemPedido();
```

!!! info "Modelo central"

    A variável não é o objeto. Ela mantém uma referência que permite acessar o objeto.

Esse é um modelo conceitual para compreender o código. Não precisamos recorrer a detalhes internos da plataforma Java para usá-lo.

### Valores simples e referências

Comece com valores inteiros:

```java
int a = 2;
int b = a;

b = 5;
```

Qual é o valor de `a` ao final? A atribuição `int b = a` copia o número `2`, então alterar `b` não altera `a`.

Agora compare:

```java
ItemPedido item1 = new ItemPedido();
item1.quantidade = 2;

ItemPedido item2 = item1;
item2.quantidade = 5;
```

Uma atribuição copia o valor da variável. Neste caso, o valor copiado é uma referência. Por isso, `item1` e `item2` passam a permitir acesso ao mesmo objeto. A atribuição `item2 = item1` não cria outro `ItemPedido`.

```text
item1 ──┐
        ├──► objeto ItemPedido
item2 ──┘
```

### Dois objetos ou duas referências?

Compare as situações.

**Situação A — dois usos de `new`**

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = new ItemPedido();
```

```text
item1 ─────► objeto ItemPedido

item2 ─────► outro objeto ItemPedido
```

**Situação B — cópia da referência**

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = item1;
```

```text
item1 ──┐
        ├──► objeto ItemPedido
item2 ──┘
```

Nas duas situações existem duas variáveis. Na situação A, dois usos de `new` criam dois objetos. Na situação B, há um único objeto acessível por duas variáveis.

### Prevendo o comportamento

Antes de continuar, preveja o que será apresentado:

```java
ItemPedido item1 = new ItemPedido();
item1.quantidade = 2;

ItemPedido item2 = item1;
item2.quantidade = 7;

System.out.println(item1.quantidade);
```

Considere:

- qual valor será apresentado?
- quantos objetos existem?
- por que uma alteração feita usando `item2` pode ser observada usando `item1`?

O programa apresenta `7`. Existe um único objeto, e as duas variáveis mantêm referências para ele. A alteração feita por `item2` modifica o estado desse objeto; `item1` permite observar o mesmo estado.

### Identidade e estado

Agora temos dois usos de `new`:

```java
ItemPedido item1 = new ItemPedido();
item1.descricao = "Teclado";
item1.quantidade = 2;

ItemPedido item2 = new ItemPedido();
item2.descricao = "Teclado";
item2.quantidade = 2;
```

- **estado:** os valores que um objeto possui naquele momento;
- **identidade:** indica se estamos falando do mesmo objeto ou de objetos diferentes.

!!! info "Estado não determina identidade"

    Dois objetos podem possuir o mesmo estado e ainda assim serem objetos distintos.

### Verificando identidade com `==`

Com dois objetos diferentes:

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = new ItemPedido();

System.out.println(item1 == item2);
```

O resultado é `false`. Com duas referências para o mesmo objeto:

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = item1;

System.out.println(item1 == item2);
```

O resultado é `true`.

!!! tip "Java em foco — `==` e referências"

    Quando trabalhamos com referências a objetos, `==` verifica se duas referências apontam para o mesmo objeto. Neste contexto, ele verifica identidade; comparação de conteúdo será discutida posteriormente, quando houver necessidade.

## Atividade de compreensão

Antes de conferir os resultados, leia o código e faça suas previsões:

```java
ItemPedido a = new ItemPedido();
a.quantidade = 2;

ItemPedido b = a;

ItemPedido c = new ItemPedido();
c.quantidade = 2;

b.quantidade = 4;
```

Discuta com um colega:

1. Quantos objetos foram criados?
2. Quais serão os valores de `a.quantidade`, `b.quantidade` e `c.quantidade`?
3. Qual será o resultado de `a == b`?
4. Qual será o resultado de `a == c`?

Depois, explique os resultados usando as ideias de referência, identidade e estado. Esta atividade não é uma entrega formal.

## Transferência para outro domínio

Considere, sem implementar a classe `Conta`:

```java
Conta conta1 = new Conta();
Conta conta2 = conta1;
```

Se uma operação realizada usando `conta2` modificar esse objeto, o que será observado quando acessarmos o mesmo objeto por `conta1`? Explique usando o modelo de referências desenvolvido nesta aula.

## Síntese

- `new` cria um novo objeto;
- uma variável de tipo de classe mantém uma referência;
- atribuir uma referência a outra variável não cria um novo objeto;
- duas variáveis podem permitir acesso ao mesmo objeto;
- objetos diferentes podem possuir o mesmo estado;
- `==` verifica identidade quando comparamos referências.

## Preparação para a próxima aula

Na estrutura atual, diferentes partes do programa que têm acesso ao objeto também podem alterar diretamente seus campos. O código abaixo, por exemplo, é aceito:

```java
item.quantidade = -200;
```

Que problemas isso pode causar? Na Aula 04 — Protegendo o estado dos objetos, partiremos dessa necessidade. Ainda não vamos resolvê-la aqui.

## Material da aula

- [Laboratório 02 — Primeiros objetos em Java](laboratorio-02-primeiros-objetos-em-java.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
