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

Faça previsões breves antes da execução. Você pode usar papel, um rascunho, um arquivo temporário, comentários temporários no código ou discutir verbalmente quando o professor estiver acompanhando. Não altere a previsão depois de conhecer o resultado: a diferença entre ambos também faz parte da aprendizagem.

Previsões, desenhos, anotações e explicações orientam a investigação, mas não fazem parte da entrega. Ao final, você enviará somente o código-fonte solicitado.

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

Não altere o estado ainda. Primeiro, preveja quantas variáveis e quantos objetos existem, se houve outra execução de `new ItemPedido()` e qual será o resultado de `itemPrincipal == itemObservado`.

Faça um desenho rápido da sua hipótese usando nomes de variáveis, setas e objetos. Ele deve tornar visível se você imagina um ou dois objetos. Pode ser feito em papel ou em outro espaço de rascunho; o diagrama não faz parte da entrega.

Essa hipótese prepara a próxima pergunta: se as variáveis permitem acesso ao mesmo objeto, uma alteração feita por uma delas deverá aparecer quando observarmos pela outra.

### Incremento C — Alterar por uma referência e observar pela outra

Use `itemObservado` para chamar:

```java
itemObservado.aumentarQuantidade(3);
```

Antes de executar, preveja a quantidade e o subtotal que serão observados por `itemPrincipal` e por `itemObservado`.

Em seguida:

1. execute a alteração somente por `itemObservado`;
2. exiba no console as quantidades e os subtotais observados pelas duas variáveis;
3. compare o resultado com sua previsão;
4. explique para si por que as duas variáveis permitem observar quantidade `5` e subtotal `750.0`.

??? "Ver explicação"

    `itemPrincipal` e `itemObservado` guardam referências para o mesmo objeto. A alteração muda esse único objeto; por isso, os dois caminhos observam quantidade `5` e subtotal `750.0`.

Antes de avançar, confirme que sua explicação distingue as duas variáveis do único objeto cujo estado foi alterado. Dizer apenas “porque uma recebeu a outra” ainda não explica o resultado.

### Incremento D — Testar a hipótese de identidade

O resultado anterior sugere que as duas variáveis permitem acesso ao mesmo objeto. Agora use `==` para testar diretamente essa hipótese:

```java
itemPrincipal == itemObservado
```

Antes de executar, preveja o resultado e justifique sua hipótese. Depois:

1. exiba a comparação no console;
2. confronte o resultado com sua previsão;
3. corrija, se necessário, o diagrama do Incremento B;
4. formule uma explicação usando **referência**, **objeto**, **estado** e **identidade**.

??? "Ver explicação"

    As duas variáveis guardam referências que chegam ao mesmo objeto e, portanto, à mesma identidade. Como existe um único estado compartilhado, `itemPrincipal == itemObservado` resulta em `true`.

Ao corrigir sua hipótese, o desenho deve representar duas variáveis apontando para o mesmo objeto. Ele continua sendo uma ferramenta de raciocínio, não um artefato de entrega.

### Incremento E — Criar um objeto com estado equivalente

Até aqui, duas variáveis permitiram observar o mesmo estado porque havia um único objeto. Agora precisamos verificar se valores iguais são suficientes para estabelecer a mesma identidade.

Crie `itemIndependente` com uma nova expressão `new ItemPedido()` e atribua a ele o mesmo estado atual observado pelos outros nomes:

| Campo | Valor |
| --- | --- |
| descrição | `Teclado` |
| preço unitário | `150.0` |
| quantidade | `5` |

Antes de executar, preveja os subtotais de `itemPrincipal` e `itemIndependente` e os resultados de `itemPrincipal == itemObservado` e `itemPrincipal == itemIndependente`.

Execute, exiba os resultados e compare-os com sua previsão. Os subtotais devem ser iguais a `750.0`, mas as duas comparações de identidade não devem produzir o mesmo resultado.

Confira se você consegue explicar por que estado equivalente não torna `itemIndependente` o mesmo objeto que `itemPrincipal`.

??? "Ver explicação"

    Os valores dos campos podem coincidir, mas cada expressão `new ItemPedido()` cria um objeto com identidade própria. Por isso, a comparação com `==` resulta em `false`.

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

