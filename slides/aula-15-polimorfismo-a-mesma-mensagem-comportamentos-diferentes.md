---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 15 — Polimorfismo

<div class="statement">A mesma mensagem, comportamentos diferentes</div>

Como Java decide qual implementação executar por uma referência de interface?

<!-- Preservar todas as situações e a transferência final. O professor
controla o tempo. Nas atividades, dar tempo para previsão individual e colher
justificativas antes de avançar. Não antecipar respostas dos próximos frames. -->

---

<div class="chapter">O ponto de chegada da Aula 14</div>

## O papel é comum; as regras são diferentes

```java
public interface Entrega {
    double calcularCusto(Pedido pedido);
}
```

| Classe que cumpre Entrega | Custo neste recorte |
| --- | ---: |
| `EntregaNormal` | `10.0` |
| `EntregaExpressa` | `25.0` |

As regras são fixas: recebem o pedido, mas não consultam seus dados.

<!-- As implementações são as da Aula 14. Cada tipo público permanece
em seu arquivo. Nesta primeira investigação, chamamos a entrega diretamente:
não é necessário fechar o pedido para essas regras fixas. -->

---

<!-- _class: activity -->

<div class="chapter">Situação 1 — a mesma variável</div>

## O que será impresso em cada chamada?

```java
Pedido pedido = new Pedido();
Entrega entrega = new EntregaNormal();
System.out.println(entrega.calcularCusto(pedido));

entrega = new EntregaExpressa();
System.out.println(entrega.calcularCusto(pedido));
```

1. Quais valores aparecem, na ordem? Qual objeto recebe cada chamada?
2. O tipo declarado de `entrega` mudou?

---

<div class="chapter">Situação 1 — acompanhe o objeto alcançado</div>

## 10.0 e depois 25.0

| Chamada | Objeto alcançado | Implementação |
| --- | --- | --- |
| Primeira | `EntregaNormal` | devolve `10.0` |
| Segunda | `EntregaExpressa` | devolve `25.0` |

O tipo declarado continua sendo **Entrega**.

A atribuição muda o objeto alcançado pela variável; cada objeto realiza sua regra.

---

<!-- _class: activity -->

<div class="chapter">Situação 2 — uma referência foi copiada</div>

## A segunda acompanha a primeira?

```java
Pedido pedido = new Pedido();
Entrega primeira = new EntregaNormal();
Entrega segunda = primeira;
primeira = new EntregaExpressa();

System.out.println(primeira.calcularCusto(pedido));
System.out.println(segunda.calcularCusto(pedido));
```

1. Quais valores aparecem? Quantos objetos de entrega foram criados?
2. A última atribuição transforma a normal ou muda `segunda`?

---

<div class="chapter">Situação 2 — cada variável guarda sua referência</div>

## 25.0 e depois 10.0

- `primeira` alcança a expressa; `segunda` conserva a normal.
- Foram criados **dois objetos de entrega**.
- Copiar a referência não cria outro objeto.
- Reatribuir `primeira` não transforma a normal nem altera `segunda`.

Vamos representar o estado antes e depois da reatribuição.

---

<div class="chapter">Antes de primeira = new EntregaExpressa()</div>

## Duas variáveis alcançam o mesmo objeto

```java
Entrega primeira = new EntregaNormal();
Entrega segunda = primeira;
```

<div class="poo-diagram poo-diagram--shared">
  <div class="poo-var" style="grid-column: 1; grid-row: 1;">primeira</div>
  <svg aria-hidden="true" viewBox="0 0 72 100" style="grid-column: 2; grid-row: 1 / span 2; width: 72px; height: 100px; overflow: visible;"><defs><marker id="shared-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto-start-reverse"><path d="M 0 0 L 10 5 L 0 10 z" fill="var(--poo-arrow)"/></marker></defs><path d="M 0 22 H 32 V 50 H 72" fill="none" stroke="var(--poo-arrow)" stroke-width="2" marker-end="url(#shared-arrow)"/><path d="M 0 78 H 32 V 50" fill="none" stroke="var(--poo-arrow)" stroke-width="2"/></svg>
  <div class="poo-object"><div class="poo-object__header">EntregaNormal#1</div></div>
  <div class="poo-var" style="grid-column: 1; grid-row: 2;">segunda</div>
