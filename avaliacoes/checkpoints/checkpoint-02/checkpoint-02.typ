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

#let questao-curta(numero) = grid(
  columns: (auto, 1.2cm),
  column-gutter: 0.1cm,
  align: horizon,
  text(weight: "bold")[Q#numero],
  campo(1cm),
)

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

#let codigo(body, tamanho: 7pt) = block(
  width: 100%,
  breakable: true,
  fill: rgb("#f7f7f8"),
  stroke: 0.4pt + rgb("#cccccc"),
  radius: 2pt,
  inset: 8pt,
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
  above: 5pt,
)[
  #set raw(tab-size: 2)
  #show raw.where(block: true): set text(size: 9pt)
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
  Programação Orientada a Objetos - Checkpoint 02
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
    columns: (1fr,),
    row-gutter: 0.15cm,

    grid(
      columns: (0.7cm, 1fr),
      column-gutter: 0.15cm,
      align: horizon,
      [**Q1**],
      grid(
        columns: (
          auto, 2.2cm,
          auto, 2.2cm,
          auto, 2.2cm,
          auto, 2.2cm,
          auto, 2.2cm,
          auto, 2.2cm,
          auto, 2.2cm,
        ),
        column-gutter: 0.1cm,
        align: horizon,
        [A)], campo(2cm),
        [B)], campo(2cm),
        [C)], campo(2cm),
        [D)], campo(2cm),
        [E)], campo(2cm),
        [F)], campo(2cm),
        [G)], campo(2cm),
      ),
    ),

    grid(
      columns: (
        0.7cm,
        1fr,
        auto, auto,
        auto, auto,
        auto, auto,
        auto, auto,
      ),
      column-gutter: 0.15cm,
      align: horizon,
      [**Q2**],

      grid(
        columns: (
          auto, 1.2cm,
          auto, 1.2cm,
          auto, 1.2cm,
          auto, 1.2cm,
          auto, 1.2cm,
        ),
        column-gutter: 0.1cm,
        align: horizon,
        [A)], campo(1cm),
        [B)], campo(1cm),
        [C)], campo(1cm),
        [D)], campo(1cm),
        [E)], campo(1cm),
      ),

      separador(),
      questao-curta(3),
      separador(),
      questao-curta(4),
      separador(),
      questao-curta(5),
      separador(),
      questao-curta(6),
    ),
  )
]

#v(5pt)

// ============================================================
// CENÁRIO — CÓDIGOS DO SISTEMA
// ============================================================

#secao("CENÁRIO")[
  Considere o sistema de uma locadora de carros representado pelos
  códigos abaixo. Analise as classes e suas relações para responder às
  questões.

#columns(
  2,
  gutter: 0.4cm,
)[
  #text(size: 9pt, weight: "bold")[Carro.java]
  #v(2pt)

  #codigo[
```java
public class Carro {
  private String modelo;
  private double valorDiaria;

  public Carro(String modelo, double valorDiaria) {
    this.modelo = modelo;

    if (valorDiaria >= 0) {
      this.valorDiaria = valorDiaria;
    }
  }

  public double getValorDiaria() {
    return valorDiaria;
  }

  public void alterarValorDiaria(double novoValor) {
    if (novoValor >= 0) {
      valorDiaria = novoValor;
    }
  }
}
```
  ]

  #v(5pt)
  #text(size: 9pt, weight: "bold")[Locacao.java]
  #v(2pt)

  #codigo[
```java
public class Locacao {
  private Carro carro;
  private int quantidadeDias;

  public Locacao(Carro carro, int quantidadeDias) {
    this.carro = carro;

    if (quantidadeDias >= 0) {
      this.quantidadeDias = quantidadeDias;
    }
  }

  public Carro getCarro() {
    return carro;
  }

  public int getQuantidadeDias() {
    return quantidadeDias;
  }

  public void aumentarDias(int quantidade) {
    if (quantidade > 0) {
      quantidadeDias += quantidade;
    }
  }

  public double calcularValor() {
    return carro.getValorDiaria() * quantidadeDias;
  }
}
```
  ]

  #v(5pt)
  #text(size: 9pt, weight: "bold")[Patio.java]
  #v(2pt)

  #codigo[
