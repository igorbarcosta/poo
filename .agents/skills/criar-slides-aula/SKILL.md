---
name: criar-slides-aula
description: Transforma uma aula deste repositório, já definida e validada pedagogicamente, em um deck Marp coerente com o roteiro e em suas distribuições oficiais HTML/PDF. Use quando o usuário pedir para criar ou gerar os slides de uma aula existente, inclusive com comandos breves como “Crie os slides da Aula 04”; não use para decidir currículo, planejar uma aula ainda indefinida ou alterar o projeto pedagógico.
---

# Criar slides de uma aula

Produzir um instrumento de condução da aula, não uma conversão mecânica da página em tópicos projetados.

## Fronteira de derivação com Docemas

Este fluxo é o wrapper local de slide derivation. Usar
`derive-lesson-slides` no Docemas por `DOCEMAS_ROOT`/`../docemas`; o wrapper
fornece a aula selecionada e `slides/presentation-profile.md`. Antes de
derivar, `can_derive_poo_lesson` deve retornar `CURRENT_APPROVAL` com
classificação `VALID_CURRENT`; aprovação não é inferida de deck, site,
renderização ou histórico Git. Eligibility e provenance são responsabilidade
do Docemas, e o POO escolhe apenas o deck, o destino de evidência e o perfil.
A decisão humana ocorre no registro de aprovação do workflow Docemas; este
wrapper apenas verifica e consome seu estado atual.

O perfil define Marp, o tema `poo.css`, a sintaxe local, a densidade, o código,
as pausas e o contexto presencial. `review-slide-projection` permanece a
revisão source-level anterior à revisão visual local. Marp, renderização,
HTML/PDF, Zensical, publicação e retrospectivas continuam pertencendo ao POO.

## Confirmar a fonte pedagógica

1. Ler `AGENTS.md`.
2. Ler `specs/padrao-slides.md` integralmente.
3. Localizar e ler a página correspondente em `docs/aulas/`.
4. Confirmar que a aula está pedagogicamente definida e validada. Se faltar uma decisão importante, interromper e pedir ao professor; não completar o currículo por conta própria.
5. Consultar a aula anterior e o deck anterior somente quando ajudarem a preservar continuidade visual, conceitual ou narrativa. Não usá-los como moldes obrigatórios.
6. Procurar em `retrospectivas/` observações relacionadas à aula ou a decks semelhantes e ler somente as entradas relevantes. Usá-las para calibrar densidade e dificuldades reais, não como autoridade normativa.
7. Consultar o tema existente em `slides/theme/` e reutilizá-lo sem criar outro sistema visual.

## Derivar o deck

1. Identificar a trajetória da aula: problema, perguntas, previsões, descobertas, formalizações, aplicações e sínteses.
2. Planejar frames com uma ideia principal cada, preservando a causalidade e as pausas didáticas definidas no roteiro.
3. Preservar o núcleo necessário e representar aprofundamentos elásticos planejados quando tiverem função pedagógica real.
4. Procurar redundância expositiva: manter retomadas que mudem a operação cognitiva e reduzir reformulações que apenas repitam a explicação.
5. Selecionar apenas texto, código, perguntas, atividades e diagramas que precisem permanecer projetados. Usar notas do apresentador para orientações de condução que não devam ocupar o frame.
6. Criar ou atualizar `slides/aula-XX-<slug>.md` com o tema compartilhado.
7. Preservar o conteúdo e a intenção da aula original. Não alterar a página salvo correção técnica ou inconsistência pequena indispensável; diante de mudança pedagógica, parar e pedir orientação.

Não inventar conteúdo importante, decidir currículo, alterar o projeto pedagógico, transformar observação isolada em regra nem antecipar assuntos apenas para completar o deck.

## Renderizar e inspecionar

1. Antes de renderizar, executar o preflight pelo entrypoint oficial; não instalar dependências nem reconfigurar o ambiente automaticamente:

   ```bash
   bash slides/render.sh aula-XX-<slug>
   ```

   O comando resolve o runtime já disponível, usa o Marp do projeto, gera HTML/PDF e verifica a consistência dos artefatos. Diante de falha, interromper e diagnosticar; não improvisar outro pipeline.

2. Ao diagnosticar ambiente, distinguir observação de inferência. Não concluir versão, configuração ou causa ambiental a partir de um sintoma. Quando essa informação for necessária para decidir ou relatar, verificá-la explicitamente; caso contrário, relatar somente o comportamento observado.
3. Confirmar a criação de:
   - `slides/rendered/aula-XX-<slug>.html`;
   - `slides/rendered/aula-XX-<slug>.pdf`.
4. Inspecionar visualmente o deck completo em visão global. Verificar narrativa, legibilidade a distância, densidade, tamanho de código, alinhamento, contraste, geometria, pausas didáticas e possíveis overflows.
5. A partir dessa visão, inspecionar de forma ampliada somente frames de maior risco, como código longo, tabelas, atividades densas, conteúdo próximo aos limites ou combinações de texto e código.
6. Diante de overflow, revisar primeiro a densidade e a divisão dos frames; não reduzir fonte automaticamente.
7. Corrigir problemas encontrados no fonte, renderizar novamente e reinspecionar os frames afetados. Nunca editar HTML ou PDF manualmente.

## Validar e relatar

1. Executar `git diff --check`.
2. Executar `.venv/bin/zensical build` se a página da aula ou links do site tiverem sido alterados.
3. Verificar `git diff` e `git status`, preservando alterações preexistentes do usuário.
4. Confirmar no resultado do comando a invariante obrigatória `slides no fonte = seções no HTML = páginas no PDF`. Qualquer divergência invalida os artefatos oficiais e deve interromper o workflow; não aceitá-la por decisão manual. Um formato futuro que exija outra relação deverá ser tratado explicitamente no tooling.
5. Relatar o fonte criado ou alterado, os renderizados oficiais, a contagem validada, a inspeção visual global e ampliada e as validações executadas.

Não fazer commit ou push sem solicitação explícita.
