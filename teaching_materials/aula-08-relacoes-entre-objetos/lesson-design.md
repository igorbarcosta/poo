# Lesson design: Relações entre objetos

Artifact identity: `lesson-design-poo-aula-08-relacoes-entre-objetos`

## Audience and prerequisites

Estudantes da disciplina de Programação Orientada a Objetos, trabalhando em
Java e no Projeto 1. A aula parte do modelo construído até a Aula 07 e o
Laboratório 07: `Produto` mantém descrição e preço; `ItemPedido` mantém uma
quantidade e uma referência para `Produto`; `Pedido` mantém uma coleção de
itens e coordena o cálculo total.

O estudante já conhece objetos, referências, identidade, encapsulamento,
construtores, passagem de objetos como argumentos, `List`, `ArrayList`, `for`
aprimorado e colaboração por chamadas de método.

## Learning intent

Ao final do estudo, o estudante deve ser capaz de:

- identificar, no código e no modelo, quais objetos mantêm referências para
  quais outros;
- justificar uma relação pela responsabilidade que ela permite cumprir;
- perceber que conhecer outro objeto não exige uma relação no sentido inverso;
- distinguir usar ou conhecer um colaborador de manter uma parte estrutural do
  próprio objeto;
- reconhecer `Pedido` e seus `ItemPedido` como uma composição conceitual
  simples, entendida como responsabilidade estrutural; e
- evitar conhecimento adicional e relações bidirecionais sem uma necessidade
  concreta do domínio.

## Organizing problem

O modelo atual já funciona: `Pedido` coordena itens e cada item consulta seu
produto. Mas o código deixa perguntas ainda implícitas: por que o item conhece
o produto, por que o pedido conhece os itens e por que o produto não conhece
os pedidos? A trajetória torna essas relações visíveis, compara uma direção
necessária com uma relação reversa desnecessária e formaliza associação,
composição e dependência somente depois de analisar as responsabilidades do
modelo existente.

## Scope

### Included

- leitura das relações existentes entre `Pedido`, `ItemPedido` e `Produto` a
  partir de campos, construtores e chamadas de método;
- direção da relação: conhecer A não implica que A conheça B;
- associação como uma referência que permite a um objeto cumprir uma
  responsabilidade por colaboração;
- composição como relação estrutural entre um todo e as partes cuja manutenção
  pertence conceitualmente ao todo;
- ciclo de vida e propriedade conceitual apenas para distinguir, no modelo
  atual, `Pedido` → `ItemPedido` de `ItemPedido` → `Produto`;
- dependência no sentido inicial de precisar conhecer uma operação de outro
  objeto para realizar uma responsabilidade;
- encapsulamento da relação pela manutenção privada da coleção e por operações
  como `adicionarItem` e `calcularTotal`;
- comparação com uma relação reversa de `Produto` para pedidos sem
  responsabilidade que a justifique; e
- transferência para `Biblioteca`, `Emprestimo`, `Livro` e `Usuario`, em que
  novas responsabilidades (devolução, consultas ativas e histórico) permitem
  avaliar quando uma relação adicional é ou não justificada.

### Excluded

- notações e classificações formais de relações;
- SOLID, Dependency Inversion Principle, interfaces, polimorfismo, herança,
  classes abstratas e padrões de projeto;
- novas operações no Projeto 1, como remoção, descontos, fechamento, preço
  histórico, busca ou regras para itens repetidos;
- `null`, cópia de objetos e gerenciamento de memória;
- alterações no Laboratório 07; e
- decisão das regras que evoluirão `Pedido` na Aula 09.

## Activities or checks

As atividades são formativas, autoguiadas e respondíveis na própria página. O
estudante primeiro mapeia referências e responsabilidades do modelo existente;
depois compara uma relação unidirecional com uma alternativa bidirecional sem
necessidade; por fim, transfere a análise para uma biblioteca. Nessa
transferência, diferencia devolução, consulta de empréstimos ativos e consulta
de histórico para perceber que uma nova responsabilidade pode exigir uma nova
decisão de estrutura, mas não uma relação reversa automática. Cada atividade
possui resposta expansível imediatamente após as perguntas.

## Relationship to adjacent material

A aula consolida a colaboração de `ItemPedido` com `Produto` da Aula 06 e a
coordenação de vários itens por `Pedido` da Aula 07. Ela não introduz regras
novas para o pedido: prepara a Aula 09 para evoluir essas regras sobre uma
estrutura de relações que o estudante já consegue explicar. A Aula 10 poderá
integrar leitura, análise, modificação e verificação de um pequeno sistema OO.

## POO consumer constraints and unresolved decisions

- O conteúdo pedagógico permanece em português; Java é suporte ao eixo de
  responsabilidades e relações entre objetos.
- A página é material permanente e autoguiado. Condução presencial, coleta de
  hipóteses e uso de slides pertencem a uma etapa posterior.
- O encontro é dimensionado internamente para aproximadamente 90 minutos, em
  três blocos didáticos (`8.1`, `8.2`, `8.3`), usando estimativas apenas como
  heurística de planejamento.
- A retrospectiva 2026.2 exige que cada atividade apresente antes o domínio, a
  situação e o significado dos dados necessários para respondê-la.
- Nenhuma decisão material permanece aberta para a revisão humana do roteiro.
  A aprovação semântica, a derivação de slides e a definição de uma prática
  posterior continuam fora desta change.
