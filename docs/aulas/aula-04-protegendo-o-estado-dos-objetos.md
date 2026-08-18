---
icon: material/school-outline
---

# Aula 04 — Protegendo o estado dos objetos

Na Aula 03, vimos que duas variáveis podem permitir acesso ao mesmo objeto. Agora precisamos investigar uma consequência dessa descoberta: se diferentes partes do programa chegam ao mesmo objeto, elas também podem tentar alterar diretamente o estado que compartilham.

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

    Sem executar o código, registre sua previsão:

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

O nome do método não resolve tudo sozinho. O ponto decisivo é quais mudanças a classe permite e quais regras ela assume a responsabilidade de preservar.

## Encapsulamento

Agora podemos nomear a ideia construída ao longo da aula.

!!! conceito-chave "Conceito-chave — encapsulamento"

    Encapsular é estabelecer uma fronteira para que o objeto controle como seu estado pode ser consultado e alterado.

    - operações públicas formam o conjunto de operações disponíveis ao código externo;
    - campos privados ajudam a impedir alterações diretas;
    - comportamentos preservam intenções e regras do objeto;
    - encapsular não significa gerar getters e setters automaticamente.

`private` é um mecanismo importante dessa fronteira, mas não decide sozinho se o conjunto de operações oferecido pela classe é adequado. Uma classe cheia de setters genéricos pode continuar entregando suas decisões ao código externo.

## Para aprofundar — transferindo a decisão

!!! activity "Atividade — proteger outro estado"

    Considere a classe:

    ```java
    class Conta {
        double saldo;
    }
    ```

    Em dupla:

    1. identifique o problema de permitir `conta.saldo = -5000`;
    2. proponha operações que expressem mudanças legítimas;
    3. explique quais decisões deveriam permanecer dentro de `Conta`;
    4. compare a proposta com a solução construída para `ItemPedido`.

    Não é necessário implementar a classe nem definir regras bancárias completas. O objetivo é transferir o raciocínio de encapsulamento para outro domínio.

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
