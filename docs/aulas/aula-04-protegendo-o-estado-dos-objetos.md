---
icon: material/school-outline
---

# Aula 04 — Protegendo o estado dos objetos

Na Aula 03, vimos que duas variáveis podem permitir acesso ao mesmo objeto. Agora precisamos investigar uma consequência dessa descoberta: se diferentes partes do programa chegam ao mesmo objeto, elas também podem tentar alterar diretamente o estado que compartilham.

**Slides:** [Apresentação HTML](../slides/rendered/aula-04-protegendo-o-estado-dos-objetos.html) · [PDF](../slides/rendered/aula-04-protegendo-o-estado-dos-objetos.pdf)

!!! lesson-question "Pergunta central"

    Se diferentes partes do programa acessam o mesmo objeto, quem deve controlar como seu estado pode mudar?

!!! lesson-objectives "Objetivos"

    Ao final deste encontro, você deverá ser capaz de:

    - diagnosticar o problema da exposição direta do estado;
    - explicar o papel de `private` como fronteira de acesso;
    - usar comportamentos para controlar mudanças e consultas ao estado;
    - justificar por que encapsulamento não equivale a gerar getters e setters automaticamente.

## Duas referências, uma alteração

Vamos retomar o cenário construído no laboratório anterior:

```java
ItemPedido itemPrincipal = new ItemPedido();
itemPrincipal.descricao = "Teclado";
itemPrincipal.precoUnitario = 150.0;
itemPrincipal.quantidade = 5;

ItemPedido itemObservado = itemPrincipal;
```

Temos duas variáveis, mas apenas um objeto. Até aqui, isso nos ajudou a compreender referências e identidade. O mesmo arranjo também permite que a alteração seja feita por qualquer um dos nomes:

```java
itemObservado.quantidade = -3;
```

!!! activity "Atividade — prever antes de executar"

    Sem executar o código, formule sua previsão:

    1. Qual quantidade será observada por `itemPrincipal`?
    2. Qual subtotal será calculado por `itemPrincipal.calcularSubtotal()`?
    3. Quantos objetos existem nesse cenário?

    Compare a previsão com a de um colega e justifique sua resposta usando o modelo de referências da Aula 03.

Quando consultamos o estado por `itemPrincipal`, encontramos `-3`. O subtotal também passa a usar esse valor. A alteração foi realizada por outro nome, mas chegou ao mesmo objeto.

Referências compartilhadas não criaram o problema. Elas apenas o tornaram mais visível: qualquer código com acesso ao objeto também possui acesso direto aos seus campos.

## O Java aceita. O domínio não.

Para o Java, `-3` é um valor possível do tipo `int`. A atribuição está sintaticamente correta e o programa pode continuar executando.

Para um item de pedido, porém, uma quantidade negativa não representa um estado válido. A linguagem verifica o tipo; a classe precisa preservar as regras do problema que representa.

Isso nos leva a uma pergunta mais específica: se `quantidade` pertence ao estado de `ItemPedido`, por que qualquer trecho externo pode decidir livremente seu valor?

## Criando uma fronteira

Podemos começar restringindo o acesso direto ao campo:

```java
public class ItemPedido {

    String descricao;
    double precoUnitario;
    private int quantidade;

    public double calcularSubtotal() {
        return precoUnitario * quantidade;
    }
}
```

Agora este código externo deixa de compilar:

```java
itemObservado.quantidade = -3;
```

O erro é consequência da fronteira que acabamos de criar. `Main` ainda conhece o objeto, mas não pode mais escolher diretamente o valor de `quantidade`.

!!! java-focus "Java em foco — `private` e `public`"

    - `private` restringe o acesso ao interior da própria classe;
    - `public` disponibiliza uma classe ou operação para uso externo;
    - métodos de `ItemPedido` continuam acessando seus campos privados;
    - código externo só pode usar os membros que a classe disponibiliza.

Tem uma pergunta natural aqui: nos exemplos anteriores, `descricao`, `precoUnitario` e `quantidade` apareciam sem `public` nem `private`, e `Main` conseguia acessá-los. O que acontece quando nenhum modificador é escrito?