</div>

As setas significam **aponta para**. `#1` identifica a instância neste desenho.

<!-- A seta de cada linha chega ao mesmo contêiner. #1 não é endereço
de memória. Não introduzir detalhes de pilha, heap ou coleta de lixo. -->

---

<div class="chapter">Depois de primeira = new EntregaExpressa()</div>

## Só o caminho de primeira mudou

<div class="poo-diagram">
  <div class="poo-var">primeira</div><div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">EntregaExpressa#1</div></div>
  <div class="poo-var">segunda</div><div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">EntregaNormal#1</div></div>
</div>

O objeto normal continua sendo o mesmo alcançado por `segunda`.

---

<!-- _class: trap -->

<div class="chapter">A previsão depende de separar variável e objeto</div>

## Reatribuir não transforma o objeto

```java
primeira = new EntregaExpressa();
```

- Cria uma entrega expressa e guarda sua referência em `primeira`.
- Não transforma a entrega normal em expressa.
- Não faz outras variáveis acompanharem essa atribuição.

---

<!-- _class: concept-key -->

<div class="chapter">Dar nome ao comportamento observado</div>

## Conceito-chave — polimorfismo

Podemos usar objetos de classes diferentes por um **mesmo tipo** e solicitar a **mesma operação**.

A implementação executada depende do objeto que recebe a chamada.

Aqui, referências `Entrega` permitem solicitar `calcularCusto(Pedido)` a objetos normais ou expressos.

---

<div class="chapter">Como a chamada chega à implementação</div>

## Essa escolha é o despacho dinâmico

```java
entrega.calcularCusto(pedido)
```

Durante a execução, Java chega ao objeto referenciado por `entrega` e executa sua implementação do método de instância.

Polimorfismo não exige resultados diferentes: cada implementação pode produzir o resultado previsto por sua regra.

<!-- O foco é o método de instância declarado no contrato. Não generalizar
o mecanismo para toda construção Java, nem introduzir sobrecarga ou static. -->

---

<div class="chapter">Uma dúvida que o despacho ainda não resolve</div>

## A expressa oferece uma operação própria

Considere este método público dentro de `EntregaExpressa`:

```java
public void priorizarNaFila() {
    System.out.println("Entrega priorizada");
}
```

`priorizarNaFila()` não pertence ao contrato `Entrega`.

O objeto tem o método. Isso basta para chamá-lo por qualquer referência?

---

<!-- _class: activity -->

<div class="chapter">Situação 3 — analise as chamadas separadamente</div>

## O objeto tem; o tipo permite?

```java
Pedido pedido = new Pedido();
Entrega entrega = new EntregaExpressa();

entrega.calcularCusto(pedido);
entrega.priorizarNaFila();
```

1. Quais chamadas compilam? Por quê?
2. Retirando a linha inválida, qual cálculo executa?
3. Com `EntregaExpressa expressa`, a prioridade poderia ser solicitada?

<!-- Trecho de análise: a chamada inválida deve ser retirada para executar.
Não apresentar erro de compilação como se fosse um resultado de execução. -->

---

<div class="chapter">Situação 3 — dois critérios diferentes</div>

## O contrato permite calcular, mas não priorizar

1. `calcularCusto(pedido)` compila; `priorizarNaFila()` não: o tipo declarado é `Entrega`, que só promete o cálculo.
2. Sem a linha inválida, executa `EntregaExpressa.calcularCusto`, que devolve **25.0**.
3. Sim. Uma referência declarada `EntregaExpressa` permite solicitar sua operação pública específica.

O objeto não perdeu o método; aquela referência não permite essa chamada.

---

<!-- _class: java-focus -->

<div class="chapter">Duas perguntas em momentos diferentes</div>

## Java em foco — compilação e execução

**Na compilação**

O tipo declarado da referência permite a chamada?

**Na execução de uma chamada válida**

Qual objeto recebe a chamada e qual implementação do método de instância executa?

O despacho dinâmico não torna válida uma chamada recusada pelo compilador.

---

<div class="chapter">Das chamadas diretas à colaboração com Pedido</div>

## O pedido guarda a entrega no fechamento

