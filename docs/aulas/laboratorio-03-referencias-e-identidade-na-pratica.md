---
icon: material/flask-outline
---

# Laboratório 03 — Referências e identidade na prática

No Laboratório 02, cada variável foi usada para trabalhar com um objeto diferente. Nesta evolução do Projeto 1, vamos mudar uma única relação: duas variáveis passarão a permitir acesso ao mesmo `ItemPedido`. A partir daí, cada resultado observado criará a pergunta do experimento seguinte.

**Pergunta prática**

> Como distinguir, no código e nos resultados, duas referências para o mesmo objeto de referências para objetos distintos?

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode esclarecer sintaxe, ajudar a interpretar mensagens de erro e fazer perguntas que apoiem sua explicação. Não deve gerar a solução completa nem responder às previsões antes da execução.

!!! warning "Laboratório acompanhado — presença requerida"

    Este laboratório é acompanhado porque investiga um modelo mental que será necessário nas próximas evoluções do projeto.

## Objetivos

Ao final deste laboratório, você deverá ser capaz de:

- formular previsões antes de executar um experimento com referências;
- distinguir criação de objeto de atribuição entre variáveis de objeto;
- explicar uma alteração observada por duas referências para o mesmo objeto;
- representar variáveis, referências e objetos em um diagrama simples;
- contrastar objetos com estados equivalentes e identidades diferentes;
- usar `==` para verificar se duas referências correspondem ao mesmo objeto;
- justificar resultados usando `new`, referência, estado e identidade.

## Projeto 1 — Versão 3: investigando referências

Use a **Versão 2** do Projeto 1 como ponto de partida. Preserve `ItemPedido.java`, inclusive os comportamentos `calcularSubtotal()` e `aumentarQuantidade(int unidades)` construídos no laboratório anterior.

Crie uma pasta para esta versão e mantenha os arquivos juntos:

```text
lab-03/
├── Main.java
└── ItemPedido.java
```

!!! tip "Dica — continue abrindo a pasta do projeto"

    Abra `lab-03/` na IDE, não os arquivos separadamente. Este hábito já foi estabelecido nos laboratórios anteriores; aqui apenas continuamos usando a mesma organização.

## Como conduzir a investigação

Em cada incremento, respeite esta ordem:

**prever → executar → observar → explicar**

Registre as previsões antes da execução. Você pode usar uma folha, um arquivo de texto ou comentários temporários no código. Não altere a previsão depois de conhecer o resultado: a diferença entre ambos também faz parte da aprendizagem.

## Atividade

### Incremento A — Preparar o cenário-base

Em `Main.java`, prepare um experimento com um único `ItemPedido`, chamado `itemPrincipal`, com o seguinte estado:

| Campo | Valor |
| --- | --- |
| descrição | `Teclado` |
| preço unitário | `150.0` |
| quantidade | `2` |

Exiba no console a quantidade e o subtotal desse objeto. Antes de avançar, confirme:

- quantidade: `2`;
- subtotal: `300.0`.

Esse estado conhecido será nosso ponto de comparação. Ainda não há resultado surpreendente: existe uma variável e um objeto criado com `new`.

### Incremento B — Introduzir uma segunda variável

Agora declare outra variável chamada `itemObservado` e atribua a ela o valor de `itemPrincipal`:

```java
ItemPedido itemObservado = itemPrincipal;
```

Não altere o estado ainda. Primeiro registre suas previsões:

| Pergunta | Previsão |
| --- | --- |
| Quantas variáveis do tipo `ItemPedido` existem? |  |
| Quantos objetos `ItemPedido` existem? |  |
| Houve alguma nova execução de `new ItemPedido()`? |  |
| `itemPrincipal == itemObservado` produzirá `true` ou `false`? |  |

Depois, desenhe sua hipótese usando nomes de variáveis, setas e objetos. O desenho deve tornar visível se você imagina um ou dois objetos.

Essa hipótese prepara a próxima pergunta: se as variáveis permitem acesso ao mesmo objeto, uma alteração feita por uma delas deverá aparecer quando observarmos pela outra.

### Incremento C — Alterar por uma referência e observar pela outra

Use `itemObservado` para chamar:

```java
itemObservado.aumentarQuantidade(3);
```

Antes de executar, preveja a quantidade e o subtotal que serão observados por cada variável:

| Observação | Previsão | Resultado observado |
| --- | --- | --- |
| `itemPrincipal.quantidade` |  |  |
| `itemObservado.quantidade` |  |  |
| `itemPrincipal.calcularSubtotal()` |  |  |
| `itemObservado.calcularSubtotal()` |  |  |

Em seguida:

1. execute a alteração somente por `itemObservado`;
2. exiba as quatro observações da tabela;
3. registre os resultados;
4. compare previsão e observação;
5. explique por que as duas variáveis permitem observar quantidade `5` e subtotal `750.0`.

Não aceite apenas “porque uma recebeu a outra” como explicação. Sua resposta deve distinguir as duas variáveis do único objeto cujo estado foi alterado.

### Incremento D — Testar a hipótese de identidade

O resultado anterior sugere que as duas variáveis permitem acesso ao mesmo objeto. Agora use `==` para testar diretamente essa hipótese:

