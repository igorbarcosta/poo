# Aula 21 — Quando uma operação não pode continuar

<!-- Artifact identity: lesson-poo-aula-21 -->

Na Aula 20, acompanhamos o movimento, o disparo e o impacto no Megamania.
Nem toda solicitação produz o efeito desejado: a nave pode estar em recarga,
um argumento pode ser inválido ou o código pode usar uma referência de forma
incorreta. Essas situações exigem decisões diferentes.

Vamos investigar como os objetos protegem seus contratos e como as mensagens
de erro ajudam a localizar uma falha antes de modificar o jogo.

**Slides:** [Apresentação HTML](../slides/rendered/aula-21-quando-uma-operacao-nao-pode-continuar.html) · [PDF](../slides/rendered/aula-21-quando-uma-operacao-nao-pode-continuar.pdf)

!!! lesson-question "Pergunta da aula"

    Quando uma operação não pode acontecer, como o objeto comunica isso?

!!! lesson-objectives "Ao final desta aula, você deve conseguir"

    - Distinguir uma recusa prevista de uma chamada que viola o contrato.
    - Acompanhar lançamento, propagação e captura de uma exceção.
    - Relacionar exceções comuns às suas causas no código.
    - Verificar a rejeição de uma chamada e o estado preservado pelo objeto.

## Duas operações recusadas, dois contratos

Em `Nave.tentarDisparar`, a nave pode recusar uma solicitação sem produzir
um projétil:

```java
public Projetil tentarDisparar() {
    if (!estaVivo() || esperaDisparo > 0) {
        return null;
    }

    esperaDisparo = 0.22;
    return new Projetil(getCentroX() - 3, getY() + getAltura(), true);
}
```

Solicitar outro disparo durante a recarga é uma possibilidade normal do jogo.
A operação foi definida como uma **tentativa**: seu cliente precisa considerar
o retorno `null`.

Já o construtor de `Partida` exige um colaborador para movimentar a formação:

```java
public Partida(MovimentoFormacao movimento) {
    if (movimento == null) {
        throw new IllegalArgumentException("A partida precisa de um movimento.");
    }

    this.movimento = movimento;
    // A criação dos inimigos continua aqui no código completo.
}
```

O trecho é um recorte do construtor real. Nesse contrato, fornecer `null`
é uma chamada inválida. A execução não deve prosseguir como se a partida
tivesse recebido o colaborador necessário.

Considere os dois experimentos independentes:

```java
// Experimento A
Nave nave = new Nave();
Projetil primeiro = nave.tentarDisparar();
Projetil segundo = nave.tentarDisparar();
System.out.println(segundo == null);
```

```java
// Experimento B
Partida partida = new Partida(null);
System.out.println("Partida criada");
```

O que acontece em cada um? Por que os resultados são diferentes?

??? "Ver resposta"

    - **A:** imprime `true`. O primeiro disparo ativa a recarga; a segunda
      tentativa devolve `null`. O método termina normalmente.
    - **B:** lança `IllegalArgumentException`. A atribuição não se completa
      e a mensagem `Partida criada` não é impressa nessa sequência sem captura.
    - A recarga é uma condição prevista da tentativa. O construtor, por sua
      vez, exige uma referência válida para o movimento.

!!! conceito-chave "Conceito-chave — a falha também faz parte do contrato"

    Uma operação deve comunicar tanto o resultado aceito quanto as situações
    em que não pode realizá-lo. Retorno normal e exceção expressam caminhos
    diferentes; a escolha depende do contrato da operação.

O Megamania também devolve `false` quando um projétil não atinge um alvo.
Isso não exige transformar toda tentativa sem efeito em exceção.

## O que muda no fluxo quando há um `throw`?

Uma exceção é um objeto que comunica uma ocorrência que interrompe o fluxo
normal. No construtor anterior, `new IllegalArgumentException(...)` cria
esse objeto com uma mensagem; `throw` o lança.

O lançamento interrompe a execução normal daquele ponto. Se o método não
tratar a exceção, ela se propaga ao chamador, que também pode não tratá-la.
Java procura um tratador compatível ao longo das chamadas em andamento.
Sem um tratador, a thread termina e normalmente um diagnóstico é exibido.

