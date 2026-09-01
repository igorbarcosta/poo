# Lesson design: Colaboração entre objetos

Artifact identity: `lesson-design-poo-aula-06-colaboracao-entre-objetos`

## Audience and prerequisites

Estudantes da disciplina de Programação Orientada a Objetos, trabalhando em
Java e no Projeto 1. A aula parte do estado alcançado na Aula 05 e no
Laboratório 05: `ItemPedido` nasce com descrição, preço unitário e quantidade,
protege seu estado inicial e ainda concentra informações que descrevem o
produto.

O estudante já conhece objetos, referências, identidade, campos, métodos,
encapsulamento, construtores, parâmetros, `this` e invariantes numéricas
simples.

## Learning intent

Ao final do estudo, o estudante deve ser capaz de:

- reconhecer quando um objeto precisa colaborar com outro para cumprir sua
  responsabilidade;
- explicar como um campo pode manter uma referência para outro objeto;
- distribuir entre `Produto` e `ItemPedido` os estados e comportamentos que
  cabem a cada um;
- explicar por que passar um objeto como argumento não cria automaticamente
  uma cópia; e
- ler uma colaboração simples em que um objeto solicita uma informação a
  outro.

## Organizing problem

Quando uma operação depende de informações que pertencem a objetos diferentes,
quem deve fazer o quê? A trajetória parte da repetição de descrição e preço em
itens do mesmo produto, separa as responsabilidades de `Produto` e
`ItemPedido`, torna necessária uma referência entre os objetos e acompanha a
colaboração usada para calcular o subtotal.

Nesta versão do Projeto 1, o item ainda não representa uma compra fechada: o
subtotal acompanha o preço atual mantido no catálogo. Essa decisão torna a
resposta sobre a localização do preço determinada sem apresentá-la como regra
universal de modelagem.

## Scope

### Included

- duplicação de informações do produto em itens diferentes;
- distribuição de descrição e preço para `Produto` e de quantidade para
  `ItemPedido`;
- campo e parâmetro cujo tipo é outra classe;
- referência de `ItemPedido` para um `Produto` existente;
- colaboração em `calcularSubtotal()`, na qual o item solicita o preço ao
  produto e combina essa informação com sua quantidade;
- passagem de um objeto como argumento sem criação ou cópia automática;
- retomada de referências, identidade e expressões `new` somente na medida
  necessária para compreender a colaboração; e
- transferência curta para `Quarto` e `Reserva` sem implementação completa.

### Excluded

- ausência de produto associado, `null` e políticas para tratar essa situação;
- preservação de preço histórico em uma compra fechada;
- cópia de objetos;
- coleções, arrays e gerenciamento de vários itens por `Pedido`;
- associação e composição como taxonomia formal;
- implementação completa de `Quarto`, `Reserva` ou `Pedido`; e
- contratos, interfaces e polimorfismo.

## Activities or checks

As atividades são verificações formativas autoguiadas. O estudante distribui
informações entre `Produto` e `ItemPedido`, explica o fluxo do subtotal, prevê
quantidade de objetos e referências e transfere a distribuição de
responsabilidades para `Quarto` e `Reserva`. Cada atividade possui contexto e
continuidade suficientes na página para ser realizada sem fala do professor ou
entrega escrita.

No deck presencial, essas mesmas pausas podem receber tempo de elaboração,
coleta de hipóteses e formalização coletiva. Essa condução pertence à
apresentação e não à página autoguiada.

## Relationship to adjacent material

A aula dá continuidade à Aula 05 e ao Laboratório 05 ao decompor o estado que
antes estava concentrado em `ItemPedido`. Ela deixa aberta a necessidade de um
`Pedido` manter e coordenar vários itens, sem antecipar a coleção ou definir um
Laboratório 06 ainda inexistente.

## POO consumer constraints

- O conteúdo pedagógico permanece em português; Java apoia o eixo de
  responsabilidades e colaboração.
- A página é material permanente e autoguiado. Instruções de condução, ritmo
  presencial, discussão coletiva e notas ao professor pertencem ao deck.
- A aula integra o piloto de três blocos didáticos da oferta 2026.2. As
  estimativas de 20–35 minutos são heurísticas internas para um encontro de 90
  minutos, não cronograma público.
- O deck deve preservar a causalidade problema → distribuição de
  responsabilidades → referência entre objetos → colaboração → retomada de
  identidade, sem converter a página mecanicamente em slides.
- Os diagramas distinguem variáveis, campos, referências e objetos. `String`
  aparece como valor conceitual do domínio, embora seja um tipo de referência
  em Java.

## Unresolved decisions

- O requisito concreto e a estrutura do Laboratório 06 ainda não foram
  definidos; a aula apenas preserva a tensão sobre vários itens.
- A política de preço histórico permanece fora do escopo desta etapa.
