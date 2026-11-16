// PDF solicitado pelo professor. Aprovação da equivalência registrada separadamente no workflow.
// Conteúdo correspondente a base.md. Modelo visual: provas/unidade_01.typ.
#set document(title: "POO — Prova da Unidade 02", author: "IFPB — Campus Campina Grande")
#set page(paper: "a4", margin: (top: 1cm, bottom: 1.2cm, left: 0.6cm, right: 0.6cm),
  footer: context align(center, text(size: 8pt, fill: rgb("#666666"))[#counter(page).display()]))
#set text(size: 11pt, lang: "pt")
#set par(justify: true, leading: 0.45em)
#show raw.where(block: false): it => box(text(font: "Ubuntu Mono", fill: rgb("#5d0563"), it))

#let campo(largura, altura: 0.8cm, raio: 1.5pt) = box(width: largura, height: altura,
  stroke: 0.5pt + rgb("#888888"), radius: raio)
#let secao(titulo, body) = block(width: 100%)[
  #grid(columns: (auto, 1fr), column-gutter: 8pt, align: horizon,
    text(size: 12pt, weight: "bold", fill: rgb("#555555"), titulo),
    line(length: 100%, stroke: 0.4pt + rgb("#cccccc")))
  #v(3pt)
  #body
]
#let codigo(body, tamanho: 9pt, numeros: true, rotulos: none, espaco: 8pt) = block(width: 100%, breakable: false,
  fill: rgb("#f7f7f8"), stroke: 0.4pt + rgb("#cccccc"), radius: 2pt, inset: 6pt, above: espaco, below: espaco)[
  #set raw(tab-size: 2)
  #show raw.where(block: true): set text(font: "Ubuntu Mono", size: tamanho)
  #if rotulos != none {
    show raw.line: it => {
      box(width: 2.5em, inset: (right: 0.5em), align(right,
        text(size: tamanho, weight: "bold", fill: rgb("#555555"))[
          #rotulos.at(it.number - 1)]))
      it.body
    }
    body
  } else if numeros {
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
  #codigo(body, espaco: 0pt)
]
#let questao(numero, enunciado, opcoes, linhas: 0, compacto: false) = block(width: 100%, above: if compacto { 9pt } else { 18pt }, below: 0pt, breakable: false)[
  #set text(size: 12pt)
  #set par(justify: false)
  #let pontos = if linhas > 0 { 3 * linhas } else { 5 }
  #text(weight: "bold")[Q#numero. (#pontos pontos)] #enunciado
  #v(2pt)
  #for (indice, opcao) in opcoes.enumerate() {
    block(width: 100%, above: 5pt, breakable: false)[
      #grid(columns: (1.4em, 1fr), column-gutter: 8pt, align: top,
        text(weight: "bold")[#("ABCDE".at(indice)))],
        opcao)
    ]
  }
  #for indice in range(linhas) {
    block(width: 100%, above: 0pt, below: 0pt)[
      #v(if compacto { 0.45cm } else { 0.55cm })
      #if linhas > 1 {
        grid(columns: (1.4em, 1fr), column-gutter: 4pt, align: bottom,
          text(size: 10pt)[#("abcdefghijklmnopqrstuvwxyz".at(indice)))],
          line(length: 100%, stroke: 0.4pt + rgb("#aaaaaa")))
      } else {
        line(length: 100%, stroke: 0.4pt + rgb("#aaaaaa"))
      }
    ]
  }
]

#text[IFPB - Campus Campina Grande #linebreak()
Programação Orientada a Objetos - Unidade 02]
#grid(columns: (auto, 1fr, 1cm, auto, auto), column-gutter: 0.15cm, align: horizon,
  [Nome:], campo(100%, altura: 0.7cm, raio: 2pt), [], [Nota:], campo(2.5cm, altura: 0.7cm, raio: 2pt))
#v(4pt)
O código do jogo está ao final da prova. As questões são independentes; classes e alterações apresentadas valem apenas na própria questão.

