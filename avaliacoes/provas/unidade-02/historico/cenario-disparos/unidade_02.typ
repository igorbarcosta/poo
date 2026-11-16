// Primeira versão para revisão do professor; não liberada para impressão.
// Conteúdo correspondente a base.md. Modelo visual: provas/unidade_01.typ.
#set document(title: "POO — Prova da Unidade 02", author: "IFPB — Campus Campina Grande")
#set page(paper: "a4", margin: (top: 1cm, bottom: 1.2cm, left: 0.6cm, right: 0.6cm),
  footer: context align(center, text(size: 8pt, fill: rgb("#666666"))[#counter(page).display()]))
#set text(size: 11pt, lang: "pt")
#set par(justify: true, leading: 0.45em)
#show raw.where(block: false): it => box(text(font: "Ubuntu Mono", fill: rgb("#5d0563"), it))

#let campo(largura, altura: 0.8cm, raio: 1.5pt) = box(width: largura, height: altura,
  stroke: 0.5pt + rgb("#888888"), radius: raio)
#let resposta(numero) = grid(columns: (auto, 1fr), column-gutter: 0.06cm, align: horizon,
  text(size: 11pt, weight: "bold")[Q.#if numero < 10 { "0" }#numero], campo(2.8cm, altura: 0.65cm))
#let secao(titulo, body) = block(width: 100%)[
  #grid(columns: (auto, 1fr), column-gutter: 8pt, align: horizon,
    text(size: 12pt, weight: "bold", fill: rgb("#555555"), titulo),
    line(length: 100%, stroke: 0.4pt + rgb("#cccccc")))
  #v(3pt)
  #body
]
#let codigo(body, tamanho: 9pt, numeros: true) = block(width: 100%, breakable: false,
  fill: rgb("#f7f7f8"), stroke: 0.4pt + rgb("#cccccc"), radius: 2pt, inset: 6pt, spacing: 0pt)[
  #set raw(tab-size: 2)
  #show raw.where(block: true): set text(font: "Ubuntu Mono", size: tamanho)
  #if numeros {
    show raw.line: it => {
      box(width: 1.5em, inset: (right: 0.35em), align(right,
        text(size: 6.5pt, fill: rgb("#aaaaaa"))[#it.number]))
      it.body
    }
    body
  } else { body }
]
#let fonte(nome, body) = block(above: 7pt, breakable: false)[
  #text(size: 10pt, weight: "bold")[#(nome + ".java")]
  #v(2pt)
  #codigo(body)
]
#let questao(numero, enunciado, opcoes, linhas: 0) = block(width: 100%, above: 8pt, breakable: false)[
  #set text(size: 12pt)
  #set par(justify: false)
  #text(weight: "bold")[Q#numero. (5 pontos)] #enunciado
  #v(2pt)
  #for (indice, opcao) in opcoes.enumerate() {
    block(width: 100%, above: 5pt, breakable: false)[
      #text(weight: "bold")[#("ABCDE".at(indice)))] #opcao
    ]
  }
  #for _ in range(linhas) {
    block(width: 100%, above: 0pt, below: 0pt)[
      #v(0.55cm)
      #line(length: 100%, stroke: 0.4pt + rgb("#aaaaaa"))
    ]
  }
]

#text[IFPB - Campus Campina Grande #linebreak()
Programação Orientada a Objetos - Unidade 02]
#grid(columns: (auto, 1fr, 1cm, auto, auto), column-gutter: 0.15cm, align: horizon,
  [Nome:], campo(100%, altura: 0.7cm, raio: 2pt), [], [Nota:], campo(2.5cm, altura: 0.7cm, raio: 2pt))
#v(4pt)
#secao("QUADRO DE RESPOSTAS — MÚLTIPLA ESCOLHA")[
  #grid(columns: (1fr, 1fr, 1fr, 1fr, 1fr), column-gutter: 0.1cm, row-gutter: 0.12cm,
    ..(1, 4, 5, 7, 11, 12, 13, 14, 15, 16, 18, 19, 20).map(resposta))
]
#v(4pt)
Vinte questões, 5 pontos cada. Nas questões de múltipla escolha, assinale uma única alternativa e registre a letra no quadro de respostas. Nas questões de saída, escreva o que será impresso pelo código nas linhas abaixo do trecho, na ordem em que aparece e com uma linha para cada `println`. Duração de referência: 90 minutos.

Cada questão é independente; as alterações propostas valem apenas nela. As classes e interfaces ficam em arquivos separados do mesmo projeto, sem `package`.

