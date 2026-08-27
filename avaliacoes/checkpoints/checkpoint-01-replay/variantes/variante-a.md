---
tipo: checkpoint
identificador: checkpoint-01-replay
titulo: Checkpoint 1
pontos_totais: 100
---

# Cenário: medição de chuva

Considere um sistema que registra a quantidade de chuva acumulada em diferentes locais. Cada objeto da classe `MedidorChuva` representa um medidor e armazena o total de chuva registrado até o momento.

Os arquivos abaixo pertencem ao mesmo projeto e ao mesmo pacote.

**MedidorChuva.java**

```java
public class MedidorChuva {
    String local;
    double totalMilimetros;

    void registrarChuva(double milimetros) {
        totalMilimetros = totalMilimetros + milimetros;
    }

    double consultarTotal() {
        return totalMilimetros;
    }
}
```

**Main.java**

```java
public class Main {

    public static void main(String[] args) {
        MedidorChuva principal = new MedidorChuva();
        principal.totalMilimetros = 8.0;
        MedidorChuva apoio = principal;

        MedidorChuva outro = new MedidorChuva();
        outro.totalMilimetros = 8.0;

        System.out.println(principal == apoio);              // S1
        System.out.println(principal == outro);              // S2

        apoio = outro;
        System.out.println(apoio == outro);                  // S3

        apoio.registrarChuva(2.0);
        System.out.println(outro.consultarTotal());          // S4
        System.out.println(principal.consultarTotal());      // S5

        apoio = principal;
        apoio.registrarChuva(4.0);
        System.out.println(principal.consultarTotal());      // S6

        apoio.totalMilimetros = -2.0;
        principal.registrarChuva(3.0);
        System.out.println(principal.consultarTotal());      // S7
    }
}
```

# Questões

## Q01 [35 pontos]

Acompanhe, na ordem, a execução completa da classe `Main` e indique o valor exibido em cada uma das saídas identificadas de S1 a S7.

### a) [5 pontos]

Qual é a saída S1?

### b) [5 pontos]

Qual é a saída S2?

### c) [5 pontos]

Qual é a saída S3?

### d) [5 pontos]

Qual é a saída S4?

### e) [5 pontos]

Qual é a saída S5?

### f) [5 pontos]

Qual é a saída S6?

### g) [5 pontos]

Qual é a saída S7?

## Q02 [25 pontos]

Analise as afirmativas abaixo e assinale **(V)** para as verdadeiras e **(F)** para as falsas.

### a) [5 pontos]

Na classe `MedidorChuva`, os atributos `local` e `totalMilimetros` representam o estado do objeto, enquanto os métodos `registrarChuva` e `consultarTotal` representam os comportamentos que ele pode realizar.

### b) [5 pontos]

O parâmetro `milimetros`, recebido pelo método `registrarChuva`, existe apenas durante a execução do método e não faz parte do estado do objeto.

### c) [5 pontos]

O método `registrarChuva` é `void`: ele não devolve um valor, mas pode alterar os dados armazenados no objeto.

### d) [5 pontos]

Se uma variável receber o valor retornado por `consultarTotal()`, alterar essa variável depois não modifica o valor de `totalMilimetros` armazenado no objeto.

### e) [5 pontos]

Para que um método consulte ou altere um atributo do próprio objeto, esse atributo precisa aparecer entre os parâmetros do método.

## Q03 [10 pontos]

Agora queremos que cada `MedidorChuva` possa informar se o total de chuva acumulada atingiu um determinado limite.

Qual das propostas abaixo permite que o próprio objeto faça essa verificação usando o valor de `totalMilimetros` que ele já armazena?

A. Adicionar um atributo para guardar se o medidor está em alerta:

```java
boolean emAlerta;
```

B. Adicionar um método que compara o limite recebido com o total armazenado no próprio objeto:

```java
boolean atingiuAlerta(double limite) {
    return totalMilimetros >= limite;
}
```

