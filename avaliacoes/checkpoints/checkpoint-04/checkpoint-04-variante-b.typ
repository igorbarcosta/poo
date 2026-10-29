// arquivo: checkpoint-04-variante-b.typ

// ============================================================
// CONFIGURAÇÃO DA PÁGINA
// ============================================================

#import "@preview/codepoint:0.2.2": exams

#set page(
  paper: "a4",
  margin: (
    top: 1cm,
    bottom: 1cm,
    left: 0.6cm,
    right: 0.6cm,
  ),
)

#set text(size: 11pt)
#set par(justify: true)

#let variante = sys.inputs.at("variante", default: "b")

#show raw.where(block: false): it => box(
)[
  #text(
    font: "Ubuntu Mono",
    fill: rgb("#5d0563"),
  )[
    #it.text
  ]
]

// ============================================================
// COMPONENTES REUTILIZÁVEIS
// ============================================================

#let campo(largura, altura: 0.8cm, raio: 1.5pt) = box(
  width: largura,
  height: altura,
  stroke: 0.5pt + rgb("#888888"),
  radius: raio,
)[]

#let separador() = box(
  width: 0.5pt,
  height: 0.55cm,
  fill: rgb("#c8c8c8"),
)[]

#let secao(titulo, body) = block(
  width: 100%,
)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 8pt,
    align: horizon,
    text(
      size: 12pt,
      weight: "bold",
      fill: rgb("#555555"),
    )[
      #titulo
    ],
    line(
      length: 100%,
      stroke: 0.4pt + rgb("#cccccc"),
    ),
  )

  #v(3pt)
  #body
]

#let questao(titulo, body) = block(
  width: 100%,
  above: 16pt,
  below: 16pt,
)[
  #text(size: 13pt, weight: "bold")[#titulo] #body
  #v(8pt)
  #line(length: 100%, stroke: 0.35pt + rgb("#d0d0d0"))
]

#let codigo(body, tamanho: 8pt, inset: 8pt) = block(
  width: 100%,
  breakable: true,
  fill: rgb("#f7f7f8"),
  stroke: 0.4pt + rgb("#cccccc"),
  radius: 2pt,
  inset: inset,
  spacing: 0pt,
)[
  #set raw(tab-size: 2)

  #show raw.where(block: true): set text(size: tamanho)

  #show raw.line: it => {
    box(
      width: 1.5em,
      inset: (right: 0.35em),
      align(right)[
        #text(
          size: 6.5pt,
          fill: rgb("#aaaaaa"),
        )[
          #it.number
        ]
      ],
    )
    it.body
  }

  #body
]

#let codigo-questao(body) = block(
  width: 100%,
  fill: rgb("#f7f7f8"),
  stroke: 0.4pt + rgb("#cccccc"),
  radius: 2pt,
  inset: 4pt,
  above: 6pt,
  below: 6pt,
)[
  #set raw(tab-size: 2)
  #show raw.where(block: true): set text(size: 10pt)
  #body
]

#let alternativa(letra, body) = block(
  width: 100%,
  below: 10pt,
)[
  #text(weight: "bold")[#letra)]
  #body
]

#let alternativa-codigo(letra, body) = grid(
  columns: (auto, 1fr),
  column-gutter: 4pt,
  align: top,
  text(weight: "bold")[#letra)],
  body,
)

// ============================================================
// CABEÇALHO
// ============================================================

#text[
  IFPB - Campus Campina Grande \
  Programação Orientada a Objetos - Checkpoint 04
]

#grid(
  columns: (auto, 1fr, 1cm, auto, auto),
  column-gutter: 0.15cm,
  align: horizon,
  [Nome:],
  campo(
    100%,
    altura: 0.7cm,
    raio: 2pt,
  ),
  [],
  [Nota:],
  campo(
    2.5cm,
    altura: 0.7cm,
    raio: 2pt,
  ),
)

// ============================================================
// QUADRO DE RESPOSTAS
// ============================================================