```java
private Entrega entrega;
private boolean fechado;

public void fechar(Entrega entrega) {
    if (!fechado && entrega != null) {
        this.entrega = entrega;
        fechado = true;
    }
}
```

O primeiro fechamento válido conserva a escolha. A regra é a da Aula 14.

---

<div class="chapter">O pedido usa a referência guardada</div>

## A consulta encaminha a solicitação

Dentro de `Pedido`:

```java
public double calcularCustoEntrega() {
    return entrega.calcularCusto(this);
}
```

O campo `entrega` indica quem recebe o cálculo; `this` fornece o próprio pedido como argumento.

Neste estudo, essa consulta ocorre **depois de um fechamento válido**.

---

<!-- _class: activity -->

<div class="chapter">Situação 4 — a variável mudou</div>

## A entrega do pedido também mudou?

```java
Entrega entrega = new EntregaNormal();
Pedido pedido = new Pedido();
pedido.fechar(entrega);
entrega = new EntregaExpressa();

System.out.println(entrega.calcularCusto(pedido));
System.out.println(pedido.calcularCustoEntrega());
```

1. Quais valores aparecem? Quem recebe cada cálculo de custo?
2. Que atribuição mudaria o campo? Ela aconteceu após criar a expressa?

---

<div class="chapter">Situação 4 — campo e variável são lugares distintos</div>

## A expressa devolve 25.0; o pedido continua em 10.0

- A primeira consulta chega diretamente à **entrega expressa** da variável local.
- A segunda chega ao **pedido**, que solicita o custo à **entrega normal** guardada em seu campo.
- Mudar o campo exigiria uma atribuição dentro de `Pedido`, como `this.entrega = entrega`.
- Depois de criar a expressa, só a variável local foi reatribuída.

---

<div class="chapter">O estado depois da reatribuição local</div>

## O campo continua apontando para a normal

<div class="poo-diagram" style="grid-template-columns: 130px 48px 310px 48px 310px; max-width: 1040px;">
  <div class="poo-var">pedido</div><div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">Pedido#1</div><div class="poo-slots"><div class="poo-slot poo-slot--ref">entrega</div><div class="poo-slot">fechado = true</div></div></div>
  <div class="poo-arrow"></div><div class="poo-object"><div class="poo-object__header">EntregaNormal#1</div></div>
  <div class="poo-var">entrega</div><div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">EntregaExpressa#1</div></div>
</div>

O campo está contido no pedido; a variável local está fora dele.

<!-- A conexão do campo parte à altura do slot entrega. Setas indicam
referência, não chamada. Os nomes iguais não tornam campo e local o mesmo slot. -->

---

<!-- _class: activity -->

<div class="chapter">Situação 4 — continue com o mesmo pedido fechado</div>

## E se tentarmos fechar novamente?

A variável local `entrega` agora alcança a expressa.

```java
pedido.fechar(entrega);
System.out.println(pedido.calcularCustoEntrega());
```

1. A chamada a `fechar` compila?
2. O campo muda para a expressa? Qual custo aparece e por quê?

---

<div class="chapter">O tipo é aceito; a regra impede a troca</div>

## O custo continua sendo 10.0

1. A chamada compila: `fechar` aceita `Entrega`.
2. O campo não muda: o pedido já está fechado, então `!fechado` é falso.

```java
if (!fechado && entrega != null) {
    this.entrega = entrega;
    fechado = true;
}
```

A consulta continua chegando à entrega normal.

---

<!-- _class: trap -->

<div class="chapter">O contrato não contorna regras do domínio</div>

## Polimorfismo não troca o campo sozinho

- A variável local pode mudar sem alterar o campo de outro objeto.
- Aceitar um argumento não obriga o método a guardá-lo.
- O despacho usa o objeto alcançado pela referência da chamada.

`Pedido` continua controlando quando guarda a entrega.

---

<div class="chapter">Registrar a diferença como uma expectativa executável</div>

## Um teste protege variável versus campo

Em `PedidoTest`, com JUnit Jupiter e `assertEquals` configurados:

```java
@Test
void reatribuirVariavelNaoTrocaEntregaDoPedido() {
    Entrega entrega = new EntregaNormal();
    Pedido pedido = new Pedido();
    pedido.fechar(entrega);
    entrega = new EntregaExpressa();
    assertEquals(25.0, entrega.calcularCusto(pedido));
    assertEquals(10.0, pedido.calcularCustoEntrega());
}
```

