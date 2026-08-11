---
icon: material/flask-outline
---

# Laboratório 01 — Java mínimo e problema inicial

Você já sabe programar: nosso objetivo não é reaprender programação, mas conhecer o mínimo necessário para começar a trabalhar com Java e implementar uma pequena solução usando o repertório que já possui.

Essa solução será o ponto de partida para uma discussão posterior sobre orientação a objetos.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode ser usada para esclarecer sintaxe, interpretar mensagens de erro, explicar uma construção e ajudar a compreender o problema. Não deve ser usada para gerar a solução completa da atividade.

!!! warning "Laboratório acompanhado — presença requerida"

    Este laboratório inclui acompanhamento e orientações durante sua realização.

## Objetivos

Ao final deste encontro, você deverá ser capaz de:

- verificar se o Java 25 está disponível no ambiente de desenvolvimento;
- compilar e executar um programa Java simples;
- reconhecer a estrutura mínima de um programa Java;
- mapear para Java construções básicas que já conhece;
- implementar uma pequena solução no estilo procedural;
- começar a identificar dados e operações que parecem pertencer juntos.

## Verificação do ambiente

Antes de iniciar a atividade principal, confirme que o Java está disponível fora da IDE. Se precisar instalar ou ajustar alguma ferramenta, consulte [Ambiente de Desenvolvimento](../materiais/ambiente-de-desenvolvimento.md).

No terminal, execute:

```bash
java --version
javac --version
```

Os dois comandos devem indicar a versão 25. Em seguida, crie um arquivo chamado `Main.java` com este conteúdo:

```java
public class Main {

    public static void main(String[] args) {
        System.out.println("Ambiente configurado!");
    }

}
```

No terminal, dentro da pasta em que o arquivo foi salvo, compile:

```bash
javac Main.java
```

Depois, execute:

```bash
java Main
```

O resultado esperado é:

```text
Ambiente configurado!
```

Mesmo que você use IntelliJ IDEA ou outra IDE, realize esta primeira compilação e execução pelo terminal. Depois da verificação, você poderá continuar usando normalmente os recursos de sua ferramenta.

## Conteúdo

### Parte 1 — Java mínimo operacional

O fluxo básico é:

**`Main.java` → `javac` → `Main.class` → JVM → execução**

O arquivo `.java` contém o código-fonte. O comando `javac` o compila e produz o arquivo `.class`, que pode ser executado pela JVM com o comando `java`. Por enquanto, basta compreender o fluxo básico: escrevemos o código-fonte, compilamos e executamos o programa. Os detalhes do funcionamento da plataforma Java não são necessários neste momento.

A estrutura mínima usada neste momento é:

```java
public class Main {

    public static void main(String[] args) {
        // o programa começa aqui
    }
}
```

> Não é necessário compreender ainda cada palavra de `public static void main(String[] args)`. Alguns desses elementos serão estudados progressivamente quando se tornarem relevantes para POO.

### Mapeamento rápido de C# para Java

| C# | Java |
| --- | --- |
| `string` | `String` |
| `bool` | `boolean` |
| `Console.WriteLine(x)` | `System.out.println(x)` |
| `int`, `double` | `int`, `double` |
| `if`, `else`, `for`, `while` | estruturas muito semelhantes |

> Você já conhece essas ideias. Neste momento estamos apenas aprendendo como expressá-las em Java.

### Parte 2 — Problema inicial

Uma loja precisa registrar um item de uma compra. Para cada item, conhecemos:

- descrição;
- preço unitário;
- quantidade.

O programa deve calcular o subtotal e exibi-lo no console. Use esta solução inicial como ponto de partida:

```java
public class Main {

    static double calcularSubtotal(double precoUnitario, int quantidade) {
        return precoUnitario * quantidade;
    }

    public static void main(String[] args) {

        String descricao = "Teclado";
        double precoUnitario = 150.0;
        int quantidade = 2;

        double subtotal =
            calcularSubtotal(precoUnitario, quantidade);

        System.out.println(descricao);
        System.out.println(subtotal);
    }
}
```

