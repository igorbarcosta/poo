# Aula 03 — Objetos, referências e identidade

No Laboratório 02, criamos objetos, alteramos seu estado e chamamos seus comportamentos. Para fazer tudo isso, usamos variáveis como `item1` e `item2`. Agora uma atribuição aparentemente simples vai nos obrigar a entender melhor o papel dessas variáveis.

**Slides:** [Apresentação HTML](../slides/rendered/aula-03-objetos-referencias-e-identidade.html) · [PDF](../slides/rendered/aula-03-objetos-referencias-e-identidade.pdf)

**Pergunta central**

> O que exatamente é copiado quando uma variável de objeto é atribuída a outra?

## Objetivos

Ao final deste encontro, você deverá ser capaz de:

- distinguir variável, referência, objeto e estado em exemplos simples;
- prever o efeito de atribuir uma variável de objeto a outra;
- explicar por que duas variáveis podem permitir acesso ao mesmo objeto;
- usar a presença de `new` para raciocinar sobre quantos objetos foram criados;
- distinguir estado de identidade;
- interpretar `==` entre referências como uma verificação de identidade;
- representar e explicar relações entre variáveis e objetos por meio de diagramas simples.

## Conteúdo

### Uma linha conhecida, seguida de outra

Começamos com uma instrução semelhante às usadas no Laboratório 02:

```java
ItemPedido item1 = new ItemPedido();
item1.quantidade = 2;
```

Até aqui, sabemos que `new ItemPedido()` cria um objeto e que `item1.quantidade` permite acessar parte de seu estado.

Agora acrescentamos uma segunda variável:

```java
ItemPedido item2 = item1;
```

Essa linha merece ser observada com cuidado. Não há uma nova expressão `new ItemPedido()`. Ainda assim, agora aparecem duas variáveis do tipo `ItemPedido`.

!!! activity "Atividade — antes de executar"

    Sem executar o código, formule uma previsão:

    1. Quantos objetos existem depois de `ItemPedido item2 = item1;`?
    2. Os dados do objeto foram copiados para um novo objeto?
    3. Se alterarmos `item2.quantidade`, o valor observado por `item1` continuará igual?

    Registre uma justificativa, mesmo que ainda não tenha certeza. A previsão será retomada depois da observação.

### Uma alteração aparece por outro nome

Complete o experimento:

```java
ItemPedido item1 = new ItemPedido();
item1.quantidade = 2;

ItemPedido item2 = item1;
item2.quantidade = 7;

System.out.println(item1.quantidade);
```

O valor exibido é:

```text
7
```

Esse resultado pode causar estranhamento. A alteração foi escrita usando `item2`, mas foi observada usando `item1`. Se imaginamos que a atribuição criou uma cópia independente do objeto, o resultado não faz sentido.

Precisamos então voltar à pergunta central: o que foi copiado para `item2`?

### Separando variável e objeto

Na instrução inicial, existem papéis diferentes:

```java
ItemPedido item1 = new ItemPedido();
```

- `ItemPedido` informa o tipo da variável;
- `item1` é a variável usada para acessar o objeto;
- `new ItemPedido()` cria o objeto.

A variável e o objeto não são a mesma coisa. Para expressar a relação entre eles, usamos a ideia de **referência**.

!!! conceito-chave "Conceito-chave — referência"

    Uma referência é um valor que permite localizar e acessar um objeto. Uma variável de tipo de classe pode manter esse valor.

Não precisamos transformar esse modelo em uma explicação sobre endereços físicos, heap ou detalhes internos da JVM. Neste momento, ele precisa apenas explicar corretamente o código que conseguimos observar.

Podemos representar a primeira instrução assim:

```text
item1 ─────► objeto ItemPedido
```

Quando executamos:

```java
ItemPedido item2 = item1;
```

o valor mantido em `item1` é atribuído a `item2`. Como esse valor é uma referência, as duas variáveis passam a permitir acesso ao mesmo objeto:

```text
item1 ──┐
        ├──► objeto ItemPedido
item2 ──┘     quantidade = 7
```

Agora podemos voltar ao resultado anterior. `item2.quantidade = 7` alterou o estado do único objeto existente. `item1.quantidade` observa esse mesmo estado.

!!! trap "Armadilha — outra variável, outro objeto"

    É tentador interpretar `ItemPedido item2 = item1;` como uma cópia independente do objeto. A instrução não executa `new`; ela copia a referência. Há duas variáveis, mas apenas um objeto.

### Contar variáveis não é contar objetos

Compare os dois cenários.

**Cenário A — uma criação**

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = item1;
```

```text
item1 ──┐
        ├──► objeto 1
item2 ──┘
```

**Cenário B — duas criações**

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = new ItemPedido();
```

```text
item1 ─────► objeto 1
item2 ─────► objeto 2
```

Nos dois cenários existem duas variáveis. O que muda é a quantidade de objetos criados: cada execução de `new ItemPedido()` cria um novo objeto.

