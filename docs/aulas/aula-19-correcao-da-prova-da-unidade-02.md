# Aula 19 — Correção da Prova da Unidade 02

A prova reúne situações que atravessam o curso: proteger estado, seguir
referências, colaborar por contratos e avaliar mudanças. Nesta retomada,
vamos resolver cada questão pela variante A, explicando o raciocínio e a
habilidade avaliada. Depois, conferimos a variante B a partir da diferença.

**Slides:** [Apresentação HTML](../slides/rendered/aula-19-correcao-da-prova-da-unidade-02.html) · [PDF](../slides/rendered/aula-19-correcao-da-prova-da-unidade-02.pdf)

!!! lesson-question "Pergunta central"

    Como justificar o resultado de um programa e avaliar suas decisões de
    projeto usando o repertório de POO construído até aqui?

!!! lesson-objectives "Objetivos"

    - Rastrear referências e alterações de estado em objetos que colaboram.
    - Separar tipo declarado, objeto concreto e implementação executada.
    - Justificar escolhas entre contratos, composição e herança.
    - Avaliar onde uma regra deve ser protegida e o que um teste consegue verificar.
    - Identificar quais raciocínios você já consegue explicar e quais precisa retomar.

**Previsões e justificativas — IA Nível 0: sem IA.** Tente responder antes de
expandir a resolução. Conferir o resultado ajuda; explicar o passo que o
determina é o que permite reconhecer a habilidade desenvolvida.

<!-- Planejamento: specs/planejamento-aula-19.md. Núcleo de 90 minutos:
abertura 5; Q1–Q8 25; Q9–Q13 25; Q14–Q20 30; fechamento 5.
As vinte questões e a comparação B são o núcleo. Tabelas e rastreios apoiam
aprofundamento conforme a dúvida. Sem laboratório associado neste desenho.
Composição A conferida com o Typst atual: Q9–Q13 vêm da página trocada.
Este é o roteiro para revisão pedagógica; não implica aprovação para slides. -->

## Como acompanhar a correção

Cada questão começa um cenário independente. Classes e alterações locais
valem somente naquela questão. Os argumentos são não nulos, os índices são
válidos e os valores iniciais respeitam os limites dos objetos.

Nas previsões, acompanhe as chamadas em ordem. Nas objetivas, formule o
argumento antes de procurar a letra. A habilidade indicada em cada resolução
descreve o raciocínio avaliado; acertar uma saída por acaso não demonstra,
sozinho, que esse raciocínio está consolidado.

Os trechos e as alternativas abaixo correspondem à **variante A**. A comparação
com B aparece depois de cada resolução. Os dois PDFs e seus gabaritos estão
em [Materiais relacionados](#materiais-relacionados).

### O cenário de consulta

| Tipo | Responsabilidade neste recorte |
| --- | --- |
| `Personagem` | Protege a vida entre zero e cem nas alterações válidas; guarda um `Usavel` e delega seu uso. |
| `Item` | Oferece `descrever`. |
| `Usavel` | Oferece `usar` sobre um alvo, com retorno booleano. |
| `Recarregavel` | Oferece recarga e consulta de cargas. |
| `Equipamento` | Implementa os três contratos, centraliza cargas e uso, e pede às subclasses a variação de vida. |
| `Cajado` | Começa com as cargas recebidas, tem capacidade três e causa doze de dano por uso aceito. |
| `Amuleto` | Começa com as cargas recebidas, tem capacidade dois e recupera quinze de vida por uso aceito. |
| `Pocao` | Recupera vinte de vida uma única vez; não oferece recarga. |
| `Inventario` | Guarda referências a itens e permite obtê-los e listá-los na ordem de inclusão. |

Use o código abaixo quando precisar conferir uma guarda ou a ordem exata dos
efeitos. Cada tipo público fica em seu próprio arquivo; considere disponíveis
`List`, `ArrayList` e, nos testes, `assertEquals` do JUnit.

??? "Consultar Item.java"

    ```java
    public interface Item {
        String descrever();
    }
    ```

??? "Consultar Usavel.java"

    ```java
    public interface Usavel {
        boolean usar(Personagem alvo);
    }
    ```

??? "Consultar Recarregavel.java"

    ```java
    public interface Recarregavel {
        void recarregar(int quantidade);
        int getCargas();
    }
    ```

??? "Consultar Personagem.java"

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

??? "Consultar Equipamento.java"

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

??? "Consultar Cajado.java"

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

??? "Consultar Amuleto.java"

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

??? "Consultar Pocao.java"

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

??? "Consultar Inventario.java"

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

## Estado e referências: o que realmente muda?

Começamos pelos efeitos das chamadas em objetos concretos. Antes de somar
valores, localize o objeto alterado, sua condição inicial e a guarda que pode
impedir a operação. Depois, acompanhe as referências: uma variável, um campo e
uma posição de lista podem alcançar o mesmo objeto.

### Q1 — Limites e entradas ignoradas

Escreva a saída do trecho abaixo.

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

**a)** 1ª linha impressa.

