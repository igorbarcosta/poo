// arquivo: checkpoint-02-revisado.typ

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

#let variante = sys.inputs.at("variante", default: "a")

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
  Programação Orientada a Objetos - Checkpoint 03
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
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    column-gutter: 0.3cm,
    align: horizon,
    [Q1: #campo(100%, altura: 1cm)],
    [Q2: #campo(100%, altura: 1cm)],
    [Q3: #campo(100%, altura: 1cm)],
    [Q4: #campo(100%, altura: 1cm)],
    [Q5: #campo(100%, altura: 1cm)],
  )
  #grid(
    columns: (auto, 1fr),
    column-gutter: 0.15cm,
    row-gutter: 3pt,
    align: horizon,
    [Q6],
    grid(
      columns: (auto, 1fr, auto, 1fr, auto, 1fr),
      column-gutter: 3pt,
      align: horizon,
      [1)], campo(100%, altura: 1cm),
      [2)], campo(100%, altura: 1cm),
      [3)], campo(100%, altura: 1cm),
        [4)], campo(100%, altura: 1cm),
        [5)], campo(100%, altura: 1cm),
        [6)], campo(100%, altura: 1cm),
      ),
      [Q7],
    grid(
      columns: (auto, 1fr, auto, 1fr),
      column-gutter: 3pt,
      align: horizon,
      [1)], campo(100%, altura: 1cm),
      [2)], campo(100%, altura: 1cm),
    ),
    [Q8],
    grid(
      columns: (auto, 1fr, auto, 1fr),
      column-gutter: 3pt,
      align: horizon,
      [Valor:], campo(100%, altura:1cm),
      [Teste:], campo(100%, altura:1cm),
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
  public int getHoras() {
    return horas;
  }
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



  #questao("Q1.")[
  Considere uma alteração na classe `Estadia`: o parâmetro `opcao` do método `encerrar` passa a ser do tipo `CobrancaPorHora`. Os demais elementos da classe permanecem como no cenário base.

  O método fica assim:

  #codigo-questao[
```java
public void encerrar(CobrancaPorHora opcao) {
  if (!encerrada && opcao != null) {
    cobranca = opcao;
    encerrada = true;
  }
}
```
  ]

  Com essa versão do método, considere o trecho abaixo:

  #codigo-questao[
```java
Estadia e = new Estadia();
e.adicionarHoras(3);

Cobranca c = new CobrancaPorHora();
e.encerrar(c);
```
  ]

  A chamada `e.encerrar(c)` compila? Assinale a alternativa com o resultado e a justificativa corretos.

  #alternativa("A")[
    A chamada compila porque o objeto referenciado por `c` é da classe `CobrancaPorHora`.
  ]

  #alternativa("B")[
    A chamada compila porque a variável `c` e o campo `cobranca` têm tipo `Cobranca`.
  ]

  #alternativa("C")[
    A chamada não compila porque o tipo declarado de `c` é `Cobranca`, e o parâmetro exige `CobrancaPorHora`.
  ]

  #alternativa("D")[
    A chamada não compila porque uma referência de interface não pode guardar um objeto de classe concreta.
  ]

  #alternativa("E")[
    A chamada não compila porque o campo `cobranca` e o parâmetro `opcao` precisam ter o mesmo tipo.
  ]
  ]
#questao("Q2.")[
  O estacionamento quer oferecer a primeira hora gratuita na modalidade por hora. Até uma hora de permanência, o valor deve ser R\$ 0; acima disso, devem ser cobrados R\$ 5 por hora além da primeira.

  A cobrança por diária deve continuar custando R\$ 40. O tempo registrado em `Estadia` e informado por `getHoras` deve continuar correspondendo a todas as horas de permanência.

  Qual alteração atende a esses requisitos?

  #alternativa("A")[
    Alterar `Estadia.adicionarHoras` para registrar uma hora a menos que a quantidade recebida.
  ]

  #alternativa("B")[
    Alterar `Estadia.calcularValor` para subtrair `5.0` do valor calculado pela cobrança escolhida.
  ]

  #alternativa("C")[
    Alterar `Estadia.getHoras` para devolver uma hora a menos que o valor registrado.
  ]

  #alternativa("D")[
    Alterar `Estadia.calcularValor` para devolver `0.0` até uma hora e manter o cálculo atual nas demais estadias.
  ]

  #alternativa("E")[
    Alterar `CobrancaPorHora.calcularValor` para aplicar a nova regra de preço.
  ]
]