Essa observação resolve uma parte do problema. Ainda precisamos distinguir situações em que os objetos possuem dados iguais.

### Estados iguais não respondem tudo

Considere duas criações:

```java
ItemPedido item1 = new ItemPedido();
item1.descricao = "Teclado";
item1.precoUnitario = 150.0;
item1.quantidade = 2;

ItemPedido item2 = new ItemPedido();
item2.descricao = "Teclado";
item2.precoUnitario = 150.0;
item2.quantidade = 2;
```

Os dois objetos possuem, neste momento, os mesmos valores de descrição, preço e quantidade. Isso nos permite dizer que seus estados são equivalentes para os campos observados.

Mas duas perguntas continuam diferentes:

1. os objetos possuem os mesmos valores?
2. as variáveis permitem acesso ao mesmo objeto?

A primeira pergunta trata de estado. A segunda exige outra ideia.

!!! conceito-chave "Conceito-chave — identidade"

    Identidade distingue um objeto dos demais. Objetos criados separadamente continuam distintos, mesmo quando possuem o mesmo estado.

No exemplo, há duas execuções de `new ItemPedido()`. Portanto, existem dois objetos com identidades diferentes. Alterar um deles não altera automaticamente o outro.

### Como responder se é o mesmo objeto?

Agora temos uma pergunta concreta para a linguagem Java:

> Como verificar se duas referências correspondem ao mesmo objeto?

Compare:

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = item1;
```

e:

```java
ItemPedido item1 = new ItemPedido();
ItemPedido item2 = new ItemPedido();
```

!!! java-focus "Java em foco — `==` entre referências"

    Neste contexto, `item1 == item2` verifica se as duas referências correspondem ao mesmo objeto.

    - duas referências para o mesmo objeto → `true`;
    - referências para objetos distintos → `false`.

    `==` não responde aqui se dois objetos possuem campos com valores iguais. Comparação de conteúdo será estudada quando essa necessidade aparecer.

No primeiro cenário, `item1 == item2` produz `true`, pois a referência foi copiada. No segundo, produz `false`, pois ocorreram duas criações.

### Aplicando o modelo completo

Agora reúna as ideias em um único trecho:

```java
ItemPedido a = new ItemPedido();
a.quantidade = 2;

ItemPedido b = a;

ItemPedido c = new ItemPedido();
c.quantidade = 2;

b.quantidade = 4;
```

!!! activity "Atividade — desenhar, prever e justificar"

    Em dupla, antes de qualquer execução:

    1. desenhem as variáveis e os objetos, usando setas para representar referências;
    2. indiquem quantos objetos foram criados;
    3. prevejam `a.quantidade`, `b.quantidade` e `c.quantidade`;
    4. prevejam `a == b` e `a == c`;
    5. justifiquem cada resposta usando `new`, referência, estado e identidade.

??? "Ver discussão"

    Há dois objetos porque aparecem duas execuções de `new`. `a` e `b` permitem acesso ao primeiro objeto, cuja quantidade termina em `4`; `c` permite acesso ao segundo, cuja quantidade permanece `2`. Assim, `a == b` é `true` e `a == c` é `false`.

### Transferindo para outro domínio

O modelo não depende de `ItemPedido`. Considere, sem implementar `Conta`:

```java
Conta contaPrincipal = new Conta();
Conta contaParaConsulta = contaPrincipal;
```

Se uma operação feita por `contaParaConsulta` alterar o objeto, a mudança também será observada por `contaPrincipal`, pois existe um único objeto acessível por duas referências.

Essa consequência será importante quando começarmos a decidir quem pode alterar o estado de um objeto.

## Síntese

!!! synthesis "Síntese — da atribuição à identidade"

    `new` cria um objeto; uma variável de tipo de classe mantém uma referência para acessá-lo. Atribuir essa variável a outra copia a referência, não o objeto. Por isso, duas variáveis podem observar o mesmo estado. Identidade distingue esse caso de dois objetos criados separadamente, e `==` responde se duas referências correspondem ao mesmo objeto.

Podemos recuperar a trajetória da aula:

**atribuição entre variáveis → alteração observada por ambas → referência → dois `new` → objetos distintos → identidade → `==`**

## Preparação para o laboratório

No Laboratório 03, você investigará esses dois cenários no Projeto 1. Para cada mudança, será necessário prever antes de executar, observar o resultado e explicá-lo com o modelo construído nesta aula.

## Questão em aberto

Se duas partes do programa possuem referências para o mesmo objeto, ambas conseguem alterar diretamente seus campos na estrutura atual:

```java
item.quantidade = -200;
```

Essa possibilidade cria a pergunta da Aula 04: se um objeto é responsável pelo próprio estado, qualquer parte do programa deveria poder modificá-lo diretamente?

## Material da aula

- [Laboratório 02 — Primeiros objetos em Java](laboratorio-02-primeiros-objetos-em-java.md)
- [Laboratório 03 — Referências e identidade na prática](laboratorio-03-referencias-e-identidade-na-pratica.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