```java
import java.util.ArrayList;
import java.util.List;

public class Patio {
  private List<Carro> carros;

  public Patio() {
    carros = new ArrayList<>();
  }

  public void adicionarCarro(Carro carro) {
    carros.add(carro);
  }

  public int contarDiariasAcima(double limite) {
    int quantidade = 0;

    for (Carro carro : carros) {
      if (carro.getValorDiaria() >= limite) {
        quantidade = quantidade + 1;
      }
    }

    return quantidade;
  }
}
```
  ]

  #v(5pt)
  #text(size: 9pt, weight: "bold")[Fatura.java]
  #v(2pt)

  #codigo[
```java
import java.util.ArrayList;
import java.util.List;

public class Fatura {
  private List<Locacao> locacoes;

  public Fatura() {
    locacoes = new ArrayList<>();
  }

  public void adicionarLocacao(Locacao locacao) {
    locacoes.add(locacao);
  }

  public double calcularTotal() {
    double total = 0.0;

    for (Locacao locacao : locacoes) {
      total += locacao.calcularValor();
    }

    return total;
  }
}
```
  ]

]

]

#pagebreak()

#text(size: 11pt, weight: "bold")[Main.java]
#v(3pt)

#codigo(tamanho: 10pt)[
#if variante == "b" {
```java
public class Main {
  public static void main(String[] args) {
    Carro hatch = new Carro("Onix", 100.0);
    Locacao principal = new Locacao(hatch, 2);

    System.out.println(principal.calcularValor());

    hatch.alterarValorDiaria(110.0);
    System.out.println(principal.calcularValor());

    Locacao apoio = principal;
    apoio.aumentarDias(2);
    System.out.println(principal.calcularValor());

    Locacao segunda = new Locacao(hatch, 3);
    System.out.println(segunda.calcularValor());

    Carro referencia = hatch;
    referencia.alterarValorDiaria(90.0);

    System.out.println(principal.calcularValor());
    System.out.println(segunda.calcularValor());

    apoio.aumentarDias(1);
    System.out.println(principal.calcularValor());
  }
}
```
} else {
```java
public class Main {
  public static void main(String[] args) {
    Carro compacto = new Carro("Argo", 120.0);
    Locacao principal = new Locacao(compacto, 3);

    System.out.println(principal.calcularValor());

    compacto.alterarValorDiaria(140.0);
    System.out.println(principal.calcularValor());

    Locacao apoio = principal;
    apoio.aumentarDias(1);
    System.out.println(principal.calcularValor());

    Locacao segunda = new Locacao(compacto, 2);
    System.out.println(segunda.calcularValor());

    Carro apoioCarro = compacto;
    apoioCarro.alterarValorDiaria(150.0);

    System.out.println(principal.calcularValor());
    System.out.println(segunda.calcularValor());

    apoio.aumentarDias(1);
    System.out.println(principal.calcularValor());
  }
}
```
}
]

// ============================================================
// QUESTÕES 1 E 2
// ============================================================

#v(8pt)
#secao("QUESTÕES")[
  #columns(
    2,
    gutter: 0.6cm,
  )[
    #set text(size: 12pt)
    #text(weight: "bold")[Q1. (35 pontos) Considere a execução completa da classe `Main` e indique o valor exibido no console em cada impressão abaixo.]

    #alternativa("A")[Linha 6]
    #alternativa("B")[Linha 9]
    #alternativa("C")[Linha 13]
    #alternativa("D")[Linha 16]
    #alternativa("E")[Linha 21]
    #alternativa("F")[Linha 22]
    #alternativa("G")[Linha 25]

    #colbreak()

   #text(weight: "bold")[Q2. (25 pontos) Analise as afirmativas abaixo e assinale (V) para as verdadeiras e (F) para as falsas.]

    #if variante == "b" [
    #alternativa("A")[Depois que a classe `Carro` declara `Carro(String modelo, double valorDiaria)`, Java continua fornecendo automaticamente um construtor sem argumentos, portanto `new Carro()` também permanece válido.]
    #alternativa("B")[Na instrução `this.valorDiaria = valorDiaria`, `this.valorDiaria` identifica o campo do objeto atual, enquanto `valorDiaria`, sem `this`, identifica o parâmetro recebido pelo construtor.]
    #alternativa("C")[Se a regra que impede valores negativos ficar apenas em `Main`, qualquer outro código que use o construtor também estará automaticamente impedido de fornecer um valor negativo.]
    #alternativa("D")[Ao executar `new Carro("Teste", -50.0)`, o campo `valorDiaria` permanece com `0.0`, pois o valor negativo não é incorporado ao estado pelo construtor.]
    #alternativa("E")[Em `new Carro("Argo", 120.0)`, `"Argo"` e `120.0` são argumentos fornecidos na criação; `modelo` e `valorDiaria`, declarados no construtor, são parâmetros que recebem esses valores.]
    ] else [
    #alternativa("A")[Ao executar `new Carro("Teste", -50.0)`, o campo `valorDiaria` permanece com `0.0`, pois o valor negativo não é incorporado ao estado pelo construtor.]
    #alternativa("B")[Depois que a classe `Carro` declara `Carro(String modelo, double valorDiaria)`, Java continua fornecendo automaticamente um construtor sem argumentos, portanto `new Carro()` também permanece válido.]
    #alternativa("C")[Em `new Carro("Argo", 120.0)`, `"Argo"` e `120.0` são argumentos fornecidos na criação; `modelo` e `valorDiaria`, declarados no construtor, são parâmetros que recebem esses valores.]
    #alternativa("D")[Na instrução `this.valorDiaria = valorDiaria`, `this.valorDiaria` identifica o campo do objeto atual, enquanto `valorDiaria`, sem `this`, identifica o parâmetro recebido pelo construtor.]
    #alternativa("E")[Se a regra que impede valores negativos ficar apenas em `Main`, qualquer outro código que use o construtor também estará automaticamente impedido de fornecer um valor negativo.]
    ]
  ]
]