#questao("Q3.")[
  Considere esta implementação adicional:

  #codigo-questao[
```java
public class CobrancaEvento implements Cobranca {
  public String getNomeEvento() {
    return "Feira";
  }

  public double calcularValor(Estadia e) {
    return 30.0;
  }
}
```
  ]

  E as referências:

  #codigo-questao[
```java
CobrancaEvento ev = new CobrancaEvento();
Cobranca mod = ev;
Estadia e = new Estadia();
e.adicionarHoras(3);
```
  ]

  Qual trecho exibe o nome do evento e encerra `e`
  com a cobrança referenciada por `ev`, sem alterar
  as classes nem a interface?

  #alternativa("A")[
    #codigo-questao[
```java
System.out.println(ev.getNomeEvento());
e.encerrar(mod);
```
    ]
  ]

  #alternativa("B")[
    #codigo-questao[
```java
System.out.println(mod.getNomeEvento());
e.encerrar(mod);
```
    ]
  ]

  #alternativa("C")[
    #codigo-questao[
```java
System.out.println(e.getNomeEvento());
e.encerrar(mod);
```
    ]
  ]

  #alternativa("D")[
    #codigo-questao[
```java
System.out.println(ev.getNomeEvento());
e.encerrar(ev.getNomeEvento());
```
    ]
  ]

  #alternativa("E")[
    #codigo-questao[
```java
System.out.println(ev.getNomeEvento());
mod.encerrar(e);
```
    ]
  ]
]

#questao("Q4.")[
  Um teste cria uma estadia `e` com 8 horas e executa:

  #codigo-questao[
```java
Cobranca hora = new CobrancaPorHora();
Cobranca dia = new CobrancaPorDiaria();
Cobranca escolhida = hora;

if (dia.calcularValor(e) <
    hora.calcularValor(e)) {
    escolhida = dia;
}

e.encerrar(escolhida);
assertEquals(40.0, e.calcularValor());
```
  ]

  O objetivo é escolher a modalidade mais barata. Após trocar `<` (menor que) por `>` (maior que), o teste continua passando. Qual análise explica esse resultado?

  #alternativa("A")[O teste confirma que as comparações produzem a mesma escolha para qualquer tempo.]
  #alternativa("B")[Os preços são iguais nesse caso; o teste não distingue as duas comparações.]
  #alternativa("C")[O método `encerrar` corrige a escolha quando recebe uma cobrança mais cara.]
  #alternativa("D")[O resultado `40.0` identifica a classe do objeto escolhido como `CobrancaPorDiaria`.]
  #alternativa("E")[Assumir o contrato `Cobranca` torna equivalentes os cálculos das duas modalidades.]
]

#questao("Q5.")[
  Somente nesta questão, o método `encerrar` é substituído por:

  #codigo-questao[
```java
public void encerrar(Cobranca escolhida) {
  if (escolhida != null) {
    cobranca = escolhida;
    encerrada = true;
  }
}
```
  ]

  Qual teste passa com o método do cenário base e falha com a implementação acima? Considere os imports de JUnit corretos.

  #alternativa("A")[
    #codigo-questao[
```java
@Test
void testeA() {
  Estadia e = new Estadia();
  e.adicionarHoras(3);
  e.encerrar(new CobrancaPorHora());
  assertEquals(15.0, e.calcularValor());
}
```
    ]
  ]

  #alternativa("B")[
    #codigo-questao[
```java
@Test
void testeB() {
  Estadia e = new Estadia();
  e.adicionarHoras(3);
  e.encerrar(new CobrancaPorHora());
  e.encerrar(new CobrancaPorHora());
  assertEquals(15.0, e.calcularValor());
}
```
    ]
  ]

  #alternativa("C")[
    #codigo-questao[
