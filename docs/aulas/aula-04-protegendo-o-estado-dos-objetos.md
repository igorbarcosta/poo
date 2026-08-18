---
icon: material/school-outline
---

# Aula 04 — Protegendo o estado dos objetos

Na Aula 03, vimos que diferentes variáveis podem permitir acesso ao mesmo objeto. Na estrutura atual do Projeto 1, qualquer trecho que tenha acesso a um `ItemPedido` também pode alterar diretamente seus campos. Agora vamos investigar as consequências dessa liberdade.

**Pergunta central**

> Se um objeto é responsável pelo próprio estado, qualquer parte do programa deveria poder modificá-lo diretamente?

## Objetivos

Ao final deste encontro, você deverá ser capaz de:

- reconhecer problemas causados pela exposição direta do estado de um objeto;
- distinguir um valor permitido pela linguagem de um valor adequado ao domínio;
- compreender o efeito básico de `private` sobre o acesso a um campo;
- compreender que comportamentos podem controlar alterações de estado;
- diferenciar consulta ao estado de alteração direta do estado;
- explicar por que encapsulamento não significa simplesmente criar getters e setters para todos os campos;
- analisar uma classe simples e identificar formas mais adequadas de proteger seu estado.

## Conteúdo

### Retomando o problema da Aula 03

Na estrutura atual de `ItemPedido`, podemos fazer uma alteração adequada ao problema:

```java
ItemPedido item = new ItemPedido();
item.quantidade = 2;
```

Mas também podemos escrever:

```java
item.quantidade = -200;
```

Discuta:

- o Java aceita essa atribuição?
- o programa pode continuar executando?
- esse valor faz sentido para um item de pedido?
- quem deveria decidir se essa alteração é aceitável?

!!! conceito-chave "Conceito-chave — validade no domínio"

    Um valor ser aceito pela linguagem não significa que seja válido para o problema que estamos modelando.

### O problema da exposição direta

Quando o campo está diretamente acessível, diferentes trechos do programa podem decidir seu valor:

```java
item.quantidade = 2;
```

```java
item.quantidade = 1000;
```

```java
item.quantidade = -5;
```

O problema não se resume aos números negativos. Se qualquer código externo decide diretamente o valor do campo, `ItemPedido` não controla como seu próprio estado evolui.

Se `quantidade` faz parte do estado de `ItemPedido`, faz sentido que o próprio item participe da decisão sobre como essa quantidade pode mudar.

### Estabelecendo uma fronteira com `private`

Compare as declarações:

```java
int quantidade;
```

```java
private int quantidade;
```

`private` restringe o acesso ao campo ao código da própria classe. Os métodos de `ItemPedido` continuam podendo utilizar `quantidade`:

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

Depois dessa mudança, um acesso externo como este deixa de ser permitido:

```java
item.quantidade = -200;
```

O erro de compilação é uma informação útil: ele mostra que a classe passou a estabelecer uma fronteira para o acesso direto ao campo.

!!! java-focus "Java em foco — `private` e `public`"

    - `private`: o membro pode ser acessado somente dentro da própria classe;
    - `public`: o membro é disponibilizado para uso externo à classe.

Temos ainda um detalhe necessário para acompanhar a próxima alteração. Quando nenhum valor é atribuído explicitamente, um campo `int` de um objeto começa com `0`.

!!! java-focus "Java em foco — valor inicial do campo"

    Neste exemplo, `quantidade` começa com `0`. Esse valor inicial permitirá aumentar a quantidade por meio de um comportamento, sem depender de uma atribuição direta em `Main`.

### Alterando o estado por meio de um comportamento

Proteger o campo cria uma nova pergunta: se o código externo não pode mais atribuir diretamente a quantidade, como uma mudança legítima deve acontecer?

Podemos representar essa mudança como um comportamento de `ItemPedido`:

```java
public void aumentarQuantidade(int unidades) {
    if (unidades > 0) {
        quantidade += unidades;
    }
}
```

