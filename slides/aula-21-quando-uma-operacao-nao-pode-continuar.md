---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 21 — Quando uma operação não pode continuar

<div class="statement">Comunicar a falha, investigar a causa</div>

Exceções a partir dos contratos do Megamania

<!-- Roteiro canônico: docs/aulas/aula-21-quando-uma-operacao-nao-pode-continuar.md.
Referência de 90 minutos: contratos 15; fluxo 20; diagnóstico 30; JUnit 15;
transferência 10. Dar tempo real de elaboração individual antes de coletar
hipóteses. As respostas estão sempre no frame imediatamente após a atividade.
Lista não modificável versus objetos mutáveis e ordem das validações são
aprofundamentos elásticos; podem ser abreviados sem retirar os cinco tipos.
Não transformar cada falha em um catch no ciclo do jogo. -->

---

<div class="chapter">Da Aula 20 à proteção dos contratos</div>

## Nem toda solicitação produz um efeito

Na Aula 20, seguimos **movimento → disparo → impacto**.

Agora vamos investigar três situações:

- A nave recebe outro pedido de disparo durante a recarga.
- A partida recebe uma direção inválida.
- O código tenta usar uma referência sem objeto.

Como comunicar cada situação e localizar sua causa?

---

<!-- _class: activity -->

## Duas tentativas, dois resultados

Considere cada experimento separadamente.

```java
// A: sem transcorrer tempo entre os disparos
Nave nave = new Nave();
nave.tentarDisparar();
Projetil segundo = nave.tentarDisparar();
System.out.println(segundo == null);
```

```java
// B
Partida partida = new Partida(null);
System.out.println("Partida criada");
```

O que acontece em A e em B? O que explica a diferença?

<!-- Recuperar o contrato de tentarDisparar, já apresentado na Aula 20.
Não antecipar a exceção do construtor antes das hipóteses. -->

---

## A recarga e o colaborador ausente

| Experimento | Resultado | Motivo |
| --- | --- | --- |
| A | Imprime `true`. | O segundo disparo é recusado: retorna `null`. |
| B | Lança `IllegalArgumentException`. | A partida exige um movimento. |

Em B, a atribuição não se completa e **Partida criada** não é impressa.

A recarga é prevista na tentativa. O construtor exige um colaborador válido.

---

<div class="chapter">Ler a decisão no objeto responsável</div>

## A nave comunica uma tentativa recusada

```java
public Projetil tentarDisparar() {
    if (!estaVivo() || esperaDisparo > 0) {
        return null;
    }

    esperaDisparo = 0.22;
    return new Projetil(
            getCentroX() - 3, getY() + getAltura(), true);
}
```

O cliente precisa considerar a possibilidade de não receber um projétil.

---

## A partida rejeita uma chamada inválida

Recorte do construtor de `Partida`:

```java
public Partida(MovimentoFormacao movimento) {
    if (movimento == null) {
        throw new IllegalArgumentException(
                "A partida precisa de um movimento.");
    }

    this.movimento = movimento;
    // Continua a criação dos inimigos.
}
```

Sem movimento, a construção não termina normalmente.

---

<!-- _class: concept-key -->

## A falha também faz parte do contrato

Uma operação precisa comunicar o resultado aceito e as situações
em que não pode realizá-lo.

**Retorno normal e exceção são caminhos diferentes.**

A escolha depende do contrato: nem todo disparo recusado ou impacto
sem acerto exige uma exceção.

---

<!-- _class: java-focus -->

## O que significa `throw`?

```java
throw new IllegalArgumentException(
        "A partida precisa de um movimento.");
```

- `new` cria o objeto de exceção com uma mensagem.
- `throw` lança esse objeto e interrompe o fluxo normal.
- Sem tratamento no método, a exceção se propaga ao chamador.

Não é um retorno com valor especial.

---

<div class="chapter">Da operação ao chamador</div>

## Quem pode receber a exceção?

Neste programa de diagnóstico, uma chamada passa por três métodos:

<div class="sequence"><span>main</span><span>criarPartida</span><span>construtor de Partida</span></div>

```java
private static Partida criarPartida(
        MovimentoFormacao movimento) {
    return new Partida(movimento);
}
```

O programa é uma experiência didática, fora do ciclo gráfico do jogo.

---

<!-- _class: activity -->

## Até onde a execução chega?

No `main` do programa de diagnóstico:

```java
System.out.println("Antes");
try {
    criarPartida(null);
    System.out.println("Criada");
} catch (IllegalArgumentException erro) {
    System.out.println("Recusada: " + erro.getMessage());
}
System.out.println("Depois");
```

Qual é a saída? Por quais chamadas a exceção passa até ser capturada?

---

## A captura muda o caminho da execução

```text
Antes
Recusada: A partida precisa de um movimento.
Depois
```

1. O construtor lança a exceção.
2. `criarPartida` não captura: seu retorno normal não se completa.
3. O `catch` de `main` recebe a exceção e imprime a mensagem.
4. A execução continua depois do `try/catch`.

**Criada** foi pulado; a construção não é repetida.

---

<!-- _class: java-focus -->

## Ler o `try/catch`

```java
try {
    criarPartida(null);
} catch (IllegalArgumentException erro) {
    System.out.println(erro.getMessage());
}
```

- `try`: delimita as instruções protegidas por esse tratamento.
- `catch`: recebe o tipo indicado ou um subtipo; `erro` é a referência.
- Sem exceção, o `catch` é pulado.
- Tipo incompatível com esse `catch`: a exceção continua se propagando.

---

## Quem tem condições de tratar?

O diagnóstico captura para **informar a recusa de uma experiência**.

Uma entrada de configuração pode rejeitar dados e pedir sua correção,
se essa interação estiver prevista.

Uma direção inválida produzida pelo código do jogo exige investigar
o cálculo ou a tradução de entrada.

O mesmo dado inválido no próximo quadro produzirá o mesmo problema.

---

<!-- _class: trap -->

## Capturar não conserta a causa

```java
try {
    // Atualizar o jogo.
} catch (Exception erro) {
    // Ignorar e continuar?
}
```

Isso pode esconder falhas diferentes e deixar o defeito se repetir.

Uma captura precisa de uma **resposta definida e segura**.

---

<div class="chapter">Investigar antes de modificar</div>

## Sem captura, o console mostra o percurso

Mesmo diagnóstico, agora sem `try/catch` — rastreamento abreviado:

```text
java.lang.IllegalArgumentException:
    A partida precisa de um movimento.
    at ...Partida.<init>(Partida.java:31)
    at Diagnostico.criarPartida(Diagnostico.java:18)
    at Diagnostico.main(Diagnostico.java:9)
```

**Tipo + mensagem + chamadas:** o *stack trace* orienta a investigação.

`<init>` identifica um construtor. Números de linha são ilustrativos.

---

## O ponto que detecta pode estar correto

1. Leia o tipo e a mensagem.
2. Localize a validação em `Partida`.
3. Siga os chamadores: de onde veio o `null`?
4. Corrija a obtenção do movimento e execute novamente.

Remover a validação permitiria construir uma partida sem o colaborador
de que ela precisa.

Sem tratador compatível, a thread termina; normalmente o diagnóstico
é exibido no console.

---

<!-- _class: activity -->

## O problema agora está no cliente da nave

Novo experimento, sem transcorrer tempo entre chamadas:

```java
Nave nave = new Nave();
nave.tentarDisparar();
Projetil novo = nave.tentarDisparar();
System.out.println(novo.getY());
```

Qual instrução falha? Como respeitar o contrato de `tentarDisparar`?

---

## `NullPointerException`: falta o objeto

A segunda tentativa devolve `null`; `novo.getY()` falha.

O cliente deve considerar a ausência prevista:

```java
if (novo != null) {
    System.out.println(novo.getY());
}
```

Guardar ou comparar `null` é permitido. Chamar um método de instância
por essa referência exige um objeto.

---

## Investigar a origem da referência

No disparo, `null` faz parte do contrato da tentativa.

Em outra colaboração, pode revelar inicialização esquecida
ou uma dependência ausente.

Uma verificação de `null` só ajuda se estiver ligada ao significado
da ausência naquela operação.

Não precisamos de um `catch` para usar corretamente o retorno do disparo.

---

<div class="chapter">Referência de contrato e objeto concreto</div>

## Cumprir `Alvo` não torna todo alvo uma nave

```java
Alvo alvo = new Inimigo(100, 200);
Nave nave = (Nave) alvo;
System.out.println(nave.getVidas());
```

O código compila, mas o cast lança **`ClassCastException`**.

O objeto alcançado é um `Inimigo`. O cast não o transforma em `Nave`
nem cria um novo objeto.

---

## Qual operação você precisa solicitar?

Para aplicar impacto, o contrato já oferece:

```java
alvo.receberImpacto();
```

Para uma consulta específica da nave, verifique antes de converter:

```java
if (alvo instanceof Nave) {
    Nave nave = (Nave) alvo;
    System.out.println(nave.getVidas());
}
```

Com o inimigo do exemplo, o corpo do `if` não executa.

---

<!-- _class: activity -->

## A lista tem 18 inimigos

Uma partida recém-criada executa:

```java
Partida partida = new Partida();
int quantidade = partida.getInimigos().size();
Inimigo ultimo = partida.getInimigos().get(quantidade);
```

Por que esse acesso falha? Subtrair `1` sempre resolve?

---

## `IndexOutOfBoundsException`: a posição não existe

| Lista | Posições válidas | Último índice |
| --- | --- | --- |
| 18 elementos | `0` a `17` | `17` |
| Vazia | Nenhuma | Não existe |

O exemplo tenta acessar o índice `18` e falha.

`quantidade - 1` resolve para a lista de 18 elementos; na vazia, seria `-1`.

Considere a lista vazia antes da consulta. Para percorrer todos os objetos,
o `for` aprimorado evita administrar índices.

---

<div class="chapter">Consulta não é permissão para alterar</div>

## A partida protege a estrutura da coleção

```java
public List<Inimigo> getInimigos() {
    return Collections.unmodifiableList(inimigos);
}
```

O cliente pode consultar e percorrer. Esta tentativa lança
**`UnsupportedOperationException`**:

```java
Partida partida = new Partida();
partida.getInimigos().clear();
```

Uma necessidade de remoção pede uma operação de domínio com regras definidas.

---

## O que essa proteção garante?

**A visão não permite alterar a estrutura da lista.**

- Não é uma cópia congelada: mudanças internas da lista aparecem na visão.
- Não torna cada inimigo imutável: seus métodos públicos continuam disponíveis.

A partida administra a coleção; os participantes ainda têm estado
e comportamento próprios.

<!-- Aprofundamento elástico: retomar a diferença entre coleção e objetos.
Não abrir implementação do wrapper nem uma discussão de concorrência. -->

---

## Do tipo da exceção à investigação

| Exceção | O que procurar |
| --- | --- |
| `IllegalArgumentException` | Um argumento rejeitado pelo contrato. |
| `NullPointerException` | Uma referência sem objeto no ponto de uso. |
| `ClassCastException` | Um cast incompatível com o objeto. |
| `IndexOutOfBoundsException` | Uma posição fora dos limites. |
| `UnsupportedOperationException` | Uma operação não oferecida ali. |

As cinco pertencem à família de `RuntimeException`: não exigem captura
ou declaração com `throws` para compilar.

---

<!-- _class: activity -->

## O ponto da falha e a origem

Um projétil **ativo** recebe `tiro.tentarAtingir(null)`.
O método começa com:

```java
if (!ativo || !alvo.estaVivo() || !alvo.colideCom(this)) {
    return false;
}
```

1. Qual exceção ocorre e em qual expressão?
2. O método devolve `false`?
3. O que investigar no chamador?

---

## A exceção interrompe a condição

1. **`NullPointerException`** em `alvo.estaVivo()`.
   O projétil está ativo, então a avaliação passa da primeira condição.
2. **Não retorna `false`.** A avaliação é interrompida antes do retorno.
3. Procure por que o chamador solicitou impacto **sem um objeto alvo**.

Se a seleção pode não encontrar alvo, o cliente pode deixar de solicitar
o impacto nessa situação.

Capturar e devolver `false` sem definir esse contrato esconderia a origem.

---

<div class="chapter">Além da exceção: o estado preservado</div>

## A direção inválida chega à partida

Início de `Partida.atualizar`, antes de atualizar participantes:

```java
if (!Double.isFinite(segundos)
        || segundos < 0
        || segundos > 1.0 / 30 + 0.000001
        || direcao < -1
        || direcao > 1) {
    throw new IllegalArgumentException(
            "Use passos de até 1/30 s e direção entre -1 e 1.");
}
```

`0.01` segundo é aceito. Direção `2` é inválida: deve ser `-1`, `0` ou `1`.

---

## A base também protege a construção

`Double.isFinite` rejeita `NaN` e infinitos.

```java
new Inimigo(Double.NaN, 200);
```

O construtor de `Inimigo` chama o de `Corpo`.
`Corpo` rejeita a posição com `IllegalArgumentException`
antes de atribuir as coordenadas.