### Observar a captura em um programa de diagnóstico

O código abaixo é uma experiência para estudar o fluxo, sem abrir a janela.
Ele não faz parte da implementação atual do jogo. Os imports dão acesso às
classes do exemplo; salve-o como `Diagnostico.java` na área de código-fonte
do módulo `exemplo-megamania` se quiser executá-lo pela IDE.

```java
import br.edu.ifpb.jogos.megamania.modelo.MovimentoFormacao;
import br.edu.ifpb.jogos.megamania.modelo.Partida;

public class Diagnostico {
    public static void main(String[] args) {
        System.out.println("Antes");
        try {
            criarPartida(null);
            System.out.println("Criada");
        } catch (IllegalArgumentException erro) {
            System.out.println("Recusada: " + erro.getMessage());
        }
        System.out.println("Depois");
    }

    private static Partida criarPartida(MovimentoFormacao movimento) {
        return new Partida(movimento);
    }
}
```

Preveja a saída e localize por quais métodos a exceção passa até ser capturada.

??? "Ver resposta"

    ```text
    Antes
    Recusada: A partida precisa de um movimento.
    Depois
    ```

    1. O construtor de `Partida` lança a exceção.
    2. `criarPartida` não a captura; o retorno normal não se completa.
    3. O `catch` em `main` recebe a exceção e imprime sua mensagem.
    4. O fluxo continua depois do `try/catch`. `Criada` não é impresso.

!!! java-focus "Java em foco — `try` e `catch`"

    - `try` delimita as instruções cuja exceção pode ser tratada ali.
    - `catch (IllegalArgumentException erro)` recebe uma exceção desse tipo
      ou de um subtipo. `erro` referencia o objeto lançado.
    - `getMessage()` consulta a mensagem; não é o percurso de chamadas.
    - A captura não repete a instrução que falhou nem retoma a próxima
      instrução dentro do `try`.

Se nenhuma exceção ocorrer, o `catch` é pulado. Se ocorrer uma exceção que
não corresponde ao tipo capturado, ela continua se propagando. Por exemplo,
esse `catch` não trata uma `NullPointerException`.

### Quem tem condições de tratar?

No programa de diagnóstico, o objetivo é executar uma tentativa e informar
sua recusa. Por isso a captura tem uma função clara. Em uma aplicação que
receba uma configuração externa, uma fronteira de entrada pode rejeitar a
configuração e pedir sua correção, quando essa interação estiver prevista.

Já uma direção inválida produzida pelo próprio código do jogo pede a
investigação do cálculo ou da tradução de entrada. Capturar a exceção em
cada quadro e continuar com os mesmos dados esconderia o defeito.

!!! trap "Armadilha — capturar não conserta a causa"

    Um `catch` vazio ou um `catch (Exception erro)` que apenas permite
    continuar pode esconder falhas diferentes. Capture quando houver uma
    resposta definida e segura para aquela situação; caso contrário,
    preserve o diagnóstico para corrigir a origem.

## Da mensagem ao trecho que precisa de correção

Se o programa de diagnóstico fosse executado sem o `try/catch`, o console
poderia apresentar o percurso abaixo. É uma representação abreviada: os
números de linha dependem da versão e da formatação dos arquivos.

```text
java.lang.IllegalArgumentException: A partida precisa de um movimento.
    at br.edu.ifpb.jogos.megamania.modelo.Partida.<init>(Partida.java:31)
    at Diagnostico.criarPartida(Diagnostico.java:18)
    at Diagnostico.main(Diagnostico.java:9)
```

Esse percurso é o **stack trace**, ou rastreamento da pilha de chamadas.
Na primeira linha estão o tipo e a mensagem. As linhas `at` mostram os
quadros de chamada, começando pelo ponto em que o rastreamento foi registrado.
`<init>` identifica um construtor.

Para investigar esse caso:

1. Leia o tipo e a mensagem: um argumento exigido não foi aceito.
2. Localize a validação em `Partida`.
3. Siga os chamadores para descobrir de onde veio o `null`.
4. Corrija a criação ou a obtenção do colaborador e execute novamente.

O ponto que detecta o problema pode estar correto. Aqui, remover a validação
de `Partida` apenas permitiria que o colaborador ausente causasse uma falha
mais tarde.