**b)** 2ª linha impressa.

??? "Conferir resolução — variante A"

    **a)**

    `100`

    **b)**

    `7`

    A recuperação atinge 100; o dano negativo é ignorado. O dano seguinte leva a zero, a recuperação válida leva a 7 e a negativa é ignorada.

    Acompanhe a vida após cada chamada, aplicando o limite naquele momento. Uma quantidade negativa é ignorada pela guarda; ela não inverte a operação. Recuperar vida depois de chegar a zero continua permitido pelo código apresentado.

    | Chamada | Vida depois da chamada |
    | --- | --- |
    | construção | `88` |
    | `recuperarVida(19)` | `100` |
    | `receberDano(-8)` | `100` |
    | `receberDano(130)` | `0` |
    | `recuperarVida(7)` | `7` |
    | `recuperarVida(-5)` | `7` |

    Somar todos os valores de uma vez perderia as saturações intermediárias. O estado depois de uma chamada é a entrada da chamada seguinte.

    **Habilidade avaliada e retomada:** Rastrear o estado de um objeto aplicando guardas e limites a cada chamada.

**Na variante B:** Os dados mudam para vida inicial `86`, recuperação `17` e dano negativo `-6`: a primeira saída continua `100`. Depois, o dano `125` leva a zero, a recuperação `9` leva a `9` e `-4` é ignorado. **Saídas: `100` e `9`.**

### Q2 — Recarga, teto e consumo

Escreva a saída do trecho abaixo.

```java
Equipamento item = new Amuleto(0);
item.recarregar(5);
item.usar(new Personagem(61));
System.out.println(item.descrever());
```

??? "Conferir resolução — variante A"

    `Amuleto: 1/2`

    A recarga de cinco satura em duas; o uso consome uma, restando uma carga de duas.

    A recarga primeiro soma e depois limita o saldo ao máximo. O uso seguinte consome uma carga. O texto impresso reúne o saldo atual e a capacidade máxima, que são informações diferentes.

    **Habilidade avaliada e retomada:** Combinar recarga, saturação e consumo, distinguindo saldo e capacidade.

**Na variante B:** A recarga passa de cinco para quatro. As duas quantidades ultrapassam a capacidade dois, de modo que o uso deixa o mesmo saldo. **Saída: `Amuleto: 1/2`.**

### Q3 — A coleção conserva referências

Escreva a saída do trecho abaixo.

```java
Inventario inventario = new Inventario();
Pocao pocao = new Pocao();
inventario.adicionar(new Cajado(2));
inventario.adicionar(pocao);
pocao.usar(new Personagem(36));
inventario.listar();
```

**a)** 1ª linha impressa.

**b)** 2ª linha impressa.

??? "Conferir resolução — variante A"

    **a)**

    `Cajado: 2/3`

    **b)**

    `Poção vazia`

    listar percorre a ordem de inclusão: o cajado conserva duas cargas; a poção foi consumida depois de guardada.

    A lista guarda referências, não fotografias do estado dos itens. Quando um item é usado depois de ser adicionado, `listar()` consulta o estado atualizado desse mesmo objeto.

    **Habilidade avaliada e retomada:** Explicar por que uma coleção de referências permite consultar o estado atualizado dos objetos.

**Na variante B:** O cajado começa com uma carga em vez de duas; a poção continua sendo consumida depois de guardada. **Saídas: `Cajado: 1/3` e `Poção vazia`.**

### Q4 — Compartilhamento de cargas

Escreva a saída do trecho abaixo.

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

**a)** 1ª linha impressa.

**b)** 2ª linha impressa.

??? "Conferir resolução — variante A"

    **a)**

    `false`

    **b)**

    `28`

    As duas posições referem-se ao mesmo cajado. O primeiro uso gasta sua carga; o segundo recusa. Vida: 40 − 12 = 28.

    Adicionar duas vezes a mesma referência não duplica o equipamento. A primeira chamada altera o saldo compartilhado; a segunda encontra o resultado dessa alteração.

    | Momento | Cargas do único cajado | Vida do alvo |
    | --- | --- | --- |
    | antes dos usos | `1` | `40` |
    | depois de `primeiro.usar(alvo)` | `0` | `28` |
    | depois de `segundo.usar(alvo)` | `0` | `28` |

    O inventário tem duas posições ocupadas, mas há somente um equipamento. Prever dois danos exigiria supor uma cópia que o código não faz.

    **Habilidade avaliada e retomada:** Reconhecer que referências repetidas compartilham identidade e estado.

**Na variante B:** A vida inicial passa de `40` para `41`. A mesma carga compartilhada permite somente o primeiro dano. **Saídas: `false` e `29`.**

### Q5 — Variável local e campo são independentes

Escreva a saída do trecho abaixo.