Os colaboradores são diferentes de `null`. Considere disponíveis os imports de `List` e `ArrayList` e, nos testes, `assertEquals` e `assertTrue` do JUnit.
#v(4pt)
#secao("QUESTÕES 1 A 4")[Consulte o cenário ao final da prova.]
#columns(2, gutter: 0.6cm)[
#questao(1, [
Qual alternativa descreve a distribuição de responsabilidades do código apresentado?
], (
[
`Nave` mantém o total de tiros; `Arma` decide quando a partida termina; `Partida` escolhe o tipo de disparo.
],
[
`Partida` decide o tipo de disparo; `Nave` mantém a contagem de acionamentos de cada arma; `Arma` controla as vidas.
],
[
`Nave` consulta a partida e solicita o disparo; `Arma` registra seus acionamentos; `Partida` mantém vidas e total de tiros.
],
[
`DisparoRepetido` controla as vidas; `Arma` mantém o total de tiros da partida; `Partida` apenas recebe consultas.
],
[
`Nave` controla as vidas e os acionamentos da arma; `Partida` escolhe quantos tiros cada implementação produz.
],
))
#questao(2, [
Escreva a saída produzida pelo trecho abaixo.
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
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
]
], (), linhas: 3)
#colbreak()
#questao(3, [
Escreva a saída produzida pelo trecho abaixo.
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
```java
Partida p = new Partida();
ArmaDupla arma = new ArmaDupla();
Nave n = new Nave(p, arma);
n.disparar();
n.disparar();
System.out.println(p.getTiros());
System.out.println(arma.getAcionamentos());
```
]
], (), linhas: 2)
#questao(4, [
Ao executar o trecho abaixo, qual sequência de chamadas realiza o disparo?
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
```java
Partida p = new Partida();
Disparo d = new ArmaDupla();
Nave n = new Nave(p, d);
n.disparar();
```
]
], (
[
`Nave.disparar` executa diretamente `ArmaDupla.quantidadeTiros`, sem passar pelo método de `Arma`.
],
[
`Nave.disparar` chama `Arma.disparar`, que usa `ArmaDupla.quantidadeTiros` no mesmo objeto de arma.
],
[
`Nave.disparar` chama uma implementação de `disparar` definida dentro da interface `Disparo`.
],
[
`Arma.disparar` cria uma `ArmaDupla` para executar `quantidadeTiros` em um segundo objeto.
],
[
`Arma.disparar` procura `quantidadeTiros` em `Nave`, pois a solicitação começou nela.
],
))
]

#pagebreak()
#secao("QUESTÕES 5 A 8")[Consulte o cenário ao final da prova.]
#columns(2, gutter: 0.6cm)[
#questao(5, [
Após as declarações abaixo, analise cada chamada isoladamente. Quais compilam sem acrescentar casts?
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
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
]
], (
[
Apenas I e II.
],
[
Apenas II e III.
],
[
Apenas I e IV.
],
[
Apenas I e III.
],
[
Apenas III e IV.
],
))
#questao(6, [
Escreva a saída produzida pelo trecho abaixo.
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
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
]
], (), linhas: 3)
#colbreak()
#questao(7, [
Uma classe nova, `DisparoTriplo`, implementa `Disparo` diretamente e registra três tiros por chamada. Ela será usada por uma nova nave. Qual alteração basta para integrar esse comportamento à nave existente?
], (
[
Alterar o campo de `Nave` para `DisparoTriplo` e reescrever todas as chamadas a `disparar`.
],
[
Acrescentar em `Nave.disparar` uma condição que reconheça `DisparoTriplo` antes de disparar.
],
[
Criar a implementação e passá-la ao construtor de `Nave`, preservando o código da classe `Nave`.
],
[
Fazer `DisparoTriplo` estender `ArmaDupla`, pois apenas subclasses de `Arma` são aceitas pela nave.
],
[
Acrescentar `dispararTriplo` à interface e trocar a chamada de `Nave` para esse novo método.
],
))
#questao(8, [
Escreva a saída produzida pelo trecho abaixo.
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
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
]
], (), linhas: 3)
]