Esta solução permanece próxima do estilo procedural que você já conhece. Não vamos criar classes de domínio neste encontro.

## Atividade

Depois de verificar o ambiente, substitua o conteúdo de `Main.java` pela solução inicial da Parte 2 e execute o programa. Antes de modificá-lo, certifique-se de que consegue explicar o papel de cada trecho. Em seguida, experimente pequenas alterações nos valores.

### Incremento A — Segundo item

Adicione à compra um segundo item, com descrição, preço unitário e quantidade próprios.

Ao final desta etapa, o programa deve manter os dados dos dois itens e calcular corretamente o subtotal de cada um.

### Incremento B — Exibir a compra

Exiba no console os dados de cada item, incluindo:

- descrição;
- quantidade;
- preço unitário;
- subtotal.

Os valores exibidos devem corresponder aos dados daquele item.

### Incremento C — Total da compra

Calcule o valor total da compra e exiba-o no console. O total deve corresponder à soma dos subtotais dos itens armazenados.

Não há uma única forma obrigatória de organizar esses incrementos. É aceitável que a solução comece a apresentar repetição ou algum desconforto: observe o que acontece com o código à medida que o problema cresce.

!!! success "Critérios de conclusão"

    Verifique se você:

    - confirmou que `java` e `javac` estão disponíveis na versão 25;
    - compilou e executou pelo terminal o programa da verificação do ambiente;
    - concluiu uma solução principal que compila e executa;
    - armazenou dois itens com dados independentes;
    - calculou corretamente o subtotal de cada item;
    - exibiu no console os dados dos dois itens;
    - calculou e exibiu no console um total correspondente à soma dos subtotais;
    - realizou o envio conforme as orientações do Google Classroom;
    - formulou respostas para as questões propostas ao final do roteiro.

Depois de atender aos critérios e realizar o envio, você poderá ser liberado. O desafio a seguir permanece opcional.

## Desafio opcional — Mais itens, menos repetição

!!! tip "Quer aprofundar?"

    Concluiu a atividade principal? Use este desafio para explorar como organizar mais itens com menos repetição.

Agora, considere uma compra com **cinco itens**. Cada item possui descrição, preço unitário e quantidade.

O programa deve:

- manter os dados dos cinco itens;
- calcular corretamente o subtotal de cada item;
- exibir no console os dados e o subtotal de todos os itens;
- calcular o valor total da compra e exibi-lo no console.

> Evite simplesmente copiar cinco vezes o mesmo bloco de código. Utilize estruturas de programação que você já conhece para reduzir a repetição.

> Neste desafio, ainda não crie novas classes.

Você pode usar o repertório anterior que considerar adequado. Não há uma organização específica de código prescrita para o desafio.

!!! success "Critérios do desafio"

    Verifique se sua solução:

    - mantém cinco itens com dados independentes;
    - calcula corretamente o subtotal de cada item;
    - exibe no console os cinco itens;
    - calcula e exibe no console um total correspondente à soma dos cinco subtotais;
    - evita repetir manualmente cinco vezes o mesmo bloco de código.

!!! question "Para a próxima aula"

    Formule uma resposta para cada questão. Não é necessário entregá-las por escrito nem discuti-las coletivamente ao final do laboratório. Vamos retomá-las na Aula 02 — Do procedural aos objetos, incluindo as estratégias usadas no desafio opcional.

    1. Quais variáveis parecem representar partes de uma mesma coisa?
    2. O que acontece com a organização do código quando aumentamos o número de itens?
    3. Existe alguma maneira de manter os dados de um item e os comportamentos relacionados a ele mais próximos?

## Entrega

> **Projeto 1 — Versão 1: solução inicial**

O código produzido neste laboratório corresponde à primeira versão do Projeto 1. As práticas de laboratório farão esse projeto evoluir durante a Unidade 1. As orientações de submissão estarão no Google Classroom.

## Materiais relacionados

- [Ambiente de Desenvolvimento](../materiais/ambiente-de-desenvolvimento.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
- [Plano de Ensino](../plano-de-ensino.md)
