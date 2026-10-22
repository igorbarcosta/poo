---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 17 — Inventário de jogo

<div class="statement">Interfaces e capacidades</div>

Como guardar itens diferentes e permitir operações específicas sem exigir que todos ofereçam as mesmas capacidades?

<!-- Derivado da Aula 17 e de seu LessonDesign, aprovados explicitamente
pelo professor nesta sessão. Referência interna: 90 minutos, incluindo
previsão, elaboração individual e discussão. Recuperação breve; concentrar
o esforço nas conversões e na passagem de classe concreta para capacidade.
Inventario e PilhaMaterial são apoio fornecido, não classes a reconstruir.
Reservar tempo para a aplicação individual. O apêndice sobre reatribuição
é opcional. Sem laboratório associado, tratamento de exceções, herança,
pattern matching ou regras adicionais de Minecraft. -->

---

<div class="chapter">De volta da exploração</div>

## Três itens chegam ao inventário

| Item | Estado inicial | Reparo com uma unidade |
| --- | --- | --- |
| Espada de ferro | `40/100` | ferro: `+25`, até `100` |
| Escudo | `30/80` | madeira: `+20`, até `80` |
| Maçã | sem durabilidade | não aceita reparo |

O **inventário** guarda e apresenta os itens. A **bigorna** tenta reparar o item selecionado com uma pilha de material.

<!-- Não é preciso conhecer Minecraft. Mecânica inspirada no jogo; números,
arquitetura e atualização do mesmo objeto são simplificações didáticas. -->

---

<div class="chapter">As regras deste modelo</div>

## Uma tentativa também envolve o material

**Sucesso:** devolve `true`, consome uma unidade e aumenta a durabilidade até o máximo.

**Recusa:** devolve `false` e preserva item e pilha — material incompatível, pilha vazia, equipamento completo ou maçã.

Mesmo uma espada em `90/100` consome uma unidade inteira para chegar a `100/100`.

<!-- Nos cenários: índices válidos, itens não nulos e pilhas não nulas.
Obter um item não o remove nem cria cópia. Os construtores recebem valores
válidos. Retomar essas premissas se uma hipótese fugir do recorte. -->

---

<div class="chapter">Primeiro, apresentar todos os itens</div>

## Um contrato comum basta para descrever

```java
public interface Item {
    String descrever();
}
```

```java
public class Maca implements Item {
    public String descrever() {
        return "Maçã";
    }
}
```

`Espada` e `Escudo` também cumprem `Item`; suas descrições incluem a durabilidade.

---

<div class="chapter">Inventario — código de apoio já fornecido</div>

## Guardar e consultar referências de Item

```java
private List<Item> itens; // inicializada com new ArrayList<>()

public Item obter(int indice) {
    return itens.get(indice);
}
public void listar() {
    for (Item item : itens) {
        System.out.println(item.descrever());
    }
}
```

`adicionar(Item item)` guarda a referência recebida. `obter(...)` consulta uma posição, sem remover nem copiar o item.

---

<!-- _class: activity -->

<div class="chapter">Cenário-base — ainda sem reparos</div>

## O que aparece na listagem?

```java
Inventario inventario = new Inventario();
inventario.adicionar(new Espada(40)); // posição 0
inventario.adicionar(new Escudo(30)); // posição 1
inventario.adicionar(new Maca());     // posição 2
PilhaMaterial ferro = new PilhaMaterial("ferro", 2);
inventario.listar();
```

1. Quais itens são apresentados, em que ordem e com quais durabilidades?
2. No laço, `item` tem que tipo declarado? Precisamos testar a classe para escolher `descrever()`?

---

<div class="chapter">Cenário-base — a mesma mensagem chega a objetos diferentes</div>

## O contrato permite; cada objeto responde

```text
Espada de ferro: 40/100
Escudo: 30/80
Maçã
```

O tipo declarado de `item` é **Item**. A chamada `descrever()` já pertence a esse contrato.

Não precisamos testar classes: o **despacho dinâmico** escolhe a implementação do objeto alcançado em cada passagem.

---

<div class="chapter">Listar funcionou; agora o jogador seleciona a espada</div>

## A chamada de reparo passa a ser permitida?

Nesta versão, `Espada` e `Escudo` implementam somente `Item`, mas já possuem métodos públicos `repararCom(...)` e `getDurabilidade()`.

