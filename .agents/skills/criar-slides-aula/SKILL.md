---
name: criar-slides-aula
description: Transforma uma aula deste repositório, já definida e validada pedagogicamente, em um deck Marp coerente com o roteiro e em suas distribuições oficiais HTML/PDF. Use quando o usuário pedir para criar ou gerar os slides de uma aula existente, inclusive com comandos breves como “Crie os slides da Aula 04”; não use para decidir currículo, planejar uma aula ainda indefinida ou alterar o projeto pedagógico.
---

# Criar slides de uma aula

Produzir um instrumento de condução da aula, não uma conversão mecânica da página em tópicos projetados.

## Confirmar a fonte pedagógica

1. Ler `AGENTS.md`.
2. Ler `specs/padrao-slides.md` integralmente.
3. Localizar e ler a página correspondente em `docs/aulas/`.
4. Confirmar que a aula está pedagogicamente definida e validada. Se faltar uma decisão importante, interromper e pedir ao professor; não completar o currículo por conta própria.
5. Consultar o deck anterior quando ele ajudar a preservar continuidade visual, vocabulário ou uma retomada narrativa. Não usá-lo como molde obrigatório.
6. Consultar o tema existente em `slides/theme/` e reutilizá-lo sem criar outro sistema visual.

## Derivar o deck

1. Identificar a trajetória da aula: problema, perguntas, previsões, descobertas, formalizações, aplicações e sínteses.
2. Planejar frames com uma ideia principal cada, preservando a causalidade e as pausas didáticas definidas no roteiro.
3. Selecionar apenas texto, código, perguntas, atividades e diagramas que precisem permanecer projetados. Usar notas do apresentador para orientações de condução que não devam ocupar o frame.
4. Criar ou atualizar `slides/aula-XX-<slug>.md` com o tema compartilhado.
5. Preservar o conteúdo e a intenção da aula original. Não alterar a página salvo correção técnica ou inconsistência pequena indispensável; diante de mudança pedagógica, parar e pedir orientação.

Não inventar conteúdo importante, decidir currículo, alterar o projeto pedagógico nem antecipar assuntos apenas para completar o deck.

## Renderizar e inspecionar

1. Gerar as distribuições oficiais com:

   ```bash
   npm run slides:render -- aula-XX-<slug>
   ```

2. Confirmar a criação de:
   - `slides/rendered/aula-XX-<slug>.html`;
   - `slides/rendered/aula-XX-<slug>.pdf`.
3. Inspecionar todas as miniaturas ou páginas renderizadas. Verificar narrativa, legibilidade a distância, densidade, tamanho de código, alinhamento, contraste, geometria, pausas didáticas e possíveis overflows.
4. Diante de overflow, revisar primeiro a densidade e a divisão dos frames; não reduzir fonte automaticamente.
5. Corrigir problemas encontrados no fonte e renderizar novamente. Nunca editar HTML ou PDF manualmente.

## Validar e relatar

1. Executar `git diff --check`.
2. Executar `.venv/bin/zensical build` se a página da aula ou links do site tiverem sido alterados.
3. Verificar `git diff` e `git status`, preservando alterações preexistentes do usuário.
4. Relatar o fonte criado ou alterado, os renderizados oficiais, a quantidade de frames, a inspeção visual e as validações executadas.

Não fazer commit ou push sem solicitação explícita.
