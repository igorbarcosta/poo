# Lesson design: Construtores e estado inicial válido

Artifact identity: `lesson-design-poo-aula-05-construtores-estado-inicial-valido`

## Audience and prerequisites

Estudantes da disciplina de Programação Orientada a Objetos, trabalhando em
Java e no Projeto 1. A aula parte do estado do projeto ao final da Aula 04 e do
Laboratório 04: `ItemPedido` já controla alterações posteriores de quantidade,
mas ainda pode ser criado e preparado em etapas separadas.

## Learning intent

Ao final do encontro, o estudante deve ser capaz de:

- diagnosticar os riscos de criar um objeto e configurá-lo em etapas separadas;
- explicar como um construtor organiza o estado inicial de um objeto;
- relacionar argumentos da criação, parâmetros do construtor e campos do objeto;
- usar `this` para distinguir um campo de um parâmetro com o mesmo nome; e
- justificar por que a própria classe deve proteger a coerência do estado
  inicial.

## Organizing problem

Se um objeto precisa de certas informações para fazer sentido, por que
permitimos que ele seja criado incompleto? A trajetória usa `ItemPedido` para
mostrar que existir para Java não garante um estado adequado ao domínio, que a
necessidade de uma criação mais explícita conduz ao construtor e que receber
todos os argumentos ainda não garante invariantes válidas.

## Scope

### Included

- criação vazia, valores padrão e o risco de circular com um objeto incompleto;
- construtor básico em Java: nome da classe, ausência de tipo de retorno,
  parâmetros e execução durante `new`;
- caminho argumento → parâmetro → campo;
- `this` somente para distinguir campos e parâmetros com o mesmo nome;
- estado inicial de `ItemPedido` com descrição, preço unitário e quantidade;
- responsabilidade da classe por duas invariantes numéricas simples:
  `precoUnitario >= 0` e `quantidade >= 0`, mantendo `0` aceito; e
- transferência conceitual, opcional e não implementada para uma `Reserva`,
  verificando se a responsabilidade por um estado coerente continua fazendo
  sentido fora de `ItemPedido`.

### Excluded

- sobrecarga, encadeamento e outras formas avançadas de construção;
- políticas de comunicação de falhas, exceções e formas alternativas de
  rejeitar argumentos;
- validação textual da descrição;
- implementação completa de `Reserva`;
- implementação de `Pedido`, colaboração entre objetos e coleções, que ficam
  para etapas posteriores do Projeto 1.

## Activities or checks

As atividades são verificações formativas, sem entrega escrita: o estudante
prevê estados antes de executar, compara criações completas e incompletas,
acompanha um valor do argumento ao campo, prevê o efeito de `this` e decide
onde a regra de `ItemPedido` deve ser preservada. A transferência para `Reserva`
é um aprofundamento elástico; pode ser encurtada conforme o ritmo do encontro.

## Relationship to Laboratório 05

A aula prepara o Laboratório 05 — Construindo objetos em estado válido. O
laboratório evolui a Versão 4 para a Versão 5: exige os três dados na criação,
adapta os pontos de criação, impede preparação direta por código externo e
preserva as invariantes numéricas durante a construção, mantendo a distinção
entre referências compartilhadas e objetos independentes.

## POO consumer constraints and unresolved reconstruction questions

- O conteúdo pedagógico permanece em português; Java é suporte ao eixo de
  responsabilidades, estado e comportamento da disciplina.
- A aula segue a política local de um encontro dimensionado internamente para
  aproximadamente 90 minutos, em três blocos didáticos (`5.1`, `5.2`, `5.3`),
  usando as faixas de tempo apenas como heurística de planejamento.
- As atividades teóricas preservam a condução com a turma: formulação
  individual, coleta de hipóteses, contraste de justificativas e fechamento
  coletivo antes da formalização. Não são entregáveis do estudante.
- Não há evidência histórica de que este `LessonDesign` tenha existido ou de
  que cada uma dessas formulações tenha sido uma decisão explícita quando a
  aula foi originalmente escrita. A intenção histórica exata permanece
  desconhecida.
- A duração real, a compreensão observada e a decisão histórica sobre o uso da
  transferência para `Reserva` não estão registradas de forma completa; para o
  presente candidato, `Reserva` permanece explicitamente opcional e elástica.