```java
Item selecionado = inventario.obter(0);
selecionado.repararCom(ferro); // não compila
```

O objeto é uma espada. Por que o compilador recusa a chamada?

<!-- Diagnóstico de compilação: não juntar essa linha aos exemplos
executáveis. Colher uma hipótese breve antes de avançar. -->

---

<div class="chapter">O contrato da referência ainda é Item</div>

## O compilador consulta o tipo declarado

```java
public interface Item {
    String descrever();
}
```

`Item` não declara `repararCom(...)`. Essa chamada é recusada mesmo que o objeto selecionado possua o método.

O despacho dinâmico escolhe a implementação de uma **chamada aceita**; ele não acrescenta operações ao contrato na compilação.

---

<div class="chapter">Antes de reparar — conhecer o colaborador recebido</div>

## A pilha cuida de sua quantidade

| Operação de PilhaMaterial | O que oferece |
| --- | --- |
| `ehDoTipo("ferro")` | confere o tipo do material |
| `consumirUma()` | retira uma unidade se houver saldo e devolve `true`; senão, devolve `false` |
| `getQuantidade()` | consulta o saldo |

O equipamento pode solicitar consumo; a pilha impede que sua quantidade fique negativa.

<!-- Classe de apoio fornecida no roteiro. ehDoTipo usa equals para
comparar o conteúdo de textos não nulos; não usa == para esse fim. -->

---

<div class="chapter">Recorte de Espada — regras antes da alteração</div>

## Só reparar depois de conseguir o material

```java
public boolean repararCom(PilhaMaterial material) {
    if (!material.ehDoTipo("ferro") || durabilidade == 100) {
        return false;
    }
    if (!material.consumirUma()) {
        return false;
    }
    // atualização da durabilidade no próximo slide
}
```

Material incompatível, espada completa ou pilha vazia encerram a tentativa sem aumentar a durabilidade.

<!-- Recorte progressivo: completar o método com o trecho seguinte antes
de compilar. As duas recusas precedem qualquer aumento de durabilidade. -->

---

<div class="chapter">Continuação do mesmo método — uma unidade já foi consumida</div>

## A espada protege seu limite

```java
durabilidade += 25;
if (durabilidade > 100) {
    durabilidade = 100;
}
return true;
```

`40 → 65`; `90 → 100`.

O escudo segue sua própria regra: aceita madeira e acrescenta `20`, até `80`.

---

<!-- _class: java-focus -->

<div class="chapter">Voltar à seleção da posição 0 — sabemos que é uma espada</div>

## Cast: usar a referência por outro tipo

```java
Item selecionado = inventario.obter(0);
Espada espada = (Espada) selecionado;
```

`(Espada)` é uma **conversão explícita**, chamada de *cast*. Ela permite usar a referência como `Espada` se o objeto alcançado for compatível.

O cast não executa `new`, não copia o objeto e não altera sua classe ou seu estado.

---

<!-- _class: activity -->

<div class="chapter">Cenário-base — espada 40/100; ferro com 2 unidades</div>

## Preveja o efeito do primeiro reparo

```java
Item selecionado = inventario.obter(0);
Espada espada = (Espada) selecionado;
boolean reparou = espada.repararCom(ferro);
System.out.println(reparou);
System.out.println(espada.getDurabilidade());
System.out.println(ferro.getQuantidade());
System.out.println(selecionado == espada);
inventario.listar();
```

Quais são as **sete linhas** impressas? Justifique a comparação com `==` e a durabilidade exibida na listagem.

---

<div class="chapter">Mesmo cenário — o reparo alterou a espada guardada</div>

## Uma espada, observada por mais de um caminho

```text
true
65
1
true
Espada de ferro: 65/100
Escudo: 30/80
Maçã
```

`==` resulta em `true`: as referências alcançam a mesma espada. A posição `0` do inventário também guarda essa referência.

---

<div class="chapter">Depois do reparo — distinguir referência, tipo e objeto</div>

## O cast não muda o tipo de selecionado

