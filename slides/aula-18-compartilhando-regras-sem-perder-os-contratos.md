---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 18 — Compartilhando regras

<div class="statement">Sem perder os contratos</div>

Quando classes diferentes podem compartilhar implementação sem perder suas responsabilidades?

**IA — Nível 1: Tutor.** Faça as previsões antes de consultar ajuda.

<!-- Fonte semântica: Aula 18 e LessonDesign aprovados pelo professor ao
solicitar o ajuste F1 e a preparação dos slides. Referência: 90 minutos,
incluindo elaboração individual e discussão. Recuperação e repetição: 10;
extração e construção: 25; abstração e chamadas: 20; comparação e ponte: 20;
verificação e fechamento: 15. O apêndice de composição é elástico.
Não reconstruir Inventario/PilhaMaterial. Não introduzir exceções, final,
hierarquias profundas ou padrões de projeto. IA: Nível 1, depois da tentativa.
Cada activity tem resposta visível no frame imediatamente seguinte. -->

---

<div class="chapter">Da Aula 17 — o que já funciona</div>

## A bigorna conhece a capacidade de reparo

| Item | Durabilidade | Material | Reparo |
| --- | --- | --- | --- |
| Espada de ferro | `40/100` | ferro | `+25`, até `100` |
| Escudo | `30/80` | madeira | `+20`, até `80` |
| Maçã | não possui | nenhum | não oferece |

O inventário usa **Item** para apresentar. A bigorna usa **Reparavel** para solicitar o reparo.

<!-- Premissas: referências não nulas; durabilidade entre zero e máximo;
máximo e acréscimo positivos; material não vazio; pilhas não negativas.
Reparo bem-sucedido consome uma unidade inteira. Recusas preservam os estados.
Essas são regras didáticas; não exigir familiaridade com Minecraft. -->

---

<!-- _class: activity -->

<div class="chapter">Recuperação — cenário independente</div>

## Quem muda cada estado?

```java
Escudo escudo = new Escudo(30);
Reparavel equipamento = escudo;
PilhaMaterial madeira = new PilhaMaterial("madeira", 2);
boolean reparou = equipamento.repararCom(madeira);
```

1. Qual é o retorno, a durabilidade final e o saldo?
2. Quem altera a durabilidade? Quem altera a quantidade?

<!-- Dar tempo de prever antes de avançar. Recuperar colaboração e identidade,
sem transformar a recuperação em nova exposição da aula anterior. -->

---

<div class="chapter">O mesmo escudo, uma pilha de madeira</div>

## Dois objetos cuidam de estados diferentes

| Observação | Resultado |
| --- | --- |
| Retorno | `true` |
| Durabilidade | `50/80` |
| Madeira restante | `1` |

O **escudo** altera sua durabilidade; a **pilha** altera a quantidade quando recebe `consumirUma()`.

`equipamento` e `escudo` alcançam o mesmo escudo.

---

<div class="chapter">A implementação anterior — corpo de repararCom em Espada</div>

## O reparo confere, consome e respeita o limite

```java
if (!material.ehDoTipo("ferro") || durabilidade == 100) {
    return false;
}
if (!material.consumirUma()) {
    return false;
}
durabilidade += 25;
if (durabilidade > 100) {
    durabilidade = 100;
}
return true;
```

---

<!-- _class: activity -->

<div class="chapter">Agora compare — corpo de repararCom em Escudo</div>

## O que varia e o que se repete?

```java
if (!material.ehDoTipo("madeira") || durabilidade == 80) {
    return false;
}
if (!material.consumirUma()) {
    return false;
}
durabilidade += 20;
if (durabilidade > 80) {
    durabilidade = 80;
}
return true;
```

Quais três dados variam? O que se repete? Onde corrigir o limite?

<!-- Comparar com a espada do frame anterior. Os dois corpos estão completos,
incluindo consumo, recusas e limite; a resposta vem no próximo frame. -->

---

<div class="chapter">A repetição está no algoritmo, não só nos nomes dos campos</div>

## Uma sequência; três parâmetros diferentes