!!! java-focus "Java em foco — e se não houver modificador?"

    Compare estas declarações:

    ```java
    private int quantidade;
    int quantidade;
    public int quantidade;
    ```

    - `private` restringe o acesso à própria classe;
    - sem modificador, ocorre acesso de pacote (`package-private`): o membro pode ser acessado no mesmo pacote;
    - `public` disponibiliza o membro externamente.

    Em nosso exemplo simples, `Main` e `ItemPedido` estão em um contexto no qual o acesso de pacote permite a interação. Portanto, funcionar sem `public` não significa que `public` seja opcional nem que a ausência de modificador torne o campo privado.

    Existe ainda `protected`, que será discutido quando houver necessidade.

Nesta etapa, protegeremos apenas `quantidade`. `descricao` e `precoUnitario` permanecerão temporariamente expostos para concentrarmos a atenção em uma mudança por vez.

## Pedindo ao objeto para mudar

Bloquear o acesso direto resolve uma parte do problema, mas também impede alterações legítimas. Como o código externo pode pedir que a quantidade aumente?

Já usamos um comportamento com essa intenção no Projeto 1. Agora ele passa a controlar a regra da mudança:

```java
public void aumentarQuantidade(int unidades) {
    if (unidades > 0) {
        quantidade += unidades;
    }
}
```

O código externo não escolhe o novo estado. Ele solicita uma operação:

```java
itemObservado.aumentarQuantidade(2);
```

O próprio `ItemPedido` decide se a solicitação preserva sua regra. Se `unidades` for menor ou igual a zero, o estado permanece inalterado.

Há um detalhe operacional importante aqui: quando um campo `int` não recebe uma inicialização explícita, cada objeto começa com esse campo em `0`. Assim, podemos construir a quantidade inicial por meio do comportamento, sem reabrir o acesso direto.

!!! tip "Dica — campo não é variável local"

    Um campo `int` recebe o valor padrão `0`:

    ```java
    class ItemPedido {
        int quantidade;
    }
    ```

    Uma variável local precisa receber um valor antes de ser utilizada:

    ```java
    void exemplo() {
        int quantidade;
        System.out.println(quantidade); // não compila
    }
    ```

    Portanto, não podemos generalizar que “todo `int` começa em zero”.

## Consultando sem entregar o controle

Depois de tornar `quantidade` privada, este código também deixa de compilar:

```java
System.out.println(itemPrincipal.quantidade);
```

Precisamos consultar a quantidade para exibi-la e verificar resultados. Consultar, porém, não exige que o código externo também possa alterá-la livremente.

```java
public int getQuantidade() {
    return quantidade;
}
```

Agora a consulta é explícita:

```java
System.out.println(itemPrincipal.getQuantidade());
```

`getQuantidade()` informa o estado atual. `aumentarQuantidade(...)` solicita uma mudança. As duas operações expõem capacidades diferentes do objeto.

## Quais capacidades o objeto precisa oferecer?

Tem uma pergunta natural aqui: se existe `aumentarQuantidade(...)`, por que não criamos também `diminuirQuantidade(...)`?

Não precisamos criar operações apenas porque elas parecem formar um par. Uma operação pública representa uma capacidade que o problema exige. Se reduzir a quantidade fizer parte do problema, essa capacidade pode ser adequada — mas traz suas próprias decisões.

!!! activity "Atividade — uma operação simétrica?"

    Parta de uma quantidade atual igual a `5` e discuta:

    1. reduzir `2` poderia produzir qual estado?
    2. reduzir `10` deveria levar a quantidade a `-5`?
    3. o que significaria pedir uma redução de `-2`?
    4. o problema realmente precisa oferecer essa operação?

    Não implemente a solução agora. O desafio opcional do Laboratório 04 permitirá explorar essa capacidade sem torná-la obrigatória.

Cada nova capacidade cria novas decisões e regras que o objeto deverá preservar. A aparente simetria do nome não decide por nós.

## Uma classe pode esconder o campo e continuar sem controle

Considere outra operação possível:

```java
public void setQuantidade(int novaQuantidade) {
    quantidade = novaQuantidade;
}
```