<!-- Imports já conhecidos: org.junit.jupiter.api.Test e import static
org.junit.jupiter.api.Assertions.assertEquals. O segundo fechamento não é
executado neste teste; precisaria de chamada e expectativa próprias. -->

---

<div class="chapter">Quem precisa conhecer cada alternativa?</div>

## E se o pedido escolhesse a fórmula?

Proposta em linguagem natural, dentro de `Pedido`:

```text
se for normal: devolver 10
senão, se for expressa: devolver 25
senão, se for retirada local: devolver 0
```

Na colaboração atual, `Pedido` solicita:

```java
return entrega.calcularCusto(this);
```

---

<!-- _class: activity -->

<div class="chapter">Uma nova alternativa testa a distribuição das regras</div>

## Chegou a entrega agendada: custo 15.0

1. Na proposta com condicionais, onde acrescentar a nova regra?
2. Na colaboração pelo contrato, quem implementa o cálculo? `Pedido` precisa mudar?
3. Quem cria e fornece a entrega, se o pedido não identifica sua classe?

<!-- Pedir justificativas de impacto. A escolha concreta continua existindo
no código que monta o cenário; não afirmar que interfaces eliminam decisões. -->

---

<div class="chapter">A nova regra fica na nova implementação</div>

## O pedido continua solicitando a mesma operação

```java
public class EntregaAgendada implements Entrega {
    public double calcularCusto(Pedido pedido) {
        return 15.0;
    }
}
```

1. Com condicionais, seria preciso acrescentar um caso em `Pedido`.
2. Pelo contrato, a nova classe calcula; `Pedido` permanece igual.
3. O código que monta o cenário, como `Main`, cria e fornece o objeto.

---

<div class="chapter">Da escolha de uma entrega à comparação de alternativas</div>

## Uma sequência pode reunir objetos diferentes

Vamos comparar custos diretamente, sem fechar o pedido com várias entregas.

No `main`:

```java
Pedido pedido = new Pedido();
List<Entrega> alternativas = new ArrayList<>();
alternativas.add(new EntregaNormal());
alternativas.add(new EntregaExpressa());
```

O tipo dos elementos agora é o contrato `Entrega`.

<!-- A comparação não altera o modelo: um pedido guarda uma entrega.
Retomar os mecanismos da Aula 07; os imports aparecem no próximo frame. -->

---

<!-- _class: java-focus -->

<div class="chapter">Recursos já conhecidos, agora com o contrato</div>

## Java em foco — lista e percurso

```java
import java.util.ArrayList;
import java.util.List;
```

- `List<Entrega>` declara a lista de referências pelo contrato.
- `new ArrayList<>()` cria uma lista inicialmente vazia.
- `add(...)` inclui a referência no fim da sequência.
- `for (Entrega entrega : alternativas)` percorre os elementos na ordem.

Não precisamos de uma lista diferente para cada classe de entrega.

---

<!-- _class: activity -->

<div class="chapter">A lista contém normal e expressa, nessa ordem</div>

## Qual regra executa a cada passagem?

```java
for (Entrega entrega : alternativas) {
    System.out.println(entrega.calcularCusto(pedido));
}
```

1. Qual é a saída? O tipo declarado de `entrega` muda?
2. Precisamos identificar a classe do elemento dentro do laço?
3. E com lista vazia ou com a mesma referência em duas posições?

---

<div class="chapter">O percurso repete a chamada; o objeto pode variar</div>

## Uma chamada por posição percorrida

1. Saída: **10.0 e depois 25.0**. A variável permanece declarada `Entrega`.
2. Não. A chamada pelo contrato executa a implementação do objeto atual.
3. Lista vazia não executa o corpo; a mesma referência em duas posições recebe duas chamadas.

O número de chamadas depende das posições percorridas, não da quantidade de objetos distintos.

---

<div class="chapter">Transferência — dos valores devolvidos à mudança de estado</div>

## E se a mesma chamada alterasse outro objeto?

Um pequeno jogo:

- O personagem começa com **50 pontos de vida**.
- A poção solicita recuperar **20 pontos**.
- A armadilha solicita perder **10 pontos**.

