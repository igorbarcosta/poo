---
icon: material/flask-outline
---

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

## Investigação

### Incremento A — Mapear os acessos atuais

Execute a Versão 3 antes de modificá-la e confirme o resultado final conhecido:

| Variável | Quantidade | Subtotal |
| --- | ---: | ---: |
| `itemPrincipal` | 5 | 750.0 |
| `itemObservado` | 5 | 750.0 |
| `itemIndependente` | 7 | 1050.0 |

Em seguida, localize em `Main.java` todos os acessos diretos a `quantidade` e classifique cada um:

- **escrita:** atribui ou altera o campo;
- **leitura:** consulta o campo para exibir ou usar o valor.

Ainda não altere o código. Esse mapa permitirá observar o impacto da próxima decisão.

### Incremento B — Criar a fronteira e compilar

Em `ItemPedido.java`, altere somente a declaração de `quantidade`:

```java
private int quantidade;
```

Agora compile o projeto **antes de corrigir qualquer acesso em `Main`**.

Registre para sua análise:

1. quais linhas deixaram de compilar;
2. quais eram leituras e quais eram escritas;
3. o que as mensagens informam sobre o acesso a `quantidade`;
4. quais dependências de `Main` em relação ao campo exposto ficaram visíveis.

Os erros fazem parte do experimento. Eles mostram o alcance de uma mudança na interface da classe.

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

Reorganize o experimento para que `itemPrincipal` comece com um novo objeto, preço unitário `150.0` e quantidade inicial ainda `0`. Prepare a quantidade por meio do comportamento e só então atribua a referência a `itemObservado`:

```java
itemPrincipal.aumentarQuantidade(5);
ItemPedido itemObservado = itemPrincipal;
```

Ajuste as chamadas herdadas da Versão 3 para que esse aumento não seja aplicado duas vezes.

Antes de cada execução, preveja o que será consultado pelas duas variáveis. Depois execute e explique o resultado.

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

Explique por que a alteração válida continua visível pelas duas referências e por que a tentativa inválida não muda o objeto.

### Incremento G — Confirmar o contraste com outro objeto

Use `itemIndependente`, que foi criado com outra execução de `new ItemPedido()`, e confirme que ele continua independente:

1. aumente sua quantidade em um valor positivo;
2. consulte seu estado e o de `itemPrincipal`;
3. verifique novamente `itemPrincipal == itemIndependente`;
4. explique por que a regra é preservada separadamente em cada objeto.

Agora há duas conclusões que precisam conviver:

- compartilhar uma referência significa acessar o mesmo objeto;
- acessar o mesmo objeto não concede acesso direto aos seus campos privados.

!!! success "Critérios de conclusão"

    Verifique se sua solução:

    - parte da Versão 3 e preserva o cenário com referências compartilhadas e objeto independente;
    - mantém `quantidade` como `private` e não a acessa diretamente em `Main`;
    - controla aumentos com `aumentarQuantidade(int unidades)` e a regra `unidades > 0`;
    - consulta a quantidade com `getQuantidade()` e calcula o subtotal com o estado interno;
    - preserva quantidade `5` após a solicitação inválida e chega a `7` após a solicitação válida;
    - confirma e explica a diferença entre referências compartilhadas e objetos distintos;
    - compila e executa sem erros ao final.

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

Entregue sua própria versão do projeto conforme as orientações disponíveis no Google Classroom.

## Materiais relacionados

- [Aula 04 — Protegendo o estado dos objetos](aula-04-protegendo-o-estado-dos-objetos.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
