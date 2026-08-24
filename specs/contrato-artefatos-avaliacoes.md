# Contrato dos artefatos de avaliações

Este documento define a representação estável dos artefatos de checkpoints e provas. Os critérios pedagógicos permanecem em `padrao-avaliacoes.md`; a ordem de trabalho pertence às skills; validações mecânicas pertencem ao tooling.

## Diretório de um instrumento

Cada instrumento novo ocupa `avaliacoes/<tipo>/<identificador>/`, em que `<tipo>` é `checkpoints` ou `provas`, com esta estrutura semântica:

```text
blueprint.md
workflow.yaml
base.md
auditoria-base.md
preview/
variantes/
auditoria-equivalencia.md
gabarito.md
rendered/
retrospectiva.md
```

Os arquivos só passam a ser obrigatórios quando o estágio correspondente é alcançado. `preview/` contém derivados temporários para revisão humana e não é fonte canônica nem distribuição final. Fontes LaTeX, arquivos auxiliares e PDFs são derivados de renderização; não substituem os Markdown canônicos.

Instrumentos anteriores a este contrato podem manter sua organização histórica. Sua migração exige trabalho explícito e não pode inferir gates retroativos.

## Blueprint

`blueprint.md` precede as questões e registra, no mínimo:

- tipo e identificador do instrumento;
- finalidade e corte curricular;
- evidências ensinadas usadas para definir o recorte;
- inclusões e exclusões explícitas;
- duração, páginas e escala de 100 pontos;
- evidências de aprendizagem e distribuição planejada dos pontos;
- operações cognitivas e formatos pretendidos;
- restrições do cenário e decisões ainda abertas.

O blueprint não contém a redação integral das questões. Sua aprovação autoriza a criação da base, não autoriza variantes nem impressão.

## Fonte semântica

`base.md` é a fonte semântica única até sua aprovação. Ela contém somente cenário, premissas necessárias para determinar respostas, código, questões, subitens, alternativas, pontos e outras informações que alterem semanticamente o instrumento. Instruções administrativas, identificação do estudante, quadro de respostas, cabeçalho institucional, paginação e decisões de composição não pertencem à base.

O contrato distingue:

- **questão:** unidade temática numerada por `QXX`;
- **evidência avaliativa:** conceito ou capacidade cognitiva que se pretende observar e que a auditoria relaciona à questão ou ao subitem correspondente;
- **subitem:** menor unidade independentemente respondível e corrigível, identificada por `a)`, `b)`, `c)` e assim por diante.

Uma questão sem subitens contém exatamente um pedido corrigível. Toda questão com mais de um pedido independentemente respondível ou corrigível deve decompor esses pedidos em subitens. Não agrupar respostas diferentes em uma única linha ou campo para reduzir artificialmente sua quantidade.

A base usa frontmatter YAML e questões identificadas de forma estável:

```markdown
---
tipo: checkpoint
identificador: checkpoint-02
titulo: Checkpoint 2
pontos_totais: 100
---

## Q01 [20 pontos]

Comando comum.

### a) [10 pontos]

Primeiro pedido corrigível.

### b) [10 pontos]

Segundo pedido corrigível.
```

Os identificadores seguem `Q` e dois ou mais algarismos, são únicos no documento e não mudam durante a derivação. Letras de subitens são únicas, minúsculas e sequenciais a partir de `a)`. A soma dos subitens deve coincidir com os pontos da questão; a soma das questões deve coincidir com `pontos_totais` e totalizar 100.

`auditoria-base.md` relaciona cada identificador à evidência principal, registra a resolução interna e documenta as auditorias realizadas. Ela não é gabarito de aplicação.

## Preview da base

`preview/base.html` é um derivado regenerável de `base.md` para revisão humana antes de `base_aprovada`. Ele prioriza leitura contínua e legibilidade de código, sem simular a paginação A4 da aplicação. Não deve ser editado manualmente, não substitui a inspeção da fonte e não pertence a `rendered/`.