Todos os tipos públicos estão em arquivos separados, no mesmo projeto, sem `package`. Considere disponíveis `List`, `ArrayList` e, nos testes, `assertEquals` do JUnit. Os argumentos são não nulos, os índices são válidos e os valores iniciais respeitam os limites dos objetos.

#columns(2, gutter: 0.6cm)[
#questao(1, [
Escreva a saída do trecho abaixo.
#codigo(tamanho: 8.8pt, numeros: false, espaco: 5pt)[
```java
Personagem p = new Personagem(88);
p.recuperarVida(19);
p.receberDano(-8);
System.out.println(p.getVida());
p.receberDano(130);
p.recuperarVida(7);
p.recuperarVida(-5);
System.out.println(p.getVida());
```
]
], (), linhas: 2, compacto: true)
#questao(2, [
Escreva a saída do trecho abaixo.
#codigo(tamanho: 8.8pt, numeros: false, espaco: 5pt)[
```java
Equipamento item = new Amuleto(0);
item.recarregar(5);
item.usar(new Personagem(61));
System.out.println(item.descrever());
```
]
], (), linhas: 1, compacto: true)
#questao(3, [
Escreva a saída do trecho abaixo.
#codigo(tamanho: 8.8pt, numeros: false, espaco: 5pt)[
```java
Inventario inventario = new Inventario();
Pocao pocao = new Pocao();
inventario.adicionar(new Cajado(2));
inventario.adicionar(pocao);
pocao.usar(new Personagem(36));
inventario.listar();
```
]
], (), linhas: 2, compacto: true)
#questao(4, [
Escreva a saída do trecho abaixo.
#codigo(tamanho: 8.8pt, numeros: false, espaco: 5pt)[
```java
Cajado cajado = new Cajado(1);
Inventario inventario = new Inventario();
inventario.adicionar(cajado);
inventario.adicionar(cajado);
Personagem alvo = new Personagem(40);
Usavel primeiro = (Usavel) inventario.obter(0);
Usavel segundo = (Usavel) inventario.obter(1);
primeiro.usar(alvo);
System.out.println(segundo.usar(alvo));
System.out.println(alvo.getVida());
```
]
], (), linhas: 2, compacto: true)
#questao(5, [
Escreva a saída do trecho abaixo.
#codigo(tamanho: 8.8pt, numeros: false, espaco: 5pt)[
```java
Personagem usuario = new Personagem(74);
Personagem alvo = new Personagem(50);
Usavel escolha = new Cajado(1);
usuario.equipar(escolha);
escolha = new Amuleto(2);
usuario.usarEquipadoEm(alvo);
System.out.println(alvo.getVida());
```
]
], (), linhas: 1, compacto: true)
#questao(6, [
Escreva a saída do trecho abaixo.
#codigo(tamanho: 8.8pt, numeros: false, espaco: 5pt)[
```java
Personagem a = new Personagem(32);
Personagem b = new Personagem(68);
a.equipar(new Cajado(1));
b.equipar(new Amuleto(1));
a.usarEquipadoEm(b);
b.usarEquipadoEm(a);
System.out.println(a.getVida());
System.out.println(b.getVida());
```
]
], (), linhas: 2, compacto: true)
#questao(7, [
Escreva a saída produzida pelo trecho abaixo.
#codigo(tamanho: 8.8pt, numeros: false, espaco: 5pt)[
```java
Item item = new Cajado(1);
Usavel uso = (Usavel) item;
Recarregavel recarga = (Recarregavel) item;
System.out.println(uso == recarga);
```
]
], (), linhas: 1, compacto: true)
#questao(8, [
Escreva a saída produzida pelo trecho abaixo.
#codigo(tamanho: 8.8pt, numeros: false)[
```java
Personagem alvo = new Personagem(100);
Amuleto item = new Amuleto(1);
System.out.println(item.usar(alvo));
System.out.println(item.getCargas());
```
]
], (), linhas: 2)
#questao(9, [
Escreva a saída produzida pelo trecho abaixo.
#codigo(tamanho: 8.8pt, numeros: false)[
```java
Personagem p = new Personagem(48);
System.out.println(p.usarEquipadoEm(p));
p.equipar(new Pocao());
if (p.usarEquipadoEm(p)) {
    p.receberDano(6);
}
if (p.usarEquipadoEm(p)) {
    p.receberDano(6);
}
System.out.println(p.getVida());
```
]
], (), linhas: 2)
#questao(10, [
Considere a classe `CajadoLivre`, apresentada apenas nesta questão. Escreva a saída do trecho que a utiliza.
#codigo(tamanho: 8.8pt, numeros: false)[
```java
public class CajadoLivre extends Cajado {
    public CajadoLivre() {
        super(0);
    }

    @Override
    public boolean usar(Personagem alvo) {
        alvo.receberDano(5);
        return true;
    }
}
```
]
#codigo(tamanho: 8.8pt, numeros: false)[
```java
Equipamento item = new CajadoLivre();
Personagem alvo = new Personagem(53);
item.usar(alvo);
System.out.println(alvo.getVida());
```
]
], (), linhas: 1)
#questao(11, [
Escreva a saída produzida pelo trecho abaixo.
#codigo(tamanho: 8.8pt, numeros: false)[
```java
Inventario inventario = new Inventario();
Amuleto amuleto = new Amuleto(0);
inventario.adicionar(new Pocao());
inventario.adicionar(amuleto);
inventario.adicionar(new Cajado(1));
int recarregados = 0;
for (int i = 0; i < 3; i++) {
    Item item = inventario.obter(i);
    if (item instanceof Recarregavel) {
        Recarregavel r = (Recarregavel) item;
        r.recarregar(1);
        recarregados++;
    }
}
System.out.println(recarregados);
System.out.println(amuleto.getCargas());
```
]
], (), linhas: 2)
#questao(12, [
Para acrescentar uma recuperação de vida ao uso de um item, foi criada a classe `UsavelComCura`, válida apenas nesta questão. Escreva a saída do trecho que a utiliza.
#codigo(tamanho: 8.8pt, numeros: false)[
```java
public class UsavelComCura implements Usavel {
    private Usavel base;

    public UsavelComCura(Usavel base) {
        this.base = base;
    }

    @Override
    public boolean usar(Personagem alvo) {
        if (!base.usar(alvo)) {
            return false;
        }
        alvo.recuperarVida(5);
        return true;
    }
}
```
]
#codigo(tamanho: 8.8pt, numeros: false)[
```java
Personagem alvo = new Personagem(98);
Usavel uso = new UsavelComCura(
    new UsavelComCura(new Cajado(1)));
uso.usar(alvo);
System.out.println(alvo.getVida());
uso.usar(alvo);
System.out.println(alvo.getVida());
```
]
], (), linhas: 2)
#questao(13, [
Uma desenvolvedora tenta mostrar a descrição do item que será usado:

#codigo(tamanho: 8.8pt, numeros: false)[
```java
Usavel escolha = new Amuleto(1);
System.out.println(escolha.descrever());
```
]

O compilador rejeita a chamada a `descrever`. Qual explicação está correta?

], (
[
`Amuleto` precisa declarar novamente `descrever`, pois métodos herdados não podem ser chamados por clientes.
],
[
O tipo `Usavel` não oferece `descrever`, embora o objeto guardado em `escolha` possua esse método.
],
[
O método `descrever` de `Equipamento` não pode ser usado porque essa classe é abstrata.
],
[
Uma variável declarada com uma interface não pode receber um objeto de uma classe concreta.
],
[
A chamada só poderia ser verificada durante a execução, quando o objeto de `escolha` fosse conhecido.
],
))
#questao(14, [
Na próxima versão do jogo, cada personagem deverá guardar e consultar seus itens. Durante a implementação, uma desenvolvedora apresenta esta proposta:

“A classe `Inventario` já tem os métodos `adicionar`, `obter` e `listar`. Podemos fazer `Personagem` herdar de `Inventario` para aproveitar esses métodos.”

#codigo(tamanho: 8.8pt, numeros: false)[
```java
public class Personagem extends Inventario {
    // Campos e métodos do personagem.
}
```
]