#secao("QUESTÕES — CONTINUAÇÃO")[
  #show raw.where(block: true): set text(size: 7pt)
  #set raw(tab-size: 2)

  #columns(
    2,
    gutter: 0.6cm,
  )[
    #set text(size: 12pt)
    // ========================================================
    // QUESTÃO 3
    // ========================================================

    #text(weight: "bold")[Q3. (10 pontos) Considere os objetos abaixo:]

    #codigo-questao[
```java
Carro primeiro = new Carro("Mobi", 100.0);
Carro segundo = new Carro("Mobi", 100.0);

Locacao locacaoA = new Locacao(primeiro, 2);
Locacao locacaoB = new Locacao(segundo, 2);
```
    ]

    Qual alternativa descreve corretamente a identidade desses objetos?

    #if variante == "b" [
    #alternativa("A")[`locacaoA.getCarro() == locacaoB.getCarro()` é `true`, pois os dois carros possuem valores iguais em seus campos.]
    #alternativa("B")[`primeiro == segundo` e `locacaoA == locacaoB` são `false`; expressões `new` diferentes criaram objetos com identidades distintas, mesmo que seus estados coincidam.]
    #alternativa("C")[Como os dois carros possuem o mesmo estado, Java mantém apenas um deles e faz as duas variáveis apontarem automaticamente para a mesma identidade.]
    #alternativa("D")[`primeiro == segundo` é `true`, pois os dois carros possuem o mesmo modelo e o mesmo valor de diária.]
    #alternativa("E")[`locacaoA == locacaoB` é `true`, pois as duas locações produzem o mesmo valor.]
    ] else [
    #alternativa("A")[`primeiro == segundo` é `true`, pois os dois carros possuem o mesmo modelo e o mesmo valor de diária.]

    #alternativa("B")[`locacaoA == locacaoB` é `true`, pois as duas locações produzem o mesmo valor.]

    #alternativa("C")[`primeiro == segundo` e `locacaoA == locacaoB` são `false`; expressões `new` diferentes criaram objetos com identidades distintas, mesmo que seus estados coincidam.]

    #alternativa("D")[`locacaoA.getCarro() == locacaoB.getCarro()` é `true`, pois os dois carros possuem valores iguais em seus campos.]

    #alternativa("E")[Como os dois carros possuem o mesmo estado, Java mantém apenas um deles e faz as duas variáveis apontarem automaticamente para a mesma identidade.]
    ]

    #v(15pt)

    // ========================================================
    // QUESTÃO 4
    // ========================================================

    #text(weight: "bold")[Q4. (10 pontos) Considere agora uma classe `Fatura` que reúne várias locações e precisa calcular o valor total a pagar. Cada `Locacao` já possui o método `calcularValor()`.]

    Qual proposta distribui melhor as responsabilidades?

    #if variante == "b" [
    #alternativa("A")[`Main` deve manter a lista de locações e fazer toda a soma, pois é o código que cria os objetos.]
    #alternativa("B")[`Fatura` deve copiar para seus próprios campos o valor da diária e a quantidade de dias de cada locação antes de calcular o total.]
    #alternativa("C")[`Fatura` deve percorrer suas locações e solicitar `locacao.calcularValor()` a cada uma, acumulando os resultados.]
    #alternativa("D")[`Fatura` deve percorrer suas locações, obter diretamente de cada uma o carro e a quantidade de dias e refazer internamente o cálculo do valor da locação.]
    #alternativa("E")[Cada `Carro` deve conhecer todas as locações em que aparece e calcular o valor total da fatura.]
    ] else [
    #alternativa("A")[`Fatura` deve percorrer suas locações, obter diretamente de cada uma o carro e a quantidade de dias e refazer internamente o cálculo do valor da locação.]

    #alternativa("B")[`Fatura` deve percorrer suas locações e solicitar `locacao.calcularValor()` a cada uma, acumulando os resultados.]

    #alternativa("C")[Cada `Carro` deve conhecer todas as locações em que aparece e calcular o valor total da fatura.]

    #alternativa("D")[`Main` deve manter a lista de locações e fazer toda a soma, pois é o código que cria os objetos.]

    #alternativa("E")[`Fatura` deve copiar para seus próprios campos o valor da diária e a quantidade de dias de cada locação antes de calcular o total.]
    ]

    #colbreak()

    // ========================================================
    // QUESTÃO 5
    // ========================================================

    #text(weight: "bold")[Q5. (10 pontos) Considere a implementação de `Patio` apresentada no cenário e o seguinte trecho:]

    #codigo-questao[