O preview deve corresponder byte a byte à saída do gerador oficial para a versão atual de `base.md`. Sua existência e integridade são exigidas antes da aprovação da base, mas o gate `base_aprovada` continua congelando exclusivamente `base.md` e `auditoria-base.md`; `preview/base.html` não integra o hash semântico.

## Variantes e gabarito

Depois da aprovação da base, `variantes/` contém ao menos `variante-a.md` e `variante-b.md`, seguindo o mesmo contrato de frontmatter, identificadores, subitens e pontos da base.

`gabarito.md` possui exatamente as seções de segundo nível `## Variante A` e `## Variante B`. Dentro de cada uma, há exatamente uma subseção `### QXX` para cada questão da variante correspondente. Quando a questão possui subitens, sua resposta usa exatamente uma subseção de quarto nível `#### a)`, `#### b)` e assim por diante para cada letra da fonte.

`auditoria-equivalencia.md` registra a resolução integral e o julgamento humano de equivalência. O tooling confere apenas estrutura, pontos e vínculos; não determina dificuldade ou equivalência cognitiva.

## Renderização e retrospectiva

`rendered/` recebe somente derivados de artefatos semanticamente aprovados. Depois da aprovação semântica, o fluxo final combina as variantes com configuração e templates de aplicação para acrescentar instruções ao estudante, quadro de respostas, cabeçalho e identificação, informações administrativas, paginação e composição física. Esses elementos não são incorporados retroativamente à base semântica.

Para o gate de impressão, `rendered/` deve conter ao menos `variante-a.pdf`, `variante-b.pdf` e `gabarito.pdf`. A implementação comum de Markdown para LaTeX/PDF ainda não faz parte deste contrato.

A liberação para impressão congela o conjunto renderizado depois de revisão visual humana. `retrospectiva.md` registra evidências da aplicação e suas interpretações provisórias. Ela não altera automaticamente specs, skills ou instrumentos futuros.

## Workflow e gates

`workflow.yaml` é criado a partir de `avaliacoes/templates/instrumento/workflow.yaml`. Os quatro gates são:

1. `blueprint_aprovado`;
2. `base_aprovada`;
3. `variantes_aprovadas`;
4. `liberada_para_impressao`.

Cada gate registra:

- `status`: `pendente`, `aprovado` ou `invalidado`;
- `artefatos`: caminhos relativos congelados;
- `hash`: SHA-256 determinístico do conjunto ordenado;
- `decisao`: texto da decisão humana explícita;
- `estado_resultante`: estado alcançado;
- `aprovado_em`: registro temporal da aprovação.

O hash inclui caminhos, tipos e conteúdos. Diretórios são percorridos recursivamente em ordem lexical. Symlinks são recusados, mesmo quando apontam para dentro do instrumento. Se um artefato aprovado mudar, seu gate e todos os posteriores deixam de ser válidos, mesmo antes de o manifesto ser regravado. O validador deve falhar e indicar a primeira divergência.

A aprovação é transacional: o tooling valida os ancestrais, constrói e valida o estado candidato em memória e só então substitui atomicamente `workflow.yaml`. Uma tentativa malsucedida preserva o manifesto anterior byte a byte.

Somente uma decisão humana explícita autoriza o comando que registra um gate. Expressões de continuidade, pedidos de correção ou a simples existência de artefatos não constituem aprovação.

## Estados válidos

O campo `estado` aceita, nesta ordem:

```text
blueprint_em_elaboracao
blueprint_aprovado
base_em_elaboracao
base_aprovada
variantes_em_elaboracao
variantes_aprovadas
renderizacao_em_andamento
liberada_para_impressao
aplicada
retrospectiva_registrada
```

Os estados intermediários podem ser registrados sem aprovação. Nenhum estado pode ultrapassar um gate pendente ou inválido. `aplicada` e `retrospectiva_registrada` não significam aprovação pedagógica nova.