#secao("QUADRO DE RESPOSTAS")[
  #grid(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    column-gutter: 0.3cm,
    align: horizon,
    [Q1: #campo(100%, altura: 1cm)],
    [Q2: #campo(100%, altura: 1cm)],
    [Q3: #campo(100%, altura: 1cm)],
    [Q4: #campo(100%, altura: 1cm)],
    [Q5: #campo(100%, altura: 1cm)],
    [Q6: #campo(100%, altura: 1cm)],
  )
  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.15cm,
    align: horizon,
    [Q7],
    grid(
      columns: (auto, 1fr, auto, 1fr, auto, 1fr, auto, 1fr),
      column-gutter: 3pt,
      row-gutter: 3pt,
      align: horizon,
      [1)], campo(100%, altura: 1cm),
      [2)], campo(100%, altura: 1cm),
      [3)], campo(100%, altura: 1cm),
      [4)], campo(100%, altura: 1cm),
      [5)], campo(100%, altura: 1cm),
      [6)], campo(100%, altura: 1cm),
      [7)], campo(100%, altura: 1cm),
      [8)], campo(100%, altura: 1cm),
    ),
  )
]

// ============================================================
// CENÁRIO — CÓDIGOS DO SISTEMA
// ============================================================

#secao("CENÁRIO BASE")[
  #columns(2, gutter: 0.5cm)[
    #text(size: 9pt, weight: "bold")[Estadia.java]
    #v(2pt)
    #codigo(tamanho: 10pt, inset: 5pt)[
```java
public class Estadia {
  private int horas;
  private boolean encerrada;
  private Cobranca cobranca;
  public Estadia() {
    horas = 0;
    encerrada = false;
  }
  public int getHoras() { return horas; }
  public boolean isEncerrada() {
    return encerrada;
  }
  public void adicionarHoras(int qtd) {
    if (!encerrada && qtd > 0) {
      horas += qtd;
    }
  }
  public void encerrar(Cobranca opcao) {
    if (!encerrada && opcao != null) {
      cobranca = opcao;
      encerrada = true;
    }
  }
  public double calcularValor() {
    if (!encerrada) {
      return 0.0;
    }
    return cobranca.calcularValor(this);
  }
}
```
    ]
    #v(5pt)
    #text(size: 11pt, weight: "bold")[CobrancaPorHora.java]
    #v(2pt)
    #codigo(tamanho: 10pt, inset: 4pt)[
```java
public class CobrancaPorHora
    implements Cobranca {
  public double calcularValor(Estadia e){
    return e.getHoras() * 5.0;
  }
}
```
    ]
    #v(5pt)
    #text(size: 11pt, weight: "bold")[CobrancaPorDiaria.java]
    #v(2pt)
    #codigo(tamanho: 10pt, inset: 4pt)[
```java
public class CobrancaPorDiaria
    implements Cobranca {
  public double calcularValor(Estadia e){
    return 40.0;
  }
}
```
    ]
    #v(5pt)
    #text(size: 11pt, weight: "bold")[Cobranca.java]
    #v(2pt)
    #codigo(tamanho: 10pt, inset: 4pt)[
```java
public interface Cobranca {
  double calcularValor(Estadia estadia);
}
```
    ]
    #v(5pt)
    #text(size: 11pt, weight: "bold")[Ajustavel.java]
    #v(2pt)
    #codigo(tamanho: 10pt, inset: 4pt)[
```java
public interface Ajustavel {
  boolean alterarTarifa(double valor);
}
```
    ]
    #v(5pt)
    #text(size: 11pt, weight: "bold")[Flexivel.java]
    #v(2pt)
    #codigo(tamanho: 10pt, inset: 4pt)[
```java
public class Flexivel
    implements Cobranca, Ajustavel {
  private double tarifa = 5.0;
  private int saldo;
  public Flexivel(int s) { saldo = s; }
  public boolean alterarTarifa(
      double v) {
    if (v<=0 || saldo==0) return false;
    tarifa = v;
    saldo--;
    return true;
  }
  public int getSaldo() { return saldo; }
  public double calcularValor(Estadia e){
    return e.getHoras() * tarifa;
  }
}
```
    ]
    #v(10pt)
    Nesta avaliação, cada questão parte do cenário base; alterações valem apenas para a própria questão.
  ]

]

