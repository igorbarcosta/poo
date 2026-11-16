---
type: exam
identifier: unidade-02
title: Prova da Unidade 02
total_points: 100
---

# Programação Orientada a Objetos — Unidade 02

A prova possui vinte questões, cada uma valendo 5 pontos. Nas questões de múltipla escolha, assinale uma única alternativa. Nas questões de saída, escreva o que será impresso pelo código, na ordem em que aparece e com uma linha para cada `println`. Duração de referência: 90 minutos.

O código de referência está no cenário ao final da prova.

Cada questão é independente; as alterações propostas valem apenas nela. As classes e interfaces ficam em arquivos separados do mesmo projeto, sem `package`.

Os colaboradores são diferentes de `null`. Considere disponíveis os imports de `List` e `ArrayList` e, nos testes, `assertEquals` e `assertTrue` do JUnit.

# Questões

## Q1 [5 points] {#q-u02-001}

Qual alternativa descreve a distribuição de responsabilidades do código apresentado?

A) `Nave` mantém o total de tiros; `Arma` decide quando a partida termina; `Partida` escolhe o tipo de disparo.

B) `Partida` decide o tipo de disparo; `Nave` mantém a contagem de acionamentos de cada arma; `Arma` controla as vidas.

C) `Nave` consulta a partida e solicita o disparo; `Arma` registra seus acionamentos; `Partida` mantém vidas e total de tiros.

D) `DisparoRepetido` controla as vidas; `Arma` mantém o total de tiros da partida; `Partida` apenas recebe consultas.

E) `Nave` controla as vidas e os acionamentos da arma; `Partida` escolhe quantos tiros cada implementação produz.

## Q2 [5 points] {#q-u02-002}

Escreva a saída produzida pelo trecho abaixo.

```java
Partida p = new Partida();
for (int i = 0; i < 5; i++) {
    p.perderVida();
}
p.registrarTiros(2);
System.out.println(p.getVidas());
System.out.println(p.getTiros());
System.out.println(p.terminou());
```

## Q3 [5 points] {#q-u02-003}

Escreva a saída produzida pelo trecho abaixo.

```java
Partida p = new Partida();
ArmaDupla arma = new ArmaDupla();
Nave n = new Nave(p, arma);
n.disparar();
n.disparar();
System.out.println(p.getTiros());
System.out.println(arma.getAcionamentos());
```

## Q4 [5 points] {#q-u02-004}

Ao executar o trecho abaixo, qual sequência de chamadas realiza o disparo?

```java
Partida p = new Partida();
Disparo d = new ArmaDupla();
Nave n = new Nave(p, d);
n.disparar();
```

A) `Nave.disparar` executa diretamente `ArmaDupla.quantidadeTiros`, sem passar pelo método de `Arma`.

B) `Nave.disparar` chama `Arma.disparar`, que usa `ArmaDupla.quantidadeTiros` no mesmo objeto de arma.

C) `Nave.disparar` chama uma implementação de `disparar` definida dentro da interface `Disparo`.

D) `Arma.disparar` cria uma `ArmaDupla` para executar `quantidadeTiros` em um segundo objeto.

E) `Arma.disparar` procura `quantidadeTiros` em `Nave`, pois a solicitação começou nela.

## Q5 [5 points] {#q-u02-005}

Após as declarações abaixo, analise cada chamada isoladamente. Quais compilam sem acrescentar casts?

```java
Partida p = new Partida();
ArmaDupla arma = new ArmaDupla();
Disparo d = arma;
Contabilizavel c = arma;

// I:   d.disparar(p);
// II:  d.getAcionamentos();
// III: c.getAcionamentos();
// IV:  c.disparar(p);
```

A) Apenas I e II.

B) Apenas II e III.

C) Apenas I e IV.

D) Apenas I e III.

E) Apenas III e IV.

## Q6 [5 points] {#q-u02-006}

Escreva a saída produzida pelo trecho abaixo.

```java
Partida p = new Partida();
ArmaSimples a = new ArmaSimples();
ArmaDupla b = new ArmaDupla();
List<Disparo> opcoes = new ArrayList<>();
opcoes.add(a);
opcoes.add(b);
for (Disparo d : opcoes) {
    d.disparar(p);
}
System.out.println(p.getTiros());
System.out.println(a.getAcionamentos());
System.out.println(b.getAcionamentos());
```

