# Aula 05 — Construtores e estado inicial válido

Na Aula 04, protegemos alterações feitas depois que um objeto já existe. `ItemPedido` passou a controlar mudanças em sua quantidade, mas sua criação ainda depende de várias etapas externas. Agora vamos investigar o que pode acontecer antes mesmo da primeira alteração.

**Slides:** [Apresentação HTML](../slides/rendered/aula-05-construtores-e-estado-inicial-valido.html) · [PDF](../slides/rendered/aula-05-construtores-e-estado-inicial-valido.pdf)

!!! lesson-question "Pergunta central"

    Se um objeto precisa de certas informações para fazer sentido, por que permitimos que ele seja criado incompleto?

!!! lesson-objectives "Objetivos"

    Ao final deste estudo, você deverá ser capaz de:

    - diagnosticar os riscos de criar um objeto e configurá-lo em etapas separadas;
    - explicar como um construtor organiza o estado inicial de um objeto;
    - relacionar argumentos da criação, parâmetros do construtor e campos do objeto;
    - usar `this` somente quando for necessário distinguir um campo de um parâmetro;
    - justificar por que a própria classe deve proteger também a coerência do estado inicial.

<!-- bloco-didatico: 5.1 | estimativa: 20–25 min -->

## Em que momento o item passa a fazer sentido?

Ao final do laboratório anterior, conseguimos criar um item e impedir alterações negativas na quantidade. Uma parte da criação, porém, ainda pode aparecer assim:

```java
ItemPedido item = new ItemPedido();
item.descricao = "Teclado";
item.precoUnitario = 150.0;
item.aumentarQuantidade(2);
```

Leia a sequência linha por linha. Depois da primeira instrução, o objeto já existe. Seu estado naquele instante, contudo, ainda é este:

| Campo | Valor nesse momento |
| --- | --- |
| `descricao` | `null` |
| `precoUnitario` | `0.0` |
| `quantidade` | `0` |

!!! java-focus "Java em foco — `null` e valores padrão"

    - campos numéricos recebem valores padrão, como `0` para `int` e `0.0` para `double`;
    - campos que guardam referências começam com `null`;
    - `String` é um tipo de referência;
    - `null` significa que a referência não aponta para nenhum objeto naquele momento.

    Por enquanto, basta reconhecer esses valores no estado inicial. Outros efeitos e usos de `null` serão discutidos quando houver necessidade.

O objeto só chega aos dados pretendidos depois de três instruções adicionais. Logo depois de `new ItemPedido()`, ele existe para Java, mas possui `descricao == null`, preço `0.0` e quantidade `0`. Esse estado representa realmente o item que queremos usar?

### Criar agora, completar depois

Separar criação e preparação produz alguns riscos:

- uma etapa pode ser esquecida;
- as instruções podem aparecer em ordens diferentes;
- outro método pode receber o objeto antes de a preparação terminar;
- todo código que cria um item precisa conhecer os detalhes de como montá-lo;
- diferentes partes do programa podem adotar sequências incompatíveis.

Considere duas criações:

```java
ItemPedido itemA = new ItemPedido();
itemA.descricao = "Teclado";
itemA.precoUnitario = 150.0;
itemA.aumentarQuantidade(2);
```

```java
ItemPedido itemB = new ItemPedido();
itemB.descricao = "Mouse";
itemB.aumentarQuantidade(3);
```

!!! activity "Atividade — quando o objeto fica pronto?"

    Sem executar, compare as duas sequências e registre suas respostas antes de continuar.

    1. Depois de qual linha `itemA` possui todos os dados pretendidos?
    2. `itemB` chega ao mesmo ponto? Qual etapa ficou ausente?
    3. Qual dos dois poderia ser usado com mais segurança para calcular um subtotal?
    4. Se um método recebesse o objeto logo após o `new`, o que observaria?

O segundo trecho compila. O preço não foi informado, então `calcularSubtotal()` usa `0.0`. A linguagem não sabe que a preparação ficou incompleta; essa expectativa pertence ao nosso domínio.

Na Aula 04, nossa pergunta era quem controla as alterações posteriores. Agora o problema aparece antes: um objeto pode nascer e circular pelo programa sem as informações que lhe dão sentido.

!!! conceito-chave "Conceito-chave — estado inicial"

    Estado inicial é o conjunto de valores que um objeto possui quando sua criação termina. Proteger mudanças posteriores não basta quando a criação ainda permite estados inadequados ou incompletos.

Se já sabemos quais informações um `ItemPedido` precisa receber, por que não fornecê-las no próprio momento da criação?

<!-- bloco-didatico: 5.2 | estimativa: 25–30 min -->

## Criar também pode significar inicializar

Queremos substituir uma sequência dispersa por uma criação que declare os dados necessários:

```java
ItemPedido item = new ItemPedido("Teclado", 150.0, 2);
```

Agora a expressão de criação comunica três informações de uma vez: descrição, preço unitário e quantidade inicial. Para que essa forma exista, a classe precisa declarar como recebe esses valores.