<div role="img" aria-label="selecionado, de tipo Item, e espada, de tipo Espada, apontam para o mesmo objeto Espada com durabilidade 65." style="position: relative; width: 1000px; height: 220px; margin: 25px 0;">
  <div class="poo-var" style="position: absolute; left: 0; top: 12px; width: 330px; box-sizing: border-box;">selecionado : Item</div>
  <div class="poo-var" style="position: absolute; left: 0; top: 140px; width: 330px; box-sizing: border-box;">espada : Espada</div>
  <svg width="1000" height="220" viewBox="0 0 1000 220" style="position: absolute; inset: 0;" aria-hidden="true"><defs><marker id="a17-ref" markerWidth="8" markerHeight="8" refX="7" refY="4" orient="auto"><path d="M0,0 L8,4 L0,8 Z" fill="var(--poo-arrow)"/></marker></defs><g fill="none" stroke="var(--poo-arrow)" stroke-width="3" marker-end="url(#a17-ref)"><path d="M330,37 H440 V76 H550"/><path d="M330,165 H440 V128 H550"/></g></svg>
  <div class="poo-object" style="position: absolute; left: 550px; top: 35px; width: 410px;"><div class="poo-object__header">Espada</div><div class="poo-slots"><div class="poo-slot">durabilidade = 65</div></div></div>
</div>

`selecionado` continua declarado como **Item**: `selecionado.repararCom(ferro)` ainda não compila.

<!-- O inventário foi omitido para destacar as duas variáveis locais; sua
posição 0 continua alcançando esse mesmo objeto. Bordas vermelhas indicam
referências; o contêiner azul delimita o objeto e seu campo de valor. -->

---

<!-- _class: activity -->

<div class="chapter">Cenário independente — inventário inicial; ferro novo com 2</div>

## E se a seleção alcançar a maçã?

```java
Item selecionado = inventario.obter(2);
Espada espada = (Espada) selecionado;
espada.repararCom(ferro);
System.out.println("Terminou");
```

1. O trecho compila? O cast funciona durante a execução?
2. Há consumo de material? A mensagem é impressa?

---

<div class="chapter">A maçã continua sendo uma maçã</div>

## O cast compila, mas falha na execução

1. **Compila:** o tipo declarado `Item` admite a possibilidade de alcançar uma espada. Ao executar, o objeto real é uma `Maca`: o cast falha com **ClassCastException**.
2. **Não há consumo nem impressão de "Terminou".** Nesse programa sem tratamento da falha, as linhas seguintes não são executadas.

Nenhuma espada foi criada. Precisamos verificar a compatibilidade antes de converter.

<!-- Reconhecer a falha neste contexto; não abrir tratamento de exceções. -->

---

<!-- _class: java-focus -->

<div class="chapter">Reiniciar o cenário da maçã — substituir o cast sem verificação</div>

## instanceof vem antes da conversão

```java
Item selecionado = inventario.obter(2);
if (selecionado instanceof Espada) {
    Espada espada = (Espada) selecionado;
    espada.repararCom(ferro);
}
```

`instanceof` produz um `boolean`: testa compatibilidade com o tipo indicado. O ramo executa somente se o resultado for `true`.

Para `null`, o resultado é `false`.

---

<div class="chapter">Comparar quatro execuções independentes — ferro novo com 2 em cada uma</div>

## Essa verificação reconhece apenas espadas

| Seleção | `instanceof Espada` | Estado após o trecho |
| --- | --- | --- |
| espada `40/100` | `true` | espada `65/100`; ferro `1` |
| escudo `30/80` | `false` | escudo `30/80`; ferro `2` |
| maçã | `false` | maçã preservada; ferro `2` |
| `null` | `false` | ramo ignorado; ferro `2` |

O escudo também aceita reparo. A pergunta “é uma espada?” é suficiente para a bigorna?

<!-- Conduzir comparação breve: não repetir uma atividade extensa de
previsão. O caso null esclarece o operador; os itens guardados não são nulos. -->

---

<div class="chapter">Uma proposta para atender também ao escudo</div>

## Acrescentar um ramo para cada classe?

```java
if (item instanceof Espada) {
    Espada espada = (Espada) item;
    return espada.repararCom(material);
}
if (item instanceof Escudo) {
    Escudo escudo = (Escudo) item;
    return escudo.repararCom(material);
}
```

Um terceiro equipamento exigiria outro ramo, embora o trabalho solicitado continuasse sendo **tentar reparar**.

<!-- Proposta parcial do corpo da bigorna, não a implementação final. -->

---

<!-- _class: activity -->

<div class="chapter">Escolher o contrato de que a colaboração precisa</div>

## Como expressar a capacidade de reparo?