Faça um último desenho rápido, ou corrija o anterior, para representar:

- `itemPrincipal` e `itemObservado` permitindo acesso ao mesmo objeto;
- `itemIndependente` permitindo acesso a outro objeto;
- o estado final de cada objeto.

O desenho pode permanecer no seu espaço de rascunho e não será enviado. Por fim, formule por que a alteração apareceu por duas variáveis, mas não pela terceira. Sua conclusão deve usar a relação entre referência e identidade, e não apenas repetir os valores exibidos.

??? "Ver explicação"

    `itemPrincipal` e `itemObservado` chegam à mesma identidade e observam o mesmo estado. `itemIndependente` chega a outro objeto; por isso, sua alteração não afeta o primeiro.

!!! success "Critérios de conclusão"

    Verifique se o código do projeto:

    - compila e executa sem erros;
    - parte da Versão 2 e preserva `ItemPedido.java` com os comportamentos já construídos;
    - mantém `Main.java` e `ItemPedido.java` na mesma pasta de projeto;
    - cria `itemPrincipal` com os dados solicitados e confirma o estado-base;
    - atribui a referência de `itemPrincipal` a `itemObservado` sem executar outro `new`;
    - altera o objeto por `itemObservado` e observa quantidade `5` e subtotal `750.0` pelas duas variáveis;
    - usa `==` para verificar a identidade nos dois cenários;
    - cria `itemIndependente` com `new` e estado inicialmente equivalente;
    - demonstra que estados equivalentes não implicam a mesma identidade;
    - produz o estado final `5`, `5` e `7`, com subtotais `750.0`, `750.0` e `1050.0`;
    - exibe no console resultados suficientes para verificar os experimentos e os estados finais.

### Antes de entregar, você deve conseguir explicar

- quantos objetos existem em cada cenário;
- por que duas variáveis podem observar o mesmo estado;
- por que estados iguais não implicam a mesma identidade;
- por que `==` muda de resultado entre os dois casos.

??? "Ver explicações"

    - No cenário compartilhado há um objeto; depois de `itemIndependente`, há dois.
    - Duas variáveis observam o mesmo estado quando suas referências chegam ao mesmo objeto.
    - Estados iguais podem pertencer a objetos criados por expressões `new` diferentes.
    - `==` resulta em `true` para referências à mesma identidade e em `false` para identidades diferentes.

Use as respostas dos experimentos anteriores para conferir essas explicações. Elas são autoavaliação e não fazem parte da entrega.

Depois de concluir, verifique os critérios e realize o envio. O desafio a seguir permanece opcional.

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

??? "Ver resposta"

    - Existe um único objeto.
    - `a == b`, `a == c` e `b == c` resultam em `true`.
    - Uma alteração feita por `c` será observada pelos três nomes.

Depois, realize o experimento, faça um desenho rápido e explique os resultados. Você pode usar o mesmo ciclo leve de investigação; não é necessário entregar previsão, diagrama ou explicação. O desafio amplia a quantidade de referências, mas não introduz um conceito novo nem altera os critérios obrigatórios.

### Para a próxima aula

Vamos retomar estas questões na Aula 04 — Protegendo o estado dos objetos. Não é necessário respondê-las por escrito.

1. Se duas partes do programa possuem referências para o mesmo objeto, ambas conseguem modificar seu estado atual?
2. Todo valor aceito em uma atribuição direta faz sentido para o problema?
3. Quem deveria decidir se uma alteração de estado é válida?

## Entrega

> **Projeto 1 — Versão 3: investigação de referências e identidade**

Entregue somente os arquivos de código-fonte do **Projeto 1 — Versão 3**, conforme as orientações disponíveis no [Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).

Não é necessário enviar previsões, tabelas preenchidas, diagramas, anotações ou explicações por escrito.

## Materiais relacionados

- [Aula 03 — Objetos, referências e identidade](aula-03-objetos-referencias-e-identidade.md)
- [Laboratório 02 — Primeiros objetos em Java](laboratorio-02-primeiros-objetos-em-java.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
