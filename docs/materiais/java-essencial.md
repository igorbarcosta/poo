# Java essencial para quem já sabe programar

Este material é uma referência rápida e incremental para quem já sabe programar e precisa consultar como determinadas construções são expressas em Java. Ele não pretende ser uma apostila completa: será ampliado ao longo da disciplina, conforme novos recursos da linguagem se tornarem necessários.

## Estrutura mínima de um programa

Um programa Java simples pode começar assim:

```java
public class Main {

    public static void main(String[] args) {
        System.out.println("Olá, POO!");
    }
}
```

O nome do arquivo deve ser `Main.java`, igual ao nome da classe pública. A execução começa no método `main`.

> Não é necessário compreender imediatamente cada elemento de `public static void main(String[] args)`. Eles serão estudados quando se tornarem relevantes.

## Compilação e execução

No terminal, dentro da pasta que contém `Main.java`, execute:

```bash
javac Main.java
java Main
```

O comando `javac` compila o código-fonte e gera `Main.class`. O comando `java Main` executa o programa.

**Código-fonte → compilação → execução**

## Saída no terminal

Use `System.out.println` para exibir um valor no console e terminar a linha:

```java
System.out.println("Olá!");
System.out.println(42);
```

## Tipos básicos mais comuns

```java
int quantidade = 2;
double preco = 150.0;
boolean disponivel = true;
char categoria = 'A';
```

- `int`: números inteiros;
- `double`: números reais;
- `boolean`: `true` ou `false`;
- `char`: um caractere, escrito entre aspas simples.

## String

Textos são representados pelo tipo `String` e escritos entre aspas duplas:

```java
String descricao = "Teclado";
System.out.println(descricao);
```

Observe que `String` começa com letra maiúscula.

## Métodos simples

Um método pode receber valores, realizar uma operação e devolver um resultado:

```java
static double calcularSubtotal(double precoUnitario, int quantidade) {
    return precoUnitario * quantidade;
}
```

Uma chamada a esse método pode ser feita assim:

```java
double subtotal = calcularSubtotal(150.0, 2);
```

O uso de `static` será explicado com mais cuidado posteriormente. Neste momento, ele permite chamar o método diretamente a partir do `main`.

## Classes e primeiros objetos

Uma classe pode reunir campos e métodos relacionados:

```java
class ItemPedido {
    String descricao;
    double precoUnitario;
    int quantidade;

    double calcularSubtotal() {
        return precoUnitario * quantidade;
    }
}
```

Os campos mantêm o estado de cada objeto. O método de instância pode acessar esse estado diretamente.

Use `new` para criar um objeto e o operador `.` para acessar seus campos e chamar seus métodos:

```java
ItemPedido item = new ItemPedido();
item.descricao = "Teclado";
item.precoUnitario = 150.0;
item.quantidade = 2;

double subtotal = item.calcularSubtotal();
```

Cada execução de `new ItemPedido()` cria uma nova instância. Construtores serão detalhados posteriormente.

## Referências e identidade

Uma variável de tipo de classe mantém uma referência que permite acessar um objeto. `new` cria um novo objeto:

```java
ItemPedido item1 = new ItemPedido();
```

Atribuir essa variável a outra copia a referência, não o objeto:

```java
ItemPedido item2 = item1;
```

Agora, `item1` e `item2` permitem acessar o mesmo objeto. Uma alteração feita por uma delas pode ser observada pela outra.

Para referências, `==` verifica se as duas variáveis apontam para o mesmo objeto:

```java
System.out.println(item1 == item2); // true
```

Dois objetos criados por expressões `new` diferentes possuem identidades diferentes, mesmo quando mantêm o mesmo estado.

## Controle de acesso e alteração do estado

### `private` e `public`

- `private` restringe o acesso ao interior da própria classe;
- `public` disponibiliza uma operação para uso externo.

Uma classe pode proteger um campo e continuar usando esse estado em seus próprios métodos:

```java
class ItemPedido {
    private int quantidade;

    public int getQuantidade() {
        return quantidade;
    }

    public void aumentarQuantidade(int unidades) {
        if (unidades > 0) {
            quantidade += unidades;
        }
    }
}
```

`getQuantidade()` consulta o valor atual. `aumentarQuantidade(...)` representa uma alteração e pode controlar quando ela deve acontecer. As duas operações possuem funções diferentes.

Neste exemplo, o campo `int quantidade` começa com `0` quando nenhum valor foi atribuído explicitamente.

## Estilo e convenções essenciais

### Nomes

- classes normalmente usam **PascalCase**: `ItemPedido`, `ContaBancaria`;
- métodos, variáveis e campos normalmente usam **camelCase**: `calcularSubtotal`, `precoUnitario`;
- Java diferencia maiúsculas de minúsculas: `ItemPedido` e `itemPedido` não são o mesmo identificador;

### Instruções e blocos

- nas instruções apresentadas, `;` indica o final da instrução;
- `{` e `}` delimitam blocos; a indentação consistente torna esses blocos legíveis;
- uma instrução pode ser quebrada em mais de uma linha para facilitar a leitura.

Por exemplo, estas formas representam a mesma instrução:

```java
double subtotal = precoUnitario * quantidade;
```

```java
double subtotal =
    precoUnitario * quantidade;
```

### Classe pública e arquivo

Quando uma classe é pública, o arquivo deve ter o mesmo nome:

```java
public class ItemPedido {
}
```

Esse código deve estar em `ItemPedido.java`.

## Mapeamento rápido de C# para Java

| C# | Java |
| --- | --- |
| `string` | `String` |
| `bool` | `boolean` |
| `Console.WriteLine(x)` | `System.out.println(x)` |
| `int`, `double` | `int`, `double` |
| `if`, `else`, `for`, `while` | estruturas muito semelhantes |

Você já conhece essas ideias. Use esta tabela apenas como apoio para começar a expressá-las em Java.