```java
@Test
void testeC() {
  Estadia e = new Estadia();
  e.adicionarHoras(3);
  e.encerrar(new CobrancaPorHora());
  e.encerrar(new CobrancaPorDiaria());
  assertTrue(e.isEncerrada());
}
```
    ]
  ]

  #alternativa("D")[
    #codigo-questao[
```java
@Test
void testeD() {
  Estadia e = new Estadia();
  e.adicionarHoras(3);
  e.encerrar(new CobrancaPorHora());
  e.encerrar(new CobrancaPorDiaria());
  assertEquals(15.0, e.calcularValor());
}
```
    ]
  ]

  #alternativa("E")[
    #codigo-questao[
```java
@Test
void testeE() {
  Estadia e = new Estadia();
  e.adicionarHoras(3);
  e.encerrar(new CobrancaPorHora());
  e.encerrar(new CobrancaPorDiaria());
  assertEquals(40.0, e.calcularValor());
}
```
    ]
  ]
]

#questao("Q6.")[
  Escreva os valores exibidos, na ordem das impressões.

  #codigo-questao[
```java
Cobranca c = new CobrancaPorHora();

Estadia a = new Estadia();
a.adicionarHoras(4);
a.encerrar(c);

Estadia b = new Estadia();
b.adicionarHoras(9);

System.out.println(a.calcularValor()); //1
System.out.println(b.calcularValor()); //2
System.out.println(c.calcularValor(b)); //3
```
  ]

  #codigo-questao[
```java
Estadia e = new Estadia();
e.adicionarHoras(3);
e.encerrar(null);

System.out.println(e.isEncerrada()); //4

if (e.isEncerrada()) {
  e.adicionarHoras(7);
} else {
  e.adicionarHoras(2);
}

e.encerrar(new CobrancaPorHora());
System.out.println(e.calcularValor()); //5
```
  ]

  #codigo-questao[
```java
Estadia principal = new Estadia();
Estadia apoio = principal;

principal.adicionarHoras(6);
apoio.adicionarHoras(4);

apoio = new Estadia();
apoio.adicionarHoras(
                principal.getHoras() - 7);
principal.adicionarHoras(apoio.getHoras());

System.out.println(principal.getHoras()); //6
```
  ]
]

#questao("Q7.")[
  Considere esta implementação adicional:

  #codigo-questao[
```java
public class CobrancaAjustavel
                    implements Cobranca {
  private double tarifa = 5.0;

  public void alterarTarifa(double valor) {
    if (valor > 0) {
      tarifa = valor;
    }
  }
  public double calcularValor(Estadia e) {
      return e.getHoras() * tarifa;
  }
}
  ```
    ]

    Escreva os valores exibidos, na ordem das impressões.

    #codigo-questao[
  ```java
  CobrancaAjustavel ajuste = new CobrancaAjustavel();
  Cobranca modalidade = ajuste;

  Estadia e = new Estadia();
  e.adicionarHoras(7);
  e.encerrar(modalidade);

  double valorRegistrado = e.calcularValor();
  ajuste.alterarTarifa(4.0);

  System.out.println(valorRegistrado); //1
  System.out.println(e.calcularValor()); //2
  ```
    ]

  ]

  #questao("Q8.")[
    Somente nesta questão, o método `calcularValor` de `Estadia` é substituído
    por:

    #codigo-questao[
  ```java
  public double calcularValor() {
    if (!encerrada) {
      return 0.0;
    }
    return horas * 5.0;
  }
  ```
    ]

    Considere o teste JUnit abaixo, com os imports corretos. Escreva o valor
    exibido pelo `println` e indique se o teste *PASSA* ou *FALHA*.

    #codigo-questao[
  ```java
  @Test
  void teste() {
    Estadia e = new Estadia();
    Cobranca mod = new CobrancaPorDiaria();
    e.adicionarHoras(6);

    assertFalse(e.isEncerrada());
    e.encerrar(mod);
    System.out.println(e.calcularValor());

    assertEquals(
        mod.calcularValor(e),
        e.calcularValor()
    );
  }
  ```
    ]
  ]
]
]
