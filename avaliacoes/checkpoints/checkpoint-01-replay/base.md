---
tipo: checkpoint
identificador: checkpoint-01-replay
titulo: Checkpoint 1
pontos_totais: 100
---

# Cenário: medição de chuva

Cada objeto `MedidorChuva` registra em `totalMilimetros` a chuva acumulada em um local. Para interpretar o programa:

- todos os arquivos apresentados pertencem ao mesmo projeto e não declaram `package`;
- os comentários `S1` a `S7` identificam as linhas de saída;
- as modificações propostas nas questões são analisadas separadamente e não alteram a execução da `Main`.

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

Considere a execução completa da classe `Main`. Informe as saídas S1 a S7.

### a) [5 pontos]

Saída S1.

### b) [5 pontos]

Saída S2.

### c) [5 pontos]

Saída S3.

### d) [5 pontos]

Saída S4.

### e) [5 pontos]

Saída S5.

### f) [5 pontos]

Saída S6.

### g) [5 pontos]

Saída S7.

## Q02 [25 pontos]

Marque (V) para verdadeira e (F) para falsa.

### a) [5 pontos]

Na classe `MedidorChuva`, `local` e `totalMilimetros` representam estado, enquanto `registrarChuva` e `consultarTotal` representam comportamento.

### b) [5 pontos]

`milimetros` é um parâmetro de `registrarChuva`; ele não se torna um campo nem passa a fazer parte do estado do objeto.

### c) [5 pontos]

O retorno `void` de `registrarChuva` significa que o método não devolve um valor; isso não impede que ele altere o estado do objeto.

### d) [5 pontos]

Uma variável recebe o valor retornado por `consultarTotal()`. Alterar essa variável depois não altera `totalMilimetros` do objeto.

### e) [5 pontos]

`registrarChuva` só consegue usar `totalMilimetros` se esse valor também for recebido como parâmetro.

## Q03 [10 pontos]

Um `MedidorChuva` deve informar se seu total atingiu um limite. Qual proposta atribui essa responsabilidade ao próprio objeto?

A. Em `MedidorChuva`, armazenar a resposta em um campo:

```java
boolean emAlerta;
```

B. Em `MedidorChuva`, calcular a resposta a partir do próprio estado:

```java
boolean atingiuAlerta(double limite) {
    return totalMilimetros >= limite;
}
```

C. Em `Main`, fazer a comparação:

```java
boolean alerta = medidor.consultarTotal() >= limite;
```

D. Em `MedidorChuva`, criar um método que recebe o total em vez de usar o estado do objeto:

```java
boolean atingiuAlerta(double total, double limite) {
    return total >= limite;
}
```

E. Em `MedidorChuva`, expor o campo para comparação externa:

```java
public double totalMilimetros;
```

## Q04 [10 pontos]

Mesmo que `registrarChuva` rejeitasse valores negativos, por que a primeira versão não conseguiria garantir que `totalMilimetros` nunca fosse negativo?

A. Porque qualquer cliente no mesmo pacote pode escrever diretamente no campo e ignorar a regra do método.

B. Porque duas referências para o mesmo objeto ignoram automaticamente a regra do método.

C. Porque campos não podem ter suas alterações controladas por métodos da própria classe.

D. Porque a regra de `registrarChuva` só funciona quando o total anterior é zero.

E. Porque `consultarTotal()` devolve o campo e permite que o cliente o altere diretamente.

## Q05 [10 pontos]

Na versão encapsulada de `MedidorChuva`:

- `totalMilimetros` é `private` e começa em `0.0`;
- `registrarChuva` acumula somente valores maiores que zero;
- `consultarTotal` devolve o total atual.

No código cliente, `principal` e `apoio` começam apontando para o mesmo objeto:

```java
MedidorChuva principal = new MedidorChuva();
MedidorChuva apoio = principal;
```

Qual continuação mantém as duas referências no mesmo objeto, rejeita o registro `-2.0` e faz `principal.consultarTotal()` e `apoio.consultarTotal()` devolverem `10.0`?

A.

```java
principal.registrarChuva(6.0);
apoio.registrarChuva(-2.0);
apoio.registrarChuva(4.0);
```

B.

```java
principal.registrarChuva(6.0);
apoio = new MedidorChuva();
apoio.registrarChuva(4.0);
```

C.

```java
principal.totalMilimetros = 6.0;
apoio.totalMilimetros = -2.0;
apoio.totalMilimetros = 10.0;
```

D.

```java
principal.registrarChuva(6.0);
apoio.consultarTotal();
apoio.registrarChuva(-2.0);
```

E.

```java
principal.registrarChuva(6.0);
apoio.registrarChuva(2.0);
apoio.registrarChuva(4.0);
```

## Q06 [10 pontos]

Considere a classe depois da implementação da regra de Q05:

> O total acumulado só pode mudar por registros maiores que zero. Nenhum cliente pode substituir diretamente o total por um valor arbitrário.

Alguém propõe acrescentar este método:

```java
public void definirTotal(double novoTotal) {
    totalMilimetros = novoTotal;
}
```

Essa modificação preserva a regra de negócio da classe?

A. Sim. O campo `private` impede que qualquer método público substitua seu valor.

B. Não. `definirTotal` permite substituir o total sem validar um registro de chuva.

C. Sim. Todo método da própria classe preserva automaticamente suas regras de negócio.

D. Não. Um método público não pode alterar um campo `private`.

E. Não. Receber `novoTotal` como parâmetro torna o campo público.