```java
Personagem usuario = new Personagem(74);
Personagem alvo = new Personagem(50);
Usavel escolha = new Cajado(1);
usuario.equipar(escolha);
escolha = new Amuleto(2);
usuario.usarEquipadoEm(alvo);
System.out.println(alvo.getVida());
```

??? "Conferir resolução — variante A"

    `38`

    A reatribuição de escolha não troca o cajado armazenado. Vida: 50 − 12 = 38.

    O campo do personagem recebeu a referência existente no momento de `equipar`. Atribuir outro objeto à variável local não executa uma nova chamada a `equipar` nem altera esse campo.

    Depois de `equipar`, a variável `escolha` e o campo `equipado` guardam referências ao cajado. Depois da reatribuição, só `escolha` aponta para o amuleto; `equipado` continua apontando para o cajado. O usuário conserva vida `74`, pois a chamada passa `alvo` como destinatário do efeito.

    **Habilidade avaliada e retomada:** Distinguir a reatribuição de uma variável da alteração de um campo que guarda outra referência.

**Na variante B:** O alvo começa com `60`, em vez de `50`. O equipamento guardado continua sendo o cajado. **Saída: `48`.**

### Q6 — Cada chamada altera seu alvo

Escreva a saída do trecho abaixo.

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

**a)** 1ª linha impressa.

**b)** 2ª linha impressa.

??? "Conferir resolução — variante A"

    **a)**

    `47`

    **b)**

    `56`

    a recebe a cura: 32 + 15 = 47. b recebe o dano: 68 − 12 = 56.

    Antes de calcular, identifique o objeto recebido como argumento de cada chamada. A referência do item e a referência do alvo têm funções distintas: o item executa a operação, e o alvo recebe a alteração de vida.

    | Chamada | Objeto que aplica o efeito | Objeto alterado | Vida resultante |
    | --- | --- | --- | --- |
    | `a.usarEquipadoEm(b)` | cajado de `a` | `b` | `68 − 12 = 56` |
    | `b.usarEquipadoEm(a)` | amuleto de `b` | `a` | `32 + 15 = 47` |

    As impressões vêm na ordem `a`, depois `b`, embora a primeira chamada tenha alterado `b`.

    **Habilidade avaliada e retomada:** Acompanhar uma colaboração identificando quem solicita a operação e quem recebe seu efeito.

**Na variante B:** As vidas iniciais passam a `34` e `66`. O alvo da cura continua sendo `a`; o do dano, `b`. **Saídas: `49` e `54`.**

### Q7 — Casts preservam a identidade

Escreva a saída produzida pelo trecho abaixo.

```java
Item item = new Cajado(1);
Usavel uso = (Usavel) item;
Recarregavel recarga = (Recarregavel) item;
System.out.println(uso == recarga);
```

??? "Conferir resolução — variante A"

    `true`

    Os casts preservam a referência ao mesmo objeto.

    Um cast muda a forma de tratar uma referência, sem criar outro objeto. A comparação com `==` verifica se as referências alcançam a mesma instância.

    **Habilidade avaliada e retomada:** Explicar por que casts compatíveis preservam a identidade do objeto.

**Na variante B:** O trecho é o mesmo. As três referências continuam alcançando um único cajado. **Saída: `true`.**

### Q8 — Sucesso do uso e efeito na vida

Escreva a saída produzida pelo trecho abaixo.

```java
Personagem alvo = new Personagem(100);
Amuleto item = new Amuleto(1);
System.out.println(item.usar(alvo));
System.out.println(item.getCargas());
```

**a)** 1ª linha impressa.

**b)** 2ª linha impressa.

??? "Conferir resolução — variante A"

    **a)**

    `true`

    **b)**

    `0`

    A carga permite o uso e é consumida, mesmo com a vida já no máximo.

    O método verifica a disponibilidade de carga, aplica o efeito e consome a carga. Ele não exige que a vida tenha mudado para devolver `true`; o limite de vida é aplicado pelo personagem.

    **Habilidade avaliada e retomada:** Distinguir aceitação da operação, mudança de vida e consumo de carga.

**Na variante B:** O trecho é o mesmo. O limite de vida não altera a condição de aceitação em `usar`. **Saídas: `true` e `0`.**

## Fluxo e contratos: qual caminho será executado?

Até aqui, identificamos os objetos e suas mudanças de estado. Agora precisamos
seguir o caminho das chamadas: uma recusa pode impedir a continuação, uma
sobrescrita pode substituir a sequência herdada e uma composição pode acrescentar
efeitos na volta da delegação. Antes da execução, porém, a chamada precisa ser
aceita pelo tipo declarado.

### Q9 — O retorno controla a continuação

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

**a)** 1ª linha impressa.

**b)** 2ª linha impressa.

