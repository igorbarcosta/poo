# Laboratório 04 — Controlando alterações de estado

Na Versão 3 do Projeto 1, `itemPrincipal` e `itemObservado` passaram a acessar o mesmo objeto. Nesta evolução, esse objeto deverá controlar como sua quantidade pode mudar.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode:

    - esclarecer sintaxe e mensagens de erro;
    - ajudar a interpretar o comportamento observado;
    - auxiliar na compreensão de `private`, `public` e métodos.

    Ela não deve gerar a solução completa, decidir toda a implementação por você nem antecipar conteúdos ainda não estudados.

!!! warning "Laboratório acompanhado — presença requerida"

    Este laboratório é acompanhado porque usa erros de compilação para analisar o impacto de uma mudança na classe e reconstruir seus acessos de forma controlada.

## Objetivos

Ao final deste laboratório, você deverá ser capaz de:

- identificar dependências causadas por um campo exposto;
- interpretar o impacto de tornar esse campo privado;
- substituir acessos diretos por operações de alteração e consulta;
- verificar que o objeto preserva sua regra mesmo quando possui referências compartilhadas.

## Projeto 1 — Versão 4: estado protegido

Parta da **Versão 3** que você concluiu no laboratório anterior. Preserve os três nomes usados na investigação:

- `itemPrincipal` e `itemObservado`, que acessam o mesmo objeto;
- `itemIndependente`, que acessa outro objeto.

O novo requisito é:

> `ItemPedido` deve controlar as alterações realizadas em sua quantidade.

!!! tip "Dica — continue na mesma pasta de projeto"

    Crie uma cópia da Versão 3 para iniciar a Versão 4 e abra a pasta completa na IDE. Mantenha `Main.java` e `ItemPedido.java` juntos; não abra apenas os arquivos separadamente.

## Como conduzir a investigação

Em cada experimento, preserve o ciclo **prever → executar → observar → explicar**. As previsões podem ser breves e feitas em papel, rascunho, comentário temporário no código ou durante a conversa com sua dupla e com o professor. Não mude uma previsão depois de conhecer o resultado: compare as duas coisas.

Previsões, mensagens de erro, classificações, anotações e explicações fazem parte da investigação, mas não da entrega. Ao final, você enviará somente o código-fonte solicitado.

## Investigação

### Incremento A — Mapear os acessos atuais

Execute a Versão 3 antes de modificá-la e confirme o resultado final conhecido:

| Variável | Quantidade | Subtotal |
| --- | ---: | ---: |
| `itemPrincipal` | 5 | 750.0 |
| `itemObservado` | 5 | 750.0 |
| `itemIndependente` | 7 | 1050.0 |

Em seguida, localize em `Main.java` todos os acessos diretos a `quantidade` e identifique o papel de cada um:

- **escrita:** atribui ou altera o campo;
- **leitura:** consulta o campo para exibir ou usar o valor.

Ainda não altere o código. Essa leitura permitirá observar o impacto da próxima decisão. Não é necessário produzir uma tabela ou um registro formal.

### Incremento B — Criar a fronteira e compilar

Em `ItemPedido.java`, altere somente a declaração de `quantidade`:

```java
private int quantidade;
```

Agora compile o projeto **antes de corrigir qualquer acesso em `Main`**.

Antes de corrigir, observe:

1. quais linhas deixaram de compilar;
2. quais eram leituras e quais eram escritas;
3. o que as mensagens informam sobre o acesso a `quantidade`;
4. quais dependências de `Main` em relação ao campo exposto ficaram visíveis.

Os erros fazem parte do experimento. Eles mostram o alcance de uma mudança na forma de acesso oferecida pela classe. Consiga explicar essa relação à sua dupla ou ao professor; não é necessário enviar as mensagens nem uma análise por escrito.

### Incremento C — Planejar a reparação

Antes de editar os trechos que quebraram, associe cada necessidade a uma operação preparada na aula:

| Necessidade de `Main` | Operação de `ItemPedido` |
| --- | --- |
| solicitar um aumento válido | `aumentarQuantidade(int unidades)` |
| consultar o valor atual | `getQuantidade()` |
| calcular o subtotal | `calcularSubtotal()` |

Uma escrita direta não será apenas substituída por outra forma de escolher qualquer valor. A mudança precisa passar por um comportamento com intenção.

### Incremento D — Controlar a alteração

Evolua o método `aumentarQuantidade(int unidades)` que já existe em `ItemPedido`. Ele deve:

- acrescentar `unidades` à quantidade atual quando `unidades > 0`;
- manter a quantidade inalterada quando `unidades <= 0`.

Adapte as escritas identificadas no Incremento A para solicitar a mudança por esse comportamento.

Como um campo `int` começa em `0` quando não é inicializado explicitamente, a quantidade inicial pode ser construída com chamadas como:

```java
itemPrincipal.aumentarQuantidade(5);
```

Não crie `setQuantidade(...)`. O requisito não é permitir que `Main` escolha qualquer estado, mas permitir que solicite uma operação controlada.

### Incremento E — Disponibilizar a consulta

Adicione a `ItemPedido` uma operação pública com esta assinatura:

```java
public int getQuantidade()
```

Ela deve apenas retornar a quantidade atual. Substitua as leituras diretas encontradas no Incremento A por chamadas a essa operação.

