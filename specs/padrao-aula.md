# Padrão das páginas de aula

Este documento registra o padrão das aulas de POO, destinadas principalmente à fundamentação conceitual. Laboratórios possuem numeração e padrão próprios, registrados em `padrao-laboratorio.md`.

## Identificação

- O nome do arquivo deve seguir o padrão `aula-XX-assunto.md`.
- O título da página deve seguir o padrão `Aula XX — Título`.
- Não incluir data ou semestre no título da aula.
- Usar `material/school-outline` no campo `icon` do front matter.

## Estrutura

Cada página deve começar com uma breve contextualização e conter as seguintes seções obrigatórias:

- **Objetivos**
- **Conteúdo**
- **Material da aula**

Quando forem pertinentes, podem ser incluídas as seguintes seções opcionais:

- **Exemplos**
- **Atividade**
- **Para revisar**
- **Referências**

## Legibilidade

Legibilidade é um requisito pedagógico. A página deve permitir que o estudante compreenda a explicação, localize informações rapidamente, diferencie conceitos, exemplos, dicas e atividades e retome o conteúdo sem reler grandes blocos.

Como orientação editorial:

- usar parágrafos curtos para desenvolver ideias;
- preferir bullets para três ou mais informações independentes e listas numeradas para sequências;
- manter exemplos próximos do conceito que ilustram;
- usar títulos informativos e linguagem direta, orientada ao estudante;
- preferir poucas perguntas de alta qualidade;
- evitar repetir em prosa o que já está claro em código, tabela ou lista;
- reservar cada admonition para uma ideia principal e evitar paredes de texto dentro dela.

Essas diretrizes apoiam a clareza sem impor uniformidade artificial.

## Identidade visual

Usar admonitions nativas do Zensical com moderação e de acordo com seu significado:

- `info`: conceito, informação importante ou uso de IA;
- `tip`: dica;
- `example`: exemplo;
- `question`: reflexão;
- `warning`: atenção;
- `success`: critérios de conclusão.

Conteúdo principal, explicações e atividades permanecem em Markdown normal. Admonitions são reservadas para informações semanticamente especiais.

### Java em foco

Java deve ser ensinado de maneira incremental e transversal. Características da linguagem, convenções e boas práticas devem ser explicadas quando surgirem naturalmente no conteúdo de POO, sem criar blocos extensos de revisão para conceitos de programação que os estudantes já possuem.

Usar `tip` com o título **Java em foco — assunto** para explicações curtas de linguagem, sintaxe ou convenção. Normalmente, um a três blocos por aula são suficientes. Cada bloco deve tratar de um assunto coeso e usar bullets quando reunir regras independentes. A trilha principal continua sendo POO; “Java em foco” explica como expressar corretamente esses conceitos na linguagem.

## Princípios de uso

- A aula oferece o embasamento conceitual que será aplicado no laboratório relacionado.
- Uma aula de 1h30 não precisa maximizar a quantidade de conceitos novos. Observar, comparar, prever, explicar, discutir, aplicar e transferir também conferem densidade ao encontro.
- Preferir aprofundar conceitos importantes antes de antecipar conteúdos futuros.
- A página deve ser útil tanto antes quanto depois da aula.
- O padrão deve orientar a organização do conteúdo, sem criar seções vazias apenas para cumprir o template.
- Admonitions devem destacar apenas informações semanticamente especiais, conforme o padrão visual do projeto; o conteúdo principal permanece em Markdown normal.