| Dado | Espada | Escudo |
| --- | --- | --- |
| Material aceito | `"ferro"` | `"madeira"` |
| Máximo | `100` | `80` |
| Acréscimo | `25` | `20` |

**Conferir → consumir → aumentar → limitar → informar sucesso.**

Hoje precisamos conferir uma correção nos **dois métodos**. Podemos concentrar essa regra e conservar os dados de cada equipamento.

---

<div class="chapter">Compartilhar o reparo cria uma pergunta sobre a descrição</div>

## A base conhece as regras; cada item se apresenta

Espada e escudo são equipamentos reparáveis neste modelo.

Uma base **Equipamento** pode concentrar o estado e o reparo. Mas qual seria a descrição de um equipamento genérico?

A base será **abstrata**: deixa `descrever()` pendente para cada classe concreta.

<!-- Introduzir o mecanismo depois da necessidade. A família respeita as mesmas
regras de reparo; semelhança textual, sozinha, não justifica herança. -->

---

<div class="chapter">Equipamento.java — declaração e campos</div>

## A implementação comum conserva os dois contratos

```java
public abstract class Equipamento implements Item, Reparavel {
    private int durabilidade;
    private int maximo;
    private String materialAceito;
    private int acrescimo;
    // construtor e métodos nos próximos recortes
}
```

Os campos são privados. Cada equipamento concreto terá seus próprios valores.

---

<div class="chapter">Dentro de Equipamento — construir o estado</div>

## Os parâmetros recebem os dados de cada equipamento

```java
protected Equipamento(int durabilidadeInicial, int maximo,
                      String materialAceito, int acrescimo) {
    this.durabilidade = durabilidadeInicial;
    this.maximo = maximo;
    this.materialAceito = materialAceito;
    this.acrescimo = acrescimo;
}
```

Por enquanto, os argumentos são válidos. O construtor apenas inicializa campos.

<!-- protected permite a chamada pelas subclasses. Não abrir uma matriz de
acesso nem discutir entradas inválidas: ficam para o próximo encontro. -->

---

<div class="chapter">Ainda dentro da base — operações de apresentação</div>

## A consulta tem corpo; a descrição fica pendente

```java
@Override
public int getDurabilidade() {
    return durabilidade;
}

@Override
public abstract String descrever();
```

`descrever()` termina com ponto e vírgula. **Não há corpo** para executar na base.

<!-- @Override corresponde aqui às declarações de Reparavel e Item.
Uma classe abstrata pode ter métodos com corpo e métodos abstratos. -->

---

<div class="chapter">Espada.java — substitui a classe anterior</div>

## A espada informa os dados e implementa a descrição

```java
public class Espada extends Equipamento {
    public Espada(int durabilidadeInicial) {
        super(durabilidadeInicial, 100, "ferro", 25);
    }
    @Override
    public String descrever() {
        return "Espada de ferro: " + getDurabilidade() + "/100";
    }
}
```

Não conservamos outra cópia da durabilidade nem do método de reparo.

---

<div class="chapter">Escudo.java — a mesma base, outros dados</div>

## O escudo conserva sua descrição e seus limites

```java
public class Escudo extends Equipamento {
    public Escudo(int durabilidadeInicial) {
        super(durabilidadeInicial, 80, "madeira", 20);
    }
    @Override
    public String descrever() {
        return "Escudo: " + getDurabilidade() + "/80";
    }
}
```

A ordem dos argumentos é: inicial, máximo, material, acréscimo.

---

<!-- _class: java-focus -->

<div class="chapter">Ler as novas declarações</div>

## extends e super têm funções diferentes

- `extends Equipamento`: estabelece a superclasse.
- `super(...)`: chama o construtor dessa base.
- `protected` no construtor permite a chamada pelas subclasses.
- A espada também cumpre `Item` e `Reparavel`, sem repetir `implements`.

Os campos da base continuam **private**.

<!-- Não usar campos protected para facilitar a descrição. Java permite
uma única superclasse direta e várias interfaces; retomaremos na comparação. -->

---

<!-- _class: activity -->

<div class="chapter">Construção — cenário novo</div>

## Dois construtores criam dois objetos?

```java
Espada espada = new Espada(40);
Equipamento equipamento = espada;
```

