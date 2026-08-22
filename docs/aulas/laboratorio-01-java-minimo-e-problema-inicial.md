# Laboratório 01 — Java mínimo e problema inicial

Você já sabe programar: nosso objetivo não é reaprender programação, mas conhecer o mínimo necessário para começar a trabalhar com Java e implementar uma pequena solução usando o repertório que já possui.

Essa solução será o ponto de partida para uma discussão posterior sobre orientação a objetos.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode ser usada para esclarecer sintaxe, interpretar mensagens de erro, explicar uma construção e ajudar a compreender o problema. Não deve ser usada para gerar a solução completa da atividade.

!!! warning "Laboratório acompanhado — presença requerida"

    Este laboratório inclui acompanhamento e orientações durante sua realização.

## Objetivos

Ao final deste encontro, você deverá ser capaz de:

- verificar se o ambiente consegue compilar e executar um programa Java;
- reconhecer a estrutura mínima de um programa Java;
- mapear para Java construções básicas que já conhece em Python e C;
- implementar uma pequena solução no estilo procedural;
- começar a identificar dados e operações que parecem pertencer juntos.

## Preparando o projeto

Antes de escrever o código da atividade:

1. crie uma pasta para este laboratório, como `poo-lab01`;
2. coloque `Laboratorio01.java` dentro dessa pasta;
3. abra **a pasta do projeto** na IDE, não apenas o arquivo isolado;
4. selecione uma JDK disponível na máquina;
5. execute o programa pela IDE ou pelo terminal, conforme o ambiente disponível.

Para a pasta do projeto, prefira um nome curto e identificável, como `poo-lab01`. Evite espaços e acentos. Não é necessário declarar um `package` neste laboratório.

!!! tip "Dica — abra a pasta do projeto"

    No VS Code, entre na pasta e use `code .` quando esse comando estiver disponível. Em outras IDEs, escolha **Abrir pasta** ou **Abrir projeto**. Manter todos os arquivos do laboratório na mesma pasta evita dificuldades quando novas classes aparecerem nos próximos encontros.

## Verificação do ambiente

O Java 25 é o ambiente de referência da disciplina, mas estas atividades iniciais não usam recursos exclusivos dessa versão. Se uma versão recente diferente conseguir compilar e executar os projetos, continue a atividade normalmente.

### Caminho A — terminal

Quando os comandos estiverem disponíveis, verifique as versões instaladas:

```bash
java --version
javac --version
```

Em `Laboratorio01.java`, escreva:

```java
public class Laboratorio01 {

    public static void main(String[] args) {
        System.out.println("Ambiente configurado!");
    }

}
```

Na pasta que contém o arquivo, compile e execute:

```bash
javac Laboratorio01.java
java Laboratorio01
```

O resultado esperado é:

```text
Ambiente configurado!
```

### Caminho B — IDE

Se `javac` não estiver disponível no terminal, mas IntelliJ IDEA ou VS Code conseguirem compilar e executar o programa, use o comando **Run** da IDE e continue a atividade.

Em uma máquina institucional, não tente instalar ou alterar componentes do sistema sem autorização. Se nem o terminal nem a IDE funcionarem, informe o problema ao professor. Para orientações adicionais, consulte [Ambiente de Desenvolvimento](../materiais/ambiente-de-desenvolvimento.md).

## Conteúdo

### Parte 1 — Java mínimo operacional

Quando o terminal está configurado, o fluxo básico é:

**`Laboratorio01.java` → `javac` → `Laboratorio01.class` → JVM → execução**

O arquivo `.java` contém o código-fonte. O comando `javac` o compila e produz o arquivo `.class`, que pode ser executado pela JVM com o comando `java`. A IDE automatiza esse mesmo fluxo quando você usa **Run**.

Por enquanto, basta compreender que escrevemos o código-fonte, compilamos e executamos o programa. Os detalhes internos da plataforma Java não são necessários neste momento.

### Antes de escrever o primeiro programa