| Proposta | Decisão |
| --- | --- |
| A | exigir `repararCom(...)` de todo `Item`, inclusive da maçã |
| B | manter um ramo para cada classe concreta na bigorna |
| C | manter `Item` e criar outro contrato para quem aceita reparo |

Qual proposta evita exigir reparo da maçã e listar todas as classes na bigorna? Justifique pelos papéis do inventário e do reparo.

---

<div class="chapter">Uma análise pelos papéis de cada cliente</div>

## C separa apresentação e capacidade adicional

**Inventário:** guarda e apresenta qualquer `Item`.

**Bigorna:** precisa reconhecer quem oferece reparo e solicitar essa operação.

A proposta **A** obriga a maçã a oferecer uma operação fora de seu papel, mesmo que sempre recuse. A proposta **B** vincula a bigorna aos nomes de todas as classes reparáveis.

---

<div class="chapter">Versão seguinte — tornar o papel compartilhado explícito</div>

## Reparavel declara a capacidade

```java
public interface Reparavel {
    boolean repararCom(PilhaMaterial material);
    int getDurabilidade();
}
```

Os equipamentos já possuem esses métodos públicos. Agora passam a declarar que cumprem também **Reparavel**.

`Maca` continua cumprindo somente `Item`.

---

<!-- _class: java-focus -->

<div class="chapter">Duas interfaces independentes no mesmo objeto</div>

## implements lista os contratos por vírgula

```java
public class Espada implements Item, Reparavel {
    // métodos públicos dos dois contratos
}
```

| Tipo declarado da referência | Operações oferecidas pelo contrato |
| --- | --- |
| `Item` | `descrever()` |
| `Reparavel` | `repararCom(...)`, `getDurabilidade()` |

`Escudo` também cumpre ambos. O objeto cumprir `Item` não acrescenta `descrever()` a uma referência declarada `Reparavel`.

<!-- Declaração resumida; métodos completos estão no roteiro. Reparavel
não estende Item. Não introduzir herança de interfaces nesta aula. -->

---

<div class="chapter">A bigorna passa a reconhecer a capacidade</div>

## Verificar, converter e delegar

Dentro de `Bigorna`:

```java
public boolean tentarReparar(Item item, PilhaMaterial material) {
    if (item instanceof Reparavel) {
        Reparavel equipamento = (Reparavel) item;
        return equipamento.repararCom(material);
    }
    return false;
}
```

A bigorna usa o item e a pilha recebidos; devolve o resultado da delegação.

---

<div class="chapter">Três decisões na tentativa de reparo</div>

## Cada mecanismo responde a uma pergunta

| Etapa | Pergunta respondida |
| --- | --- |
| `item instanceof Reparavel` | o objeto oferece essa capacidade? |
| `(Reparavel) item` | podemos usar a referência por esse contrato? |
| `equipamento.repararCom(material)` | qual implementação executa no objeto alcançado? |

Na última etapa, o despacho dinâmico escolhe a regra da espada ou do escudo.

Se já recebemos um `Reparavel` não nulo, podemos solicitar o reparo diretamente.

---

<!-- _class: activity -->

<div class="chapter">Versão com Reparavel — três cenários independentes</div>

## Oferecer reparo garante o sucesso?

Em cada cenário, uma bigorna nova recebe:

| Cenário | Item | Pilha |
| --- | --- | --- |
| 1 | espada `100/100` | ferro `2` |
| 2 | espada `40/100` | madeira `2` |
| 3 | maçã | ferro `2` |

1. Para cada cenário, qual o resultado de `instanceof Reparavel`? O método do equipamento executa?
2. Qual o retorno da tentativa e o estado final do item e da pilha em cada cenário?

---

<div class="chapter">A capacidade permite solicitar; as regras determinam o sucesso</div>

## As três tentativas devolvem false

| Cenário | Capacidade | Retorno | Estado final |
| --- | --- | --- | --- |
| 1 — completa | `true` | `false` | espada `100/100`; ferro `2` |
| 2 — madeira | `true` | `false` | espada `40/100`; madeira `2` |
| 3 — maçã | `false` | `false` | maçã preservada; ferro `2` |

Em **1 e 2**, `Espada.repararCom(...)` executa e recusa o reparo. Em **3**, a bigorna não entra no ramo de reparo.

<!-- Recuperar brevemente a Aula 15: receber argumento de tipo aceito
não garantia um segundo fechamento. null também não entraria no ramo. -->

---

<div class="chapter">Novo cenário — acompanhar a regra do outro equipamento</div>