### Uma referência sem objeto: `NullPointerException`

O próximo experimento introduz um erro no uso do retorno de `tentarDisparar`:

```java
Nave nave = new Nave();
nave.tentarDisparar();
Projetil novo = nave.tentarDisparar();
System.out.println(novo.getY());
```

Qual instrução falha? Como respeitar o contrato já existente?

??? "Ver resposta"

    - A segunda tentativa devolve `null`, pois a recarga continua ativa.
    - `novo.getY()` tenta chamar um método sem objeto e causa
      `NullPointerException`.
    - O cliente deve verificar o retorno antes de usar o projétil:

    ```java
    if (novo != null) {
        System.out.println(novo.getY());
    }
    ```

    Isso respeita uma ausência prevista. Não é necessário capturar a exceção.

Guardar ou comparar `null` não causa, por si só, essa falha. O problema aqui
é tentar acessar um método de instância por essa referência. Em outros casos,
um `null` pode revelar inicialização esquecida ou dependência ausente: a
correção deve considerar a origem, não acrescentar verificações sem critério.

### O cast não transforma o objeto: `ClassCastException`

`Nave` e `Inimigo` cumprem `Alvo`. Isso permite guardar qualquer um deles
em uma referência do contrato, mas não torna seus tipos concretos iguais:

```java
Alvo alvo = new Inimigo(100, 200);
Nave nave = (Nave) alvo;
System.out.println(nave.getVidas());
```

O código compila. Em execução, a conversão lança `ClassCastException`:
o objeto alcançado é um `Inimigo`, não uma `Nave`. O cast não cria outro
objeto nem altera a classe do objeto existente.

Se a intenção for aplicar um impacto a qualquer alvo, o próprio contrato
já resolve:

```java
alvo.receberImpacto();
```

Se existir uma necessidade específica de consultar vidas de uma nave, a
conversão depende de verificar essa condição:

```java
if (alvo instanceof Nave) {
    Nave nave = (Nave) alvo;
    System.out.println(nave.getVidas());
}
```

Para o inimigo desse exemplo, o corpo do `if` não executa. A verificação evita
o cast inválido; o uso do contrato evita precisar de cast para uma operação
que todos os alvos já oferecem.

### Uma posição que não existe: `IndexOutOfBoundsException`

Uma partida recém-criada possui 18 inimigos. Examine esta consulta:

```java
Partida partida = new Partida();
int quantidade = partida.getInimigos().size();
Inimigo ultimo = partida.getInimigos().get(quantidade);
```

Por que ela falha? Subtrair `1` sempre resolve?

??? "Ver resposta"

    - Há 18 elementos, com índices de `0` a `17`. O acesso ao índice `18`
      lança `IndexOutOfBoundsException`.
    - Para essa partida, o último índice é `quantidade - 1`.
    - Em uma lista vazia, isso seria `-1`, também inválido. Antes de buscar
      o último elemento, é necessário considerar se a lista está vazia.

Um percurso com `i <= lista.size()` tem o mesmo problema no último passo.
Se o objetivo for visitar todos os objetos, o `for` aprimorado já conhecido
evita administrar índices manualmente.

### Uma operação que a lista não oferece: `UnsupportedOperationException`

Em `Partida`, a coleção devolvida para consulta é uma visão não modificável:

```java
public List<Inimigo> getInimigos() {
    return Collections.unmodifiableList(inimigos);
}
```

O cliente consegue consultar e percorrer essa lista. Esta tentativa de
modificar sua estrutura, porém, lança `UnsupportedOperationException`:

```java
Partida partida = new Partida();
partida.getInimigos().clear();
```

A proteção mantém a alteração da coleção sob responsabilidade de `Partida`.
Se um requisito precisar remover participantes, será necessário considerar
uma operação de domínio e suas regras, em vez de contornar a proteção.

Essa visão não é uma cópia congelada: alterações internas da coleção
aparecem nela. E não torna os inimigos imutáveis; ainda é possível chamar
as operações públicas dos objetos consultados.

### Recuperar o diagnóstico

Os cinco tipos estudados pertencem à família de `RuntimeException`. Java
não exige que sejam declarados com `throws` nem capturados para compilar.
Isso não elimina a necessidade de compreender seus contratos e suas causas.