#### Tipos e instruções

Compare a declaração de uma variável nas linguagens que você já conhece:

=== "Python"

    ```python
    quantidade = 2
    ```

=== "C"

    ```c
    int quantidade = 2;
    ```

=== "Java"

    ```java
    int quantidade = 2;
    ```

Em Java, a declaração informa explicitamente o tipo da variável. Muitas instruções Java terminam com `;`:

```java
int quantidade = 2;
double precoUnitario = 150.0;
System.out.println(quantidade);
```

#### Blocos e ponto de entrada

```java
public class Laboratorio01 {

    public static void main(String[] args) {
        int quantidade = 2;
        System.out.println(quantidade);
    }
}
```

- `{` e `}` delimitam blocos de código em Java, assim como em C;
- Python usa principalmente a indentação para definir blocos;
- em Java, a indentação não delimita o bloco, mas continua essencial para a legibilidade.

Neste momento, trate `public static void main(String[] args)` como o ponto de entrada do programa. Elementos como `public`, `static` e os demais detalhes serão compreendidos progressivamente quando tiverem função no curso.

#### Nomes e arquivos

Se uma classe pública se chama `Laboratorio01`, o arquivo deve se chamar `Laboratorio01.java`:

```text
Laboratorio01.java
```

```java
public class Laboratorio01 {
}
```

Use estas convenções iniciais:

- **classes:** começam com letra maiúscula e usam PascalCase, como `Laboratorio01`, `ItemPedido` e `Conta`;
- **variáveis:** começam com letra minúscula e usam camelCase, como `quantidade`, `precoUnitario` e `itemPedido`.

### Parte 2 — Problema inicial

Uma loja precisa registrar um item de uma compra. Para cada item, conhecemos:

- descrição;
- preço unitário;
- quantidade.

O programa deve calcular o subtotal e exibi-lo no console. Use esta solução inicial como ponto de partida:

```java
public class Laboratorio01 {

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

Depois de verificar o ambiente, substitua o conteúdo de `Laboratorio01.java` pela solução inicial da Parte 2 e execute o programa. Antes de modificá-lo, certifique-se de que consegue explicar o papel de cada trecho. Em seguida, experimente pequenas alterações nos valores.

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

    - confirmou que uma versão recente do Java funciona no ambiente disponível;
    - compilou e executou o programa inicial pelo terminal ou pela IDE;
    - concluiu uma solução principal que compila e executa;
    - armazenou dois itens com dados independentes;
    - calculou corretamente o subtotal de cada item;
    - exibiu no console os dados dos dois itens;
    - calculou e exibiu no console um total correspondente à soma dos subtotais;
    - realizou o envio conforme as orientações do [Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5);
    - formulou respostas para as questões propostas ao final do roteiro.

Depois de atender aos critérios e realizar o envio, você poderá ser liberado. O desafio a seguir permanece opcional.

## Desafio opcional — Mais itens, menos repetição

!!! tip "Dica — desafio opcional"

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

### Para a próxima aula

Formule uma resposta para cada questão. Não é necessário entregá-las por escrito nem discuti-las coletivamente ao final do laboratório. Vamos retomá-las na Aula 02 — Do procedural aos objetos, incluindo as estratégias usadas no desafio opcional.

1. Quais variáveis parecem representar partes de uma mesma coisa?
2. O que acontece com a organização do código quando aumentamos o número de itens?
3. Existe alguma maneira de manter os dados de um item e os comportamentos relacionados a ele mais próximos?

## Entrega

> **Projeto 1 — Versão 1: solução inicial**

O código produzido neste laboratório corresponde à primeira versão do Projeto 1. As práticas de laboratório farão esse projeto evoluir durante a Unidade 1. As orientações de submissão estarão no [Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).

## Materiais relacionados

- [Ambiente de Desenvolvimento](../materiais/ambiente-de-desenvolvimento.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
- [Plano de Ensino](../plano-de-ensino.md)
