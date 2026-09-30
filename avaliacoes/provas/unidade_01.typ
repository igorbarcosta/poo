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

#let resposta(numero) = {
  let prefixo = if numero < 10 { "0" } else { "" }
  grid(
    columns: (auto, 1fr),
    column-gutter: 0.06cm,
    align: horizon,
    text(size: 12pt, weight: "bold")[Q.#prefixo#numero],
    campo(2.8cm, altura: 0.8cm),
  )
}

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

#let codigo(body, tamanho: 12pt) = block(
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

#let codigoq(body, tamanho: 10pt) = block(
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
  Programação Orientada a Objetos - Unidade 01
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
    row-gutter: 0.12cm,
    grid(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr),
      column-gutter: 0.1cm,
      resposta(1), resposta(2), resposta(3), resposta(4), resposta(5),
    ),
    grid(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr),
      column-gutter: 0.1cm,
      resposta(6), resposta(7), resposta(8), resposta(9), resposta(10),
    ),
    grid(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr),
      column-gutter: 0.1cm,
      resposta(11), resposta(12), resposta(13), resposta(14), resposta(15),
    ),
    grid(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr),
      column-gutter: 0.1cm,
      resposta(16), resposta(17), resposta(18), resposta(19), resposta(20),
    ),
  )
]

#v(5pt)

// ============================================================
// CENÁRIO — CÓDIGOS DO SISTEMA
// ============================================================

#secao("CENÁRIO")[
Considere o sistema abaixo, usado para representar uma eleição de representantes do IFPB.

Analise atentamente as classes e seus métodos. Todas as respostas da prova devem ser derivadas exclusivamente do código apresentado.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 0.4cm,
  [
  #text(size: 11pt, weight: "bold")[Candidato.java]
  #v(2pt)
  #codigo(tamanho: 9pt)[
```java
public class Candidato {

  private int numero;
  private String nome;

  public Candidato(int numero, String nome) {
    this.numero = numero;
    this.nome = nome;
  }

  public int getNumero() {
    return numero;
  }

  public String getNome() {
    return nome;
  }
}
```
  ]

  #v(4pt)
  #text(size: 11pt, weight: "bold")[Voto.java]
  #v(2pt)
  #codigo(tamanho: 9pt)[
```java
public class Voto {

  private Candidato candidato;

  public Voto(Candidato candidato) {
    this.candidato = candidato;
  }

  public boolean ehPara(Candidato cand) {
    return this.candidato == cand;
  }
}
```
  ]
  ],
  [
  #text(size: 11pt, weight: "bold")[Eleitor.java]
  #v(2pt)
  #codigo(tamanho: 9pt)[
```java
public class Eleitor {

  private String identificacao;
  private boolean votou;

  public Eleitor(String identificacao) {
    this.identificacao = identificacao;
    this.votou = false;
  }

  public String getIdentificacao() {
    return identificacao;
  }

  public boolean jaVotou() {
    return votou;
  }

  public void registrarVoto() {
    if (!votou) {
      votou = true;
    }
  }
}
```
  ]
  ],
)


]

#pagebreak()
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

#text(weight: "bold")[Q1. (5 pontos) Observando as classes do sistema, qual alternativa descreve melhor a distribuição de responsabilidades adotada?]

#alternativa("A")[`Eleitor` controla o registro dos votos, enquanto `Eleicao` apenas mantém candidatos cadastrados.]
#alternativa("B")[`Voto` decide se uma votação pode ocorrer, enquanto `Candidato` controla os votos que recebe.]
#alternativa("C")[`Eleicao` coordena a votação, `Eleitor` mantém seu próprio estado e `Voto` registra o candidato escolhido.]
#alternativa("D")[`Candidato` coordena a votação, `Eleitor` registra o candidato escolhido e `Eleicao` mantém apenas os votos.]
#alternativa("E")[`Eleicao` concentra o estado dos eleitores, candidatos e votos, deixando os demais objetos apenas como dados.]

#v(10pt)
#text(weight: "bold")[Q2. (5 pontos) Suponha que a classe `Eleicao` oferecesse o método abaixo:]
#codigo-questao[
```java
public List<Voto> getVotos() {
    return votos;
}
```
]
#text()[Qual seria a principal consequência dessa decisão para o modelo apresentado?]

