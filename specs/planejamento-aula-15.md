# Planejamento da Aula 15 — Polimorfismo: a mesma mensagem, comportamentos diferentes

Este documento registra o desenho pedagógico aprovado pelo professor para a
Aula 15. É um planejamento docente para orientar a autoria posterior do roteiro
e do deck.

## Contexto e decisão de escopo

- Unidade 02 — Colaboração, Contratos e Polimorfismo.
- A Aula 14 foi avaliada pelo professor como uma boa aula. A turma ainda apresenta
  dificuldades naturais do primeiro contato com o tema.
- A Aula 14 estabeleceu o contrato e a possibilidade de diferentes classes
  ocuparem o mesmo papel. A Aula 15 deve avançar com situações, previsões e
  armadilhas que permitam explicar a execução e definir polimorfismo.
- Manter todas as situações propostas e a transferência final, sem reduzir as
  anteriores para acomodar a transferência.
- O professor controla o tempo. Não estabelecer divisão de minutos nem tratar
  parte deste conteúdo como opcional por motivo de duração.

## Pergunta central e aprendizagem esperada

**Como Java decide qual implementação executar quando a chamada é feita por uma
referência de interface?**

Ao final, o estudante deve conseguir:

- determinar se uma chamada compila considerando o tipo declarado da referência;
- identificar o objeto que recebe uma chamada e a implementação executada;
- distinguir reatribuição de referência, identidade e mudança de estado;
- explicar polimorfismo e despacho dinâmico a partir das situações observadas;
- avaliar a necessidade de identificar classes concretas dentro do cliente; e
- transferir o raciocínio para outro domínio e incorporar uma nova implementação.

## Trajetória com entregas

Preservar `Pedido` e as entregas como contexto conhecido. As regras de custo
continuam sendo `10.0` para `EntregaNormal` e `25.0` para `EntregaExpressa`.
O primeiro fechamento válido conserva a entrega. As consultas ao custo ocorrem
depois de um fechamento válido quando feitas por meio do pedido.

As armadilhas devem nascer de previsões plausíveis antes da explicação. Não
apresentar uma lista de erros já resolvidos como substituto da investigação.

### Situação 1 — A variável tem o mesmo tipo; por que os resultados mudam?

```java
Entrega entrega = new EntregaNormal();
System.out.println(entrega.calcularCusto(pedido));

entrega = new EntregaExpressa();
System.out.println(entrega.calcularCusto(pedido));
```

Fornecer o contexto e a criação de `pedido` no roteiro. A turma prevê `10.0` e
`25.0`, identifica o que permaneceu igual e explica qual objeto recebe cada
chamada. O parâmetro `pedido` não altera essas regras fixas.

**Armadilha:** imaginar que o tipo declarado `Entrega` determina uma única
implementação. A chamada e o tipo declarado permanecem; o objeto alcançado muda.

### Situação 2 — Trocar uma referência também troca as outras?

```java
Entrega primeira = new EntregaNormal();
Entrega segunda = primeira;

primeira = new EntregaExpressa();

System.out.println(primeira.calcularCusto(pedido));
System.out.println(segunda.calcularCusto(pedido));
```

Os resultados são `25.0` e `10.0`. Usar um desenho das referências antes e depois
da reatribuição para sustentar a explicação.

**Armadilhas:** imaginar que o objeto normal se tornou expresso ou que `segunda`
acompanha automaticamente as atribuições a `primeira`.

### Formalização após as observações

Polimorfismo permite usar objetos de classes diferentes por um mesmo tipo e
solicitar a mesma operação, cuja implementação é escolhida conforme o objeto
que recebe a chamada.

Introduzir **despacho dinâmico** como a escolha da implementação durante a
execução. A formalização deve recuperar as previsões anteriores e distinguir
o tipo declarado da referência da classe do objeto.

### Situação 3 — Se o objeto possui o método, por que a chamada não compila?

Retomar a operação pública específica `priorizarNaFila()` de `EntregaExpressa`,
que não pertence ao contrato `Entrega`:

```java
Entrega entrega = new EntregaExpressa();

entrega.calcularCusto(pedido); // compila
entrega.priorizarNaFila();    // não compila
```

Tratar a chamada inválida como análise de compilação, separada de exemplos
executáveis. Contrastar com uma referência declarada como `EntregaExpressa`.

**Armadilha:** concluir que o despacho dinâmico permite chamar qualquer método
existente no objeto. O compilador verifica as chamadas pelo tipo declarado;
na chamada válida ao método de instância, o objeto determina a implementação.

### Situação 4 — Se a variável mudou, o pedido também mudou?

```java
Entrega entrega = new EntregaNormal();
Pedido pedido = new Pedido();
pedido.fechar(entrega);

entrega = new EntregaExpressa();

System.out.println(pedido.calcularCustoEntrega());
```

O resultado permanece `10.0`. O pedido guardou uma referência para a entrega
normal; a reatribuição posterior mudou somente a variável local.

Investigar também a tentativa de um segundo fechamento com entrega expressa.
A guarda de `Pedido` preserva a escolha inicial e o custo continua `10.0`.

**Armadilhas:** confundir a variável local com o campo do pedido ou atribuir ao
polimorfismo a capacidade de contornar as regras de estado.

### Avaliar a colaboração e seu impacto

