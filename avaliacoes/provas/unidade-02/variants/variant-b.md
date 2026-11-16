---
type: exam
identifier: unidade-02
title: Prova da Unidade 02
total_points: 100
---

# Programação Orientada a Objetos — Unidade 02

O código do jogo está ao final da prova. As questões são independentes; classes e alterações apresentadas valem apenas na própria questão.

Todos os tipos públicos estão em arquivos separados, no mesmo projeto, sem `package`. Considere disponíveis `List`, `ArrayList` e, nos testes, `assertEquals` do JUnit. Os argumentos são não nulos, os índices são válidos e os valores iniciais respeitam os limites dos objetos.

# Questões de saída

## Q1 [6 points] {#q-u02-001}

Escreva a saída do trecho abaixo.

```java
Personagem p = new Personagem(86);
p.recuperarVida(17);
p.receberDano(-6);
System.out.println(p.getVida());
p.receberDano(125);
p.recuperarVida(9);
p.recuperarVida(-4);
System.out.println(p.getVida());
```

### a) [3 points] {#q-u02-001-a}

1ª linha impressa.

### b) [3 points] {#q-u02-001-b}

2ª linha impressa.

## Q2 [3 points] {#q-u02-002}

Escreva a saída do trecho abaixo.

```java
Equipamento item = new Amuleto(0);
item.recarregar(4);
item.usar(new Personagem(61));
System.out.println(item.descrever());
```

## Q3 [6 points] {#q-u02-003}

Escreva a saída do trecho abaixo.

```java
Inventario inventario = new Inventario();
Pocao pocao = new Pocao();
inventario.adicionar(new Cajado(1));
inventario.adicionar(pocao);
pocao.usar(new Personagem(36));
inventario.listar();
```

### a) [3 points] {#q-u02-003-a}

1ª linha impressa.

### b) [3 points] {#q-u02-003-b}

2ª linha impressa.

## Q4 [6 points] {#q-u02-004}

Escreva a saída do trecho abaixo.

```java
Cajado cajado = new Cajado(1);
Inventario inventario = new Inventario();
inventario.adicionar(cajado);
inventario.adicionar(cajado);
Personagem alvo = new Personagem(41);
Usavel primeiro = (Usavel) inventario.obter(0);
Usavel segundo = (Usavel) inventario.obter(1);
primeiro.usar(alvo);
System.out.println(segundo.usar(alvo));
System.out.println(alvo.getVida());
```

### a) [3 points] {#q-u02-004-a}

1ª linha impressa.

### b) [3 points] {#q-u02-004-b}

2ª linha impressa.

## Q5 [3 points] {#q-u02-005}

Escreva a saída do trecho abaixo.

```java
Personagem usuario = new Personagem(74);
Personagem alvo = new Personagem(60);
Usavel escolha = new Cajado(1);
usuario.equipar(escolha);
escolha = new Amuleto(2);
usuario.usarEquipadoEm(alvo);
System.out.println(alvo.getVida());
```

## Q6 [6 points] {#q-u02-006}

Escreva a saída do trecho abaixo.

```java
Personagem a = new Personagem(34);
Personagem b = new Personagem(66);
a.equipar(new Cajado(1));
b.equipar(new Amuleto(1));
a.usarEquipadoEm(b);
b.usarEquipadoEm(a);
System.out.println(a.getVida());
System.out.println(b.getVida());
```

### a) [3 points] {#q-u02-006-a}

1ª linha impressa.

### b) [3 points] {#q-u02-006-b}

2ª linha impressa.

## Q7 [3 points] {#q-u02-007}

Escreva a saída produzida pelo trecho abaixo.

```java
Item item = new Cajado(1);
Usavel uso = (Usavel) item;
Recarregavel recarga = (Recarregavel) item;
System.out.println(uso == recarga);
```

## Q8 [6 points] {#q-u02-008}

Escreva a saída produzida pelo trecho abaixo.

```java
Personagem alvo = new Personagem(100);
Amuleto item = new Amuleto(1);
System.out.println(item.usar(alvo));
System.out.println(item.getCargas());
```

### a) [3 points] {#q-u02-008-a}

1ª linha impressa.

### b) [3 points] {#q-u02-008-b}

2ª linha impressa.

## Q9 [6 points] {#q-u02-009}

Escreva a saída produzida pelo trecho abaixo.

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

### a) [3 points] {#q-u02-009-a}

1ª linha impressa.

### b) [3 points] {#q-u02-009-b}

2ª linha impressa.

## Q10 [3 points] {#q-u02-010}

Considere a classe `CajadoLivre`, apresentada apenas nesta questão. Escreva a saída do trecho que a utiliza.

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

```java
Equipamento item = new CajadoLivre();
Personagem alvo = new Personagem(53);
item.usar(alvo);
System.out.println(alvo.getVida());
```

