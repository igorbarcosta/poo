# Desenho da Aula 09 — Fechamento do pedido

## Ponto de partida

A aula parte da Versão 8 do Projeto 1, concluída no Laboratório 08. `Pedido`
mantém uma lista privada de `ItemPedido`, recebe um `Produto` e uma quantidade em
`adicionarItem(Produto, int)`, cria o item dentro dessa operação e calcula o
total solicitando o subtotal de cada item. `ItemPedido` consulta o preço em
`Produto` para calcular seu subtotal.

Os estudantes já trabalharam estado, encapsulamento, construtores, invariantes
simples, identidade, referências, colaboração, composição e coleções. A Aula 08
explicou por que `Pedido` mantém a estrutura de itens e deixou aberta a evolução
de suas regras.

## Requisito que organiza a aula

> Depois que um pedido é fechado, não podem ser adicionados novos itens.

A pergunta central é: **como evoluir `Pedido` para proteger essa regra sem
deslocar ou refazer as responsabilidades que já funcionam?**

O requisito trata da inclusão de novos itens. Não estabelece, por si só, uma
regra geral de imutabilidade do pedido, de preço histórico ou de alteração de
quantidade dos itens existentes. A formulação a recuperar durante a aula é:
**depois do fechamento, `adicionarItem` não acrescenta um item à coleção**.

## Aprendizagem esperada

Ao final, o estudante deve ser capaz de:

- identificar que aberto ou fechado é estado de cada objeto `Pedido`;
- justificar por que `Pedido` controla o fechamento e decide se aceita uma
  inclusão;
- explicar como o campo privado e as operações públicas protegem a regra;
- prever o efeito de adicionar antes e depois do fechamento;
- localizar o impacto da mudança em `Pedido` e no cenário cliente, preservando
  as responsabilidades de `ItemPedido` e `Produto`;
- explicar por que `calcularTotal()` continua delegando os subtotais; e
- distinguir o requisito dado de outras regras plausíveis, ainda não definidas.

## Trajetória narrativa e dimensionamento

O núcleo ocupa aproximadamente 90 minutos, com três blocos didáticos. As
estimativas orientam a condução e não devem aparecer como cronograma na página
do estudante.

### 9.1 — O modelo atual não distingue um pedido fechado (25–30 min)

Recuperar a interface da Versão 8 e apresentar uma sequência concreta: adicionar
teclado em duas unidades, fechar o pedido e tentar adicionar um mouse. A
sequência desejada inclui `pedido.fechar()`, operação que o modelo ainda não
possui. Antes de propor código, pedir que o estudante preveja quais inclusões
devem acontecer e qual total deverá resultar.

Com teclado a `150.0` e mouse a `80.0`, o pedido deve totalizar `300.0` depois
da tentativa de inclusão posterior ao fechamento. Sem uma proteção em
`adicionarItem`, a inclusão do mouse elevaria o total a `380.0`: o contraste
torna visível a regra ausente. Nenhuma etapa exige calcular o total antes de
fechar.

O fechamento cria uma necessidade de estado no próprio `Pedido`. O próximo
bloco investiga quem deve controlar esse estado e a operação de inclusão.

### 9.2 — Quem protege a inclusão? (30–35 min)

Comparar a verificação feita por cada cliente com a verificação dentro de
`Pedido`. Também confrontar a hipótese de atribuir a decisão a `ItemPedido`.
`Pedido` conhece seu estado e mantém a coleção; todos os clientes passam por
`adicionarItem`, portanto é nele que a regra deve ser protegida.

O desenho mínimo para estudo usa um campo privado `boolean fechado`, um pedido
que nasce aberto e uma operação `fechar()`. A proteção de `adicionarItem` deve
ser avaliada **antes** da criação do novo `ItemPedido`, para que uma tentativa
recusada não produza sequer um item descartado. O código externo solicita o
fechamento; não escreve diretamente em `fechado` nem recebe a lista interna.