??? "Conferir resolução — variante A"

    **a)**

    `false`

    **b)**

    `62`

    Sem equipado, retorna false. Depois: 48 + 20 − 6 = 62; a recusa da segunda tentativa impede outro dano.

    A primeira tentativa não tem item equipado. Depois, a poção só permite um uso: o primeiro `if` aplica a cura e executa seu corpo; no segundo, a recusa impede tanto a cura quanto o dano escrito no corpo do `if`.

    **Habilidade avaliada e retomada:** Rastrear como o retorno de uma operação delegada controla a continuação do programa.

**Na variante B:** A vida inicial é `49`, em vez de `48`. Depois da recusa inicial, há uma recuperação de vinte pontos e um dano de seis. **Saídas: `false` e `63`.**

### Q10 — A sobrescrita define o caminho executado

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

??? "Conferir resolução — variante A"

    `48`

    CajadoLivre.usar substitui a sequência herdada e causa cinco de dano: 53 − 5 = 48.

    O tipo declarado `Equipamento` permite chamar `usar`, mas o objeto é um `CajadoLivre`. Sua sobrescrita executa o corpo completo apresentado na questão; o corpo herdado não é chamado automaticamente. Por isso, começar com zero cargas não bloqueia esse uso.

    A condição `cargas == 0` pertence ao corpo de `Equipamento.usar`. Como o método escolhido é outro e não chama `super.usar(alvo)`, essa condição não é executada. O resultado descreve o código apresentado; não garante que a sobrescrita preserve a política de consumo da base.

    **Habilidade avaliada e retomada:** Prever a implementação executada quando uma subclasse sobrescreve um método completo.

**Na variante B:** O alvo começa com `43`, em vez de `53`. A sobrescrita causa os mesmos cinco pontos de dano. **Saída: `38`.**

### Q11 — Interfaces expressam capacidades

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

**a)** 1ª linha impressa.

**b)** 2ª linha impressa.

??? "Conferir resolução — variante A"

    **a)**

    `2`

    **b)**

    `1`

    Somente os dois equipamentos oferecem Recarregavel; a recarga modifica o amuleto original de zero para um.

    O `instanceof` verifica cada objeto da lista. A poção não oferece recarga; amuleto e cajado oferecem. O cast permite chamar o contrato identificado, e a recarga modifica o próprio objeto que também é alcançado pela variável `amuleto`.

    **Habilidade avaliada e retomada:** Reconhecer capacidades por interface e rastrear alterações no objeto compartilhado.

**Na variante B:** O trecho é o mesmo: dois objetos oferecem recarga, e o amuleto original ganha uma carga. **Saídas: `2` e `1`.**

### Q12 — Composição e propagação da recusa

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

**a)** 1ª linha impressa.

**b)** 2ª linha impressa.

??? "Conferir resolução — variante A"

    **a)**

    `96`

    **b)**

    `96`

    Primeiro uso: 98 → 86 → 91 → 96. No segundo, a recusa do cajado se propaga e a vida permanece 96.

    Cada camada chama sua base antes de curar. No primeiro uso, o cajado causa dano e, na volta das chamadas, cada camada acrescenta sua cura. Na tentativa seguinte, `false` percorre as camadas e faz cada uma retornar antes da cura.

    | Passo do primeiro uso | Vida |
    | --- | --- |
    | estado inicial | `98` |
    | cajado causa dano | `86` |
    | camada interna recupera cinco | `91` |
    | camada externa recupera cinco | `96` |

    Não se deve aplicar as curas antes do dano: isso encontraria o teto `100` e mudaria indevidamente a previsão. No segundo uso, a recusa do cajado faz as duas camadas retornarem antes de `recuperarVida`.

    **Habilidade avaliada e retomada:** Acompanhar chamadas por composição e a propagação de sucesso ou recusa entre camadas.

**Na variante B:** A vida inicial é `97`, em vez de `98`. O primeiro percurso é `97 → 85 → 90 → 95`; o segundo uso é recusado. **Saídas: `95` e `95`.**

### Q13 — Tipo declarado e operações disponíveis

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

??? "Conferir resolução — variante A"

    Resposta: **B**.

    - **A:** Métodos públicos herdados podem ser chamados; o problema é o tipo da referência.
    - **B:** Usavel não oferece descrever, embora Amuleto possua a implementação herdada.
    - **C:** Uma classe abstrata pode fornecer métodos concretos utilizáveis por suas subclasses.
    - **D:** A atribuição de Amuleto a Usavel é válida; uma referência de interface pode guardar esse objeto.
    - **E:** A disponibilidade do método é verificada em compilação, não adiada até o despacho.

    A análise tem duas etapas: a atribuição é válida porque o objeto implementa `Usavel`; a chamada é rejeitada porque esse tipo declarado não oferece `descrever`. O despacho dinâmico só escolhe uma implementação depois que a chamada é aceita pelo compilador.

    **Habilidade avaliada e retomada:** Separar a verificação de uma chamada em compilação da escolha de implementação em execução.

**Na variante B:** O código e o argumento correto são os mesmos; a alternativa sobre a ausência de `descrever` em `Usavel` está na **letra D**.