#alternativa("A")[O cliente poderia consultar os votos, mas continuaria impedido de alterar a coleção mantida pela eleição.]
#alternativa("B")[O cliente poderia alterar diretamente a coleção interna, contornando operações e regras controladas por `Eleicao`.]
#alternativa("C")[A coleção seria copiada a cada chamada, fazendo com que alterações externas não afetassem a eleição.]
#alternativa("D")[Os objetos `Voto` deixariam de manter referências para candidatos e passariam a pertencer ao cliente.]
#alternativa("E")[A eleição deixaria de conseguir percorrer seus votos, pois a lista passaria a ser controlada externamente.]

#v(10pt)
#text(weight: "bold")[Q3. (5 pontos) Um aluno propõe acrescentar o método abaixo à classe `Eleitor`:]

#codigo-questao[
```java
public void setVotou(boolean votou) {
    this.votou = votou;
}
```
]

#text()[Considerando o restante do modelo, qual análise é mais adequada?]

#alternativa("A")[O método é adequado porque todo campo privado deve possuir uma operação pública para escrita.]
#alternativa("B")[O método é adequado porque permite que `Eleicao` altere o estado do eleitor sem chamar `registrarVoto()`.]
#alternativa("C")[O método enfraquece o controle do estado, pois permite alterações que não correspondem necessariamente a uma votação realizada.]
#alternativa("D")[O método não produz diferença porque campos `boolean` não podem ser modificados depois do construtor.]
#alternativa("E")[O método é necessário porque `registrarVoto()` não consegue alterar um campo declarado como `private`.]

#v(10pt)
#text(weight: "bold")[Q4. (5 pontos) A classe `Voto` mantém uma referência para `Candidato`, mas `Candidato` não mantém uma lista dos votos recebidos. O que melhor explica essa decisão no modelo atual?]

#alternativa("A")[A relação inversa é proibida em Java quando uma das classes já mantém referência para a outra.]
#alternativa("B")[`Candidato` não precisa alcançar os votos para cumprir as responsabilidades que lhe foram atribuídas.]
#alternativa("C")[Uma relação entre dois objetos deve sempre existir em apenas uma direção para evitar referências duplicadas.]
#alternativa("D")[`Voto` possui uma cópia completa do candidato e, por isso, não seria possível manter a relação inversa.]
#alternativa("E")[A lista de votos só poderia existir em `Candidato` se a classe também mantivesse referência para `Eleicao`.]

#v(10pt)
#text(weight: "bold")[Q5. (5 pontos) Eleicao mantém candidatos cadastrados e votos registrados. Considerando como esses objetos participam do modelo, qual interpretação é mais adequada?]

#alternativa("A")[Candidatos e votos possuem o mesmo papel estrutural, pois ambos são armazenados em listas mantidas por Eleicao.]

#alternativa("B")[Candidatos formam partes estruturais da eleição, enquanto votos existem independentemente e apenas colaboram com ela.]

#alternativa("C")[Votos funcionam como partes estruturais mantidas pela eleição, enquanto candidatos podem existir independentemente e se associar a ela.]

#alternativa("D")[Candidatos e votos apenas colaboram temporariamente com a eleição, pois uma coleção não estabelece relação entre objetos.]

#alternativa("E")[Votos e candidatos só poderiam fazer parte da estrutura da eleição se também mantivessem uma referência para Eleicao.]

  ]
]

#pagebreak()

#text(size: 11pt, weight: "bold")[Eleicao.java]
#v(3pt)