Nesta etapa, `adicionarItem(Produto, int)` mantém seu retorno `void`. Uma
tentativa recusada preserva a coleção, como nas primeiras regras de validação
do projeto. Comunicar a recusa ao cliente é uma decisão de contrato separada e
somente deve ser introduzida se houver necessidade concreta para ela.

A regra pode ser formalizada como uma restrição às transições permitidas:
**depois que `fechado` se torna verdadeiro, `adicionarItem` não aumenta o
conjunto de itens**. Essa formulação recupera a ideia de invariante sem afirmar
que todas as propriedades do pedido se tornam imutáveis.

### 9.3 — O que a mudança afeta? (25–30 min)

Retomar a sequência com dois pedidos. O primeiro recebe o teclado, é fechado e
recusa a inclusão do mouse, permanecendo com total `300.0`. O segundo continua
aberto e aceita um item de mouse, totalizando `80.0`. A comparação verifica que
o estado de fechamento pertence a cada instância de `Pedido`.

Analisar o impacto no modelo:

| Parte | Consequência do requisito |
| --- | --- |
| `Pedido` | passa a manter o estado de fechamento e a impedir inclusões após `fechar()` |
| Código cliente (`Main`) | exercita a nova sequência de uso e confere os resultados |
| `ItemPedido` | continua calculando o subtotal a partir da própria quantidade e do preço solicitado ao produto |
| `Produto` | continua fornecendo suas informações aos itens |
| Coleção interna | continua privada e mantida por `Pedido` |
| `calcularTotal()` | continua percorrendo os itens existentes e delegando os subtotais |

Uma atividade de diagnóstico pode apresentar uma proposta em que apenas `Main`
verifica se o pedido está fechado, outra que põe a verificação em `Pedido` e uma
terceira que reescreve o cálculo do total. O estudante identifica qual proposta
protege a regra para todos os clientes e quais mudanças não são exigidas.

Fechar a trajetória pela análise de impacto: o requisito novo exige uma
transição de estado e uma guarda na inclusão; não exige redistribuir o cálculo.

## Verificações formativas

As perguntas devem ter contexto, dados e respostas imediatamente disponíveis
em bloco expansível na futura página autoguiada. O núcleo inclui:

1. previsão do total após uma inclusão aceita e outra tentada depois de
   `fechar()`;
2. comparação da regra em `Main`, `ItemPedido` e `Pedido`;
3. identificação do ponto em que a guarda deve ocorrer em `adicionarItem`;
4. contraste entre dois pedidos, um fechado e outro aberto; e
5. análise do que precisa mudar e do que continua cumprindo sua responsabilidade.

## Aprofundamentos elásticos

Se o núcleo terminar antes, ampliar a previsão ou a comparação sem fixar regras
novas: analisar o que uma segunda chamada a `fechar()` faz no desenho mínimo;
discutir que informações faltam para decidir se um pedido vazio pode ser
fechado; ou perguntar se impedir inclusões também bastaria para impedir toda
mudança possível em um pedido. Essas perguntas não entram como requisitos do
Projeto 1 nesta aula.

## Relação com o laboratório seguinte

O Laboratório 09 pode implementar a Versão 9 do Projeto 1 a partir da Versão 8:
representar o estado de fechamento em `Pedido`, oferecer `fechar()`, proteger
`adicionarItem(Produto, int)` e verificar pedidos abertos e fechados com
resultados observáveis. A aula deve preparar a leitura e o uso de `boolean`, da
guarda e de qualquer construção Java escolhida para a implementação antes de
exigir sua escrita no laboratório. Os incrementos práticos deverão alterar
concretamente o programa e preservar o cálculo por colaboração.

## Limites do desenho

Não introduzir retorno `boolean` em `adicionarItem`, exceções, reabertura,
remoção de itens, alteração de quantidade após o fechamento, preço histórico,
regras para fechar pedido vazio ou uma política para fechamentos repetidos.
Esses casos podem motivar discussão, mas não são consequências obrigatórias do
requisito escolhido. Não produzir slides a partir deste desenho antes da
revisão e aprovação do roteiro da aula.