A base exige posições finitas e dimensões finitas e positivas.
Essa proteção vale para os participantes que a estendem.

---

## Como verificar que a chamada foi rejeitada?

`PartidaTest.argumentosInvalidosSaoRecusados` já verifica argumentos inválidos.

Vamos observar também uma propriedade do estado: **a posição da nave**.

```java
Partida partida = new Partida();
double xAntes = partida.getNave().getX();

assertThrows(IllegalArgumentException.class,
        () -> partida.atualizar(0.01, 2, false));

assertEquals(xAntes, partida.getNave().getX());
```

Experimento com JUnit, sem abrir a janela.

---

<!-- _class: java-focus -->

## Esperar a exceção com `assertThrows`

```java
assertThrows(IllegalArgumentException.class,
        () -> partida.atualizar(0.01, 2, false));
```

- `Tipo.class` identifica o tipo esperado.
- `() -> ...` fornece a ação para o JUnit executar dentro da verificação.
- Passa se a ação lançar o tipo esperado ou um subtipo.
- Falha se não houver exceção ou se o tipo for incompatível.

Usar o import estático de `org.junit.jupiter.api.Assertions.assertThrows`.

---

## Por que a comparação seguinte é alcançada?

O JUnit captura a exceção esperada e continua o teste:

```java
assertEquals(xAntes, partida.getNave().getX());
```

Se chamássemos `atualizar(0.01, 2, false)` diretamente,
a exceção escaparia e o teste falharia antes dessa comparação.

Esperar a exceção verifica uma comunicação.
Observar a posição verifica uma propriedade do estado.

---

<!-- _class: trap -->

## Exceção não desfaz alterações

`throw` e `catch` **não restauram campos automaticamente**.

No método atual, a nave não se move porque a validação vem antes
da atualização dos participantes.

Se o método alterasse campos antes de lançar a exceção,
essas alterações poderiam permanecer.

---

<!-- _class: activity -->

## A ordem das condições faz diferença

Após validar argumentos, `Partida.atualizar` executa:

```java
if (estado != Estado.JOGANDO || segundos == 0) {
    return;
}
```

Em uma partida recém-criada, o que acontece com esta chamada?

```java
partida.atualizar(0, 2, false);
```

O tempo zero permite ignorar a direção inválida?

<!-- Aprofundamento elástico. Se abreviado, manter a armadilha anterior
e preservar os 10 minutos de transferência. -->

---

## A validação vem primeiro

`partida.atualizar(0, 2, false)` lança **`IllegalArgumentException`**.

1. A direção `2` é rejeitada na validação inicial.
2. O retorno por tempo zero não é alcançado.
3. A atualização dos participantes também não é alcançada.

O resultado depende da ordem real das verificações.

---

<!-- _class: activity -->

## Agora, uma operação do seu jogo

Escolha uma operação existente do modelo.

1. Qual recusa é prevista e quais condições tornam a chamada válida?
2. Como o contrato comunica o resultado e como o cliente reage?
3. Que cenário verifica a recusa e o estado preservado?

**IA Nível 3 — Colaborador**, como no Projeto 3.
Você precisa compreender, verificar e conseguir modificar o código incorporado.

Não é necessário acrescentar uma exceção se não houver uma necessidade real.

<!-- Reservar tempo de elaboração, depois coletar hipóteses da turma.
Sem nova entrega, relatório ou mecânica obrigatória. -->

---

## Uma análise possível: energia

| Operação e contrato possível | Comunicação e reação | Verificação |
| --- | --- | --- |
| `tentarAtacar()` sem energia | Retorna `false`; cliente não cria ataque. | Retorno e energia preservada. |
| `gastarEnergia(-1)`, exigindo quantidade positiva | Lança `IllegalArgumentException`; corrigir a chamada. | Exceção e energia preservada. |

As regras são exemplos. Seu jogo pode ter outro domínio e outro contrato.

O critério é ligar **regra → comunicação → reação → verificação**.

---

<!-- _class: synthesis -->

## Comunicar, localizar e verificar

- O contrato distingue recusa prevista de chamada inválida.
- A exceção interrompe o fluxo normal e pode se propagar.
- Tipo, mensagem e chamadas ajudam a localizar a causa.
- Capturar exige uma resposta definida; não corrige nem desfaz alterações.
- Verifique a comunicação da falha e o estado relevante.

O roteiro da Aula 21 mantém os exemplos completos e as respostas de estudo.