#pagebreak()

#columns(
  2,
  gutter: 0.6cm,
)[
  #set text(size: 13pt)
  #secao("QUESTÕES")[



  #questao("Q1. (10 pontos)")[
O trecho abaixo percorre uma lista com duas modalidades de cobrança. Considere os imports de `List` e `ArrayList` corretos.
#codigo-questao[
```java
Estadia e = new Estadia();
e.adicionarHoras(4);
List<Cobranca> opcoes = new ArrayList<>();
opcoes.add(new CobrancaPorHora());
opcoes.add(new CobrancaPorDiaria());
for (Cobranca c : opcoes) {
  c.calcularValor(e);
}
```
]
Por que a mesma chamada, `c.calcularValor(e)`, executa cálculos diferentes nas duas passagens pelo laço?
#alternativa("A")[
O compilador usa a classe de cada elemento para alterar o tipo declarado de `c`.
]
#alternativa("B")[
O tipo de `c` fixa a implementação, e os atributos de cada cobrança mudam o resultado.
]
#alternativa("C")[
O objeto `e` escolhe a cobrança, e `c` encaminha a chamada para essa escolha.
]
#alternativa("D")[
O tipo de `c` permite a chamada, e o objeto referenciado determina a implementação.
]
#alternativa("E")[
O compilador define a implementação de cada passagem a partir das chamadas a `add`.
]

]

#questao("Q2. (10 pontos)")[
A classe `Fixa` registra quantas vezes seu método de cálculo foi chamado. `Taxa` usa uma cobrança base e acrescenta R\$ 4 ao valor.
#codigo-questao[
```java
public class Fixa implements Cobranca {
  private int vezes;
  public double calcularValor(Estadia e) {
    vezes++;
    return 16.0;
  }
  public int getVezes() { return vezes; }
}
```
]
#codigo-questao[
```java
public class Taxa implements Cobranca {
  private Cobranca base;
  public Taxa(Cobranca c) { base = c; }
  public double calcularValor(Estadia e) {
    double valor = base.calcularValor(e);
    if (valor == 0.0) return 4.0;
    return base.calcularValor(e) + 4.0;
  }
}
```
]
Em seguida, executamos:
#codigo-questao[
```java
Fixa base = new Fixa();
Cobranca c = new Taxa(base);
double valor = c.calcularValor(
    new Estadia());
```
]
Ao final desse trecho, quais são os valores de `valor` e `base.getVezes()`, respectivamente?
#alternativa("A")[
`12.0` e `1`.
]
#alternativa("B")[
`16.0` e `1`.
]
#alternativa("C")[
`16.0` e `2`.
]
#alternativa("D")[
`20.0` e `2`.
]
#alternativa("E")[
`28.0` e `2`.
]

]

#questao("Q3. (10 pontos)")[
A classe `Recibo` permite calcular a cobrança e emitir um comprovante. A cobrança por hora continua como no cenário base.
#codigo-questao[
```java
public interface Comprovavel {
  String emitir();
}
```
]
#codigo-questao[
```java
public class Recibo
    implements Cobranca, Comprovavel {
  public double calcularValor(Estadia e) {
    return 25.0;
  }
  public String emitir() { return "OK"; }
}
```
]
Considere o trecho:
#codigo-questao[
```java
Cobranca primeira = new CobrancaPorHora();
Cobranca segunda = new Recibo();
if (primeira instanceof Comprovavel) {
  Comprovavel a = (Comprovavel) primeira;
  System.out.println(a.emitir());
  Comprovavel b = (Comprovavel) segunda;
  System.out.println(b.emitir());
}
```
]
O trecho compila? Se compilar, o que acontece ao executá-lo?
#alternativa("A")[
Compila, mas não imprime: a condição do `if` é falsa.
]
#alternativa("B")[
Compila e imprime `OK` duas vezes, sem falhar.
]
#alternativa("C")[
Não compila: `Cobranca` não declara o método `emitir`.
]
#alternativa("D")[
Compila, mas falha no cast de `primeira`, antes de imprimir.
]
#alternativa("E")[
Compila, imprime `OK` uma vez e falha no cast de `segunda`.
]

]