```java
itemPrincipal == itemObservado
```

Antes de executar, registre o resultado esperado e justifique-o. Depois:

1. exiba a comparação no console;
2. confronte o resultado com sua previsão;
3. corrija, se necessário, o diagrama do Incremento B;
4. escreva uma explicação que use as palavras **referência**, **objeto**, **estado** e **identidade**.

O diagrama final desta situação deve representar duas variáveis apontando para o mesmo objeto.

### Incremento E — Criar um objeto com estado equivalente

Até aqui, duas variáveis permitiram observar o mesmo estado porque havia um único objeto. Agora precisamos verificar se valores iguais são suficientes para estabelecer a mesma identidade.

Crie `itemIndependente` com uma nova expressão `new ItemPedido()` e atribua a ele o mesmo estado atual observado pelos outros nomes:

| Campo | Valor |
| --- | --- |
| descrição | `Teclado` |
| preço unitário | `150.0` |
| quantidade | `5` |

Antes de executar as comparações, preveja:

| Observação | Previsão | Resultado observado |
| --- | --- | --- |
| subtotal de `itemPrincipal` |  |  |
| subtotal de `itemIndependente` |  |  |
| `itemPrincipal == itemObservado` |  |  |
| `itemPrincipal == itemIndependente` |  |  |

Execute e registre os resultados. Os subtotais devem ser iguais a `750.0`, mas as duas comparações de identidade não devem produzir o mesmo resultado.

Explique por que estado equivalente não torna `itemIndependente` o mesmo objeto que `itemPrincipal`.

### Incremento F — Fazer o contraste aparecer no estado

Agora use `itemIndependente` para chamar `aumentarQuantidade(2)`.

Antes de executar, preveja as quantidades que serão observadas por:

- `itemPrincipal`;
- `itemObservado`;
- `itemIndependente`.

Depois, exiba as três quantidades e os três subtotais. O resultado esperado é:

| Variável | Quantidade | Subtotal |
| --- | ---: | ---: |
| `itemPrincipal` | 5 | 750.0 |
| `itemObservado` | 5 | 750.0 |
| `itemIndependente` | 7 | 1050.0 |

Atualize seu diagrama para representar:

- `itemPrincipal` e `itemObservado` permitindo acesso ao mesmo objeto;
- `itemIndependente` permitindo acesso a outro objeto;
- o estado final de cada objeto.

Por fim, explique por que a alteração apareceu por duas variáveis, mas não pela terceira. Essa conclusão deve usar a relação entre referência e identidade, e não apenas repetir os valores exibidos.

!!! success "Critérios de conclusão"

    Verifique se sua investigação:

    - parte da Versão 2 e preserva `ItemPedido.java` com os comportamentos já construídos;
    - mantém `Main.java` e `ItemPedido.java` na mesma pasta de projeto;
    - cria `itemPrincipal` com os dados solicitados e confirma o estado-base;
    - atribui a referência de `itemPrincipal` a `itemObservado` sem executar outro `new`;
    - registra previsões antes das execuções solicitadas;
    - altera o objeto por `itemObservado` e observa quantidade `5` e subtotal `750.0` pelas duas variáveis;
    - usa `==` para verificar a identidade nos dois cenários;
    - cria `itemIndependente` com `new` e estado inicialmente equivalente;
    - demonstra que estados equivalentes não implicam a mesma identidade;
    - produz o estado final `5`, `5` e `7`, com subtotais `750.0`, `750.0` e `1050.0`;
    - apresenta um diagrama final coerente com dois objetos e três variáveis;
    - explica os resultados usando `new`, variável, referência, objeto, estado e identidade;
    - compila, executa, verifica os resultados e realiza o envio conforme o Google Classroom.

Depois de concluir, verificar os critérios e realizar o envio, você poderá ser liberado. O desafio a seguir permanece opcional.

## Desafio opcional — Três referências, um objeto

Parta de um novo cenário:

```java
ItemPedido a = new ItemPedido();
ItemPedido b = a;
ItemPedido c = b;
```

Antes de executar, preveja:

- quantos objetos existem;
- quais comparações entre `a`, `b` e `c` resultarão em `true`;
- o que será observado por `a` e `b` se a quantidade for alterada usando `c`.

Depois, realize o experimento, desenhe o diagrama e explique os resultados. O desafio amplia a quantidade de referências, mas não introduz um conceito novo nem altera os critérios obrigatórios.

### Para a próxima aula

Vamos retomar estas questões na Aula 04 — Protegendo o estado dos objetos. Não é necessário respondê-las por escrito.

1. Se duas partes do programa possuem referências para o mesmo objeto, ambas conseguem modificar seu estado atual?
2. Todo valor aceito em uma atribuição direta faz sentido para o problema?
3. Quem deveria decidir se uma alteração de estado é válida?

## Entrega

> **Projeto 1 — Versão 3: investigação de referências e identidade**

Entregue sua própria versão do projeto conforme as orientações disponíveis no Google Classroom.

## Materiais relacionados

- [Aula 03 — Objetos, referências e identidade](aula-03-objetos-referencias-e-identidade.md)
- [Laboratório 02 — Primeiros objetos em Java](laboratorio-02-primeiros-objetos-em-java.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