## Projeto e testes: a solução protege o que promete?

Prever a execução é a base para avaliar uma mudança. Nas próximas questões,
o requisito orienta o julgamento: que relação a herança cria, que chamadas um
parâmetro aceita, onde uma regra fica protegida e que defeitos um teste revela.
Leia cada proposta apenas no contexto da própria questão.

### Q14 — Herança e composição

Na próxima versão do jogo, cada personagem deverá guardar e consultar seus itens. Durante a implementação, uma desenvolvedora apresenta esta proposta:

“A classe `Inventario` já tem os métodos `adicionar`, `obter` e `listar`. Podemos fazer `Personagem` herdar de `Inventario` para aproveitar esses métodos.”

```java
public class Personagem extends Inventario {
    // Campos e métodos do personagem.
}
```

Você está revisando essa proposta. Qual comentário orienta melhor a decisão de projeto?

A) “A herança é adequada: se o personagem precisa desses métodos, isso é suficiente para defini-lo como uma especialização de inventário.”

B) “A herança não permite esse reaproveitamento: como a lista de itens é privada, os métodos herdados não conseguem acessá-la.”

C) “Seria melhor colocar um inventário dentro do personagem, embora isso exija copiar para `Personagem` a implementação dos três métodos.”

D) “Podemos manter a herança e sobrescrever os três métodos: assim, o personagem aproveita o código sem ser tratado como um inventário.”

E) “A herança permite o reaproveitamento, mas torna o personagem um tipo de inventário. Ele poderia ter um inventário e usar os métodos desse objeto.”

??? "Conferir resolução — variante A"

    Resposta: **E**.

    - **A:** Precisar dos métodos não basta para caracterizar o personagem como subtipo de inventário.
    - **B:** Os métodos de Inventario continuam acessando seu próprio campo privado quando herdados.
    - **C:** Composição permite delegar ao inventário, sem copiar seus métodos.
    - **D:** Sobrescrever métodos não elimina a relação de subtipagem.
    - **E:** A herança reutiliza, mas cria subtipagem; ter um inventário permite reutilizar por delegação.

    Reutilizar operações e estabelecer uma relação de subtipagem são decisões diferentes. Com um campo `Inventario`, o personagem pode delegar tarefas ao colaborador sem passar a ser utilizável como um inventário.

    **Habilidade avaliada e retomada:** Comparar herança e composição considerando a relação que cada solução estabelece.

**Na variante B:** A alternativa que propõe ter um inventário e delegar ao colaborador está na **letra C**. A análise de subtipagem permanece a mesma.

### Q15 — O parâmetro define os argumentos aceitos

Atualmente, `Personagem.equipar` recebe um `Usavel`. Um desenvolvedor propõe trocar o tipo do parâmetro para `Equipamento`, mantendo o campo `equipado` e o corpo do método:

```java
public void equipar(Equipamento item) {
    equipado = item;
}
```

Ele justifica a mudança dizendo que o personagem precisa de um objeto com o método `usar`. Qual avaliação está correta?

A) A mudança não afeta as chamadas existentes, pois o tipo do parâmetro apenas documenta o argumento recebido.

B) O método deixa de compilar, pois um campo do tipo `Usavel` não pode guardar uma referência recebida como `Equipamento`.

C) O método continua aceitando poções, pois `Pocao` possui a mesma assinatura de `usar` que os equipamentos.

D) Chamadas com poções deixam de compilar, embora `Usavel` já ofereça a operação de que o personagem precisa.

E) A mudança faz todo item equipado executar `Equipamento.usar`, mesmo quando sua classe sobrescreve esse método.

??? "Conferir resolução — variante A"

    Resposta: **D**.

    - **A:** O tipo do parâmetro afeta os argumentos aceitos, mesmo com corpo inalterado.
    - **B:** Equipamento implementa Usavel; a atribuição ao campo continua válida.
    - **C:** Ter a mesma assinatura não torna Pocao um subtipo de Equipamento.
    - **D:** Pocao deixa de ser aceita, embora o contrato Usavel já ofereça usar.
    - **E:** A restrição do parâmetro não elimina despacho dinâmico nem sobrescritas.

    A compatibilidade do argumento é verificada pelo tipo declarado e pelo contrato do parâmetro. Restringir o parâmetro a `Equipamento` exclui outros implementadores de `Usavel`, mesmo que ofereçam a operação necessária ao corpo do método.

    A restrição também afeta uma chamada com `Usavel escolha = new Cajado(1)`: o argumento tem tipo declarado `Usavel`, que não é automaticamente convertido para `Equipamento`. O objeto ser um cajado não dispensa a verificação de tipos na chamada. Não há necessidade de exigir essa classe base para delegar a operação `usar`.

    **Habilidade avaliada e retomada:** Analisar o impacto de restringir o tipo de um parâmetro nas chamadas existentes.