## Q11 [6 points] {#q-u02-011}

Escreva a saída produzida pelo trecho abaixo.

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

### a) [3 points] {#q-u02-011-a}

1ª linha impressa.

### b) [3 points] {#q-u02-011-b}

2ª linha impressa.

## Q12 [6 points] {#q-u02-012}

Para acrescentar uma recuperação de vida ao uso de um item, foi criada a classe `UsavelComCura`, válida apenas nesta questão. Escreva a saída do trecho que a utiliza.

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

```java
Personagem alvo = new Personagem(98);
Usavel uso = new UsavelComCura(
    new UsavelComCura(new Cajado(1)));
uso.usar(alvo);
System.out.println(alvo.getVida());
uso.usar(alvo);
System.out.println(alvo.getVida());
```

### a) [3 points] {#q-u02-012-a}

1ª linha impressa.

### b) [3 points] {#q-u02-012-b}

2ª linha impressa.

# Questões de múltipla escolha

## Q13 [5 points] {#q-u02-013}

Uma desenvolvedora tenta mostrar a descrição do item que será usado:

```java
Usavel escolha = new Amuleto(1);
System.out.println(escolha.descrever());
```

O compilador rejeita a chamada a `descrever`. Qual explicação está correta?

A) `Amuleto` precisa declarar novamente `descrever`, pois métodos herdados não podem ser chamados por clientes.

B) O tipo `Usavel` não oferece `descrever`, embora o objeto guardado em `escolha` possua esse método.

C) O método `descrever` de `Equipamento` não pode ser usado porque essa classe é abstrata.

D) Uma variável declarada com uma interface não pode receber um objeto de uma classe concreta.

E) A chamada só poderia ser verificada durante a execução, quando o objeto de `escolha` fosse conhecido.

## Q14 [5 points] {#q-u02-015}

Na próxima versão do jogo, cada personagem deverá guardar e consultar seus itens. Durante a implementação, uma desenvolvedora apresenta esta proposta:

“A classe `Inventario` já tem os métodos `adicionar`, `obter` e `listar`. Podemos fazer `Personagem` herdar de `Inventario` para aproveitar esses métodos.”

```java
public class Personagem extends Inventario {
    // Campos e métodos do personagem.
}
```

Você está revisando essa proposta. Qual comentário orienta melhor a decisão de projeto?

A) “A herança não permite esse reaproveitamento: como a lista de itens é privada, os métodos herdados não conseguem acessá-la.”

B) “Podemos manter a herança e sobrescrever os três métodos: assim, o personagem aproveita o código sem ser tratado como um inventário.”

C) “A herança permite o reaproveitamento, mas torna o personagem um tipo de inventário. Ele poderia ter um inventário e usar os métodos desse objeto.”

D) “A herança é adequada: se o personagem precisa desses métodos, isso é suficiente para defini-lo como uma especialização de inventário.”

E) “Seria melhor colocar um inventário dentro do personagem, embora isso exija copiar para `Personagem` a implementação dos três métodos.”

## Q15 [5 points] {#q-u02-018}

Atualmente, `Personagem.equipar` recebe um `Usavel`. Um desenvolvedor propõe trocar o tipo do parâmetro para `Equipamento`, mantendo o campo `equipado` e o corpo do método:

```java
public void equipar(Equipamento item) {
    equipado = item;
}
```

Ele justifica a mudança dizendo que o personagem precisa de um objeto com o método `usar`. Qual avaliação está correta?

A) O método continua aceitando poções, pois `Pocao` possui a mesma assinatura de `usar` que os equipamentos.

B) A mudança não afeta as chamadas existentes, pois o tipo do parâmetro apenas documenta o argumento recebido.

C) A mudança faz todo item equipado executar `Equipamento.usar`, mesmo quando sua classe sobrescreve esse método.

D) O método deixa de compilar, pois um campo do tipo `Usavel` não pode guardar uma referência recebida como `Equipamento`.

E) Chamadas com poções deixam de compilar, embora `Usavel` já ofereça a operação de que o personagem precisa.

## Q16 [5 points] {#q-u02-016}

Durante uma revisão, foi proposta esta nova implementação de `Equipamento.recarregar`:

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

Qual teste passa na implementação original e falha na proposta? Considere cada alternativa independentemente.

A)

```java
Cajado item = new Cajado(3);
item.recarregar(5);
assertEquals(3, item.getCargas());
```

B)

```java
Cajado item = new Cajado(2);
item.recarregar(0);
assertEquals(2, item.getCargas());
```

C)

```java
Cajado item = new Cajado(0);
item.recarregar(1);
assertEquals(1, item.getCargas());
```

D)

```java
Cajado item = new Cajado(1);
item.recarregar(1);
assertEquals(2, item.getCargas());
```

E)