## O escudo recebe madeira

```java
Item item = new Escudo(30);
PilhaMaterial madeira = new PilhaMaterial("madeira", 2);
Bigorna bigorna = new Bigorna();
boolean reparou = bigorna.tentarReparar(item, madeira);
```

A bigorna reconhece `Reparavel` e chama a mesma operação.

Como essa chamada chega ao consumo de madeira e à atualização do escudo?

---

<div class="chapter">Mesmo escudo — seguir chamadas e devoluções</div>

## Cada objeto protege seu estado

1. A **bigorna** verifica a capacidade e delega ao escudo recebido.
2. `Escudo.repararCom(...)` confere material e durabilidade; solicita `consumirUma()` à pilha.
3. A **pilha** reduz seu saldo de `2` para `1` e devolve `true`.
4. O **escudo** aumenta de `30` para `50`, respeitando o máximo `80`, e devolve `true`. A bigorna devolve esse resultado.

A bigorna não calcula `+20` nem `+25` e não cria um item substituto.

---

<!-- _class: activity -->

<div class="chapter">Verificar a solução — espada e material novos em cada linha</div>

## O que cada teste precisa observar?

| Cenário | Espada inicial | Pilha inicial |
| --- | --- | --- |
| Reparo possível | `40/100` | ferro `2` |
| Material incompatível | `40/100` | madeira `2` |
| Próximo ao máximo | `90/100` | ferro `2` |

Cada cenário executa `bigorna.tentarReparar(espada, material)`.

Preveja o retorno, a durabilidade e a quantidade final de material em cada linha.

---

<div class="chapter">Expectativas para os três testes prioritários</div>

## Conferir retorno, durabilidade e consumo

| Cenário | Retorno | Durabilidade final | Saldo final |
| --- | --- | --- | --- |
| Reparo possível | `true` | `65` | ferro `1` |
| Material incompatível | `false` | `40` | madeira `2` |
| Próximo ao máximo | `true` | `100` | ferro `1` |

No último caso, consome-se uma unidade inteira. O limite impede a durabilidade de chegar a `115`.

---

<div class="chapter">BigornaTest — preparar e executar o primeiro cenário</div>

## O teste guarda acesso à espada original

```java
Espada espada = new Espada(40);
Inventario inventario = new Inventario();
inventario.adicionar(espada);
PilhaMaterial ferro = new PilhaMaterial("ferro", 2);
Bigorna bigorna = new Bigorna();

boolean reparou =
        bigorna.tentarReparar(inventario.obter(0), ferro);
```

A tentativa recebe o item do inventário. A variável `espada` permite conferir o estado do objeto fornecido.

<!-- Recorte do método @Test reparaOMesmoItemDoInventario. JUnit Jupiter
já configurado, com org.junit.jupiter.api.Test e o import estático de
org.junit.jupiter.api.Assertions.assertEquals. Continuação no próximo frame. -->

---

<div class="chapter">Continuação do primeiro teste — os mesmos objetos</div>

## As expectativas incluem estado e identidade

```java
assertEquals(true, reparou);
assertEquals(65, espada.getDurabilidade());
assertEquals(1, ferro.getQuantidade());
assertEquals(true, inventario.obter(0) == espada);
```

O reparo precisa alcançar **a espada recebida**, consumir material e preservar sua presença no inventário.

Retorno correto, sozinho, não demonstra essa colaboração.

---

<div class="chapter">Segundo teste — material incompatível deve preservar os dois estados</div>

## A recusa também precisa ser verificada

```java
@Test
void materialIncompativelPreservaItemEPilha() {
    Espada espada = new Espada(40);
    PilhaMaterial madeira = new PilhaMaterial("madeira", 2);
    Bigorna bigorna = new Bigorna();
    boolean reparou = bigorna.tentarReparar(espada, madeira);

    assertEquals(false, reparou);
    assertEquals(40, espada.getDurabilidade());
    assertEquals(2, madeira.getQuantidade());
}
```

---

<div class="chapter">Terceiro teste — perto do máximo, o consumo continua inteiro</div>

## O limite pertence à regra do equipamento

```java
@Test
void limitaDurabilidadeMesmoConsumindoUmaUnidade() {
    Espada espada = new Espada(90);
    PilhaMaterial ferro = new PilhaMaterial("ferro", 2);
    Bigorna bigorna = new Bigorna();
    boolean reparou = bigorna.tentarReparar(espada, ferro);

    assertEquals(true, reparou);
    assertEquals(100, espada.getDurabilidade());
    assertEquals(1, ferro.getQuantidade());
}
```