#pagebreak()
#secao("QUESTÕES 9 A 12")[Consulte o cenário ao final da prova.]
#columns(2, gutter: 0.6cm)[
#questao(9, [
Escreva a saída produzida pelo trecho abaixo.
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
```java
Partida p = new Partida();
Disparo base = new ArmaSimples();
Disparo repetido = new DisparoRepetido(base);
base = new ArmaDupla();
repetido.disparar(p);
System.out.println(p.getTiros());
```
]
], (), linhas: 1)
#questao(10, [
Escreva a saída produzida pelo trecho abaixo.
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
```java
Partida p = new Partida();
ArmaDupla arma = new ArmaDupla();
Disparo d = new DisparoRepetido(
    new DisparoRepetido(arma));
d.disparar(p);
System.out.println(p.getTiros());
System.out.println(arma.getAcionamentos());
```
]
], (), linhas: 2)
#colbreak()
#questao(11, [
Um aluno substitui apenas o corpo do construtor de `DisparoRepetido` pela linha abaixo. O que essa mudança compromete?
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
```java
this.base = new ArmaSimples();
```
]
], (
[
O objeto recebido passa a ter seu contador zerado sempre que o repetidor é criado.
],
[
A interface deixa de permitir que a nave chame o método `disparar` do repetidor.
],
[
O repetidor passa a compartilhar a mesma arma simples entre todas as suas instâncias.
],
[
A reatribuição posterior da variável do cliente passa a trocar a arma interna do repetidor.
],
[
O repetidor deixa de usar o colaborador recebido e passa a repetir sempre uma arma simples criada por ele.
],
))
#questao(12, [
Uma nova classe, `DisparoComExtra`, guarda no campo `base` um `Disparo` recebido. Ela deve solicitar um disparo a esse colaborador e, em seguida, registrar um tiro adicional na mesma partida. Qual corpo de `disparar(Partida partida)` cumpre esse requisito?
], (
[
#codigo(tamanho: 8.5pt, numeros: false)[
```java
base.disparar(new Partida());
partida.registrarTiros(1);
```
]
],
[
#codigo(tamanho: 8.5pt, numeros: false)[
```java
new ArmaSimples().disparar(partida);
partida.registrarTiros(1);
```
]
],
[
#codigo(tamanho: 8.5pt, numeros: false)[
```java
base.disparar(partida);
partida.registrarTiros(1);
```
]
],
[
#codigo(tamanho: 8.5pt, numeros: false)[
```java
base.disparar(partida);
base.disparar(partida);
```
]
],
[
#codigo(tamanho: 8.5pt, numeros: false)[
```java
partida.registrarTiros(2);
```
]
],
))
]

#pagebreak()
#secao("QUESTÕES 13 A 16")[Consulte o cenário ao final da prova.]
#columns(2, gutter: 0.6cm)[
#questao(13, [
A classe `Arma` foi declarada abstrata. Qual uso é permitido e corresponde ao papel dessa base no sistema?
], (
[
Criar `new Arma()` e escolher a implementação de `quantidadeTiros` depois da construção.
],
[
Declarar `Arma a = new ArmaSimples()`, mas reimplementar `disparar` em toda subclasse, pois o corpo da base não é herdado.
],
[
Criar `new Arma()` apenas para consultar seu contador, sem chamar o método abstrato.
],
[
Declarar `Arma a = new ArmaSimples()` e usar nela o método concreto `disparar` herdado da base.
],
[
Usar uma referência `Arma` somente como parâmetro de construtor, sem chamar métodos por ela.
],
))
#questao(14, [
Ao executar `new ArmaDupla()`, qual afirmação descreve corretamente o efeito de `super()` e o estado inicial do objeto?
], (
[
O construtor de `Arma` inicializa o contador do mesmo objeto que está sendo criado como `ArmaDupla`.
],
[
O construtor cria uma `Arma` separada, que passa a ser o colaborador interno da `ArmaDupla`.
],
[
Um contador é criado em `Arma` e outro em `ArmaDupla`; os dois são incrementados a cada disparo.
],
[
O contador passa a ser compartilhado entre todas as armas porque foi declarado na superclasse.
],
[
O contador só é inicializado quando a primeira chamada a `quantidadeTiros` acontece.
],
))
#colbreak()
#questao(15, [
Queremos repetir tanto armas simples quanto duplas, sem duplicar a sequência de repetição para cada tipo de arma. Por que a composição usada em `DisparoRepetido` atende a esse requisito?
], (
[
Porque uma subclasse recebe automaticamente as implementações de todas as classes que cumprem a mesma interface.
],
[
Porque o repetidor guarda um `Disparo` e reutiliza a mesma sequência de chamadas com colaboradores diferentes.
],
[
Porque implementar `Disparo` faz o repetidor herdar o contador privado da classe `Arma`.
],
[
Porque o campo `base` faz o repetidor e a arma recebida se tornarem um único objeto.
],
[
Porque o repetidor altera o método `quantidadeTiros` da arma recebida antes de chamá-la.
],
))
#questao(16, [
Considere o teste de capacidade e o cast abaixo. Qual afirmação descreve corretamente o que acontece?
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
```java
Disparo d = new ArmaDupla();
if (d instanceof Contabilizavel) {
    Contabilizavel c = (Contabilizavel) d;
    int acionamentos = c.getAcionamentos();
}
```
]
], (
[
O cast cria uma cópia da arma, e `c` consulta o contador dessa cópia.
],
[
O cast transforma a arma em um objeto da classe `Contabilizavel`, que passa a armazenar o contador.
],
[
O cast permite usar a capacidade de consulta do mesmo objeto `ArmaDupla`, sem criar outra arma.
],
[
O `instanceof` acrescenta a capacidade à arma; antes do teste, o objeto cumpria apenas `Disparo`.
],
[
O cast é válido porque qualquer objeto guardado em uma variável `Disparo` oferece `getAcionamentos`.
],
))
]