O personagem controla sua vida; cada efeito decide o que solicitar a ele.

<!-- Exercício de transferência, sem definir o Projeto 3. Não acrescentar
limites de vida, morte, validação de pontos ou falhas ao recorte. -->

---

<div class="chapter">A capacidade comum é aplicar um efeito</div>

## O contrato recebe o personagem afetado

Em `Efeito.java`:

```java
public interface Efeito {
    void aplicarEm(Personagem personagem);
}
```

O método não devolve um custo: pode produzir uma mudança de estado por colaboração.

---

<div class="chapter">Personagem conserva o controle de seu estado</div>

## Vida inicial e operações públicas

Recorte de `Personagem.java`:

```java
private int vida;
public Personagem() { vida = 50; }
public int getVida() { return vida; }

public void recuperarVida(int pontos) {
    vida += pontos;
}
public void perderVida(int pontos) {
    vida -= pontos;
}
```

<!-- O arquivo completo está no roteiro. Este é um recorte dentro da classe
Personagem, não um conjunto de métodos soltos. Somente os valores fornecidos. -->

---

<div class="chapter">O próprio personagem oferece o alvo ao efeito</div>

## Receber encaminha a solicitação

Dentro de `Personagem`:

```java
public void receber(Efeito efeito) {
    efeito.aplicarEm(this);
}
```

`this` é o personagem que recebeu a chamada.

O método usa o efeito recebido naquela chamada e não o guarda em um campo.

---

<div class="chapter">Cada efeito realiza sua colaboração</div>

## A poção solicita recuperação

Em `Pocao.java`:

```java
public class Pocao implements Efeito {
    public void aplicarEm(Personagem personagem) {
        personagem.recuperarVida(20);
    }
}
```

O efeito não acessa o campo privado `vida`: solicita uma operação ao personagem.

---

<div class="chapter">A mesma operação também pode solicitar perda</div>

## A armadilha cumpre o mesmo contrato

Em `Armadilha.java`:

```java
public class Armadilha implements Efeito {
    public void aplicarEm(Personagem personagem) {
        personagem.perderVida(10);
    }
}
```

As classes de efeito escolhem a solicitação; o personagem altera sua própria vida.

---

<!-- _class: activity -->

<div class="chapter">O mesmo personagem recebe os dois efeitos</div>

## Quais estados serão observados?

```java
Personagem personagem = new Personagem();
Efeito efeito = new Pocao();
personagem.receber(efeito);
System.out.println(personagem.getVida());

efeito = new Armadilha();
personagem.receber(efeito);
System.out.println(personagem.getVida());
```

Quais valores aparecem? Por que o mesmo `receber(...)` produz outro efeito? Qual objeto muda de estado?

---

<div class="chapter">A referência do efeito mudou; o personagem é o mesmo</div>

## A vida passa por 70 e depois 60

| Chamada | Efeito alcançado | Solicitação ao personagem | Vida |
| --- | --- | --- | ---: |
| Primeira | `Pocao` | recuperar `20` | `70` |
| Segunda | `Armadilha` | perder `10` | `60` |

O parâmetro de `receber(...)` agora alcança outro efeito; o despacho chega à outra implementação de `aplicarEm(...)`.

O estado alterado é a vida do **mesmo personagem**.

---

<!-- _class: activity -->

<div class="chapter">Além de prever o valor, localize os receptores</div>

## Quem recebe cada chamada da poção?

```java
personagem.receber(efeito);  // efeito é a poção
```

Dentro de `receber`:

```java
efeito.aplicarEm(this);
```

Quem recebe `receber`, `aplicarEm` e `recuperarVida(20)`?
O que `this` representa nessa passagem?

---

<div class="chapter">O efeito executa; o personagem é alterado</div>

## O caminho da poção até a vida

```text
Main solicita receber(poção) ao personagem
Personagem solicita aplicarEm(personagem) à poção
Pocao solicita recuperarVida(20) ao personagem
Personagem altera sua vida de 50 para 70
```

`this`, dentro de `Personagem.receber`, é esse personagem, fornecido como argumento à poção.

---

<!-- _class: activity -->

<div class="chapter">Continue com a vida em 70 e efeito sendo a armadilha</div>