**Na variante B:** A alternativa que identifica a exclusão das poções está na **letra E**. O parâmetro mais restrito continua desnecessário para a operação usada pelo personagem.

### Q16 — Um teste precisa revelar o defeito

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
Cajado item = new Cajado(0);
item.recarregar(1);
assertEquals(1, item.getCargas());
```

B)

```java
Cajado item = new Cajado(2);
item.recarregar(3);
assertEquals(3, item.getCargas());
```

C)

```java
Cajado item = new Cajado(1);
item.recarregar(1);
assertEquals(2, item.getCargas());
```

D)

```java
Cajado item = new Cajado(3);
item.recarregar(5);
assertEquals(3, item.getCargas());
```

E)

```java
Cajado item = new Cajado(2);
item.recarregar(0);
assertEquals(2, item.getCargas());
```

??? "Conferir resolução — variante A"

    Resposta: **C**.

    - **A:** Saldo inicial zero: somar um e substituir por um produzem o mesmo resultado.
    - **B:** As duas versões terminam no máximo três; a saturação oculta o defeito.
    - **C:** Uma carga mais uma resulta em duas no original; a proposta substitui o saldo por uma.
    - **D:** As duas versões terminam no máximo três; a saturação oculta o defeito.
    - **E:** Recarga zero retorna antes de modificar o saldo nas duas versões.

    Compare a execução original e a alterada com os mesmos dados. Um teste só detecta essa alteração quando seus resultados observados diferem. Saldo zero e saturação no máximo podem fazer as duas implementações coincidir.

    | Alternativa na variante A | Inicial / recarga | Saldo original | Saldo proposto | Distingue? |
    | --- | --- | --- | --- | --- |
    | A | `0 / 1` | `1` | `1` | não |
    | B | `2 / 3` | `3` | `3` | não |
    | C | `1 / 1` | `2` | `1` | sim |
    | D | `3 / 5` | `3` | `3` | não |
    | E | `2 / 0` | `2` | `2` | não |

    Todos passam no original. Só C falha na proposta. Executar uma linha alterada não basta: o estado inicial e a observação final precisam tornar a diferença visível.

    **Habilidade avaliada e retomada:** Escolher dados de teste que distinguem o comportamento correto de uma implementação defeituosa.

**Na variante B:** O teste com uma carga inicial, recarga de uma e expectativa de duas está na **letra D**. Os valores e o defeito discriminado são os mesmos.

### Q17 — A guarda deve proteger todos os caminhos

A equipe decidiu acrescentar uma restrição ao uso dos equipamentos: se o alvo estiver com vida zero, a tentativa deverá retornar `false`, sem alterar sua vida nem gastar cargas. Essa regra ainda não está implementada. Ela deverá valer tanto pelo uso via personagem quanto por uma chamada direta a `equipamento.usar(alvo)`.

Onde inserir a verificação `alvo.getVida() == 0` para cumprir essa regra?

A) Em `Personagem.recuperarVida`, retornando antes de alterar a vida.

B) Em `Equipamento.usar`, retornando `false` antes de chamar `aplicarEm` e de diminuir as cargas.

C) Em `Equipamento.usar`, retornando `false` depois de chamar `aplicarEm`, antes de diminuir as cargas.

D) Em `Equipamento.aplicarEm`, retornando antes de realizar o efeito, sem mudar `Equipamento.usar`.

E) Em `Personagem.usarEquipadoEm`, retornando `false` antes de delegar, sem mudar os equipamentos.

??? "Conferir resolução — variante A"

    Resposta: **B**.

    - **A:** Impedir apenas a recuperação não controla retorno nem consumo do equipamento.
    - **B:** A verificação em usar, antes de aplicarEm e do consumo, protege os dois caminhos de entrada.
    - **C:** A validação ocorre depois do efeito; o alvo já pode ter sido alterado.
    - **D:** Interromper somente aplicarEm deixa usar consumir a carga e devolver true.
    - **E:** A proteção no coordenador não cobre a chamada direta ao equipamento.

    Liste os dois caminhos de entrada: chamada direta ao equipamento e chamada pelo personagem. A condição precisa ser verificada antes do efeito e do consumo, em um ponto comum aos dois caminhos.

    Os caminhos exigidos são `equipamento.usar(alvo)` e `personagem.usarEquipadoEm(alvo) → equipado.usar(alvo)`. A proteção deve anteceder o efeito e o consumo no método comum aos dois. A questão não altera a poção nem exige acomodar a classe local `CajadoLivre` de Q10: cada mudança pertence apenas à sua questão.

    **Habilidade avaliada e retomada:** Localizar a proteção de uma regra antes dos efeitos e em um ponto comum aos caminhos exigidos.

**Na variante B:** A guarda em `Equipamento.usar`, antes do efeito e do consumo, está na **letra A**.

### Q18 — Cada teste observa uma propriedade

A equipe preparou dois testes para o uso do cajado. Cada teste começa com seus próprios objetos novos:

```java
Cajado item = new Cajado(1);
Personagem alvo = new Personagem(46);
```

Teste I:

```java
assertEquals(true, item.usar(alvo));
```

Teste II:

```java
item.usar(alvo);
assertEquals(34, alvo.getVida());
```

Qual comportamento incorreto de `usar` seria identificado somente pelo Teste II?

A) Consumir uma carga e retornar `true`, sem causar dano ao alvo.

B) Consumir uma carga, causar 12 pontos de dano e retornar `false`.

C) Retornar `false` sem alterar o alvo nem consumir uma carga.

D) Causar 12 pontos de dano e retornar `true`, sem consumir uma carga.

E) Consumir uma carga, causar 24 pontos de dano e retornar `false`.

??? "Conferir resolução — variante A"

    Resposta: **A**.

    - **A:** Retorna true sem dano: I passa e II falha.
    - **B:** Retorna false e causa o dano esperado: I falha e II passa.
    - **C:** Retorna false sem dano: os dois testes falham.
    - **D:** Retorna true e causa o dano esperado sem consumir: os dois testes passam, pois não observam cargas.
    - **E:** Retorna false e causa dano excessivo: os dois testes falham.

    Analise separadamente o retorno booleano e a vida final. Um teste que observa apenas uma dessas propriedades pode passar com a outra incorreta. Os dois testes também não verificam o saldo de cargas; passar neles não demonstra que todo o comportamento está correto.

    | Alternativa na variante A | Comportamento defeituoso | Teste I | Teste II |
    | --- | --- | --- | --- |
    | A | `true`, sem dano, com consumo | passa | falha |
    | B | `false`, dano de doze, com consumo | falha | passa |
    | C | `false`, sem dano ou consumo | falha | falha |
    | D | `true`, dano de doze, sem consumo | passa | passa |
    | E | `false`, dano de vinte e quatro, com consumo | falha | falha |

    Em cada linha, compare as duas observações separadamente. O caso D demonstra que até os dois testes passando juntos deixam uma propriedade importante sem verificar: o consumo.

    **Habilidade avaliada e retomada:** Avaliar quais propriedades cada teste observa e quais defeitos permanecem invisíveis.

**Na variante B:** O alvo começa com `48`, e o Teste II espera `36`. Retornar `true` sem causar dano continua passando em I e falhando em II; esse comportamento está na **letra E**.

### Q19 — Implementação herdada e sobrescritas

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

A) `Orbe` não pode ser instanciada, pois toda subclasse de uma classe abstrata também é abstrata.

B) `Orbe` pode ser instanciada sem sobrescrever `getVariacaoVida`; `Cajado` e `Amuleto` mantêm suas próprias variações.

C) `Orbe` não compila, pois precisa declarar diretamente todos os métodos das interfaces de `Equipamento`.

D) `Orbe` precisa declarar novamente os campos `nome`, `cargas` e `maximo` para utilizar os métodos herdados.

E) `Cajado` e `Amuleto` também passam a usar a variação zero, pois o método concreto da base substitui suas sobrescritas.

??? "Conferir resolução — variante A"

    Resposta: **B**.

    - **A:** Uma subclasse concreta pode ser instanciada mesmo que sua superclasse seja abstrata.
    - **B:** Orbe herda a implementação concreta; Cajado e Amuleto mantêm suas sobrescritas.
    - **C:** Métodos herdados podem satisfazer os contratos das interfaces.
    - **D:** Os métodos da base usam o estado privado já existente no objeto; não se duplicam campos.
    - **E:** O corpo concreto na base não substitui as sobrescritas de Cajado e Amuleto.

    Uma subclasse concreta pode aproveitar a implementação concreta herdada para cumprir um contrato. Quando outra subclasse já sobrescreve o método, essa implementação própria continua sendo escolhida para seus objetos.

    Com a operação ainda abstrata, `Orbe` precisaria implementá-la para ser concreta. Depois da mudança, herda o retorno zero. A base continuar abstrata impede `new Equipamento(...)`, mas não impede instanciar uma subclasse concreta. O código passa a admitir um equipamento cujo uso aceita e consome uma carga sem mudar a vida; compilar não demonstra que essa seja uma boa regra para qualquer requisito.

    **Habilidade avaliada e retomada:** Explicar a convivência entre implementação concreta herdada e sobrescritas das subclasses.

**Na variante B:** A alternativa que permite instanciar `Orbe` e preserva as variações próprias de `Cajado` e `Amuleto` está na **letra D**.

### Q20 — Encapsulamento de uma coleção mutável

O inventário passará a guardar no máximo três itens. O método `Inventario.adicionar` já foi alterado para impedir novas inclusões ao atingir esse limite. A equipe propõe acrescentar este método:

```java
public List<Item> getItens() {
    return itens;
}
```

Com esse método, outro código consegue ultrapassar o limite de três itens? Por quê?

A) Não. Como o campo `itens` é privado, a lista devolvida só pode ser modificada pelos métodos de `Inventario`.

B) Não. Ao devolver a lista, o método cria uma cópia; alterações nessa cópia não afetam o inventário.

C) Sim. Outro código pode chamar `add` na lista devolvida, sem executar a verificação de `Inventario.adicionar`.

D) Sim. A referência devolvida permite substituir o campo privado `itens` por outra lista criada fora do inventário.

E) Não. Sem um método `setItens`, outro código pode consultar a lista devolvida, mas não acrescentar elementos.

??? "Conferir resolução — variante A"

    Resposta: **C**.

    - **A:** private restringe acesso direto ao campo, mas não torna imutável o objeto devolvido.
    - **B:** Devolver a referência não cria uma cópia da lista.
    - **C:** O cliente pode executar add na lista real sem chamar Inventario.adicionar.
    - **D:** Reatribuir uma referência externa não substitui o campo privado do inventário.
    - **E:** Acrescentar à lista devolvida não exige um setter para substituir o campo.

    O modificador `private` protege o acesso direto ao campo. Se um método devolve a própria lista mutável, o cliente ganha uma referência capaz de alterar seu conteúdo e pode contornar as verificações de `adicionar`.

    O cliente obtém uma referência à mesma lista guardada no campo. Um comando como `inventario.getItens().add(new Pocao())` altera seu conteúdo sem executar `adicionar`. O problema é a possibilidade de modificar a coleção interna por outro caminho, mesmo sem conseguir acessar o campo diretamente ou substituí-lo por outra lista.

    **Habilidade avaliada e retomada:** Diagnosticar como expor uma coleção mutável permite contornar a proteção do estado.

**Na variante B:** A alternativa que identifica o `add` na lista real sem passar pela verificação está na **letra A**.

## O que levar desta correção

As questões mudam de formato, mas recuperam algumas distinções que precisam
acompanhar qualquer leitura de código orientado a objetos.

!!! synthesis "Síntese — três distinções para continuar"

    - **Referência, objeto e estado:** compartilhar uma referência não copia o
      objeto; reatribuir uma variável não redireciona as demais referências.
    - **Contrato e execução:** o tipo declarado delimita as chamadas possíveis;
      o objeto concreto determina a implementação de uma chamada válida.
    - **Regra e verificação:** a proteção deve alcançar os caminhos exigidos;
      cada teste só verifica as propriedades que suas observações conseguem revelar.

Para revisar sua compreensão, escolha uma questão cujo raciocínio você agora
consegue explicar e uma habilidade que ainda precisa retomar. Em cada caso,
registre o passo decisivo da resolução: qual referência, condição, chamada
ou observação determina o resultado? É um registro de estudo, sem nova nota
ou entrega.

??? "Conferir o próprio diagnóstico"

    Um registro útil identifica uma ação, além do nome do assunto. Por exemplo:

    - **Já consigo explicar Q5:** reatribuir `escolha` muda essa variável;
      o campo `equipado` continua guardando a referência ao cajado.
    - **Preciso retomar Q12:** devo seguir a delegação até a base e só aplicar
      as curas quando as chamadas voltam com `true`.

    Se sua explicação se limita a “a resposta é 38” ou “preciso estudar
    polimorfismo”, volte à resolução e localize o passo que faltou justificar.

## Materiais relacionados

- Prova da Unidade 02: [variante A (PDF)](../avaliacoes/prova-unidade-02/prova-unidade-02-variante-a.pdf) e [variante B (PDF)](../avaliacoes/prova-unidade-02/prova-unidade-02-variante-b.pdf).
- Gabaritos comentados: [variante A](../avaliacoes/prova-unidade-02/gabarito-variante-a.md) e [variante B](../avaliacoes/prova-unidade-02/gabarito-variante-b.md).
- [Aula 03 — Objetos, referências e identidade](aula-03-objetos-referencias-e-identidade.md): fundamentos de Q3–Q7.
- [Aula 13 — Como saber se ainda funciona?](aula-13-como-saber-se-ainda-funciona.md): observações e expectativas dos testes em Q16 e Q18.
- [Aula 14 — Do colaborador concreto ao contrato](aula-14-do-colaborador-concreto-ao-contrato.md): capacidades e dependências em Q11, Q13 e Q15.
- [Aula 15 — Polimorfismo: a mesma mensagem, comportamentos diferentes](aula-15-polimorfismo-a-mesma-mensagem-comportamentos-diferentes.md): tipo declarado, objeto concreto e despacho.
- [Aula 16 — Combinando comportamentos por composição](aula-16-combinando-comportamentos-por-composicao.md): delegação em camadas em Q12.
- [Aula 18 — Compartilhando regras sem perder os contratos](aula-18-compartilhando-regras-sem-perder-os-contratos.md): herança, implementação comum e sobrescrita em Q10, Q14 e Q19.