| Exceção | O que investigar neste exemplo | Correção orientada pelo contrato |
| --- | --- | --- |
| `IllegalArgumentException` | Argumento recusado por `Partida` ou `Corpo`. | Fornecer um valor válido e preservar a validação. |
| `NullPointerException` | Uso de `novo` após recusa do disparo. | Considerar o retorno `null` antes de usar o projétil. |
| `ClassCastException` | Cast de um inimigo para nave. | Usar `Alvo` ou verificar a capacidade específica. |
| `IndexOutOfBoundsException` | Índice fora das posições da lista. | Corrigir o acesso e considerar a lista vazia. |
| `UnsupportedOperationException` | Alteração pela visão não modificável. | Respeitar quem administra a coleção. |

!!! activity "Atividade — o ponto da falha e a origem"

    Um projétil ativo recebe a chamada `tiro.tentarAtingir(null)`. O método
    começa assim:

    ```java
    if (!ativo || !alvo.estaVivo() || !alvo.colideCom(this)) {
        return false;
    }
    ```

    1. Qual exceção ocorre e em qual expressão?
    2. O método chega a devolver `false`?
    3. O que procurar no chamador antes de alterar essa condição?

??? "Ver resposta"

    1. `NullPointerException` em `alvo.estaVivo()`: `alvo` é `null`. Como
       o projétil está ativo, a avaliação passa da primeira condição.
    2. Não. A exceção interrompe a avaliação antes do retorno.
    3. Investigue por que foi solicitada uma tentativa sem objeto alvo.
       Se a ausência for prevista na seleção, o chamador pode deixar de
       solicitar o impacto. Acrescentar `catch` e devolver `false` sem
       definir esse contrato esconderia a origem da falha.

## Verificar a rejeição e o estado do objeto

`Partida.atualizar` valida os argumentos antes de atualizar nave, disparos
ou inimigos. Este é o início do método real:

```java
public void atualizar(double segundos, int direcao, boolean disparar) {
    if (!Double.isFinite(segundos)
            || segundos < 0
            || segundos > 1.0 / 30 + 0.000001
            || direcao < -1
            || direcao > 1) {
        throw new IllegalArgumentException("Use passos de até 1/30 s e direção entre -1 e 1.");
    }

    if (estado != Estado.JOGANDO || segundos == 0) {
        return;
    }

    // A atualização dos participantes continua aqui.
}
```

`Double.isFinite` verifica se o número é finito; rejeita `NaN` e infinitos.
Para a investigação seguinte, basta usar `0.01` segundo, um passo aceito,
e direção `2`, que é inválida. A direção deve ser `-1`, `0` ou `1`.

A construção dos participantes segue a mesma ideia. `new Inimigo(Double.NaN,
200)` chega ao construtor de `Corpo`, que rejeita a posição com
`IllegalArgumentException` antes de atribuir as coordenadas. `Double.NaN`
representa um valor que não é um número. `Corpo` também exige dimensões
finitas e positivas: a validação na base protege a geometria compartilhada
pelas subclasses.

O teste `argumentosInvalidosSaoRecusados`, em `PartidaTest`, já verifica
vários argumentos inválidos. Este teste adicional ilustra uma observação
mais localizada: a nave não muda de posição quando a chamada é recusada.

```java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import br.edu.ifpb.jogos.megamania.modelo.Partida;

class ContratoPartidaTest {
    @Test
    void direcaoInvalidaNaoMoveANave() {
        Partida partida = new Partida();
        double xAntes = partida.getNave().getX();

        assertThrows(IllegalArgumentException.class,
                () -> partida.atualizar(0.01, 2, false));

        assertEquals(xAntes, partida.getNave().getX());
    }
}
```

Esse teste pode ficar em `ContratoPartidaTest.java` na área de testes do
módulo `exemplo-megamania`. Execute pelo suporte JUnit da IDE, como nos testes
fornecidos, sem abrir a janela.

!!! java-focus "Java em foco — esperar uma exceção com `assertThrows`"

    - `IllegalArgumentException.class` identifica o tipo esperado.
    - `() -> partida.atualizar(...)` fornece uma ação para o JUnit executar
      dentro da verificação. A chamada não deve ser executada antes dela.
    - `assertThrows` passa se a ação lançar o tipo esperado ou um subtipo;
      falha se não houver exceção ou se o tipo for incompatível.

