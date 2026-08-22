# Laboratório 05 — Construindo objetos em estado válido

Na Versão 4 do Projeto 1, `ItemPedido` passou a controlar alterações em sua quantidade. Nesta evolução, a própria classe também deverá organizar aquilo que cada objeto recebe quando é criado e impedir valores numéricos negativos no estado inicial.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode:

    - esclarecer a sintaxe de construtores, parâmetros e `this`;
    - ajudar a interpretar erros de compilação;
    - fazer perguntas que apoiem a comparação entre previsão e resultado.

    Ela não deve gerar a solução completa, tomar as decisões por você nem introduzir recursos ainda não estudados.

!!! warning "Laboratório acompanhado — presença requerida"

    Este laboratório é acompanhado porque altera a forma de criação dos objetos e exige adaptar os pontos do programa que dependiam da preparação em várias etapas.

## Objetivos

Ao final deste laboratório, você deverá ser capaz de:

- criar um construtor que recebe o estado inicial de `ItemPedido`;
- adaptar o código cliente à nova forma de criação;
- impedir que código externo configure diretamente os campos;
- preservar invariantes numéricas simples durante a criação;
- verificar que objetos diferentes continuam recebendo estados independentes.

## Projeto 1 — Versão 5: criação coerente

Parta da **Versão 4** concluída no Laboratório 04. Preserve o cenário com:

- `itemPrincipal` e `itemObservado`, que acessam o mesmo objeto;
- `itemIndependente`, criado por outra execução de `new ItemPedido()`;
- `calcularSubtotal()`, `aumentarQuantidade(int unidades)` e `getQuantidade()` funcionando;
- a regra que ignora aumentos com valores menores ou iguais a zero.

Crie uma cópia da versão anterior para trabalhar nesta evolução e mantenha `Main.java` e `ItemPedido.java` na mesma pasta de projeto.

O novo requisito é:

> Todo `ItemPedido` deve receber descrição, preço unitário e quantidade no momento da criação. Preço e quantidade negativos não podem fazer parte de seu estado inicial.

## Como conduzir a investigação

Em cada incremento, use como referência:

**prever → modificar → executar → observar → compreender**

Faça previsões breves antes da mudança e compare-as com o resultado. Elas podem ficar em papel, rascunho ou conversa com sua dupla e com o professor. Você entregará somente o código final solicitado.

## Evolução do projeto

### Incremento A — Fazer a classe exigir os dados iniciais

Em `ItemPedido`, adicione um construtor que receba:

- `String descricao`;
- `double precoUnitario`;
- `int quantidade`.

Use os parâmetros para inicializar os campos. Quando o parâmetro e o campo tiverem o mesmo nome, use `this` para indicar o campo do objeto atual:

```java
public ItemPedido(String descricao,
                  double precoUnitario,
                  int quantidade) {
    this.descricao = descricao;
    this.precoUnitario = precoUnitario;
    this.quantidade = quantidade;
}
```

Antes de compilar, preveja o que acontecerá com as expressões `new ItemPedido()` existentes em `Main`.

Compile sem corrigir essas criações ainda. Observe as linhas indicadas pelo compilador e confirme se o erro está relacionado aos três argumentos que o construtor passou a exigir.

Ao final deste incremento, `ItemPedido` possui uma nova forma obrigatória de criação. O projeto pode permanecer temporariamente sem compilar; essa quebra torna visíveis todos os clientes que ainda dependem da criação vazia.

### Incremento B — Adaptar os pontos de criação

Agora modifique cada expressão `new ItemPedido()` em `Main` para fornecer descrição, preço unitário e quantidade.

Por exemplo, uma criação que antes era preparada em várias etapas:

```java
ItemPedido itemPrincipal = new ItemPedido();
itemPrincipal.descricao = "Teclado";
itemPrincipal.precoUnitario = 150.0;
itemPrincipal.aumentarQuantidade(5);
```

passa a ser:

```java
ItemPedido itemPrincipal =
    new ItemPedido("Teclado", 150.0, 5);
```

Adapte também `itemIndependente`, preservando os dados e o estado final que sua Versão 4 já utilizava. Não execute outro `new` para `itemObservado`: ele deve continuar recebendo a referência de `itemPrincipal`.

Remova as instruções que existiam apenas para preparar descrição, preço e quantidade logo após cada criação. Preserve as chamadas posteriores que realmente representam mudanças do projeto ou verificações das regras.

Execute e confirme:

- o projeto volta a compilar;
- `itemPrincipal == itemObservado` continua produzindo `true`;
- `itemPrincipal == itemIndependente` continua produzindo `false`;
- quantidades e subtotais iniciais permanecem equivalentes aos da Versão 4;
- cada criação ficou completa em uma única expressão.