```java
Cajado item = new Cajado(2);
item.recarregar(3);
assertEquals(3, item.getCargas());
```

## Q17 [5 points] {#q-u02-014}

A equipe decidiu acrescentar uma restrição ao uso dos equipamentos: se o alvo estiver com vida zero, a tentativa deverá retornar `false`, sem alterar sua vida nem gastar cargas. Essa regra ainda não está implementada. Ela deverá valer tanto pelo uso via personagem quanto por uma chamada direta a `equipamento.usar(alvo)`.

Onde inserir a verificação `alvo.getVida() == 0` para cumprir essa regra?

A) Em `Equipamento.usar`, retornando `false` antes de chamar `aplicarEm` e de diminuir as cargas.

B) Em `Personagem.usarEquipadoEm`, retornando `false` antes de delegar, sem mudar os equipamentos.

C) Em `Personagem.recuperarVida`, retornando antes de alterar a vida.

D) Em `Equipamento.aplicarEm`, retornando antes de realizar o efeito, sem mudar `Equipamento.usar`.

E) Em `Equipamento.usar`, retornando `false` depois de chamar `aplicarEm`, antes de diminuir as cargas.

## Q18 [5 points] {#q-u02-017}

A equipe preparou dois testes para o uso do cajado. Cada teste começa com seus próprios objetos novos:

```java
Cajado item = new Cajado(1);
Personagem alvo = new Personagem(48);
```

Teste I:

```java
assertEquals(true, item.usar(alvo));
```

Teste II:

```java
item.usar(alvo);
assertEquals(36, alvo.getVida());
```

Qual comportamento incorreto de `usar` seria identificado somente pelo Teste II?

A) Causar 12 pontos de dano e retornar `true`, sem consumir uma carga.

B) Consumir uma carga, causar 12 pontos de dano e retornar `false`.

C) Consumir uma carga, causar 24 pontos de dano e retornar `false`.

D) Retornar `false` sem alterar o alvo nem consumir uma carga.

E) Consumir uma carga e retornar `true`, sem causar dano ao alvo.

## Q19 [5 points] {#q-u02-019}

Ao revisar `Equipamento`, uma desenvolvedora propõe substituir seu método abstrato por:

```java
public int getVariacaoVida() {
    return 0;
}
```

`Equipamento` continua abstrata e seus outros métodos são mantidos. Com essa mudança, ela acrescenta:

```java
public class Orbe extends Equipamento {
    public Orbe() {
        super("Orbe", 2, 4);
    }
}
```

Qual consequência da proposta está correta?

A) `Cajado` e `Amuleto` também passam a usar a variação zero, pois o método concreto da base substitui suas sobrescritas.

B) `Orbe` não compila, pois precisa declarar diretamente todos os métodos das interfaces de `Equipamento`.

C) `Orbe` não pode ser instanciada, pois toda subclasse de uma classe abstrata também é abstrata.

D) `Orbe` pode ser instanciada sem sobrescrever `getVariacaoVida`; `Cajado` e `Amuleto` mantêm suas próprias variações.

E) `Orbe` precisa declarar novamente os campos `nome`, `cargas` e `maximo` para utilizar os métodos herdados.

## Q20 [5 points] {#q-u02-020}

O inventário passará a guardar no máximo três itens. O método `Inventario.adicionar` já foi alterado para impedir novas inclusões ao atingir esse limite. A equipe propõe acrescentar este método:

```java
public List<Item> getItens() {
    return itens;
}
```

Com esse método, outro código consegue ultrapassar o limite de três itens? Por quê?

A) Sim. Outro código pode chamar `add` na lista devolvida, sem executar a verificação de `Inventario.adicionar`.

B) Não. Sem um método `setItens`, outro código pode consultar a lista devolvida, mas não acrescentar elementos.

C) Sim. A referência devolvida permite substituir o campo privado `itens` por outra lista criada fora do inventário.

D) Não. Ao devolver a lista, o método cria uma cópia; alterações nessa cópia não afetam o inventário.

E) Não. Como o campo `itens` é privado, a lista devolvida só pode ser modificada pelos métodos de `Inventario`.

# Cenário {#src-u02-aventura}

### Item.java {#src-u02-item}

```java
public interface Item {
    String descrever();
}
```

### Usavel.java {#src-u02-usavel}

```java
public interface Usavel {
    boolean usar(Personagem alvo);
}
```

### Recarregavel.java {#src-u02-recarregavel}

```java
public interface Recarregavel {
    void recarregar(int quantidade);
    int getCargas();
}
```

### Personagem.java {#src-u02-personagem}

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

### Equipamento.java {#src-u02-equipamento}

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

### Cajado.java {#src-u02-cajado}

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

### Amuleto.java {#src-u02-amuleto}

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

### Pocao.java {#src-u02-pocao}

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

### Inventario.java {#src-u02-inventario}

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