```java
public class ItemPedido {
    String descricao;
    double precoUnitario;
    private int quantidade;

    public ItemPedido(String descricaoRecebida,
                      double precoRecebido,
                      int quantidadeRecebida) {
        descricao = descricaoRecebida;
        precoUnitario = precoRecebido;
        quantidade = quantidadeRecebida;
    }

    // demais métodos
}
```

O trecho com o mesmo nome da classe é o **construtor**. Ele é executado durante a criação de cada novo objeto e prepara seu estado inicial.

!!! conceito-chave "Conceito-chave — construtor"

    Um construtor define como o estado inicial de um objeto é preparado no momento de sua criação. A classe passa a explicitar aquilo de que o objeto precisa ao nascer, sem depender de uma sequência externa dispersa.

!!! java-focus "Java em foco — construtor"

    Um construtor:

    - possui o mesmo nome da classe;
    - não declara tipo de retorno, nem mesmo `void`;
    - pode receber parâmetros;
    - é executado quando a expressão `new` cria o objeto.

    Nesta aula, precisamos apenas dessa forma básica. Sobrecarga, encadeamento e outros recursos de construção ficam para quando houver um problema que os exija.

!!! trap "Armadilha — mas `new ItemPedido()` funcionava antes"

    Quando uma classe não declara nenhum construtor, Java fornece implicitamente um construtor sem argumentos. Depois que declaramos nosso construtor com três parâmetros, esse construtor implícito deixa de ser fornecido automaticamente.

    Por isso, `new ItemPedido()` deixa de corresponder ao construtor disponível e não compila. Agora a criação precisa fornecer os três argumentos exigidos pela classe.

### Valores fornecidos e valores recebidos

Compare a criação com a declaração do construtor:

```java
new ItemPedido("Teclado", 150.0, 2)
```

```java
public ItemPedido(String descricaoRecebida,
                  double precoRecebido,
                  int quantidadeRecebida)
```

Vamos acompanhar apenas `150.0` nessa execução:

- `150.0` é o **argumento** fornecido na chamada;
- `precoRecebido` é o **parâmetro** que recebe esse valor;
- `precoUnitario` é o **campo** em que o valor passa a fazer parte do estado do objeto.

```text
150.0 → precoRecebido → precoUnitario
```

De modo geral:

- **argumento:** valor ou expressão fornecida na chamada;
- **parâmetro:** variável declarada pelo construtor para receber o valor;
- **campo:** parte do estado do objeto em que esse valor pode ser armazenado.

**argumento → parâmetro → campo**

Cada execução pode fornecer argumentos diferentes:

```java
ItemPedido teclado = new ItemPedido("Teclado", 150.0, 2);
ItemPedido mouse = new ItemPedido("Mouse", 80.0, 3);
```

O construtor é o mesmo, mas cada objeto recebe e mantém seu próprio estado.

### Quando os nomes coincidem

Nomes como `descricaoRecebida` tornam a distinção explícita, mas é comum que o parâmetro tenha o mesmo nome do campo que alimenta:

```java
public ItemPedido(String descricao,
                  double precoUnitario,
                  int quantidade) {
    this.descricao = descricao;
    this.precoUnitario = precoUnitario;
    this.quantidade = quantidade;
}
```

Agora existem duas coisas chamadas `descricao`: o campo do objeto e o parâmetro recebido. Precisamos indicar qual está de cada lado da atribuição.

- `this.descricao` é o campo do objeto atual;
- `descricao` é o parâmetro recebido pelo construtor.

O mesmo vale para preço e quantidade. `this` aparece porque surgiu uma ambiguidade concreta de nomes; não precisamos explorar outros usos agora.

!!! tip "Dica — siga o valor"

    Para entender uma construção, escolha um valor da chamada, localize o parâmetro que o recebe e veja em qual campo ele é armazenado:

    ```text
    150.0 → precoUnitario → this.precoUnitario
    ```

!!! activity "Atividade — acompanhe a criação"

    Considere:

    ```java
    new ItemPedido("Mouse", 80.0, 3)
    ```

    1. Qual será o estado do objeto ao final da execução do construtor?
    2. O que aconteceria se escrevêssemos `descricao = descricao;` em vez de `this.descricao = descricao;`?
    3. Em `descricao = descricao;`, a qual `descricao` cada lado se refere?

    Registre uma hipótese antes de reler a explicação sobre o papel de `this`.

O construtor resolveu o risco de esquecer uma etapa externa: a criação agora exige os três argumentos. Mas exigir dados e receber dados corretos não são a mesma coisa.

Considere:

```java
ItemPedido item = new ItemPedido("", -100.0, -4);
```

Todos os argumentos foram fornecidos. Isso significa que o objeto necessariamente nasceu em um estado aceitável?

<!-- bloco-didatico: 5.3 | estimativa: 20–25 min -->

## Receber todos os dados não garante coerência

O construtor anterior copia os valores sem avaliar o que eles significam. Para Java, `-100.0` é um `double` e `-4` é um `int`; os tipos estão corretos. Para `ItemPedido`, preço e quantidade negativos continuam representando estados inadequados.

