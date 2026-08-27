---
name: criar-base-avaliacao
description: Desenvolve blueprint e base de um instrumento de POO pelo processo genérico de autoria do Docemas, até base_aprovada.
---

# Criar base de avaliação de POO

Interface local de compatibilidade.

1. Ler `AGENTS.md`, `specs/projeto-pedagogico.md`, `specs/padrao-avaliacoes.md`, o recorte curricular e o diretório do instrumento.
2. Aplicar integralmente `../docemas/.agents/skills/author-assessment/SKILL.md`.
3. Usar o tooling e os templates do checkout Docemas irmão; os wrappers em `avaliacoes/scripts/` aceitam `DOCEMAS_ROOT` quando necessário.
4. Aplicar as restrições locais de Java e repertório ensinado sem promovê-las a políticas genéricas.
5. Usar `avaliacoes/tests/regressao-pedagogica.md` como regressão contextual da disciplina.

Não produzir variantes nem renderização nesta etapa.
