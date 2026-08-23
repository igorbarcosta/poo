---
name: finalizar-avaliacao
description: Deriva variantes e gabarito de uma base Markdown aprovada de checkpoint ou prova e prepara a auditoria humana de equivalência, sem presumir liberação para impressão.
---

# Finalizar avaliação

Produzir a distribuição sem alterar silenciosamente o contrato semântico aprovado.

## Confirmar o gate

1. Ler `AGENTS.md`, as duas specs de avaliações e todos os artefatos do instrumento.
2. Executar `workflow.py validate` e confirmar `base_aprovada` íntegra.
3. Exigir pedido explícito para gerar variantes. Se a base precisar mudar, interromper e devolver a decisão ao professor; não contornar o gate.

## Derivar e auditar

1. Criar `variantes/variante-a.md` e `variante-b.md` preservando identificadores, pontos, evidências e estrutura da base.
2. Produzir `gabarito.md` com todas as questões das duas variantes.
3. Resolver ambas integralmente e registrar em `auditoria-equivalencia.md` a correspondência e o julgamento humano de equivalência.
4. Executar `workflow.py validate`. As verificações de estrutura, pontos e vínculos não substituem a comparação de dificuldade, demanda cognitiva, leitura, escrita ou tempo.
5. Aplicar `revisar-avaliacao` no estágio de variantes.

Encerrar no gate `variantes_aprovadas`. Só registrá-lo após aprovação humana explícita da equivalência. Esta skill não renderiza, não realiza revisão visual e não libera para impressão.