Você está revisando essa proposta. Qual comentário orienta melhor a decisão de projeto?
], (
[
“A herança é adequada: se o personagem precisa desses métodos, isso é suficiente para defini-lo como uma especialização de inventário.”
],
[
“A herança não permite esse reaproveitamento: como a lista de itens é privada, os métodos herdados não conseguem acessá-la.”
],
[
“Seria melhor colocar um inventário dentro do personagem, embora isso exija copiar para `Personagem` a implementação dos três métodos.”
],
[
“Podemos manter a herança e sobrescrever os três métodos: assim, o personagem aproveita o código sem ser tratado como um inventário.”
],
[
“A herança permite o reaproveitamento, mas torna o personagem um tipo de inventário. Ele poderia ter um inventário e usar os métodos desse objeto.”
],
))
#questao(15, [
Atualmente, `Personagem.equipar` recebe um `Usavel`. Um desenvolvedor propõe trocar o tipo do parâmetro para `Equipamento`, mantendo o campo `equipado` e o corpo do método:

#codigo(tamanho: 8.8pt, numeros: false)[
```java
public void equipar(Equipamento item) {
    equipado = item;
}
```
]

Ele justifica a mudança dizendo que o personagem precisa de um objeto com o método `usar`. Qual avaliação está correta?

], (
[
A mudança não afeta as chamadas existentes, pois o tipo do parâmetro apenas documenta o argumento recebido.
],
[
O método deixa de compilar, pois um campo do tipo `Usavel` não pode guardar uma referência recebida como `Equipamento`.
],
[
O método continua aceitando poções, pois `Pocao` possui a mesma assinatura de `usar` que os equipamentos.
],
[
Chamadas com poções deixam de compilar, embora `Usavel` já ofereça a operação de que o personagem precisa.
],
[
A mudança faz todo item equipado executar `Equipamento.usar`, mesmo quando sua classe sobrescreve esse método.
],
))
#questao(16, [
Durante uma revisão, foi proposta esta nova implementação de `Equipamento.recarregar`:

#codigo(tamanho: 8.8pt, numeros: false)[
```java
public void recarregar(int quantidade) {
    if (quantidade <= 0) {
        return;
    }
    cargas = quantidade;
    if (cargas > maximo) {
        cargas = maximo;
    }
}
```
]

Qual teste passa na implementação original e falha na proposta? Considere cada alternativa independentemente.
], (
[
#codigo(tamanho: 8.5pt, numeros: false, espaco: 3pt)[
```java
Cajado item = new Cajado(0);
item.recarregar(1);
assertEquals(1, item.getCargas());
```
]
],
[
#codigo(tamanho: 8.5pt, numeros: false, espaco: 3pt)[
```java
Cajado item = new Cajado(2);
item.recarregar(3);
assertEquals(3, item.getCargas());
```
]
],
[
#codigo(tamanho: 8.5pt, numeros: false, espaco: 3pt)[
```java
Cajado item = new Cajado(1);
item.recarregar(1);
assertEquals(2, item.getCargas());
```
]
],
[
#codigo(tamanho: 8.5pt, numeros: false, espaco: 3pt)[
```java
Cajado item = new Cajado(3);
item.recarregar(5);
assertEquals(3, item.getCargas());
```
]
],
[
#codigo(tamanho: 8.5pt, numeros: false, espaco: 3pt)[
```java
Cajado item = new Cajado(2);
item.recarregar(0);
assertEquals(2, item.getCargas());
```
]
],
))
#questao(17, [
A equipe decidiu acrescentar uma restrição ao uso dos equipamentos: se o alvo estiver com vida zero, a tentativa deverá retornar `false`, sem alterar sua vida nem gastar cargas. Essa regra ainda não está implementada. Ela deverá valer tanto pelo uso via personagem quanto por uma chamada direta a `equipamento.usar(alvo)`.