## Reconstrua o segundo caminho

```java
personagem.receber(efeito);
```

Desenhe ou escreva a sequência de chamadas até a alteração da vida.

Inclua os receptores, a operação solicitada e a vida antes e depois.

<!-- A operação cognitiva agora é reconstruir o fluxo completo. Não pedir
somente a repetição do valor 60 já previsto e explicado. -->

---

<div class="chapter">O contrato permanece; a colaboração realizada muda</div>

## O caminho da armadilha até a vida

```text
Main solicita receber(armadilha) ao personagem
Personagem solicita aplicarEm(personagem) à armadilha
Armadilha solicita perderVida(10) ao personagem
Personagem altera sua vida de 70 para 60
```

O personagem usa o novo argumento. `receber(...)` não guardou a poção anterior.

---

<div class="chapter">Compare com a entrega guardada em Pedido</div>

## O contrato não decide quando guardar o colaborador

| Modelo | Quando recebe? | Guarda para depois? |
| --- | --- | --- |
| `Pedido` | primeiro fechamento válido | sim, no campo `entrega` |
| `Personagem` | cada chamada a `receber` | não, usa o argumento |

As regras dos métodos explicam essa diferença.

O polimorfismo permite a chamada pelos contratos nos dois casos.

---

<!-- _class: activity -->

<div class="chapter">Diagnosticar uma proposta para o jogo</div>

## Precisamos descobrir a classe do efeito?

Uma sugestão afirma:

> “Dentro de receber, precisamos descobrir se o efeito é poção ou armadilha para escolher o que fazer.”

Essa identificação é necessária? Como a versão atual chega ao comportamento correto? Quem controla a vida?

---

<div class="chapter">O contrato já expressa a colaboração necessária</div>

## O personagem pode solicitar aplicarEm(this)

- Não é necessário identificar a classe dentro de `receber`.
- A implementação do objeto recebido solicita recuperação ou perda.
- O personagem continua controlando `vida` por suas operações públicas.

```java
public void receber(Efeito efeito) {
    efeito.aplicarEm(this);
}
```

---

<!-- _class: activity -->

<div class="chapter">Evoluir a solução sem receber o novo código pronto</div>

## Uma fonte de cura recupera 5 pontos

O mesmo personagem terminou com **60 pontos**.

1. Que contrato `FonteDeCura` deve cumprir e qual operação implementar?
2. O que deve solicitar ao personagem?
3. `Personagem.receber` ou `Efeito` precisam mudar?
4. Onde o novo objeto é criado e qual vida será observada?

---

<div class="chapter">A nova implementação incorpora a variação</div>

## FonteDeCura cumpre Efeito; a vida chega a 65

```java
public class FonteDeCura implements Efeito {
    public void aplicarEm(Personagem personagem) {
        personagem.recuperarVida(5);
    }
}
```

- Implementa `aplicarEm(Personagem)` e solicita `recuperarVida(5)`.
- `Personagem.receber` e `Efeito` permanecem iguais.
- `Main` cria e fornece a fonte: `personagem.receber(new FonteDeCura())`.
- O mesmo personagem passa de **60 para 65**.

---

<!-- _class: synthesis -->

<div class="chapter">Da chamada ao resultado ou à mudança de estado</div>

## Quatro perguntas para analisar a execução

1. O tipo declarado permite a chamada?
2. Qual objeto a referência alcança?
3. Qual implementação do método de instância executa?
4. Qual resultado ou mudança de estado ela produz?

Reatribuir uma variável não transforma objetos nem troca outros campos.

---

<div class="chapter">Laboratório 15 — aplicar o raciocínio no Projeto 2</div>

## A mesma chamada, vários canais

Evoluir o sistema de lembretes com:

```java
public void avisarPorTodos(List<Notificador> notificadores)
```

- Um envio por posição, na ordem da lista.
- Contar cada envio e preservar o canal inicial.
- Lista vazia não envia; referência repetida recebe outro envio.
- Ampliar os testes e preservar a lista recebida.

<!-- A implementação pertence ao laboratório, não deve ser entregue aqui.
Continuar a solução do Laboratório 14. IA Nível 1; entrega somente dos Java,
incluindo LembreteTest. O jogo foi transferência, não mudança do Projeto 2. -->