#questao("Q4. (10 pontos)")[
Um mesmo objeto pode ser referenciado pelos tipos `Cobranca` e `Cancelavel`, como no exemplo abaixo.
#codigo-questao[
```java
public interface Cancelavel {
  void cancelar();
}
```
]
#codigo-questao[
```java
public class Evento
    implements Cobranca, Cancelavel {
  private boolean cancelada;
  public void cancelar() {
    cancelada = true;
  }
  public double calcularValor(Estadia e) {
    if (cancelada) return 0.0;
    return 30.0;
  }
}
```
]
#codigo-questao[
```java
Evento evento = new Evento();
Cobranca c = evento;
Evento x = evento;
Estadia e = new Estadia();
```
]
Cada chamada a seguir deve ser analisada separadamente, após as declarações acima. Quais compilam sem acrescentar casts?
#codigo-questao[
```java
x.cancelar();         // I
x.calcularValor(e);   // II
e.encerrar(x);       // III
e.encerrar(c);       // IV
```
]
#alternativa("A")[
Apenas I, II e IV.
]
#alternativa("B")[
Apenas I e IV.
]
#alternativa("C")[
Apenas I.
]
#alternativa("D")[
Apenas I, III e IV.
]
#alternativa("E")[
I, II, III e IV.
]

]

#questao("Q5. (10 pontos)")[
A classe `Registro` guarda a estadia recebida no cálculo. Analise também a implementação de `Servico`.
#codigo-questao[
```java
public class Registro
    implements Cobranca {
  private Estadia alvo;
  public double calcularValor(Estadia e) {
    alvo = e;
    return 12.0;
  }
  public Estadia getAlvo() { return alvo; }
}
```
]
#codigo-questao[
```java
public class Servico implements Cobranca {
  private Cobranca base;
  public Servico(Cobranca c) { base = c; }
  public double calcularValor(Estadia e) {
    Estadia outra = e;
    return base.calcularValor(outra) + 3.0;
  }
}
```
]
O teste verifica se a cobrança base recebeu a mesma estadia que solicitou o cálculo. Considere os imports de JUnit corretos.
#codigo-questao[
```java
@Test
void teste() {
  Estadia e = new Estadia();
  Registro registro = new Registro();
  e.encerrar(new Servico(registro));
  e.calcularValor();
  assertTrue(registro.getAlvo() == e);
}
```
]
O teste passa ou falha? Assinale o resultado e a justificativa corretos.
#alternativa("A")[
Passa: o cálculo usa a cobrança `registro`, preservando também a estadia original.
]
#alternativa("B")[
Passa: o teste compara o conteúdo dos objetos, e as duas estadias têm zero horas.
]
#alternativa("C")[
Falha: `Registro` armazena `outra`, que é uma instância diferente da estadia `e`.
]
#alternativa("D")[
Falha: o cálculo não chama `Registro`, pois a estadia não tem horas registradas.
]
#alternativa("E")[
Falha: `Registro` recebe `e`, mas a atribuição `alvo = e` cria uma cópia da estadia.
]

]