---

<!-- _class: activity -->

<div class="chapter">Os três testes usam espadas — sucesso, recusa por material e limite</div>

## Esses testes distinguem quais defeitos?

1. Uma versão repara indevidamente a maçã. Algum dos três testes a detecta?
2. Outra versão repara a espada corretamente, mas nunca consome material. Algum a detecta?

Justifique indicando os objetos fornecidos e as expectativas que passam ou falham.

---

<div class="chapter">A cobertura depende dos cenários e das observações</div>

## O saldo revela um defeito que a durabilidade esconde

1. **Nenhum detecta o reparo da maçã:** os três fornecem espadas. Também não verificam a regra do escudo.
2. **O primeiro e o terceiro detectam a falta de consumo:** esperam saldo `1`, mas observariam `2`, mesmo com durabilidade correta.

Os casos de maçã, escudo, equipamento completo e pilha vazia complementam a cobertura; estão no roteiro para consulta.

---

<!-- _class: activity -->

<div class="chapter">Evolução — a solução correta passa a receber uma picareta</div>

## Onde a novidade precisa aparecer?

`Picareta` é um item reparável com ferro: acrescenta `25` até `100`, consome uma unidade por sucesso e preserva os estados na recusa.

1. Que contratos e métodos a classe deve oferecer? Onde criá-la e adicioná-la?
2. A listagem e a tentativa da bigorna precisam de novos ramos?
3. Que resultado esperar de um teste com picareta `40/100` e ferro `2`?

---

<div class="chapter">Uma implementação nova ocupa os papéis existentes</div>

## A montagem escolhe a nova classe

1. `Picareta implements Item, Reparavel`: oferece `descrever()`, `repararCom(PilhaMaterial)` e `getDurabilidade()`.

```java
inventario.adicionar(new Picareta(40));
```

2. **Sem novos ramos:** a listagem usa `Item`; a bigorna verifica `Reparavel` e delega.
3. O teste deve obter **true**, durabilidade **65** e ferro **1**. Recusa e limite complementam a verificação da classe.

---

<div class="chapter">Aplicação individual — versão final com as duas interfaces</div>

## Prever e justificar antes de conferir

Quatro decisões: compilação e execução; identidade e estado; contrato e despacho; escolha de cenários de teste.

Produza sua resposta **sem consulta**, antes da discussão.

Atividade formativa, sem nota ou entrega. No estudo com IA, **Nível 1 — Tutor**: primeiro sua previsão; depois ajuda para compreender a dúvida.

<!-- Reservar tempo real para produção. Cada solicitação abaixo é seguida
imediatamente da resposta visível. Pausar antes de revelar cada conferência. -->

---

<!-- _class: activity -->

<div class="chapter">Individual 1 — analisar as alternativas separadamente</div>

## Não compila ou falha ao executar?

```java
// A
Item item = new Espada(40);
item.repararCom(new PilhaMaterial("ferro", 2));
```

```java
// B
Item item = new Maca();
Espada espada = (Espada) item;
```

Classifique A e B e justifique pelo tipo declarado e pelo objeto real.

---

<div class="chapter">Individual 1 — conferir os motivos da recusa</div>

## A para na compilação; B falha na execução

**A:** `Item` não declara `repararCom(...)`. A chamada não compila, mesmo alcançando uma espada.

**B:** o cast compila porque uma referência declarada `Item` pode alcançar uma espada. Ao executar, o objeto é uma `Maca`: ocorre **ClassCastException**.

A possibilidade admitida pelo tipo declarado não garante a compatibilidade do objeto encontrado.

---

<!-- _class: activity -->

<div class="chapter">Individual 2 — inventário novo, sem reparos anteriores</div>

## O inventário observa qual estado?

```java
Inventario inventario = new Inventario();
inventario.adicionar(new Espada(90));
Item selecionado = inventario.obter(0);
Reparavel equipamento = (Reparavel) selecionado;
PilhaMaterial ferro = new PilhaMaterial("ferro", 2);
equipamento.repararCom(ferro);
System.out.println(inventario.obter(0).descrever());
System.out.println(ferro.getQuantidade());
```

Preveja as duas linhas. Explique por que a atualização aparece no inventário: o cast criou outro equipamento?

