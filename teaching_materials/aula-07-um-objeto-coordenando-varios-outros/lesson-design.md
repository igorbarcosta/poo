# Lesson design: Um objeto coordenando vários outros

Artifact identity: `lesson-design-poo-aula-07-um-objeto-coordenando-varios-outros`

## Audience and prerequisites

Estudantes da disciplina de Programação Orientada a Objetos, trabalhando em Java e no Projeto 1. A aula parte do estado alcançado na Aula 06 e no Laboratório 06: `Produto` mantém descrição e preço; `ItemPedido` mantém quantidade e uma referência para o produto; o subtotal é calculado por colaboração.

O estudante já conhece objetos, referências, identidade, campos, métodos, encapsulamento, construtores, passagem de objetos como argumentos e colaboração entre dois objetos.

## Learning intent

Ao final do estudo, o estudante deve ser capaz de:

- justificar por que `Pedido` deve manter os itens que o compõem;
- representar uma quantidade variável de objetos com `List` e `ArrayList`;
- explicar que adicionar um item a uma coleção guarda uma referência existente;
- acompanhar um percurso de objetos com o `for` aprimorado;
- explicar a colaboração entre `Pedido`, `ItemPedido` e `Produto`; e
- distinguir coordenação de absorção das responsabilidades dos colaboradores.

## Organizing problem

Um item isolado já calcula seu subtotal, mas o código cliente ainda precisa conhecer cada item e somá-los manualmente. A trajetória identifica `Pedido` como responsável pelo conjunto, torna necessária uma coleção de referências e usa o percurso dessa coleção para coordenar o cálculo do total sem reproduzir a regra do subtotal.

## Scope

### Included

- `Pedido` como objeto que representa e coordena o conjunto de itens;
- `List<ItemPedido>` e `ArrayList<>` no nível necessário para criar, adicionar e percorrer;
- lista vazia como estado inicial coerente e total `0.0`;
- adição de referências existentes sem cópia automática;
- aliasing entre variáveis e posições da coleção;
- `for` aprimorado para percorrer os itens;
- delegação de `calcularSubtotal()` a cada `ItemPedido`;
- colaboração indireta com `Produto`; e
- transferência para `Turma` e `Aluno` por meio de `estaAprovado()`.

### Excluded

- Generics como tópico;
- remoção, busca, ordenação ou outras operações de coleção;
- exposição da lista interna por getter;
- políticas sobre itens repetidos ou `null`;
- quantidade máxima, descontos, fechamento e preço histórico;
- streams, lambdas e tratamento de exceções; e
- implementação completa do domínio de turma e alunos.

## Activities or checks

As atividades pedem distribuição de responsabilidades, acompanhamento de referências na coleção, previsão do fluxo de chamadas e transferência para outro domínio. Cada pergunta recebe resposta expansível na página permanente.

No deck presencial, as pausas preservam tempo de elaboração antes da resposta. O diagrama de sequência usa papéis (`item atual : ItemPedido` e `produto do item : Produto`) para evitar interpretar o loop como comunicação repetida com uma única instância fixa.

## Relationship to adjacent material

A aula continua a colaboração introduzida na Aula 06, resolve a tensão deixada pelo Laboratório 06 sobre vários itens e prepara o Laboratório 07, no qual o Projeto 1 ganha `Pedido`, uma coleção e o cálculo coordenado do total.

## POO consumer constraints

- O conteúdo pedagógico permanece em português e prioriza responsabilidades sobre sintaxe de Java.
- A página é material permanente e autoguiado; instruções de condução pertencem ao deck.
- A aula integra o piloto de blocos didáticos da oferta 2026.2.
- O deck deve preservar a causalidade item isolado → responsável pelo conjunto → coleção de referências → percurso → coordenação por delegação → transferência.
- A notação de objetos e referências segue `specs/padrao-diagramas-poo.md`, inclusive light/dark e papéis em diagramas de sequência.
- A atividade de transferência não deve revelar sua solução antes da elaboração do estudante.

## Unresolved decisions

Nenhuma decisão material permanece aberta para a derivação do deck ou para o Laboratório 07 solicitado pelo professor.