Compare:

```java
item.quantidade = 5;
```

```java
item.aumentarQuantidade(5);
```

Na atribuição direta, o código externo decide o novo estado. No segundo caso, ele solicita uma operação, e o próprio objeto decide como seu estado será alterado.

O comportamento também pode preservar uma regra. Ao receber um valor menor ou igual a zero, o método simplesmente não altera a quantidade:

```java
item.aumentarQuantidade(-10);
```

### Consultando sem alterar diretamente

Com `quantidade` privada, este acesso também deixa de ser permitido:

```java
System.out.println(item.quantidade);
```

Impedir a alteração direta não significa impedir a consulta. A classe pode disponibilizar uma operação para informar o valor atual:

```java
public int getQuantidade() {
    return quantidade;
}
```

O código externo passa a consultar assim:

```java
System.out.println(item.getQuantidade());
```

**Consulta e alteração**

> Permitir consultar um valor não significa permitir modificá-lo diretamente.

### Encapsulamento não é getter mais setter

Considere esta possibilidade:

```java
public void setQuantidade(int novaQuantidade) {
    quantidade = novaQuantidade;
}
```

Se qualquer código puder executar `item.setQuantidade(-200)`, o problema foi realmente resolvido?

Não necessariamente. Encapsular não é apenas esconder campos: é controlar como o estado pode ser observado e modificado. Por isso, não criaremos getters e setters automaticamente para todos os campos. Um método deve existir porque representa uma interação necessária com o objeto, e um comportamento com intenção pode ser mais adequado que um setter genérico.

Nesta aula, protegeremos primeiro apenas `quantidade` para compreender o mecanismo. `descricao` e `precoUnitario` podem permanecer temporariamente como estão. Ainda não resolveremos como garantir que todos esses dados sejam informados ao criar o objeto.

## Atividade de compreensão

Considere outro domínio:

```java
class Conta {
    double saldo;
}
```

Com o campo exposto, um trecho externo pode fazer:

```java
conta.saldo = -5000;
```

Discuta com um colega:

1. Qual problema existe na alteração direta de `saldo`?
2. Quem deveria controlar mudanças nesse estado?
3. Quais comportamentos poderiam representar melhor operações legítimas?

Operações como `depositar(...)` e `sacar(...)` podem surgir na discussão. Não é necessário implementar a classe nem definir regras bancárias completas.

### Aprofundamento se o ritmo permitir

!!! activity "Atividade — diagnosticar uma solução aparentemente protegida"

    Compare uma classe que expõe `setQuantidade(int valor)` sem verificar o valor recebido com outra que oferece `aumentarQuantidade(int unidades)` e preserva a regra `unidades > 0`.

    1. Responda individualmente: as duas soluções protegem o estado da mesma forma?
    2. Discuta a resposta com um colega.
    3. Revise sua resposta e justifique qual operação comunica melhor a intenção do domínio.

    O objetivo não é adicionar outro mecanismo de Java, mas usar encapsulamento e responsabilidade para diagnosticar duas decisões possíveis.

## Síntese

- objetos possuem estado;
- a exposição direta permite que código externo modifique esse estado;
- um valor aceito pela linguagem pode ser inadequado para o domínio;
- `private` restringe o acesso direto;
- comportamentos podem controlar mudanças;
- consultas podem ser disponibilizadas sem permitir alteração direta;
- encapsulamento envolve proteger as regras do objeto;
- encapsulamento não significa criar getters e setters mecanicamente.

## Questão em aberto

Considere novamente:

```java
ItemPedido item = new ItemPedido();
```

Nesse instante, qual é a quantidade? E a descrição e o preço? Quem garante que um `ItemPedido` seja criado já com os dados necessários?

Esse problema será retomado posteriormente. Por enquanto, vamos consolidar como o objeto pode proteger as alterações do próprio estado.

## Material da aula

- [Laboratório 04 — Controlando alterações de estado](laboratorio-04-controlando-alteracoes-de-estado.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
