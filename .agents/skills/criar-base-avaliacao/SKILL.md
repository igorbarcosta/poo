---
name: criar-base-avaliacao
description: Cria e refina a prova-base em Markdown de um checkpoint ou prova com blueprint aprovado, sem gerar variantes nem iniciar diagramação final.
---

# Criar base de avaliação

Transformar um blueprint aprovado em uma fonte semântica completa e auditada.

## Confirmar o gate

1. Ler `AGENTS.md`, as duas specs de avaliações e o diretório do instrumento.
2. Executar `workflow.py validate` e confirmar que `blueprint_aprovado` está íntegro.
3. Recusar a etapa se o hash divergir ou se a aprovação humana não estiver registrada.

## Produzir a base

1. Criar `base.md` segundo o contrato e manter os identificadores estáveis `QXX`.
2. Criar `auditoria-base.md` com a matriz questão → evidência principal e a resolução interna.
3. Aplicar os critérios de `padrao-avaliacoes.md`: cobertura, determinação, independência, repertório ensinado, pontuação, alternativas e ausência de entrega de respostas.
4. Não produzir variantes, gabarito, LaTeX ou PDF.
5. Usar `revisar-avaliacao` no modo integrado: auditoria inicial e no máximo dois ciclos de correção objetiva. Parar diante de decisão pedagógica ou problema persistente.
6. Executar `workflow.py validate` e as verificações de diff.

Encerrar com a base aguardando aprovação humana. Registrar `base_aprovada` somente depois de decisão explícita. A aprovação congela `base.md` e `auditoria-base.md`; qualquer mudança posterior invalida esse gate e os seguintes.