---

<div class="chapter">Individual 2 — conferir identidade e estado compartilhado</div>

## O inventário continua alcançando a mesma espada

```text
Espada de ferro: 100/100
1
```

O cast não criou outro equipamento. A posição `0`, `selecionado` e `equipamento` alcançam **a mesma espada**.

O reparo altera esse objeto, respeita o máximo `100` e consome uma unidade da pilha recebida.

---

<!-- _class: activity -->

<div class="chapter">Individual 3 — escudo e pilha novos, fornecidos à bigorna</div>

## O contrato escolhe a regra?

```java
Item item = new Escudo(30);
PilhaMaterial madeira = new PilhaMaterial("madeira", 2);
```

1. Por que o cast para `Reparavel` dentro da bigorna é válido?
2. Qual implementação de `repararCom(...)` executa?
3. Qual o retorno, a durabilidade final e o saldo de madeira?
4. Uma referência `Reparavel` permite chamar `descrever()` diretamente? Justifique.

---

<div class="chapter">Individual 3 — conferir capacidade, despacho e resultado</div>

## O objeto determina a implementação executada

1. O objeto **Escudo cumpre Reparavel**, condição verificada pelo `instanceof` antes do cast.
2. Executa **Escudo.repararCom(...)**, por despacho dinâmico.
3. Retorno **true**; escudo **50/80**; madeira **1**.
4. **Não.** `descrever()` pertence a `Item`; a referência declarada `Reparavel` não oferece essa operação diretamente.

---

<!-- _class: activity -->

<div class="chapter">Individual 4 — duas versões defeituosas, analisadas separadamente</div>

## Que cenário revela cada defeito?

**A:** a bigorna cria uma `Espada(40)` e repara essa nova espada, ignorando o item recebido.

**B:** o equipamento consome uma unidade antes de conferir o material. Se incompatível, devolve `false` sem aumentar a durabilidade.

Para cada defeito, escolha um cenário: informe estado inicial, ação e resultado esperado na solução correta, incluindo saldo. Que observação revelaria a falha?

---

<div class="chapter">Individual 4 — uma escolha possível para cada versão</div>

## Observar o item fornecido e o material restante

| Versão | Inicial; ação: tentar reparar | Esperado na solução correta | O que revela a falha |
| --- | --- | --- | --- |
| A | espada original `40/100`; ferro `2` | `true`; original `65/100`; ferro `1` | a original continua em `40/100` |
| B | espada `40/100`; madeira `2` | `false`; espada `40/100`; madeira `2` | a madeira termina em `1` |

Em A, conferir só o retorno esconde o colaborador ignorado. Em B, conferir só a durabilidade esconde o consumo indevido.

---

<!-- _class: synthesis -->

<div class="chapter">Do inventário à colaboração verificada</div>

## Contratos mostram o que podemos solicitar

O **tipo declarado** determina as chamadas permitidas na compilação.

O **cast** permite outro uso compatível da referência, preservando o objeto. `instanceof` verifica a compatibilidade antes da conversão.

O **objeto alcançado** determina a implementação executada. Contratos distintos expressam capacidades distintas.

Delegar e verificar exige observar **o colaborador recebido**, o resultado e os estados envolvidos.

---

<!-- _class: activity -->

<div class="chapter">Aprofundamento opcional — reatribuição após a seleção</div>

## A variável local substitui o item na lista?

Inventário novo: apenas uma `Espada(40)`, na posição `0`.

```java
Item selecionado = inventario.obter(0);
selecionado = new Escudo(30);
PilhaMaterial madeira = new PilhaMaterial("madeira", 2);
new Bigorna().tentarReparar(selecionado, madeira);
inventario.listar();
System.out.println(selecionado.descrever());
```

Quais são as duas linhas impressas? O escudo substituiu a espada no inventário?

<!-- Apêndice elástico previsto no roteiro. Encerrar no slide anterior se
não houver tempo; esse aprofundamento não condiciona a atividade individual. -->

---

<div class="chapter">Aprofundamento opcional — conferir a reatribuição local</div>

## A lista conserva a referência para a espada

```text
Espada de ferro: 40/100
Escudo: 50/80
```

A reatribuição muda somente `selecionado`. O escudo não substitui a espada na lista.

A bigorna recebe e repara o escudo recém-criado. O inventário continua apresentando a espada, sem alteração.