## Q7 [5 points] {#q-u02-007}

Uma classe nova, `DisparoTriplo`, implementa `Disparo` diretamente e registra três tiros por chamada. Ela será usada por uma nova nave. Qual alteração basta para integrar esse comportamento à nave existente?

A) Alterar o campo de `Nave` para `DisparoTriplo` e reescrever todas as chamadas a `disparar`.

B) Acrescentar em `Nave.disparar` uma condição que reconheça `DisparoTriplo` antes de disparar.

C) Criar a implementação e passá-la ao construtor de `Nave`, preservando o código da classe `Nave`.

D) Fazer `DisparoTriplo` estender `ArmaDupla`, pois apenas subclasses de `Arma` são aceitas pela nave.

E) Acrescentar `dispararTriplo` à interface e trocar a chamada de `Nave` para esse novo método.

## Q8 [5 points] {#q-u02-008}

Escreva a saída produzida pelo trecho abaixo.

```java
ArmaSimples arma = new ArmaSimples();
Partida p1 = new Partida();
Partida p2 = new Partida();
Nave n1 = new Nave(p1, arma);
Nave n2 = new Nave(p2, arma);
n1.disparar();
n2.disparar();
System.out.println(arma.getAcionamentos());
System.out.println(p1.getTiros());
System.out.println(p2.getTiros());
```

## Q9 [5 points] {#q-u02-009}

Escreva a saída produzida pelo trecho abaixo.

```java
Partida p = new Partida();
Disparo base = new ArmaSimples();
Disparo repetido = new DisparoRepetido(base);
base = new ArmaDupla();
repetido.disparar(p);
System.out.println(p.getTiros());
```

## Q10 [5 points] {#q-u02-010}

Escreva a saída produzida pelo trecho abaixo.

```java
Partida p = new Partida();
ArmaDupla arma = new ArmaDupla();
Disparo d = new DisparoRepetido(
    new DisparoRepetido(arma));
d.disparar(p);
System.out.println(p.getTiros());
System.out.println(arma.getAcionamentos());
```

## Q11 [5 points] {#q-u02-011}

Um aluno substitui apenas o corpo do construtor de `DisparoRepetido` pela linha abaixo. O que essa mudança compromete?

```java
this.base = new ArmaSimples();
```

A) O objeto recebido passa a ter seu contador zerado sempre que o repetidor é criado.

B) A interface deixa de permitir que a nave chame o método `disparar` do repetidor.

C) O repetidor passa a compartilhar a mesma arma simples entre todas as suas instâncias.

D) A reatribuição posterior da variável do cliente passa a trocar a arma interna do repetidor.

E) O repetidor deixa de usar o colaborador recebido e passa a repetir sempre uma arma simples criada por ele.

## Q12 [5 points] {#q-u02-012}

Uma nova classe, `DisparoComExtra`, guarda no campo `base` um `Disparo` recebido. Ela deve solicitar um disparo a esse colaborador e, em seguida, registrar um tiro adicional na mesma partida. Qual corpo de `disparar(Partida partida)` cumpre esse requisito?

A) 

```java
base.disparar(new Partida());
partida.registrarTiros(1);
```

B) 

```java
new ArmaSimples().disparar(partida);
partida.registrarTiros(1);
```

C) 

```java
base.disparar(partida);
partida.registrarTiros(1);
```

D) 

```java
base.disparar(partida);
base.disparar(partida);
```

E) 

```java
partida.registrarTiros(2);
```

## Q13 [5 points] {#q-u02-013}

A classe `Arma` foi declarada abstrata. Qual uso é permitido e corresponde ao papel dessa base no sistema?

A) Criar `new Arma()` e escolher a implementação de `quantidadeTiros` depois da construção.

B) Declarar `Arma a = new ArmaSimples()`, mas reimplementar `disparar` em toda subclasse, pois o corpo da base não é herdado.

C) Criar `new Arma()` apenas para consultar seu contador, sem chamar o método abstrato.

D) Declarar `Arma a = new ArmaSimples()` e usar nela o método concreto `disparar` herdado da base.