Compile novamente. Se ainda houver erro de acesso a `quantidade` em `Main`, volte ao mapa e verifique qual leitura ou escrita ainda depende do campo exposto.

### Incremento F — Testar a regra no objeto compartilhado

Reorganize `Main` para iniciar este experimento com um novo objeto. Use o comportamento de aumento para chegar à quantidade `5` e só então atribua a referência de `itemPrincipal` a `itemObservado`. Remova ou ajuste as alterações herdadas da Versão 3 que mudariam novamente esse estado.

Antes da sequência de testes, compile, execute e confirme este estado-base:

| Verificação | Resultado esperado |
| --- | --- |
| `itemPrincipal == itemObservado` | `true` |
| quantidade consultada pelos dois nomes | `5` |
| preço unitário do objeto compartilhado | `150.0` |
| subtotal calculado pelos dois nomes | `750.0` |

Só avance quando as quatro verificações forem atendidas.

Antes de cada execução, preveja o que será consultado pelas duas variáveis. Depois execute, observe e explique o resultado à sua dupla ou ao professor.

1. Use `itemObservado.aumentarQuantidade(-10)`.
2. Consulte a quantidade e o subtotal por `itemPrincipal` e `itemObservado`.
3. Use `itemObservado.aumentarQuantidade(2)`.
4. Consulte novamente pelos dois nomes.
5. Verifique `itemPrincipal == itemObservado`.

O resultado esperado é:

| Momento | Quantidade pelas duas referências | Subtotal pelas duas referências |
| --- | ---: | ---: |
| início | 5 | 750.0 |
| após tentar aumentar em `-10` | 5 | 750.0 |
| após aumentar em `2` | 7 | 1050.0 |

Antes de avançar, confirme que você consegue explicar por que a alteração válida continua visível pelas duas referências e por que a tentativa inválida não muda o objeto.

### Incremento G — Confirmar o contraste com outro objeto

Use `itemIndependente`, que foi criado com outra execução de `new ItemPedido()`, e confirme que ele continua independente:

1. aumente sua quantidade em um valor positivo;
2. consulte seu estado e o de `itemPrincipal`;
3. verifique novamente `itemPrincipal == itemIndependente`;
4. explique à sua dupla ou ao professor por que a regra é preservada separadamente em cada objeto.

Agora há duas conclusões que precisam conviver:

- compartilhar uma referência significa acessar o mesmo objeto;
- acessar o mesmo objeto não concede acesso direto aos seus campos privados.

!!! success "Critérios de conclusão"

    Verifique se o código do projeto:

    - parte da Versão 3 e preserva o cenário com referências compartilhadas e objeto independente;
    - compila e executa sem erros ao final;
    - mantém `quantidade` como `private` e não a acessa diretamente em `Main`;
    - mantém público `aumentarQuantidade(int unidades)` e só altera o estado quando `unidades > 0`;
    - oferece `getQuantidade()` como operação pública de consulta;
    - mantém `calcularSubtotal()` usando o estado interno;
    - preserva quantidade `5` após a solicitação inválida e chega a `7` após a solicitação válida;
    - mantém referências compartilhadas observando o mesmo estado e o objeto criado com outro `new` independente;
    - exibe no console resultados suficientes para verificar a regra, o compartilhamento e a independência dos objetos.

### Antes de entregar, você deve conseguir explicar

- por que os acessos diretos deixaram de compilar após `quantidade` se tornar privada;
- por que duas referências ainda observam o mesmo estado;
- por que `private` não muda a identidade do objeto;
- por que um `setQuantidade(...)` irrestrito não resolve sozinho o problema;
- o que encapsulamento significa neste exemplo.

Essas explicações podem ser demonstradas oralmente durante o acompanhamento e não precisam ser enviadas.

Ao concluir corretamente, verifique os critérios, envie a atividade e aguarde a liberação do professor.

## Desafio opcional — Reduzindo quantidade com segurança

!!! tip "Quer aprofundar?"

    Explore uma segunda alteração controlada somente depois de concluir e verificar o núcleo obrigatório.

Adicione a `ItemPedido`:

```java
public void reduzirQuantidade(int unidades)
```

O comportamento deve manter a quantidade inalterada quando:

- `unidades` não for positivo;
- a redução tornaria a quantidade negativa.

Parta de quantidade `5` e verifique:

| Operação | Quantidade esperada |
| --- | ---: |
| reduzir `2` | 3 |
| reduzir `10` | 3 |
| reduzir `-1` | 3 |

Não use exceções nem retorno booleano. O desafio apenas amplia a aplicação da ideia de alteração controlada.

## Para consolidar

1. O que a quebra de compilação revelou sobre a dependência de `Main` em relação ao estado exposto?
2. Por que duas referências para o mesmo objeto continuam observando o mesmo estado depois do encapsulamento?
3. O que ainda falta para impedir que um `ItemPedido` seja criado sem descrição e preço adequados?

Não é necessário entregar respostas escritas.

## Entrega

> **Projeto 1 — Versão 4: estado protegido**

Entregue somente os arquivos de código-fonte do **Projeto 1 — Versão 4**, conforme as orientações disponíveis no [Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).

Não é necessário enviar previsões, respostas, tabelas, diagramas, mensagens de erro, anotações ou explicações por escrito.

## Materiais relacionados

- [Aula 04 — Protegendo o estado dos objetos](aula-04-protegendo-o-estado-dos-objetos.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
