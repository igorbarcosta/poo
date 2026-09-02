# Aula 07 semantic approval gate

Status: `READY_FOR_HUMAN_SEMANTIC_REVIEW`

Este pacote apresenta o estado semântico exato de `LessonDesign + Lesson` para decisão humana. A revisão e a publicação anterior da página não constituem aprovação pelo workflow Docemas.

## Canonical pair

| Papel | Caminho | SHA-256 |
| --- | --- | --- |
| LessonDesign | `teaching_materials/aula-07-um-objeto-coordenando-varios-outros/lesson-design.md` | `3e9c045b9599f12ab6d0981934666fb613abe37dc33a510de5830ecc6d517d17` |
| Lesson | `docs/aulas/aula-07-um-objeto-coordenando-varios-outros.md` | `c5c94aae43d6e16490b645bb24c896855ee7da22f40961e3e84d25484e6a89fb` |
| Combined semantic | `docemas-lesson-semantic-v1` | `26a97ae09e5bba0c07e2807a50dac23e2853a2ca3922a667369e8c39937457a4` |

## Semantic scope

- `Pedido` como responsável pelo conjunto de itens;
- `List<ItemPedido>` e `ArrayList<>` para manter quantidade variável de referências;
- adição de itens sem cópia automática;
- percurso com `for` aprimorado;
- cálculo total coordenado por delegação a `ItemPedido`;
- colaboração indireta com `Produto`;
- distinção entre coordenar e absorver responsabilidades; e
- transferência para `Turma`, que solicita `estaAprovado()` a cada `Aluno`.

Permanecem fora do escopo: Generics como tópico, exposição da lista interna, remoção e busca, políticas sobre repetição ou `null`, descontos, fechamento, preço histórico, streams, lambdas e implementação do domínio de turma.

## Bounded review

Artefatos comparados com o projeto pedagógico, os padrões de aula, laboratório, slides e diagramas, a Aula 06, o Laboratório 06, a referência Java e a retrospectiva 2026.2.

Findings: none.

Recommendation: `READY_FOR_HUMAN_SEMANTIC_REVIEW`.

Essa recomendação não constitui aprovação.

## Human semantic question

Você aprova explicitamente este estado exato de `LessonDesign + Lesson`, identificado pelos hashes acima, como baseline canônica da Aula 07 para o workflow Docemas e para a derivação dos slides?

A aprovação se limita ao par canônico. Ela não aprova antecipadamente o deck, os renderizados, a publicação do site ou o Laboratório 07.
