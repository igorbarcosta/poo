---
name: criar-checkpoint
description: Encaminha a criação de um checkpoint para o workflow comum de blueprint e base Markdown; use quando o pedido mencionar especificamente um checkpoint ainda não finalizado.
---

# Criar checkpoint

Esta é uma interface de compatibilidade para o workflow comum de avaliações. Não mantém um processo próprio.

1. Ler `workflow.yaml` quando o instrumento já existir.
2. Se ainda não houver blueprint aprovado, aplicar `planejar-avaliacao` com tipo `checkpoint`.
3. Se o blueprint estiver aprovado e a base ainda não, aplicar `criar-base-avaliacao`.
4. Se a base estiver aprovada e o pedido for gerar variantes, encaminhar para `finalizar-avaliacao`.
5. Não inferir gates nem migrar instrumentos históricos.

Os padrões de 50 minutos e duas páginas A4 permanecem em `specs/padrao-avaliacoes.md`.
