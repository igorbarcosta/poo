---
name: criar-par-aula-laboratorio
description: Implementa um novo par Aula + Laboratório deste repositório a partir de um desenho pedagógico já decidido pelo professor. Use quando o usuário pedir para criar um novo par, implementar um par pedagogicamente planejado ou transformar um desenho aprovado em páginas Zensical da disciplina; não use para decidir currículo, criar avaliações ou revisar isoladamente material existente.
---

# Criar par Aula e Laboratório

Transformar decisões pedagógicas já fornecidas em um par coerente de páginas didáticas. Não decidir autonomamente o currículo.

## Preparar o trabalho

1. Ler `AGENTS.md`.
2. Ler integralmente:
   - `specs/projeto-pedagogico.md`;
   - `specs/padrao-aula.md`;
   - `specs/padrao-laboratorio.md`;
   - `specs/estrutura-site.md`.
3. Consultar o par anterior, quando existir, para preservar continuidade e recuperar questões deixadas em aberto.
4. Consultar `docs/materiais/java-essencial.md`, `docs/aulas/index.md` e a navegação atual em `zensical.toml`.
5. Identificar no pedido:
   - número e títulos do par;
   - pergunta ou problema central;
   - conceitos incluídos e conteúdos que ainda não entram;
   - função prática do laboratório;
   - evolução do projeto, nível de IA e ponte seguinte, quando definidos.

Se faltar uma decisão pedagógica relevante que não esteja no pedido nem nas fontes do repositório, não inventar: pedir a decisão ao professor. Não pedir confirmação sobre detalhes editoriais já estabelecidos nas specs.

## Implementar o par

1. Criar a Aula conforme `specs/padrao-aula.md`.
2. Criar o Laboratório conforme `specs/padrao-laboratorio.md`.
3. Garantir que a Aula forneça o embasamento usado no Laboratório e que o Laboratório seja predominantemente prático.
4. Usar, quando servirem ao objetivo, comparação, previsão, execução, explicação, experimentação, transferência e incrementos do projeto.
5. Aprofundar os conceitos planejados antes de antecipar conteúdos futuros apenas para aumentar a densidade.
6. Tratar Java de forma incremental e transversal. Usar “Java em foco” apenas diante de uma necessidade real de linguagem, sintaxe ou convenção.
7. Atualizar `docs/materiais/java-essencial.md` somente com recursos Java efetivamente introduzidos no par, sem transformá-lo em apostila.
8. Atualizar `docs/aulas/index.md`. Alterar `zensical.toml` somente se a navegação explícita atual exigir a inclusão das novas páginas.

Manter no roteiro público apenas informações úteis para compreender, executar, verificar, aprofundar e entregar. Deixar detalhes internos de planejamento nas specs.

## Verificar o laboratório

Antes de concluir, confirmar:

- requisitos observáveis, verificáveis e autossuficientes, sem prescrever implementação além do necessário;
- dados e estados iniciais suficientes para cada experimento;
- valores de previsão determinados;
- operações especificadas sem ambiguidade;
- resultados efetivamente visíveis ou consultáveis;
- critérios de conclusão correspondentes ao que foi solicitado;
- desafios opcionais apresentados como aprofundamento, sem ocupar tempo artificialmente;
- ausência de dependências em informações não fornecidas.

Não inventar datas, prazos, calendário, regras de entrega, critérios de avaliação ou arquitetura futura do projeto.

## Validar e entregar

1. Executar `zensical build`.
2. Corrigir eventuais erros.
3. Verificar `git diff` e `git status`, preservando alterações preexistentes do usuário.
4. Informar:
   - arquivos criados e alterados;
   - progressão conceitual do par;
   - atualização de `java-essencial.md`;
   - atualização do índice e, se necessária, da navegação;
   - resultado do build.

Não criar checkpoints, provas, unidades ou mudanças no projeto pedagógico. Não alterar pesos de avaliação nem decidir a sequência macro da disciplina. Não fazer commit ou push sem solicitação explícita.