Ela esconde o campo, mas ainda permite que qualquer código externo escolha qualquer valor, inclusive `-200`. A escrita mudou de forma; a decisão continua fora do objeto.

!!! activity "Atividade — diagnosticar duas soluções"

    Compare `setQuantidade(int novaQuantidade)` sem validação com `aumentarQuantidade(int unidades)` preservando `unidades > 0`.

    1. Responda individualmente: as duas operações protegem o estado da mesma forma?
    2. Discuta sua justificativa com um colega.
    3. Responda novamente e indique qual operação comunica melhor a intenção do domínio.
    4. Participe do fechamento coletivo, relacionando a escolha à responsabilidade de `ItemPedido`.

!!! trap "Armadilha — campo privado não garante encapsulamento"

    Criar getters e setters para todos os campos pode apenas trocar a sintaxe do acesso. Se `setQuantidade(...)` aceita qualquer valor, o código externo continua decidindo livremente o estado final.

    Isso não significa que setters sejam sempre inadequados. O contexto e a responsabilidade do objeto determinam quais operações fazem sentido e quais regras elas devem preservar.

## Protegemos a quantidade. E o resto?

Até aqui, protegemos apenas `quantidade`. Mas isso resolve o problema do objeto inteiro?

```java
item.precoUnitario = -200.0;
item.descricao = "";
```

!!! activity "Atividade — transferir dentro do mesmo objeto"

    Discuta sem implementar uma refatoração completa:

    1. preço negativo representa um estado válido para este item?
    2. descrição vazia representa um estado válido?
    3. quem deveria decidir se esses estados fazem sentido?
    4. proteger apenas `quantidade` preserva todas as regras de `ItemPedido`?

O objetivo não é tornar todos os campos privados nem criar getters, setters, validações e construtores agora. O contraste mostra que a responsabilidade do objeto não termina em um campo específico.

## Encapsulamento

Agora podemos nomear a ideia construída ao longo da aula.

!!! conceito-chave "Conceito-chave — encapsulamento"

    Encapsular é estabelecer uma fronteira para que o objeto controle como seu estado pode ser consultado e alterado.

    - operações públicas formam o conjunto de operações disponíveis ao código externo;
    - campos privados ajudam a impedir alterações diretas;
    - comportamentos preservam intenções e regras do objeto;
    - encapsular não significa gerar getters e setters automaticamente.

`private` é um mecanismo importante dessa fronteira, mas não decide sozinho se o conjunto de operações oferecido pela classe é adequado. Uma classe cheia de setters genéricos pode continuar entregando suas decisões ao código externo.

Encapsulamento, portanto, não serve apenas para proteger um campo escolhido. Ele ajuda o objeto a preservar estados e mudanças coerentes com o problema que representa.

## Quando uma solicitação é rejeitada

Em nossa implementação, `aumentarQuantidade(-10)` mantém o estado inalterado. Isso garante que o objeto não aceite a alteração inválida, mas deixa outra pergunta:

> Quem chamou não deveria saber que a solicitação foi rejeitada?

Hoje nosso foco é preservar o estado do objeto. Como comunicar a rejeição ao código externo é outra decisão de projeto, que discutiremos quando essa necessidade aparecer.

## Fechando a trajetória

!!! synthesis "Síntese"

    - `private` cria uma fronteira contra o acesso direto ao campo;
    - código externo solicita operações, em vez de escolher livremente o estado;
    - comportamentos podem preservar as regras das mudanças;
    - consultas podem ser oferecidas sem devolver o controle da alteração;
    - encapsulamento é controle intencional da evolução do estado, não geração mecânica de getters e setters.

## Uma pergunta que ainda permanece

Considere novamente:

```java
ItemPedido item = new ItemPedido();
```

Nesse instante, `quantidade` começa em `0`, mas descrição e preço ainda não foram informados. Como garantir que um objeto já nasça com os dados necessários e em um estado válido?

Construtores entram nessa história, mas ainda não precisamos abrir esse assunto. Primeiro vamos consolidar como um objeto controla as alterações feitas depois de sua criação.

## Material da aula

- [Laboratório 04 — Controlando alterações de estado](laboratorio-04-controlando-alteracoes-de-estado.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