E) Usar uma referência `Arma` somente como parâmetro de construtor, sem chamar métodos por ela.

## Q14 [5 points] {#q-u02-014}

Ao executar `new ArmaDupla()`, qual afirmação descreve corretamente o efeito de `super()` e o estado inicial do objeto?

A) O construtor de `Arma` inicializa o contador do mesmo objeto que está sendo criado como `ArmaDupla`.

B) O construtor cria uma `Arma` separada, que passa a ser o colaborador interno da `ArmaDupla`.

C) Um contador é criado em `Arma` e outro em `ArmaDupla`; os dois são incrementados a cada disparo.

D) O contador passa a ser compartilhado entre todas as armas porque foi declarado na superclasse.

E) O contador só é inicializado quando a primeira chamada a `quantidadeTiros` acontece.

## Q15 [5 points] {#q-u02-015}

Queremos repetir tanto armas simples quanto duplas, sem duplicar a sequência de repetição para cada tipo de arma. Por que a composição usada em `DisparoRepetido` atende a esse requisito?

A) Porque uma subclasse recebe automaticamente as implementações de todas as classes que cumprem a mesma interface.

B) Porque o repetidor guarda um `Disparo` e reutiliza a mesma sequência de chamadas com colaboradores diferentes.

C) Porque implementar `Disparo` faz o repetidor herdar o contador privado da classe `Arma`.

D) Porque o campo `base` faz o repetidor e a arma recebida se tornarem um único objeto.

E) Porque o repetidor altera o método `quantidadeTiros` da arma recebida antes de chamá-la.

## Q16 [5 points] {#q-u02-016}

Considere o teste de capacidade e o cast abaixo. Qual afirmação descreve corretamente o que acontece?

```java
Disparo d = new ArmaDupla();
if (d instanceof Contabilizavel) {
    Contabilizavel c = (Contabilizavel) d;
    int acionamentos = c.getAcionamentos();
}
```

A) O cast cria uma cópia da arma, e `c` consulta o contador dessa cópia.

B) O cast transforma a arma em um objeto da classe `Contabilizavel`, que passa a armazenar o contador.

C) O cast permite usar a capacidade de consulta do mesmo objeto `ArmaDupla`, sem criar outra arma.

D) O `instanceof` acrescenta a capacidade à arma; antes do teste, o objeto cumpria apenas `Disparo`.

E) O cast é válido porque qualquer objeto guardado em uma variável `Disparo` oferece `getAcionamentos`.

## Q17 [5 points] {#q-u02-017}

Escreva a saída produzida pelo trecho abaixo.

```java
Disparo d = new DisparoRepetido(
    new ArmaDupla());
System.out.println(d instanceof Contabilizavel);
```

## Q18 [5 points] {#q-u02-018}

Um aluno remove de `Nave.disparar()` o trecho abaixo.

```java
if (partida.terminou()) {
    return;
}
```

Cada alternativa parte destes objetos novos:

```java
Partida p = new Partida();
ArmaSimples arma = new ArmaSimples();
Nave n = new Nave(p, arma);
```

Qual teste passa com o código original e falha após essa remoção?

A)

```java
n.disparar();
assertEquals(1, arma.getAcionamentos());
```

B)

```java
n.disparar();
n.disparar();
assertEquals(2, arma.getAcionamentos());
```

C)

```java
p.perderVida();
n.disparar();
assertEquals(1, arma.getAcionamentos());
```

D)

```java
p.perderVida();
p.perderVida();
p.perderVida();
n.disparar();
assertEquals(0, arma.getAcionamentos());
```

E)

```java
p.perderVida();
p.perderVida();
p.perderVida();
n.disparar();
assertEquals(0, p.getTiros());
```

## Q19 [5 points] {#q-u02-019}

O teste abaixo usa o colaborador de apoio `DisparoRegistro`. Se ele passar, qual conclusão é sustentada pelas verificações?

```java
Partida p = new Partida();
DisparoRegistro r = new DisparoRegistro();
Disparo d = new DisparoRepetido(r);
d.disparar(p);

assertEquals(2, r.getChamadas());
assertTrue(r.getUltimaPartida() == p);
```