Onde inserir a verificação `alvo.getVida() == 0` para cumprir essa regra?
], (
[
Em `Personagem.recuperarVida`, retornando antes de alterar a vida.
],
[
Em `Equipamento.usar`, retornando `false` antes de chamar `aplicarEm` e de diminuir as cargas.
],
[
Em `Equipamento.usar`, retornando `false` depois de chamar `aplicarEm`, antes de diminuir as cargas.
],
[
Em `Equipamento.aplicarEm`, retornando antes de realizar o efeito, sem mudar `Equipamento.usar`.
],
[
Em `Personagem.usarEquipadoEm`, retornando `false` antes de delegar, sem mudar os equipamentos.
],
))
#questao(18, [
A equipe preparou dois testes para o uso do cajado. Cada teste começa com seus próprios objetos novos:

#codigo(tamanho: 8.8pt, numeros: false)[
```java
Cajado item = new Cajado(1);
Personagem alvo = new Personagem(46);
```
]

Teste I:

#codigo(tamanho: 8.8pt, numeros: false)[
```java
assertEquals(true, item.usar(alvo));
```
]

Teste II:

#codigo(tamanho: 8.8pt, numeros: false)[
```java
item.usar(alvo);
assertEquals(34, alvo.getVida());
```
]

Qual comportamento incorreto de `usar` seria identificado somente pelo Teste II?

], (
[
Consumir uma carga e retornar `true`, sem causar dano ao alvo.
],
[
Consumir uma carga, causar 12 pontos de dano e retornar `false`.
],
[
Retornar `false` sem alterar o alvo nem consumir uma carga.
],
[
Causar 12 pontos de dano e retornar `true`, sem consumir uma carga.
],
[
Consumir uma carga, causar 24 pontos de dano e retornar `false`.
],
))
#questao(19, [
Ao revisar `Equipamento`, uma desenvolvedora propõe substituir seu método abstrato por:

#codigo(tamanho: 8.8pt, numeros: false)[
```java
public int getVariacaoVida() {
    return 0;
}
```
]

`Equipamento` continua abstrata e seus outros métodos são mantidos. Com essa mudança, ela acrescenta:

#codigo(tamanho: 8.8pt, numeros: false)[
```java
public class Orbe extends Equipamento {
    public Orbe() {
        super("Orbe", 2, 4);
    }
}
```
]

Qual consequência da proposta está correta?

], (
[
`Orbe` não pode ser instanciada, pois toda subclasse de uma classe abstrata também é abstrata.
],
[
`Orbe` pode ser instanciada sem sobrescrever `getVariacaoVida`; `Cajado` e `Amuleto` mantêm suas próprias variações.
],
[
`Orbe` não compila, pois precisa declarar diretamente todos os métodos das interfaces de `Equipamento`.
],
[
`Orbe` precisa declarar novamente os campos `nome`, `cargas` e `maximo` para utilizar os métodos herdados.
],
[
`Cajado` e `Amuleto` também passam a usar a variação zero, pois o método concreto da base substitui suas sobrescritas.
],
))
#questao(20, [
O inventário passará a guardar no máximo três itens. O método `Inventario.adicionar` já foi alterado para impedir novas inclusões ao atingir esse limite. A equipe propõe acrescentar este método:

#codigo(tamanho: 8.8pt, numeros: false)[
```java
public List<Item> getItens() {
    return itens;
}
```
]

Com esse método, outro código consegue ultrapassar o limite de três itens? Por quê?

], (
[
Não. Como o campo `itens` é privado, a lista devolvida só pode ser modificada pelos métodos de `Inventario`.
],
[
Não. Ao devolver a lista, o método cria uma cópia; alterações nessa cópia não afetam o inventário.
],
[
Sim. Outro código pode chamar `add` na lista devolvida, sem executar a verificação de `Inventario.adicionar`.
],
[
Sim. A referência devolvida permite substituir o campo privado `itens` por outra lista criada fora do inventário.
],
[
Não. Sem um método `setItens`, outro código pode consultar a lista devolvida, mas não acrescentar elementos.
],
))

]