#codigo(tamanho: 11pt)[
```java
import java.util.ArrayList;
import java.util.List;

public class Eleicao {

    private String nome;
    private List<Candidato> candidatos;
    private List<Voto> votos;
    private boolean encerrada;

    public Eleicao(String nome) {
        this.nome = nome;
        candidatos = new ArrayList<>();
        votos = new ArrayList<>();
        encerrada = false;
    }

    public void cadastrarCandidato(Candidato candidato) {
        if (!encerrada && !candidatoCadastrado(candidato)) {
            candidatos.add(candidato);
        }
    }

    public void votar(Eleitor eleitor, Candidato candidato) {
        if (!encerrada
                && !eleitor.jaVotou()
                && candidatoCadastrado(candidato)) {

            Voto voto = new Voto(candidato);
            votos.add(voto);
            eleitor.registrarVoto();
        }
    }

    public void retirarCandidato(Candidato candidato) {
        if (!encerrada && !possuiVotoPara(candidato)) {
            for (int i = 0; i < candidatos.size(); i++) {
                if (candidatos.get(i) == candidato) {
                    candidatos.remove(i);
                    return;
                }
            }
        }
    }

    public void encerrar() {
        encerrada = true;
    }

    public int quantidadeCandidatos() {
        return candidatos.size();
    }

    public int quantidadeVotos() {
        return votos.size();
    }

    public int totalVotosDe(Candidato candidato) {
        int total = 0;

        for (Voto voto : votos) {
            if (voto.ehPara(candidato)) {
                total++;
            }
        }

        return total;
    }

    public boolean isEncerrada() {
        return encerrada;
    }

    private boolean candidatoCadastrado(Candidato candidato) {
        for (Candidato atual : candidatos) {
            if (atual == candidato) {
                return true;
            }
        }

        return false;
    }

    private boolean possuiVotoPara(Candidato candidato) {
        for (Voto voto : votos) {
            if (voto.ehPara(candidato)) {
                return true;
            }
        }

        return false;
    }
}
```
}
]

#pagebreak()

#secao("QUESTÕES — CONTINUAÇÃO")[

#text(size: 12pt, weight: "bold")[Questões 6 a 20 — Leitura de código (75 pontos)]


Cada trecho abaixo representa uma execução independente. Os objetos criados em um trecho não existem nos demais.

Para cada questão, escreva exatamente o conteúdo exibido pela impressão identificada com seu número. Cada impressão corresponde a uma questão e vale 5 pontos. Não inclua aspas nas respostas textuais.

#v(15pt)
#text(size: 12pt, weight: "bold")[Trecho I — Questões 6 a 8]
#v(5pt)

#codigoq[
```java
public class Main {
    public static void main(String[] args) {
        Candidato ana = new Candidato(15, "Ana");
        Candidato referencia = ana;

        Eleicao eleicao = new Eleicao("Conselho");
        eleicao.cadastrarCandidato(referencia);

        referencia = new Candidato(20, "Bia");
        eleicao.retirarCandidato(referencia);

        System.out.println(eleicao.quantidadeCandidatos()); // Q6

        Candidato alias = ana;
        eleicao.cadastrarCandidato(alias);

        Candidato outraAna = new Candidato(15, "Ana");
        eleicao.cadastrarCandidato(outraAna);

        System.out.println(eleicao.quantidadeCandidatos()); // Q7

        Eleitor titular = new Eleitor("E1");
        Eleitor apoio = titular;

        eleicao.votar(apoio, outraAna);

        System.out.println(titular.jaVotou());              // Q8
    }
}
```
]


#v(15pt)
#text(size: 12pt, weight: "bold")[Trecho II — Questões 9 a 11]
#v(5pt)

#codigoq[
```java
public class Main {
    public static void main(String[] args) {
        Candidato ana1 = new Candidato(15, "Ana");
        Candidato ana2 = new Candidato(15, "Ana");
        Candidato caio = new Candidato(30, "Caio");

        Eleicao eleicao = new Eleicao("Conselho");

        eleicao.cadastrarCandidato(ana1);
        eleicao.cadastrarCandidato(ana2);

        Eleitor e1 = new Eleitor("X");
        Eleitor e2 = new Eleitor("X");

        eleicao.votar(e1, ana1);

        System.out.println(e2.jaVotou());                  // Q9

        Eleitor e3 = new Eleitor("E3");

        eleicao.votar(e3, caio);
        eleicao.cadastrarCandidato(caio);
        eleicao.votar(e3, caio);

        System.out.println(eleicao.totalVotosDe(caio));    // Q10

        eleicao.votar(e2, ana2);
        eleicao.votar(new Eleitor("E4"), ana2);
        eleicao.votar(new Eleitor("E5"), ana1);

        System.out.println(eleicao.totalVotosDe(ana1));    // Q11
    }
}
```
]


#v(15pt)
#text(size: 12pt, weight: "bold")[Trecho III — Questões 12 a 14]
#v(5pt)