Acompanhar a chamada de `Pedido` até o objeto de entrega e comparar a solução
pelo contrato com uma proposta em que `Pedido` identifica cada modalidade por
condicionais. Investigar o impacto de acrescentar outra implementação: quem
conhece a nova regra, onde o objeto é criado e por que o cliente pode continuar
solicitando a mesma operação.

## Transferência final — Efeitos sobre um personagem de jogo

O jogo é um exercício de transferência da aula, sem definir o domínio do
Projeto 3. A mudança de domínio deve exigir acompanhar efeitos sobre estado,
além de prever valores devolvidos por métodos.

### Contexto fornecido

- Um personagem começa com 50 pontos de vida.
- `Pocao` solicita ao personagem recuperar 20 pontos.
- `Armadilha` solicita ao personagem perder 10 pontos.
- O personagem controla seus pontos de vida e oferece as operações de recuperação
  e perda. Os cenários usam os valores indicados; não acrescentar regras de
  limites, morte ou falhas de uso ao exercício.
- As classes de efeito cumprem `Efeito`, que exige
  `void aplicarEm(Personagem personagem)`.

O personagem recebe um efeito desta forma:

```java
public void receber(Efeito efeito) {
    efeito.aplicarEm(this);
}
```

### Movimento 1 — Prever e explicar

O mesmo personagem recebe uma poção e depois uma armadilha. Solicitar a previsão
dos estados, `70` e `60`, e o desenho do caminho das chamadas: quem recebe
`receber(...)`, quem recebe `aplicarEm(...)` e quem altera a vida.

O estudante deve distinguir o objeto que executa o efeito daquele cujo estado
muda. Explicitar que cada chamada de `receber(...)` usa o argumento recebido;
esse método não guarda o efeito como o fechamento de `Pedido` guarda a entrega.

### Movimento 2 — Diagnosticar uma proposta

Analisar a sugestão: “Dentro de `receber`, precisamos descobrir se o efeito é
poção ou armadilha para escolher o que fazer.”

A turma deve avaliar a necessidade dessa decisão e explicar como a chamada pelo
contrato chega à implementação correspondente. A comparação não exige ensinar
mecanismos de inspeção de tipo ou conversões de referências.

### Movimento 3 — Evoluir sem receber a solução pronta

Introduzir `FonteDeCura`, que recupera 5 pontos. Pedir que os estudantes indiquem
o contrato que ela deve cumprir, sua responsabilidade e os pontos que precisam
mudar para criá-la e usá-la.

Partindo dos 60 pontos anteriores, o personagem termina com `65`.
`Personagem` e `Efeito` permanecem iguais; a nova implementação e o código que
a cria e utiliza incorporam a variação.

### Fechamento e evidência de compreensão

Retomar a pergunta: **o que faz o mesmo código de `receber(...)` produzir efeitos
diferentes sem perguntar qual é a classe do objeto?**

Em uma leitura final, o estudante deve justificar:

1. se a chamada compila;
2. qual objeto recebe a chamada;
3. qual implementação executa; e
4. qual estado muda como consequência.

## Laboratório 15 — A mesma chamada, vários canais

O professor escolheu evoluir o Projeto 2 com envio por uma sequência de canais,
contando cada envio e preservando o canal inicial. A prática parte do
Laboratório 14 e acrescenta `avisarPorTodos(List<Notificador>)` a `Lembrete`.

- Percorrer a sequência na ordem fornecida, solicitando o envio por contrato.
- Somar um aviso por posição percorrida, inclusive quando uma referência se
  repete; lista vazia não envia nem altera o contador.
- Preservar `avisar()`, `avisarPor(Notificador)`, as saídas existentes e o canal
  recebido na criação. O método usa a lista naquela chamada, sem alterá-la.
- Integrar a operação ao cenário de `Main` e ampliar os testes JUnit existentes.
- Manter IA no Nível 1 e entrega somente dos arquivos Java, como no par anterior.

A aula prepara a prática retomando `List`, `ArrayList`, `add` e o laço por
elementos, agora com referências declaradas pelo contrato `Entrega`. O percurso
compara custos e não altera a regra de uma única entrega por pedido.

| Exigência da prática | Preparação conceitual e técnica |
| --- | --- |
| Lista de notificadores e percurso em ordem | Aula 15: lista de entregas pelo contrato; mecanismos de coleção da Aula 07 |
| Uma implementação por objeto atual | Aula 15: duas chamadas, definição e despacho dinâmico |
| Preservar o canal inicial | Aula 15: variável local versus campo; Laboratório 14: contrato atual de `Lembrete` |
| Contagem, lista vazia e referências repetidas | Aula 15: percurso vazio e chamadas por posição; Laboratórios 13–14: contador e expectativas JUnit |
| Suíte de regressão | Aula 15: exemplo JUnit sobre referências; Aula 13 e Laboratório 13: montagem e execução dos testes |

## Limites da decisão atual

A transferência do jogo pertence à aula e não substitui o Projeto 2 — Sistema
de lembretes e notificações. A prática não se limita a acrescentar outro canal.

Não há decisão de introduzir herança, sobrecarga, casts ou inspeção de tipos
nesta aula. A autoria deve seguir os padrões existentes para narrativa,
respostas imediatas e expansíveis, diagramas e slides.
