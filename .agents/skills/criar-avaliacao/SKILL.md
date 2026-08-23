---
name: criar-avaliacao
description: Encaminha a criação de uma prova de unidade ou substitutiva para o workflow comum de blueprint e base Markdown; não use para checkpoints focais.
---

# Criar avaliação

Esta é uma interface de compatibilidade para provas. Não cria variantes nem diagramação diretamente.

1. Ler `workflow.yaml` quando o instrumento já existir.
2. Se ainda não houver blueprint aprovado, aplicar `planejar-avaliacao` com tipo `prova`.
3. Se o blueprint estiver aprovado e a base ainda não, aplicar `criar-base-avaliacao`.
4. Se a base estiver aprovada e o pedido for gerar variantes, encaminhar para `finalizar-avaliacao`.
5. Não inferir duração, páginas, corte curricular ou gates.

As propriedades acumulativas e integrativas da prova permanecem em `specs/padrao-avaliacoes.md` e `specs/projeto-pedagogico.md`.