Essa notação é suficiente para o teste; não precisamos estudar lambdas
como um tópico da linguagem. O JUnit captura a exceção esperada, permitindo
que a verificação da posição seja executada em seguida.

Se retirássemos `assertThrows` e chamássemos diretamente `atualizar(0.01, 2,
false)`, a exceção escaparia do método de teste e o teste falharia. A
comparação da posição não seria alcançada.

Um teste que espera uma exceção por si só não garante a preservação do
estado. Também é necessário observar o estado relevante para aquela operação.

!!! trap "Armadilha — uma exceção não desfaz o que já aconteceu"

    `throw` e `catch` não restauram campos automaticamente. Neste método,
    a nave permanece na mesma posição porque a validação ocorre antes das
    alterações. Se o método alterasse campos antes de lançar a exceção,
    essas alterações poderiam permanecer.

Considere uma partida recém-criada. O que acontece em
`partida.atualizar(0, 2, false)`? O tempo zero permite ignorar a direção?

??? "Ver resposta"

    A chamada lança `IllegalArgumentException`. A direção inválida é
    verificada antes do retorno por tempo zero. O corpo posterior não executa.
    A ordem das condições faz parte do comportamento observado.

## Aplicar o raciocínio ao seu jogo

No Projeto 3, permanece **IA Nível 3 — Colaborador**. Você pode usar IA para
apoiar a investigação, mas precisa compreender, verificar e conseguir modificar
o código incorporado. Uma sugestão de `catch` precisa de uma justificativa
ligada ao comportamento desejado.

Escolha uma operação existente do seu modelo e analise:

1. Qual situação de recusa é prevista pelas regras?
2. Quais argumentos ou dependências são necessários para a chamada ser válida?
3. Como o contrato comunica o resultado e como o cliente reage?
4. Que cenário verifica a recusa e o estado que deve permanecer preservado?

??? "Ver uma análise possível"

    Em um jogo com energia, `tentarAtacar()` pode devolver `false` quando
    não há energia suficiente. O cliente não cria o ataque; o teste confere
    o retorno e a energia preservada.

    Já uma operação `gastarEnergia(int quantidade)` cujo contrato exige
    quantidade positiva pode lançar `IllegalArgumentException` ao receber
    `-1`. O teste verifica a exceção e que a energia não aumentou nem diminuiu.
    A validação deve anteceder a alteração.

    É uma possibilidade de contrato, não uma mecânica obrigatória. Para sua
    operação, o importante é explicitar a regra, a comunicação e o resultado
    verificável. Uma exceção nova só se justifica se houver necessidade real.

!!! synthesis "Síntese — comunicar, localizar e verificar"

    - O contrato distingue recusa prevista de chamada inválida.
    - Uma exceção interrompe o fluxo normal e pode se propagar até um tratador.
    - Tipo, mensagem e chamadas orientam a investigação da causa.
    - Capturar exige uma resposta definida; a captura não corrige o defeito
      nem desfaz alterações de estado.
    - Verifique a comunicação da falha e o estado relevante após a recusa.

## Materiais relacionados

- [Aula 20 — Entendendo a estrutura de um jogo orientado a objetos](aula-20-entendendo-a-estrutura-de-um-jogo.md).
- [Base do Projeto 3 — ZIP](../materiais/projeto-03/base-jogo-poo.zip): Megamania, engine e testes fornecidos.
- [Aula 13 — Como saber se ainda funciona?](aula-13-como-saber-se-ainda-funciona.md): cenários e verificações com JUnit.
- [Aula 17 — Inventário de jogo: interfaces e capacidades](aula-17-inventario-de-jogo-interfaces-e-capacidades.md): cast, tipos e `instanceof`.
- [Java essencial — Exceções](../materiais/java-essencial.md#excecoes).
- [Java — tratamento de exceções](https://docs.oracle.com/javase/tutorial/essential/exceptions/handling.html): documentação oficial.
- [Java — `Collections.unmodifiableList`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/Collections.html#unmodifiableList(java.util.List)): contrato da visão não modificável.