```java
Carro popular = new Carro("Mobi", 100.0);
Carro sedan = new Carro("Virtus", 140.0);

Patio patio = new Patio();
patio.adicionarCarro(popular);
patio.adicionarCarro(sedan);
patio.adicionarCarro(popular);

popular.alterarValorDiaria(150.0);
```
    ]

    Qual valor será devolvido por `patio.contarDiariasAcima(130.0)`?

    #if variante == "b" [
    #alternativa("A")[O código não compila porque o mesmo objeto `Carro` não pode ser adicionado duas vezes à lista.]
    #alternativa("B")[`2`]
    #alternativa("C")[`0`]
    #alternativa("D")[`1`]
    #alternativa("E")[`3`]
    ] else [
    #alternativa("A")[`0`]
    #alternativa("B")[`1`]
    #alternativa("C")[`2`]
    #alternativa("D")[`3`]
    #alternativa("E")[O código não compila porque o mesmo objeto `Carro` não pode ser adicionado duas vezes à lista.]
    ]

    #v(15pt)

    // ========================================================
    // QUESTÃO 6
    // ========================================================

    #text(weight: "bold")[Q6. (10 pontos) Na classe `Fatura` apresentada no cenário, um estudante propõe acrescentar:]

    #codigo-questao[
```java
public List<Locacao> getLocacoes() {
  return locacoes;
}
```
    ]

    Considerando que `Fatura` deve controlar sua própria coleção por meio de suas operações, qual análise é a mais adequada?

    #if variante == "b" [
    #alternativa("A")[A mudança transforma cada `Locacao` armazenada na lista em um objeto `public`, mas não permite modificar a coleção.]
    #alternativa("B")[A mudança é necessária, pois um campo `private` não pode ser percorrido pelos métodos da própria classe.]
    #alternativa("C")[A mudança enfraquece esse controle, pois quem receber a referência da lista poderá modificá-la diretamente sem passar pelas operações definidas por `Fatura`.]
    #alternativa("D")[A mudança cria automaticamente outra lista contendo cópias das locações, portanto a coleção interna continua isolada.]
    #alternativa("E")[A mudança é segura porque `locacoes` continua declarada como `private`; nenhuma alteração poderá ser feita fora da classe.]
    ] else [
    #alternativa("A")[A mudança enfraquece esse controle, pois quem receber a referência da lista poderá modificá-la diretamente sem passar pelas operações definidas por `Fatura`.]

    #alternativa("B")[A mudança é segura porque `locacoes` continua declarada como `private`; nenhuma alteração poderá ser feita fora da classe.]

    #alternativa("C")[A mudança cria automaticamente outra lista contendo cópias das locações, portanto a coleção interna continua isolada.]

    #alternativa("D")[A mudança é necessária, pois um campo `private` não pode ser percorrido pelos métodos da própria classe.]

    #alternativa("E")[A mudança transforma cada `Locacao` armazenada na lista em um objeto `public`, mas não permite modificar a coleção.]
    ]
  ]
]