#pagebreak()
#secao("QUESTÕES 17 A 20")[Consulte o cenário ao final da prova.]
#columns(2, gutter: 0.6cm)[
#questao(17, [
Escreva a saída produzida pelo trecho abaixo.
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
```java
Disparo d = new DisparoRepetido(
    new ArmaDupla());
System.out.println(d instanceof Contabilizavel);
```
]
], (), linhas: 1)
#questao(18, [
Um aluno remove de `Nave.disparar()` o trecho abaixo.
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
```java
if (partida.terminou()) {
    return;
}
```
]

Cada alternativa parte destes objetos novos:
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
```java
Partida p = new Partida();
ArmaSimples arma = new ArmaSimples();
Nave n = new Nave(p, arma);
```
]

Qual teste passa com o código original e falha após essa remoção?
], (
[
#codigo(tamanho: 8.8pt, numeros: false)[
```java
n.disparar();
assertEquals(1, arma.getAcionamentos());
```
]
],
[
#codigo(tamanho: 8.8pt, numeros: false)[
```java
n.disparar();
n.disparar();
assertEquals(2, arma.getAcionamentos());
```
]
],
[
#codigo(tamanho: 8.8pt, numeros: false)[
```java
p.perderVida();
n.disparar();
assertEquals(1, arma.getAcionamentos());
```
]
],
[
#codigo(tamanho: 8.8pt, numeros: false)[
```java
p.perderVida();
p.perderVida();
p.perderVida();
n.disparar();
assertEquals(0, arma.getAcionamentos());
```
]
],
[
#codigo(tamanho: 8.8pt, numeros: false)[
```java
p.perderVida();
p.perderVida();
p.perderVida();
n.disparar();
assertEquals(0, p.getTiros());
```
]
],
))
#colbreak()
#questao(19, [
O teste abaixo usa o colaborador de apoio `DisparoRegistro`. Se ele passar, qual conclusão é sustentada pelas verificações?
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
```java
Partida p = new Partida();
DisparoRegistro r = new DisparoRegistro();
Disparo d = new DisparoRepetido(r);
d.disparar(p);

assertEquals(2, r.getChamadas());
assertTrue(r.getUltimaPartida() == p);
```
]
], (
[
Houve duas chamadas ao registro, e a última recebeu `p`; o teste não verifica qual partida a primeira chamada recebeu.
],
[
As duas chamadas receberam `p`, pois guardar o último argumento permite conferir todos os argumentos anteriores.
],
[
A partida recebeu dois tiros, pois toda implementação de `Disparo` deve aumentar o contador de tiros.
],
[
Nenhuma outra partida foi criada durante a execução, pois o último argumento continua sendo `p`.
],
[
Qualquer implementação de `DisparoRepetido` está correta para todos os colaboradores e todas as partidas.
],
))
#questao(20, [
Um aluno acrescenta a sobrescrita abaixo em `ArmaDupla`, mantendo o restante da classe. O total de tiros continua correto para uma chamada, mas a regra de contagem de acionamentos precisa ser preservada. Qual verificação revela o problema após `arma.disparar(p)`, com `arma` e `p` novos?
#v(4pt)
#codigo(tamanho: 8.8pt, numeros: false)[
```java
@Override
public void disparar(Partida partida) {
    partida.registrarTiros(2);
}
```
]
], (
[
`assertEquals(2, p.getTiros());`
],
[
`assertEquals(3, p.getVidas());`
],
[
`assertEquals(1, arma.getAcionamentos());`
],
[
`assertTrue(arma instanceof Contabilizavel);`
],
[
`assertEquals(false, p.terminou());`
],
))
]

#pagebreak()
#secao("CENÁRIO — CÓDIGO DE REFERÊNCIA")[]
#grid(columns: (1fr, 1fr), column-gutter: 0.4cm,
[
#fonte("Partida")[
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
]
], [
#fonte("Disparo")[
```java
public interface Disparo {
    void disparar(Partida partida);
}
```
]
#fonte("Nave")[
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
]
])

#pagebreak()
#secao("CENÁRIO — CONTINUAÇÃO")[]

#grid(columns: (1fr, 1fr), column-gutter: 0.4cm,
[
#fonte("Contabilizavel")[
```java
public interface Contabilizavel {
    int getAcionamentos();
}
```
]
#fonte("Arma")[
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
]
#fonte("DisparoRegistro")[
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
]
], [
#fonte("ArmaSimples")[
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
]
#fonte("ArmaDupla")[
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
]
#fonte("DisparoRepetido")[
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
]
])

