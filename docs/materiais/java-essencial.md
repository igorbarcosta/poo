# Java essencial para quem já sabe programar

Este material é uma referência rápida e incremental para quem já sabe programar e precisa consultar como determinadas construções são expressas em Java. Ele não pretende ser uma apostila completa: será ampliado ao longo da disciplina, conforme novos recursos da linguagem se tornarem necessários.

## Estrutura mínima de um programa

No primeiro laboratório, o programa começa assim:

```java
public class Laboratorio01 {

    public static void main(String[] args) {
        System.out.println("Olá, POO!");
    }
}
```

O nome do arquivo deve ser `Laboratorio01.java`, igual ao nome da classe pública. A execução começa no método `main`.

> Neste momento, trate essa assinatura como o ponto de entrada do programa. Elementos como `public`, `static` e os demais detalhes serão estudados quando se tornarem relevantes.

`{` e `}` delimitam blocos em Java, assim como em C. A indentação não define esses blocos, como ocorre principalmente em Python, mas continua importante para tornar o código legível.

## Compilação e execução

O Java 25 é o ambiente de referência da disciplina, mas as atividades iniciais não dependem de recursos exclusivos dessa versão. Uma versão recente diferente pode ser utilizada quando conseguir compilar e executar os projetos.

Quando o terminal estiver configurado, entre na pasta que contém `Laboratorio01.java` e execute:

```bash
javac Laboratorio01.java
java Laboratorio01
```

O comando `javac` compila o código-fonte e gera `Laboratorio01.class`. O comando `java Laboratorio01` executa o programa.

Se `javac` não estiver disponível no terminal, mas a IDE conseguir compilar e executar o programa, use **Run**. Em máquinas institucionais, não instale ou altere componentes do sistema sem autorização; se nenhum dos caminhos funcionar, informe o professor.

**Código-fonte → compilação → execução**

## Projeto, classe e arquivo

Crie ou abra um projeto Java e coloque a classe na área de código-fonte. Para a pasta do projeto, prefira nomes curtos, sem espaços ou acentos, como `poo-lab01`.

Quando uma classe é pública, o arquivo deve ter o mesmo nome:

```text
Laboratorio01.java
```

```java
public class Laboratorio01 {
}
```

Não é necessário declarar um `package` no primeiro laboratório.

## Ponte de Python e C para Java

| Conceito | Python | C | Java |
| --- | --- | --- | --- |
| inteiro | `x = 10` | `int x = 10;` | `int x = 10;` |
| saída | `print(x)` | `printf(...)` | `System.out.println(x);` |
| blocos | indentação | `{ }` | `{ }` |
| tipo da variável | normalmente não declarado | declarado | declarado |

Em Java, a declaração de uma variável informa explicitamente seu tipo. A tabela serve apenas como ponte para construções que você já conhece.

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

### `null` e valores padrão de campos

Campos numéricos recebem valores padrão quando um objeto é criado: `0` para `int` e `0.0` para `double`. Campos que guardam referências começam com `null`.

Como `String` é um tipo de referência, um campo ainda não inicializado pode começar assim:

```java
class ItemPedido {
    String descricao;       // null
    double precoUnitario;   // 0.0
    int quantidade;         // 0
}
```

`null` significa que a referência não aponta para nenhum objeto naquele momento. Outros efeitos e usos serão apresentados somente quando forem necessários.

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

Cada execução de `new ItemPedido()` cria uma nova instância. A criação com dados iniciais é detalhada na [Aula 05 — Construtores e estado inicial válido](../aulas/aula-05-construtores-e-estado-inicial-valido.md).

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

## Referências entre objetos

Um campo também pode usar uma classe como tipo e manter uma referência para outro objeto:

```java
class ItemPedido {
    private Produto produto;
    private int quantidade;

    public ItemPedido(Produto produto, int quantidade) {
        this.produto = produto;
        this.quantidade = quantidade;
    }

    public double calcularSubtotal() {
        return produto.getPreco() * quantidade;
    }
}
```

Na criação, o argumento `teclado` fornece uma referência ao parâmetro `produto`:

```java
Produto teclado = new Produto("Teclado", 150.0);
ItemPedido item = new ItemPedido(teclado, 2);
```

Passar o objeto como argumento não executa `new Produto(...)` nem cria automaticamente uma cópia. O campo do item e a variável `teclado` podem permitir acesso ao mesmo objeto `Produto`.

## Listas e percurso de objetos

`List<ItemPedido>` declara uma coleção em sequência cujos elementos são referências para objetos `ItemPedido`. `ArrayList` fornece uma implementação concreta dessa lista:

```java
import java.util.ArrayList;
import java.util.List;

private List<ItemPedido> itens;

public Pedido() {
    itens = new ArrayList<>();
}
```

Use `add` para guardar na lista a referência recebida:

```java
public void adicionarItem(ItemPedido item) {
    itens.add(item);
}
```

O `for` aprimorado percorre essas referências uma de cada vez:

```java
for (ItemPedido item : itens) {
    total += item.calcularSubtotal();
}
```

Leia: “para cada `ItemPedido`, chamado temporariamente de `item`, presente em `itens`”. Adicionar ou percorrer um elemento não cria automaticamente uma cópia do objeto.

O método `calcularSubtotal()` mostra uma colaboração simples: o item solicita ao produto o preço que pertence ao estado do produto e combina essa informação com sua própria quantidade.

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

## Construtores e estado inicial

Uma classe pode declarar quais dados devem ser fornecidos quando um objeto é criado:

```java
class ItemPedido {
    private String descricao;
    private double precoUnitario;
    private int quantidade;

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
}
```

O construtor possui o mesmo nome da classe, não declara tipo de retorno e é executado durante a criação:

```java
ItemPedido item = new ItemPedido("Teclado", 150.0, 2);
```

Na criação, `"Teclado"`, `150.0` e `2` são argumentos. No construtor, `descricao`, `precoUnitario` e `quantidade` são parâmetros que recebem esses valores.

Quando campo e parâmetro possuem o mesmo nome, `this` distingue o campo do objeto atual:

```java
this.descricao = descricao;
```

- `this.descricao`: campo do objeto atual;
- `descricao`: parâmetro recebido.

Neste exemplo, os campos numéricos só recebem valores não negativos. Caso contrário, permanecem com os valores padrão `0.0` e `0`. Essa regra simples protege o estado inicial sem introduzir ainda mecanismos de comunicação de erro.

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

### Exemplo com outra classe pública

A mesma relação entre classe pública e arquivo vale para as demais classes:

```java
public class ItemPedido {
}
```

Esse código deve estar em `ItemPedido.java`.