#questao("Q6. (10 pontos)")[
A classe `Seguro` acrescenta R\$ 7 ao valor da cobrança recebida no construtor.
#codigo-questao[
```java
public class Seguro implements Cobranca {

  private Cobranca base;
  public Seguro(Cobranca c) { base = c; }
  public double calcularValor(Estadia e) {
    return base.calcularValor(e) + 7.0;
  }
}
```
]
Uma cobrança com seguro é criada e, depois, a variável `base` recebe outra modalidade:
#codigo-questao[
```java
Estadia e = new Estadia();
e.adicionarHoras(6);
Cobranca base = new CobrancaPorHora();
Cobranca segurada = new Seguro(base);
base = new CobrancaPorDiaria();
e.encerrar(segurada);
```
]
Qual valor é devolvido por `e.calcularValor()` ao final desse trecho?
#alternativa("A")[
`0.0`.
]
#alternativa("B")[
`15.0`.
]
#alternativa("C")[
`40.0`.
]
#alternativa("D")[
`22.0`.
]
#alternativa("E")[
`37.0`.
]

]

#questao("Q7. (40 pontos)")[
Use `Ajustavel` e `Flexivel` do cenário base e as duas classes abaixo.
#codigo-questao[
```java
public class Adicional implements Cobranca {
  private Cobranca base;
  private double adicional;
  public Adicional(Cobranca c, double v) {
    base = c;
    adicional = v;
  }
  public double calcularValor(Estadia e) {
    return base.calcularValor(e)
        + adicional;
  }
}
```
]
#codigo-questao[
```java
public class Teto implements Cobranca {
  private Cobranca base;
  private double limite;
  public Teto(Cobranca c, double max) {
    base = c;
    limite = max;
  }
  public double calcularValor(Estadia e) {
    double valor = base.calcularValor(e);
    if (valor > limite) return limite;
    return valor;
  }
}
```
]
Os cinco trechos são *independentes*. Escreva as oito saídas na ordem dos `println` numerados. Cada saída vale *5 pontos*. Considere os imports de `List` e `ArrayList` corretos.

#colbreak()
*Trecho I*
#codigo-questao[
```java
Estadia e = new Estadia();
e.adicionarHoras(3);
Cobranca base = new CobrancaPorHora();
Cobranca uma = new Adicional(base, 3.0);
Cobranca duas = new Adicional(uma, 4.0);
e.encerrar(duas);
System.out.println(e.calcularValor()); //1
```
]

*Trecho II*
#codigo-questao[
```java
Flexivel f = new Flexivel(4);
List<Ajustavel> opcoes = new ArrayList<>();
opcoes.add(f);
opcoes.add(f);
for (Ajustavel a : opcoes) {
  a.alterarTarifa(6.0);
}
System.out.println(f.getSaldo());      //2
```
]

*Trecho III*
#codigo-questao[
```java
Estadia e = new Estadia();
Cobranca base = new CobrancaPorDiaria();
Cobranca a = new Teto(
    new Adicional(base, 8.0), 35.0);
Cobranca b = new Adicional(
    new Teto(base, 35.0), 8.0);
double diferenca =
  b.calcularValor(e) - a.calcularValor(e);
System.out.println(diferenca);        //3
```
]

*Trecho IV*
#codigo-questao[
```java
Estadia e = new Estadia();
e.adicionarHoras(3);
Cobranca opcao = new CobrancaPorHora();
if (!(opcao instanceof Ajustavel)) {
  opcao = new CobrancaPorDiaria();
}
System.out.println(
    opcao.calcularValor(e));          //4
opcao = new Teto(
    new CobrancaPorHora(), 20.0);
System.out.println(
    opcao.calcularValor(e));          //5
```
]

*Trecho V*
#codigo-questao[
```java
Flexivel f = new Flexivel(3);
f.alterarTarifa(-2.0);
System.out.println(f.getSaldo());      //6
Flexivel g = new Flexivel(2);
g.alterarTarifa(4.0);
System.out.println(
    g.alterarTarifa(6.0));             //7
Cobranca c = new Adicional(g, 3.0);
System.out.println(
    c instanceof Ajustavel);          //8
```
]

]

]
]

// GABARITO DO PROFESSOR (não é impresso):
// Q1 D; Q2 D; Q3 A; Q4 E; Q5 A; Q6 E (10 pontos cada).
// Q7: 22.0; 2; 8.0; 40.0; 15.0; 3; true; false (5 pontos cada).