1. Quantos equipamentos são criados? As referências alcançam quais objetos?
2. Que construtor inicializa os campos de durabilidade e reparo?

<!-- Esperar uma hipótese sobre a participação de super(...).
O objetivo é distinguir inicialização da base e composição com outro objeto. -->

---

<div class="chapter">Construção — um único objeto concreto</div>

## As duas referências alcançam a mesma espada

<div style="position: relative; width: 1000px; height: 270px; margin-top: 20px;" role="img" aria-label="espada e equipamento apontam para a mesma Espada, com durabilidade 40, máximo 100, material ferro e acréscimo 25.">
  <div class="poo-var" style="position: absolute; left: 0; top: 18px; width: 330px; box-sizing: border-box;">espada : Espada</div>
  <div class="poo-var" style="position: absolute; left: 0; top: 160px; width: 330px; box-sizing: border-box;">equipamento : Equipamento</div>
  <svg width="1000" height="270" viewBox="0 0 1000 270" style="position: absolute; inset: 0;" aria-hidden="true"><defs><marker id="a18-ref" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--poo-arrow)"/></marker></defs><g fill="none" stroke="var(--poo-arrow)" stroke-width="3" marker-end="url(#a18-ref)"><path d="M330,43 H430 V88 H540"/><path d="M330,185 H430 V155 H540"/></g></svg>
  <div class="poo-object" style="position: absolute; left: 540px; top: 0; width: 450px; box-sizing: border-box;">
    <div class="poo-object__header">Espada</div>
    <div class="poo-slots"><div class="poo-slot">durabilidade = 40</div><div class="poo-slot">maximo = 100</div><div class="poo-slot">materialAceito = "ferro"</div><div class="poo-slot">acrescimo = 25</div></div>
  </div>
</div>

O construtor de **Equipamento** inicializa esses campos na própria espada.

---

<div class="chapter">Reconstruir a criação — new Espada(40)</div>

## A base participa da inicialização da espada

1. `Espada` recebe `40` em seu construtor.
2. `super(...)` passa `40`, `100`, `"ferro"` e `25` à base.
3. `Equipamento` atribui os valores aos campos do mesmo objeto.
4. A construção termina; a referência é atribuída a `espada`.

Construtores **não são herdados**. A espada declara o seu e chama o da base.

<!-- Não há new Equipamento(...), nem um equipamento colaborador separado.
A atribuição a equipamento apenas fornece outra referência à mesma espada. -->

---

<!-- _class: activity -->

<div class="chapter">Dentro de Espada — duas propostas de descrição</div>

## Herdar permite acessar qualquer campo?

**A**
```java
return "Espada de ferro: " + durabilidade + "/100";
```

**B**
```java
return "Espada de ferro: " + getDurabilidade() + "/100";
```

Qual compila? Precisamos tornar o campo `protected`?

---

<div class="chapter">A visibilidade continua sendo respeitada</div>

## B usa a consulta pública herdada

**B compila.** `getDurabilidade()` está implementado em `Equipamento` e é público.

**A não compila.** `durabilidade` é privado em outra classe.

Não precisamos ampliar a visibilidade do campo. A base continua responsável por proteger e alterar esse estado.

---

<!-- _class: activity -->

<div class="chapter">Diagnóstico — analisar cada linha separadamente</div>

## A base abstrata pode ser um tipo de referência?

```java
Equipamento a = new Espada(40);
Equipamento b = new Equipamento(40, 100, "ferro", 25);
Item c = new Escudo(30);
Reparavel d = new Espada(40);
```

Quais linhas compilam? Por que declarar uma referência é diferente de instanciar a classe?

<!-- As linhas são alternativas independentes; não executar juntas. -->

---

<div class="chapter">Referenciar um objeto não exige instanciar o tipo declarado</div>

## a, c e d compilam; b tenta criar a base abstrata

| Linha | Diagnóstico |
| --- | --- |
| `a` | uma espada pode ser usada como `Equipamento` |
| `b` | `abstract` impede `new Equipamento(...)` |
| `c` | um escudo cumpre `Item` |
| `d` | uma espada cumpre `Reparavel` |

Uma subclasse concreta precisa fornecer as operações abstratas pendentes. Caso contrário, ela também deverá ser abstrata.

<!-- Uma classe abstrata pode ter construtor e métodos com corpo. Nem toda
classe abstrata precisa declarar um método abstrato. -->

---

<div class="chapter">Equipamento — agora concentrar o método de reparo</div>

## As recusas usam os dados do próprio objeto

```java
@Override
public boolean repararCom(PilhaMaterial material) {
    if (!material.ehDoTipo(materialAceito) || durabilidade == maximo) {
        return false;
    }
    if (!material.consumirUma()) {
        return false;
    }
    // continuação no próximo slide
}
```

<!-- Recorte progressivo. A atualização seguinte deve substituir o comentário,
antes da chave final. Não acrescentar teste da classe concreta. -->

---

<div class="chapter">Continuação de repararCom — uma unidade já foi consumida</div>

## A mesma regra protege os limites de cada equipamento

```java
durabilidade += acrescimo;
if (durabilidade > maximo) {
    durabilidade = maximo;
}
return true;
```

Na espada: `+25`, até `100`. No escudo: `+20`, até `80`.

O corpo está na base; o estado pertence ao equipamento que recebe a chamada.

---

<!-- _class: concept-key -->

<div class="chapter">A hierarquia já tem estado e comportamento</div>

## Herdar e sobrescrever são papéis diferentes

**Reparo:** a espada usa a implementação herdada de `Equipamento`.

**Descrição:** a espada fornece uma implementação para a operação abstrata. Isso é **sobrescrita**.

Ambas executam sobre o próprio objeto concreto.

---

<!-- _class: activity -->

<div class="chapter">Cenário novo — quatro referências para uma espada</div>

## Quais implementações executam?

```java
Espada espada = new Espada(40);
Item item = espada;
Equipamento equipamento = espada;
Reparavel capacidade = espada;
PilhaMaterial ferro = new PilhaMaterial("ferro", 2);
System.out.println(item.descrever());
System.out.println(capacidade.repararCom(ferro));
System.out.println(equipamento.descrever());
System.out.println(espada.getDurabilidade());
System.out.println(ferro.getQuantidade());
System.out.println(item == equipamento);
```

Preveja as seis linhas. Onde estão os corpos do reparo e da descrição?

<!-- Dar tempo individual para acompanhar as referências e a mudança de estado.
Não alterar os dados deste cenário no slide de resposta. -->

---

<div class="chapter">As referências observam o mesmo estado reparado</div>

## Uma espada, duas descrições em momentos diferentes

```text
Espada de ferro: 40/100
true
Espada de ferro: 65/100
65
1
true
```

O reparo executa o corpo de **Equipamento**. A descrição executa o de **Espada**. Há um único equipamento, alcançado pelas quatro referências.

---

<div class="chapter">O tipo declarado ainda limita as chamadas</div>

## Declarar a operação permite solicitar sua execução

| Chamada | Compila? | Motivo |
| --- | --- | --- |
| `capacidade.descrever()` | não | `Reparavel` não declara a operação |
| `equipamento.descrever()` | sim | `Equipamento` declara a operação abstrata |

`@Override` ajuda o compilador a detectar um nome errado, como `descrver()`.

A anotação não escolhe o corpo na execução: isso continua dependendo do objeto.

---

<div class="chapter">O reparo mudou de lugar; o cliente continua válido</div>

## A bigorna ainda solicita uma capacidade

```java
public boolean tentarReparar(Item item, PilhaMaterial material) {
    if (item instanceof Reparavel) {
        Reparavel equipamento = (Reparavel) item;
        return equipamento.repararCom(material);
    }
    return false;
}
```

`Inventario` conserva sua `List<Item>`. `Maca` continua implementando somente `Item`.

---

<!-- _class: activity -->

<div class="chapter">A nova base deve mudar todos os clientes?</div>

## Compare três propostas

**A.** A bigorna testa `instanceof Equipamento`, pois os reparáveis atuais usam essa base.

**B.** A maçã estende `Equipamento`, para todos os itens ficarem na mesma hierarquia.

**C.** A bigorna usa `Reparavel`; a base fica onde suas regras fazem sentido.

Qual preserva os papéis? Um futuro `Item` reparável de outra hierarquia seria aceito pela bigorna atual?

---

<div class="chapter">Capacidade e família de implementação não são a mesma exigência</div>

## C preserva os contratos dos clientes

- **A** restringe a bigorna à família `Equipamento`.
- **B** atribui à maçã estado e reparo que não pertencem a seu papel.
- **C** mantém a colaboração pela capacidade necessária.

Um futuro objeto que cumpra **Item e Reparavel** pode usar a bigorna atual sem estender `Equipamento`.

---

<div class="chapter">Comparar com a Aula 16 — muda a relação entre os objetos</div>

## A entrega com seguro guarda uma entrega-base

Recortes de `EntregaComSeguro`:

```java
private Entrega entregaBase; // recebida no construtor

public double calcularCusto(Pedido pedido) {
    return entregaBase.calcularCusto(pedido) + 5.0;
}
```

Dois objetos colaboram. Já `Espada extends Equipamento` usa métodos que operam sobre o estado da própria espada.

<!-- Na composição, a entrega recebida pode ser normal ou expressa.
No reparo também há delegação: a espada solicita consumo à pilha recebida.
Herança e colaboração podem coexistir no mesmo sistema. -->

---

<!-- _class: activity -->

<div class="chapter">Duas necessidades independentes</div>

## Escolher pelo requisito

1. Uma ferramenta segue a mesma regra de reparo, mudando máximo, material, acréscimo e descrição. Que solução pode compartilhar o algoritmo? Sob qual condição?
2. O seguro deve combinar com modalidades diferentes, recebidas na criação. O que se perde criando uma subclasse com seguro para cada modalidade?

<!-- Não exigir uma única técnica por sistema. Pedir justificativa ligada
às regras e às possibilidades de combinação, não apenas os nomes dos mecanismos. -->

---

<div class="chapter">Os requisitos indicam relações diferentes</div>

## Compartilhar regras ou combinar colaboradores

1. Uma subclasse de **Equipamento** pode passar seus dados à base e implementar a descrição, desde que respeite suas operações e regras.
2. Uma classe com seguro por modalidade repete o acréscimo e exige novas classes para novas modalidades. A **composição** permite receber qualquer `Entrega` compatível e delegar o cálculo.

Em Java, uma classe tem uma superclasse direta e pode cumprir várias interfaces.

---

<!-- _class: trap -->

<div class="chapter">Uma semelhança pode sugerir a pergunta errada</div>

## Herdar só para aproveitar código

Código parecido é um indício para investigar.

Antes de criar a hierarquia, confira se as subclasses podem respeitar as operações e regras da base.

Se precisarem negar essas regras, reavalie a relação e a distribuição das responsabilidades.

---

<!-- _class: activity -->

<div class="chapter">Depois da extração — cenários independentes</div>

## A organização mudou; os resultados mudaram?

| Cenário | Estado inicial | Pilha |
| --- | --- | --- |
| A | espada `90/100` | ferro `2` |
| B | escudo `30/80` | ferro `2` |
| C | escudo `30/80` | madeira `2` |

Preveja o retorno, a durabilidade final e o saldo em cada cenário.

<!-- Comparar com a regra anterior. A unidade de material é consumida por
inteiro mesmo quando falta menos que o acréscimo para atingir o máximo. -->

---

<div class="chapter">A extração preserva o comportamento esperado</div>

## Refatorar inclui conferir o que deve permanecer

| Cenário | Retorno | Durabilidade | Saldo |
| --- | --- | --- | --- |
| A | `true` | `100` | `1` |
| B | `false` | `30` | `2` |
| C | `true` | `50` | `1` |

**A:** o limite impede `115`. **B:** material incompatível impede o consumo. **C:** o escudo usa acréscimo `20`.

Os testes anteriores continuam relevantes: construções e operações públicas foram preservadas.

---

<div class="chapter">EquipamentoTest — cenário A com JUnit Jupiter já configurado</div>

## Observar o limite, o consumo e a descrição

```java
Espada espada = new Espada(90);
PilhaMaterial ferro = new PilhaMaterial("ferro", 2);
Bigorna bigorna = new Bigorna();

boolean reparou = bigorna.tentarReparar(espada, ferro);

assertEquals(true, reparou);
assertEquals(100, espada.getDurabilidade());
assertEquals(1, ferro.getQuantidade());
assertEquals("Espada de ferro: 100/100", espada.descrever());
```

<!-- Corpo do teste @Test; imports iguais aos anteriores. O arquivo completo
está no roteiro. Não reconstruir a configuração de JUnit durante a aula. -->

---

<div class="chapter">Um teste não representa todas as condições da regra</div>

## Preservar também os casos de recusa

O teste anterior cobre **limite, consumo e descrição** daquele cenário.

Precisamos conferir também:

- material incompatível, pilha vazia e equipamento completo;
- recusa da maçã, que não oferece reparo;
- dados específicos do escudo passados à base.

<!-- Reaproveitar os testes/casos da Aula 17. Não transformar este frame
em uma segunda lista extensa de implementações para copiar. -->

---

<!-- _class: activity -->

<div class="chapter">Fechamento individual 1 — cenário independente</div>

## A referência é Equipamento; o objeto é Escudo

```java
Equipamento equipamento = new Escudo(30);
PilhaMaterial madeira = new PilhaMaterial("madeira", 2);
boolean reparou = equipamento.repararCom(madeira);
System.out.println(equipamento.descrever());
```

Qual corpo realiza o reparo? Qual é o retorno e a linha impressa? Quanto material resta?

<!-- Tentativa individual antes da resposta. Esse cenário exige integrar
o método herdado, os parâmetros do escudo e a descrição sobrescrita. -->

---

<div class="chapter">Fechamento 1 — o objeto conserva os dados do escudo</div>

## O reparo herdado altera a descrição observada

Executa **Equipamento.repararCom(...)** sobre o escudo.

Retorno: **true**. Madeira restante: **1**.

```text
Escudo: 50/80
```

A linha é produzida por **Escudo.descrever()**, lendo a consulta herdada da durabilidade.

---

<!-- _class: activity -->

<div class="chapter">Fechamento individual 2 — proposta alternativa</div>

## E se o reparo voltasse para a bigorna?

Uma proposta apaga `repararCom(...)` da base e coloca na bigorna um ramo para espada (`+25`) e outro para escudo (`+20`).

Mantendo os demais trechos:

1. As classes concretas ainda compilam? Por quê?
2. Que responsabilidade muda de lugar? O que acontece quando surge outro reparável?

---

<div class="chapter">Fechamento 2 — mover um cálculo não implementa o contrato</div>

## A proposta fica incompleta e concentra regras no cliente

1. **Não compilam:** espada e escudo continuam cumprindo `Reparavel`, mas perderam a implementação de `repararCom(...)`.
2. A bigorna tenta assumir as regras dos equipamentos. Mesmo corrigindo a ausência do método, outra classe exigiria revisar seus ramos e dados.

Na solução atual, a bigorna coordena a tentativa; cada equipamento realiza o reparo.

---

<!-- _class: activity -->

<div class="chapter">Fechamento individual 3 — integrar uma nova ferramenta</div>

## A picareta segue a mesma regra de reparo

Ferro; máximo **100**; acréscimo **25**. Descrição: `"Picareta: "` seguida da durabilidade e de `"/100"`.

1. Que partes precisam ser acrescentadas?
2. Proponha um cenário que verifique a integração sem alterar inventário ou bigorna: estado inicial, ação e resultados.

<!-- Não basta dizer extends. Esperar a indicação de construtor, descrição,
montagem e uma verificação observável do mesmo item guardado no inventário. -->

---

<div class="chapter">Fechamento 3 — acrescentar a classe e sua montagem</div>

## O reparo e os clientes existentes podem permanecer

**Classe:** `Picareta extends Equipamento`; construtor com `super(durabilidadeInicial, 100, "ferro", 25)`; sobrescrita de `descrever()`.

**Montagem:** criar a picareta e adicioná-la ao inventário.

**Teste possível:** picareta `90/100` no inventário, ferro `2`; reparar o item obtido. Esperar `true`, a mesma picareta, descrição `"Picareta: 100/100"` e saldo `1`.

---

<div class="chapter">Ponte para o laboratório — mais uma consequência do despacho</div>

## Um método da base pode chamar uma operação sobrescrita

Imagine acrescentar a `Equipamento`:

```java
public void apresentar() {
    System.out.println(descrever());
}
```

`descrever()` continua abstrato na base e implementado em cada subclasse concreta.

<!-- A nova operação é um cenário hipotético, não uma modificação obrigatória
no exemplo completo. Não dar a saída antes da atividade seguinte. -->

---

<!-- _class: activity -->

<div class="chapter">Cenário novo — após acrescentar apresentar() à base</div>

## Uma chamada leva a qual implementação?

```java
new Espada(40).apresentar();
```

1. Que linha será impressa?
2. Onde estão os corpos de `apresentar()` e `descrever()` executados? As operações atuam sobre o mesmo objeto?

<!-- Esta previsão implementa o ajuste F1 da auditoria. Deixar o aluno
reconstruir a chamada interna antes de transferir o mecanismo aos canais. -->

---

<div class="chapter">A chamada interna também usa o objeto concreto</div>

## A base apresenta; a espada fornece a descrição

```text
Espada de ferro: 40/100
```

1. Essa é a linha impressa.
2. `apresentar()` está em **Equipamento**; `descrever()` executa o corpo de **Espada**. Ambos atuam sobre a mesma espada.

A declaração abstrata permite a chamada. O objeto concreto fornece o corpo.

<!-- A chamada ocorre depois da construção. Não chamar operações
sobrescrevíveis em construtores neste percurso. -->

---

<div class="chapter">Laboratório 18 — transferir para o Projeto 2</div>

## Os canais compartilham impressão e contagem

Uma base pode executar **obter identificação → imprimir → contar**. Cada canal fornece sua identificação: `SMS`, `PAINEL`, `APP` ou `EMAIL [Agenda]`.

Cada objeto conserva seu contador. O contador de **Lembrete** continua registrando os avisos daquele lembrete, que podem usar canais diferentes.

O objeto com prefixo continua delegando por **Notificador**, sem precisar pertencer à base dos canais de console.

<!-- A prática continua a solução final do Laboratório 16; não há um Lab 17
intermediário. Não implementar o laboratório nos slides. O método herdado
chama a identificação sobrescrita após a construção, como na previsão anterior. -->

---

<!-- _class: synthesis -->

<div class="chapter">Compartilhar sem prender os clientes à base</div>

## Regras comuns, objetos próprios, contratos preservados

- A base concentra o estado e o reparo; cada equipamento tem seu estado.
- As subclasses herdam o reparo e sobrescrevem a descrição.
- A bigorna usa `Reparavel`: capacidade não exige uma mesma base.
- Herança e composição atendem relações e variações diferentes.

<!-- Fim do núcleo. O aprofundamento seguinte é elástico: pular se necessário,
sem remover a ponte que prepara a implementação obrigatória do laboratório. -->

---

<!-- _class: activity -->

<div class="chapter">Aprofundamento opcional — outra distribuição do estado</div>

## E se a durabilidade ficasse em um colaborador?

Espada e escudo implementam `Item` e `Reparavel` diretamente. Cada um cria seu próprio colaborador exclusivo para guardar a durabilidade e realizar o reparo.

1. Onde fica o estado? Que delegações são necessárias?
2. Qual vínculo deixa de ser exigido? Os contratos dos clientes precisam mudar?

<!-- Somente se houver tempo. Não pedir a implementação completa do
colaborador nem dar nome de padrão de projeto à alternativa. -->

---

<div class="chapter">Aprofundamento — centralizar o algoritmo sem a mesma superclasse</div>

## A composição muda onde o estado vive

1. Durabilidade, limite e reparo ficam no **colaborador exclusivo**. Cada equipamento delega consulta e reparo; continua produzindo sua descrição.
2. Espada e escudo deixam de precisar estender `Equipamento`. Continuam cumprindo **Item e Reparavel**, preservando os clientes.

O algoritmo pode permanecer centralizado, com o custo das delegações e da construção do colaborador correto.