#pagebreak()
#secao("CENÁRIO — CONTRATOS, INVENTÁRIO E PERSONAGEM")[]
#grid(columns: (1fr, 1fr), column-gutter: 0.4cm,
[
#fonte("Item")[
```java
public interface Item {
    String descrever();
}
```
]
#fonte("Usavel")[
```java
public interface Usavel {
    boolean usar(Personagem alvo);
}
```
]
#fonte("Recarregavel")[
```java
public interface Recarregavel {
    void recarregar(int quantidade);
    int getCargas();
}
```
]
#fonte("Inventario")[
```java
import java.util.ArrayList;
import java.util.List;

public class Inventario {
    private List<Item> itens;

    public Inventario() {
        itens = new ArrayList<>();
    }

    public void adicionar(Item item) {
        itens.add(item);
    }

    public Item obter(int indice) {
        return itens.get(indice);
    }

    public void listar() {
        for (Item item : itens) {
            System.out.println(
                item.descrever());
        }
    }
}
```
]
],
[
#fonte("Personagem")[
```java
public class Personagem {
    private int vida;
    private Usavel equipado;

    public Personagem(int vidaInicial) {
        vida = vidaInicial;
        equipado = null;
    }

    public void receberDano(int quantidade) {
        if (quantidade > 0) {
            vida -= quantidade;
            if (vida < 0) {
                vida = 0;
            }
        }
    }

    public void recuperarVida(int quantidade) {
        if (quantidade > 0) {
            vida += quantidade;
            if (vida > 100) {
                vida = 100;
            }
        }
    }

    public int getVida() { return vida; }

    public void equipar(Usavel item) {
        equipado = item;
    }

    public Usavel getEquipado() {
        return equipado;
    }

    public boolean usarEquipadoEm(
            Personagem alvo) {
        if (equipado == null) {
            return false;
        }
        return equipado.usar(alvo);
    }
}
```
]
],
)

#pagebreak()
#secao("CENÁRIO — EQUIPAMENTOS E POÇÃO")[]
#grid(columns: (1fr, 1fr), column-gutter: 0.4cm,
[
#fonte("Equipamento")[
```java
public abstract class Equipamento
        implements Item, Usavel, Recarregavel {
    private String nome;
    private int cargas;
    private int maximo;

    protected Equipamento(String nome,
                          int cargasIniciais,
                          int maximo) {
        this.nome = nome;
        cargas = cargasIniciais;
        this.maximo = maximo;
    }

    @Override
    public boolean usar(Personagem alvo) {
        if (cargas == 0) {
            return false;
        }
        aplicarEm(alvo);
        cargas--;
        return true;
    }

    @Override
    public void recarregar(int quantidade) {
        if (quantidade <= 0) {
            return;
        }
        cargas += quantidade;
        if (cargas > maximo) {
            cargas = maximo;
        }
    }

    @Override
    public int getCargas() { return cargas; }

    @Override
    public String descrever() {
        return nome + ": " + cargas
            + "/" + maximo;
    }

    private void aplicarEm(Personagem alvo) {
        int variacao = getVariacaoVida();
        if (variacao < 0) {
            alvo.receberDano(-variacao);
        } else {
            alvo.recuperarVida(variacao);
        }
    }

    // Variação de vida aplicada por usar:
    // negativa: dano; positiva: recuperação.
    public abstract int getVariacaoVida();
}
```
]
],
[
#fonte("Cajado")[
```java
public class Cajado extends Equipamento {
    public Cajado(int cargasIniciais) {
        super("Cajado", cargasIniciais, 3);
    }

    @Override
    public int getVariacaoVida() {
        return -12;
    }
}
```
]
#fonte("Amuleto")[
```java
public class Amuleto extends Equipamento {
    public Amuleto(int cargasIniciais) {
        super("Amuleto", cargasIniciais, 2);
    }

    @Override
    public int getVariacaoVida() {
        return 15;
    }
}
```
]
#fonte("Pocao")[
```java
public class Pocao implements Item, Usavel {
    private boolean consumida = false;

    @Override
    public boolean usar(Personagem alvo) {
        if (consumida) {
            return false;
        }
        alvo.recuperarVida(20);
        consumida = true;
        return true;
    }

    @Override
    public String descrever() {
        if (consumida) {
            return "Poção vazia";
        }
        return "Poção cheia";
    }
}
```
]
],
)