#codigoq[
```java
public class Main {
    public static void main(String[] args) {
        Candidato ana1 = new Candidato(15, "Ana");
        Candidato ana2 = new Candidato(15, "Ana");
        Candidato bia = new Candidato(20, "Bia");

        Eleicao eleicao = new Eleicao("Conselho");

        eleicao.cadastrarCandidato(ana1);
        eleicao.cadastrarCandidato(ana2);
        eleicao.cadastrarCandidato(bia);

        eleicao.retirarCandidato(ana1);

        System.out.println(eleicao.quantidadeCandidatos()); // Q12

        Eleicao outraEleicao = new Eleicao("Representacao");
        Eleitor outroEleitor = new Eleitor("E2");

        outraEleicao.cadastrarCandidato(ana1);
        outraEleicao.votar(outroEleitor, ana1);

        System.out.println(outraEleicao.quantidadeVotos()); // Q13

        eleicao.votar(new Eleitor("E1"), ana2);

        eleicao.retirarCandidato(ana2);
        eleicao.retirarCandidato(bia);

        System.out.println(eleicao.quantidadeCandidatos()); // Q14
    }
}
```
]


#v(15pt)
#text(size: 12pt, weight: "bold")[Trecho IV — Questões 15 a 17]
#v(5pt)

#codigoq[
```java
public class Main {
    public static void main(String[] args) {
        Candidato ana = new Candidato(15, "Ana");
        Candidato bia = new Candidato(20, "Bia");

        Eleitor compartilhado = new Eleitor("E1");
        Eleitor livre = new Eleitor("E2");

        Eleicao manha = new Eleicao("Manha");
        Eleicao tarde = new Eleicao("Tarde");

        manha.cadastrarCandidato(ana);
        manha.cadastrarCandidato(bia);

        tarde.cadastrarCandidato(ana);
        tarde.cadastrarCandidato(bia);

        manha.votar(compartilhado, ana);

        tarde.votar(compartilhado, bia);
        tarde.votar(livre, bia);

        System.out.println(tarde.quantidadeVotos());        // Q15

        manha.retirarCandidato(bia);
        tarde.retirarCandidato(bia);

        System.out.println(tarde.quantidadeCandidatos());   // Q16

        Eleicao atual = manha;
        atual.encerrar();

        atual = new Eleicao("Noite");
        atual.cadastrarCandidato(bia);
        atual.encerrar();
        atual.cadastrarCandidato(ana);

        System.out.println(atual.quantidadeCandidatos());   // Q17
    }
}
```
]


#v(15pt)
#text(size: 12pt, weight: "bold")[Trecho V — Questões 18 a 20]
#v(5pt)

#codigoq[
```java
public class Main {
    public static void main(String[] args) {
        Candidato ana = new Candidato(15, "Ana");
        Candidato bia = new Candidato(20, "Bia");

        Candidato escolha = ana;
        Candidato memoria = escolha;

        Eleitor primeiro = new Eleitor("E1");
        Eleitor segundo = new Eleitor("E2");

        Eleicao principal = new Eleicao("Principal");

        principal.cadastrarCandidato(ana);
        principal.cadastrarCandidato(bia);

        principal.votar(primeiro, escolha);

        escolha = bia;
        principal.votar(segundo, escolha);

        escolha = memoria;
        principal.votar(new Eleitor("E3"), escolha);

        memoria = bia;

        System.out.println(principal.totalVotosDe(memoria));        // Q18

        Eleitor eleitor = new Eleitor("E2");
        Eleicao ordem = new Eleicao("Ordem");

        ordem.cadastrarCandidato(ana);
        ordem.retirarCandidato(ana);

        ordem.votar(eleitor, ana);

        ordem.cadastrarCandidato(ana);
        ordem.votar(eleitor, ana);

        ordem.retirarCandidato(ana);

        System.out.println(ordem.quantidadeCandidatos());    // Q19

        Candidato caio = new Candidato(30, "Caio");
        Eleitor e3 = new Eleitor("E3");

        Eleicao finalEleicao = new Eleicao("Final");

        finalEleicao.cadastrarCandidato(ana);
        finalEleicao.cadastrarCandidato(bia);

        finalEleicao.votar(new Eleitor("E4"), ana);

        finalEleicao.retirarCandidato(bia);
        finalEleicao.cadastrarCandidato(caio);

        finalEleicao.encerrar();

        finalEleicao.retirarCandidato(caio);
        finalEleicao.cadastrarCandidato(bia);
        finalEleicao.votar(e3, caio);

        System.out.println(finalEleicao.quantidadeCandidatos()); // Q20
    }
}
```
]

]