C. Fazer a comparação diretamente na classe `Main`:

```java
boolean alerta = medidor.consultarTotal() >= limite;
```

D. Adicionar um método ao `MedidorChuva`, mas exigir que o total também seja informado:

```java
boolean atingiuAlerta(double total, double limite) {
    return total >= limite;
}
```

E. Permitir que outros trechos do programa acessem diretamente o total para fazer a comparação:

```java
public double totalMilimetros;
```

## Q04 [10 pontos]

Na versão inicial de `MedidorChuva`, o atributo `totalMilimetros` foi declarado sem um modificador de acesso:

```java
double totalMilimetros;
```

Mesmo assim, a classe `Main` consegue executar:

```java
principal.totalMilimetros = 8.0;
```

Considerando que `Main` e `MedidorChuva` pertencem ao mesmo pacote, qual alternativa explica corretamente por que esse acesso é permitido?

A. Porque todo atributo do tipo `double` pode ser acessado diretamente por qualquer classe do projeto.

B. Porque a criação do objeto com `new MedidorChuva()` torna seus atributos públicos.

C. Porque uma variável que guarda a referência de um objeto pode acessar qualquer atributo desse objeto, independentemente do modificador de acesso.

D. Porque um atributo declarado sem modificador de acesso pode ser acessado por outras classes do mesmo pacote.

E. Porque o método `main` possui permissão especial para acessar os atributos de qualquer classe.

## Q05 [10 pontos]

Na versão inicial de `MedidorChuva`, o atributo `totalMilimetros` pode ser alterado diretamente por qualquer código que tenha acesso ao objeto. Para controlar melhor essas alterações, considere agora que:

- `totalMilimetros` é `private`;
- cada `MedidorChuva` começa com total `0.0`;
- `registrarChuva` soma apenas valores maiores que zero;
- `consultarTotal` informa o total acumulado.

Considere o seguinte início:

```java
MedidorChuva principal = new MedidorChuva();
MedidorChuva apoio = principal;
```

Qual alternativa mantém `principal` e `apoio` apontando para o mesmo objeto e, ao final, faz `consultarTotal()` devolver `10.0` pelas duas referências?

A.

```java
principal.registrarChuva(6.0);
apoio = new MedidorChuva();
apoio.registrarChuva(4.0);
```

B.

```java
principal.registrarChuva(6.0);
apoio.consultarTotal();
apoio.registrarChuva(-2.0);
```

C.

```java
principal.registrarChuva(6.0);
apoio.registrarChuva(-2.0);
apoio.registrarChuva(4.0);
```

D.

```java
principal.registrarChuva(6.0);
apoio.registrarChuva(2.0);
apoio.registrarChuva(4.0);
```

E.

```java
principal.totalMilimetros = 6.0;
apoio.totalMilimetros = -2.0;
apoio.totalMilimetros = 10.0;
```

## Q06 [10 pontos]

Agora `totalMilimetros` é `private`, e seu valor só deve ser alterado por meio de `registrarChuva`, que aceita apenas valores maiores que zero.

Considere a proposta de adicionar o seguinte método à classe:

```java
public void definirTotal(double novoTotal) {
    totalMilimetros = novoTotal;
}
```

Essa mudança mantém o controle sobre as alterações de `totalMilimetros`?

A. Não. O método `definirTotal` permite substituir diretamente o valor de `totalMilimetros`, sem passar pela validação feita em `registrarChuva`.

B. Sim. Como `totalMilimetros` é `private`, nenhum método público pode atribuir diretamente um novo valor ao atributo.

C. Não. Um método `public` não pode alterar um atributo `private` da própria classe.

D. Sim. Como `definirTotal` pertence à própria classe, qualquer alteração realizada por ele respeita automaticamente as regras definidas para `MedidorChuva`.

E. Não. Ao receber `novoTotal` como parâmetro, `totalMilimetros` deixa de ser `private`.