Antes de avançar, você deve conseguir explicar por que adicionar um construtor exigiu mudanças em `Main` sem mudar a identidade dos objetos.

### Incremento C — Impedir a preparação direta por código externo

O construtor organiza a criação, mas `descricao` e `precoUnitario` ainda podem estar expostos em sua versão. Torne privados os três campos de `ItemPedido`:

```java
private String descricao;
private double precoUnitario;
private int quantidade;
```

Preserve `getQuantidade()` e adicione operações públicas de consulta para descrição e preço unitário:

```java
public String getDescricao() {
    return descricao;
}

public double getPrecoUnitario() {
    return precoUnitario;
}
```

Procure em `Main` qualquer leitura direta dos campos que acabou de proteger e substitua-a pela operação de consulta correspondente. Não crie setters.

Compile e execute novamente. Verifique que:

- `Main` não acessa diretamente nenhum campo de `ItemPedido`;
- os dados ainda podem ser consultados e exibidos;
- o subtotal continua sendo calculado pelo próprio item;
- alterações de quantidade continuam passando por `aumentarQuantidade(...)`.

Ao final deste incremento, o código externo não precisa conhecer uma sequência de atribuições nem pode reabrir diretamente o estado que a classe passou a organizar.

### Incremento D — Proteger também o estado inicial

Até agora, o construtor copia qualquer valor numérico recebido. Antes de editar, preveja o estado criado por:

```java
new ItemPedido("Teste", -10.0, -2)
```

Evolua o construtor para copiar preço e quantidade somente quando forem não negativos:

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

Para verificar a mudança, altere temporariamente os argumentos numéricos de uma das criações em `Main` para valores negativos, execute e consulte o estado. O preço deve permanecer em `0.0` e a quantidade em `0`, seus valores padrão. Em seguida, restaure os argumentos válidos que pertencem ao estado final do projeto.

Execute novamente e confirme:

- os objetos com argumentos válidos preservam os valores recebidos;
- argumentos negativos não entram no estado;
- `aumentarQuantidade(-10)` continua mantendo a quantidade atual;
- objetos distintos continuam com estados independentes.

A modificação permanente deste incremento está no construtor. A troca temporária de argumentos serve apenas para verificar a regra e não precisa permanecer no código entregue.

Antes de avançar, você deve conseguir explicar por que validar apenas em `Main` deixaria outros pontos de criação responsáveis por repetir ou lembrar a mesma regra.

!!! success "Critérios de conclusão"

    Verifique se o código final:

    - compila e executa sem erros;
    - parte da Versão 4 e preserva o cenário de referências compartilhadas e objeto independente;
    - declara um construtor com descrição, preço unitário e quantidade;
    - usa `this` para distinguir os campos dos parâmetros com mesmo nome;
    - cria todos os objetos com os três argumentos necessários;
    - remove as sequências externas que existiam apenas para preparar o estado inicial;
    - mantém os três campos privados;
    - oferece consultas públicas para descrição, preço e quantidade;
    - preserva `calcularSubtotal()` e `aumentarQuantidade(int unidades)`;
    - impede preço e quantidade negativos no estado inicial;
    - preserva os estados e resultados esperados para argumentos válidos;
    - mantém `itemPrincipal` e `itemObservado` acessando o mesmo objeto;
    - mantém `itemIndependente` acessando outro objeto.

### Antes de entregar, você deve conseguir explicar

- por que a criação em várias etapas permitia objetos incompletos;
- o caminho argumento → parâmetro → campo;
- por que `this.descricao` e `descricao` não representam a mesma coisa no construtor;
- por que a classe, e não cada trecho de `Main`, deve preservar as regras da criação;
- como construtor e métodos de alteração protegem momentos diferentes da vida do objeto.

Essas explicações podem ser demonstradas oralmente durante o acompanhamento e não precisam ser enviadas.

## Para consolidar

Considere uma classe `Pedido` que futuramente precisará reunir vários itens:

1. de quais informações um pedido precisa quando nasce?
2. um pedido precisa nascer com itens ou pode começar vazio?
3. quem deveria controlar a entrada e a retirada de itens?

Não implemente `Pedido` ainda e não entregue respostas escritas. Essas perguntas preparam a próxima etapa do projeto.

## Entrega

> **Projeto 1 — Versão 5: criação coerente**

Entregue somente os arquivos de código-fonte da **Versão 5**, conforme as orientações disponíveis no [Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).

Não envie previsões, respostas, tabelas, prints, diagramas, mensagens de erro ou reflexões por escrito.

## Materiais relacionados

- [Aula 05 — Construtores e estado inicial válido](aula-05-construtores-e-estado-inicial-valido.md)
- [Laboratório 04 — Controlando alterações de estado](laboratorio-04-controlando-alteracoes-de-estado.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
