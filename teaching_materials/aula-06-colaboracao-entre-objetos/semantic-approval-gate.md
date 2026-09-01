# Aula 06 semantic approval gate

Status: `READY_FOR_HUMAN_SEMANTIC_REVIEW`

Este pacote apresenta o estado semântico exato de `LessonDesign + Lesson` para
decisão humana. A presença da página no site e a revisão anterior não implicam
aprovação pelo workflow Docemas.

## Canonical pair

| Papel | Caminho | SHA-256 |
| --- | --- | --- |
| LessonDesign | `teaching_materials/aula-06-colaboracao-entre-objetos/lesson-design.md` | `8607578f0259152a62d30e065dc3721092b85f77165f71792a9c223a2f322e86` |
| Lesson | `docs/aulas/aula-06-colaboracao-entre-objetos.md` | `3ccc9334ee46acba56ad8b84902527ad2105da126fd40ed5435f52719a5e44d7` |
| Combined semantic | `docemas-lesson-semantic-v1` | `baa7fa5ab2e2bb01ea69b9ed2d9e80c89cd060770a8a85b0d3fef833a9f1ea9d` |

## Semantic scope

- colaboração inicial entre `Produto` e `ItemPedido`;
- distribuição de descrição, preço e quantidade;
- referência de um item para um produto existente;
- cálculo do subtotal por colaboração;
- passagem de objetos como argumentos sem cópia automática;
- transferência curta para `Quarto` e `Reserva`;
- página permanente autoguiada e condução presencial reservada ao deck.

Permanecem fora do escopo: `null`, preço histórico, cópia de objetos,
coleções, implementação de `Pedido`, taxonomia formal de associação e
composição, interfaces e polimorfismo. O Laboratório 06 não foi inventado.

## Bounded review

Artefatos comparados com o projeto pedagógico, o padrão de aulas, a Aula 05, o
Laboratório 05, a referência Java e a retrospectiva 2026.2.

Findings: none.

Recommendation: `READY_FOR_HUMAN_SEMANTIC_REVIEW`.

Essa recomendação não constitui aprovação.

## Human semantic question

Você aprova explicitamente este estado exato de `LessonDesign + Lesson`,
identificado pelos hashes acima, como baseline canônica da Aula 06 para o
workflow Docemas e para a posterior derivação dos slides?

A aprovação se limita ao par canônico. Ela não aprova antecipadamente o deck,
os renderizados, a publicação do site ou qualquer Laboratório 06 futuro.