A situação retoma o princípio da Aula 04. Antes, impedimos uma alteração negativa depois da criação. Agora a classe precisa aplicar sua responsabilidade enquanto prepara o estado inicial.

### Regras simples para começar

Vamos trabalhar com duas regras compatíveis com o repertório atual:

- preço unitário não pode ser negativo;
- quantidade não pode ser negativa.

O valor `0` permanece aceito nesta etapa. Isso preserva os valores padrão já conhecidos e concentra a discussão em impedir estados negativos. A validação textual da descrição exige decisões adicionais e não será aprofundada agora.

Podemos manter os valores padrão quando um argumento numérico for inválido:

```java
public ItemPedido(String descricao,
                  double precoUnitario,
                  int quantidade) {
    this.descricao = descricao;

    if (precoUnitario >= 0) {
        this.precoUnitario = precoUnitario;
    }

    if (quantidade >= 0) {
        this.quantidade = quantidade;
    }
}
```

Se o preço recebido for negativo, o campo permanece em `0.0`. Se a quantidade recebida for negativa, o campo permanece em `0`. A classe não aceita esses valores em seu estado.

Essa estratégia não comunica ao código externo que um argumento foi rejeitado. Assim como ocorreu com `aumentarQuantidade(-10)`, primeiro estamos aprendendo a preservar a regra; formas de comunicar falhas serão discutidas quando tivermos repertório para isso.

!!! activity "Atividade — onde a regra deve ficar?"

    Nosso foco ainda não é decidir como comunicar um erro, rejeitar a criação ou exibir uma mensagem. Compare somente **quem conhece e deve preservar as regras de `ItemPedido`**.

    **Proposta A — cada cliente tenta preservar a regra**

    ```java
    double precoInicial = 0.0;
    if (preco >= 0) {
        precoInicial = preco;
    }

    int quantidadeInicial = 0;
    if (quantidade >= 0) {
        quantidadeInicial = quantidade;
    }

    ItemPedido item =
        new ItemPedido(descricao, precoInicial, quantidadeInicial);
    ```

    **Proposta B — a classe preserva a regra em todo ponto de criação**

    ```java
    ItemPedido item = new ItemPedido(descricao, preco, quantidade);
    ```

    Na proposta B, considere o construtor já mostrado, que só incorpora preço e quantidade quando os valores são não negativos.

    1. O que acontece se outro trecho esquecer a verificação da proposta A?
    2. Qual proposta concentra a regra em todos os pontos de criação?
    3. Quem conhece melhor os estados aceitáveis de `ItemPedido`?

    Escolha uma proposta e justifique sua decisão com base em quem conhece e deve preservar a regra. Não compare ainda políticas de comunicação da falha.

!!! conceito-chave "Conceito-chave — invariante"

    Uma invariante é uma regra que deve permanecer verdadeira para o estado do objeto. Nesta etapa, `precoUnitario >= 0` e `quantidade >= 0` são invariantes simples de `ItemPedido`.

    A classe protege essas regras tanto durante a criação quanto nas mudanças posteriores.

O construtor organiza a criação; a validação impede que os argumentos sejam copiados cegamente; a responsabilidade permanece com o objeto.

## A ideia continua em outro domínio?

Usamos `ItemPedido` porque ele dá continuidade ao projeto. Para verificar se compreendemos a ideia, vamos transferi-la sem implementar outra classe completa.

<!-- aprofundamento-elastico -->

Considere uma `Reserva` que precisa nascer com um número de pessoas e um valor de diária:

```java
Reserva reserva = new Reserva(4, 180.0);
```

Antes da síntese, registre respostas para estas perguntas:

1. quais informações a reserva precisa receber na criação?
2. uma reserva para `-2` pessoas deveria ser possível?
3. uma diária negativa deveria fazer parte do estado?
4. quem deveria proteger essas regras?
5. que resultado rápido mostraria que a proteção funcionou?

Não desenvolva a implementação completa. A transferência serve para testar se a responsabilidade pelo estado inicial continua fazendo sentido fora de `ItemPedido`.

## Fechando a trajetória

!!! synthesis "Síntese"

    Antes, criávamos um objeto e depois tentávamos colocá-lo em ordem. Agora, a própria classe pode declarar aquilo de que o objeto precisa para começar a existir e pode impedir que valores incompatíveis sejam incorporados ao estado inicial.

    - o problema da criação incompleta produz a necessidade do construtor;
    - argumentos fornecem valores aos parâmetros da criação;
    - o construtor usa esses valores para preparar os campos;
    - `this` distingue o campo do objeto do parâmetro com o mesmo nome;
    - invariantes simples orientam quais valores podem fazer parte do estado inicial.

Até aqui, cada `ItemPedido` cuida de si. Um `Pedido`, porém, precisa trabalhar com vários itens. Quem deve cuidar dessa colaboração e do conjunto formado por eles?

## Material da aula

- [Aula 04 — Protegendo o estado dos objetos](aula-04-protegendo-o-estado-dos-objetos.md)
- [Laboratório 05 — Construindo objetos em estado válido](laboratorio-05-construindo-objetos-em-estado-valido.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
