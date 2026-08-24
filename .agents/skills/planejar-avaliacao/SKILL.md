---
name: planejar-avaliacao
description: Planeja o blueprint de um checkpoint ou prova desta disciplina a partir do conteúdo efetivamente ensinado, sem escrever questões nem avançar sem aprovação humana explícita.
---

# Planejar avaliação

Produzir somente o blueprint de um novo instrumento.

## Preparar

1. Ler `AGENTS.md`, `specs/projeto-pedagogico.md`, `specs/padrao-avaliacoes.md` e `specs/contrato-artefatos-avaliacoes.md`.
2. Determinar com o professor o tipo, o identificador e qualquer parâmetro que não esteja definido. Não inventar corte curricular, duração de prova, páginas ou condição de aplicação.
3. Ler integralmente aulas e laboratórios do corte e consultar materiais de Java apenas para confirmar o repertório ensinado.
4. Usar retrospectivas como evidência contextual, nunca como regra permanente.

## Criar o blueprint

Criar o diretório do instrumento, copiar somente `workflow.yaml` e `blueprint.md` de `avaliacoes/templates/instrumento/` e ajustá-los. Nesta etapa, não copiar os demais esqueletos, redigir questões completas, criar `base.md`, produzir variantes, gabarito ou derivados.

O blueprint deve tornar auditáveis o recorte, as exclusões, as evidências prioritárias, a distribuição dos 100 pontos, as operações cognitivas, os formatos possíveis, as restrições do cenário e as decisões abertas. Planejar quantidades cognitivas como evidências avaliativas, não como “itens corrigíveis”: uma evidência pode exigir vários subitens na base. Verificar a soma planejada sem transformar a distribuição em uma meta rígida de questões ou subitens.

Executar:

```bash
.venv/bin/python avaliacoes/scripts/workflow.py validate avaliacoes/<tipo>/<identificador>
```

Encerrar apresentando o blueprint e aguardando aprovação. Somente após decisão humana explícita, registrar o gate com `workflow.py approve --gate blueprint_aprovado --decision "..."`. Não interpretar continuidade ou pedido de ajuste como aprovação.