A) Houve duas chamadas ao registro, e a última recebeu `p`; o teste não verifica qual partida a primeira chamada recebeu.

B) As duas chamadas receberam `p`, pois guardar o último argumento permite conferir todos os argumentos anteriores.

C) A partida recebeu dois tiros, pois toda implementação de `Disparo` deve aumentar o contador de tiros.

D) Nenhuma outra partida foi criada durante a execução, pois o último argumento continua sendo `p`.

E) Qualquer implementação de `DisparoRepetido` está correta para todos os colaboradores e todas as partidas.

## Q20 [5 points] {#q-u02-020}

Um aluno acrescenta a sobrescrita abaixo em `ArmaDupla`, mantendo o restante da classe. O total de tiros continua correto para uma chamada, mas a regra de contagem de acionamentos precisa ser preservada. Qual verificação revela o problema após `arma.disparar(p)`, com `arma` e `p` novos?

```java
@Override
public void disparar(Partida partida) {
    partida.registrarTiros(2);
}
```

A) `assertEquals(2, p.getTiros());`

B) `assertEquals(3, p.getVidas());`

C) `assertEquals(1, arma.getAcionamentos());`

D) `assertTrue(arma instanceof Contabilizavel);`

E) `assertEquals(false, p.terminou());`

# Cenário

### Partida.java {#src-u02-partida}

```java
public class Partida {
    private int vidas;
    private int tiros;
    private boolean fim;

    public Partida() {
        vidas = 3;
        tiros = 0;
        fim = false;
    }

    public void registrarTiros(int quantidade) {
        if (!fim && quantidade > 0) {
            tiros += quantidade;
        }
    }

    public void perderVida() {
        if (fim) {
            return;
        }
        vidas--;
        if (vidas == 0) {
            fim = true;
        }
    }

    public int getVidas() { return vidas; }
    public int getTiros() { return tiros; }
    public boolean terminou() { return fim; }
}
```

### Disparo.java {#src-u02-disparo}

```java
public interface Disparo {
    void disparar(Partida partida);
}
```

### Nave.java {#src-u02-nave}

```java
public class Nave {
    private Partida partida;
    private Disparo disparo;

    public Nave(Partida partida,
                Disparo disparo) {
        this.partida = partida;
        this.disparo = disparo;
    }

    public void disparar() {
        if (partida.terminou()) {
            return;
        }
        disparo.disparar(partida);
    }
}
```

### Contabilizavel.java {#src-u02-contabilizavel}

```java
public interface Contabilizavel {
    int getAcionamentos();
}
```

### Arma.java {#src-u02-arma}

```java
public abstract class Arma
        implements Disparo, Contabilizavel {
    private int acionamentos;

    protected Arma() {
        acionamentos = 0;
    }

    @Override
    public void disparar(Partida partida) {
        partida.registrarTiros(
            quantidadeTiros());
        acionamentos++;
    }

    @Override
    public int getAcionamentos() {
        return acionamentos;
    }

    protected abstract int quantidadeTiros();
}
```

### ArmaSimples.java {#src-u02-armasimples}

```java
public class ArmaSimples extends Arma {
    public ArmaSimples() {
        super();
    }

    @Override
    protected int quantidadeTiros() {
        return 1;
    }
}
```

### ArmaDupla.java {#src-u02-armadupla}

```java
public class ArmaDupla extends Arma {
    public ArmaDupla() {
        super();
    }

    @Override
    protected int quantidadeTiros() {
        return 2;
    }
}
```

### DisparoRepetido.java {#src-u02-disparorepetido}

```java
public class DisparoRepetido implements Disparo {
    private Disparo base;

    public DisparoRepetido(Disparo base) {
        this.base = base;
    }

    @Override
    public void disparar(Partida partida) {
        base.disparar(partida);
        base.disparar(partida);
    }
}
```

### DisparoRegistro.java {#src-u02-disparoregistro}

```java
public class DisparoRegistro implements Disparo {
    private int chamadas = 0;
    private Partida ultimaPartida = null;

    @Override
    public void disparar(Partida partida) {
        chamadas++;
        ultimaPartida = partida;
    }

    public int getChamadas() {
        return chamadas;
    }

    public Partida getUltimaPartida() {
        return ultimaPartida;
    }
}
```
