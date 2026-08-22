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
4. Procurar em `retrospectivas/` observações relacionadas ao material, à oferta ou aos conceitos em questão e ler somente as entradas relevantes. Tratá-las como evidência contextual para calibração, não como regra normativa.
5. Consultar `docs/materiais/java-essencial.md`, `docs/aulas/index.md` e a navegação atual em `zensical.toml`.
6. Identificar no pedido:
   - número e títulos do par;
   - pergunta ou problema central;
   - conceitos incluídos e conteúdos que ainda não entram;
   - função prática do laboratório;
   - evolução do projeto, nível de IA e ponte seguinte, quando definidos.

Se faltar uma decisão pedagógica relevante que não esteja no pedido nem nas fontes do repositório, não inventar: pedir a decisão ao professor. Não pedir confirmação sobre detalhes editoriais já estabelecidos nas specs.

## Implementar o par

1. Criar a Aula conforme `specs/padrao-aula.md` e revisar integralmente sua narrativa antes de construir o Laboratório.
2. Criar o Laboratório conforme `specs/padrao-laboratorio.md`, derivando a prática de um roteiro teórico já internamente consistente.
3. Garantir que a Aula forneça o embasamento usado no Laboratório e que o Laboratório seja predominantemente prático.
4. Usar, quando servirem ao objetivo, comparação, previsão, execução, explicação, experimentação, transferência e incrementos do projeto.
5. Aprofundar os conceitos planejados antes de antecipar conteúdos futuros apenas para aumentar a densidade.
6. Dimensionar a aula com núcleo necessário e aprofundamentos elásticos que mudem a operação cognitiva, sem usar repetição ou conteúdo futuro como preenchimento.
7. Tratar Java de forma incremental e transversal. Usar “Java em foco” apenas diante de uma necessidade real de linguagem, sintaxe ou convenção.
8. Atualizar `docs/materiais/java-essencial.md` somente com recursos Java efetivamente introduzidos no par, sem transformá-lo em apostila.
9. Atualizar `docs/aulas/index.md`. Alterar `zensical.toml` somente se a navegação explícita atual exigir a inclusão das novas páginas.

Nas aulas teóricas, usar como dinâmica padrão perguntas dirigidas à turma toda: dar tempo real para formulação individual, coletar hipóteses, explorar justificativas e somente então formalizar a ideia. Não inserir automaticamente “discuta com um colega”, “compare com um colega” ou “em dupla”. Trabalho em pares e Peer Instruction exigem uma razão pedagógica explícita e deliberada. Essa restrição não se aplica aos laboratórios, nos quais investigação e colaboração em dupla podem ser naturais.

Não transformar uma impressão isolada da retrospectiva em mudança curricular, exclusão de conteúdo ou regra permanente.

Manter no roteiro público apenas informações úteis para compreender, executar, verificar, aprofundar e entregar. Deixar detalhes internos de planejamento nas specs.

Esta skill termina com roteiro e laboratório. Não criar nem alterar slides no mesmo fluxo. Preservar a sequência permanente: **roteiro → revisão pedagógica → validação e aprovação do professor → slides → revisão visual dos slides**. A produção do deck pertence a uma solicitação posterior, depois da aprovação pedagógica explícita.

### Aplicar o piloto de blocos didáticos

Ao criar as Aulas 05–07 da oferta 2026.2, aplicar o piloto registrado em `specs/padrao-aula.md`. Antes de escrever o roteiro, responder internamente:

1. Qual é o arco geral da aula?
2. Quais são os dois a quatro blocos conceituais?
3. Qual pergunta move cada bloco?
4. Qual avanço no modelo mental cada bloco produz?
5. Qual atividade curta de processamento existe em cada bloco?
6. Como cada bloco causa o próximo?
7. Existe algum bloco que seja apenas exposição de um recurso da linguagem?
8. O conjunto cabe realisticamente nos 90 minutos?

Usar 20–30 minutos e aproximadamente três blocos apenas como referências flexíveis. Preservar a narrativa contínua, evitar headings ou slides separadores artificiais e usar os identificadores internos leves definidos na spec. Não aplicar retroativamente o piloto às Aulas 01–04 nem tratá-lo como regra universal antes da retrospectiva posterior à Aula 07.

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

Para cada incremento obrigatório, responder internamente:

1. Qual mudança concreta de código ocorre?
2. Como essa mudança evolui a solução?
3. Existe investigação ou previsão associada?
4. Essa investigação está incorporada ao mesmo incremento?
5. O incremento possui resultado observável?
6. Há algum incremento que seja apenas leitura, observação ou resposta sem mudança de código?

Se a última resposta for sim, fundir a investigação com um incremento vizinho ou reestruturá-la, salvo razão pedagógica explícita e excepcional. Não inventar alteração sem valor pedagógico nem código descartável para satisfazer formalmente essa regra. Preservar a distinção entre investigação e entrega: raciocínio acompanha a evolução, mas previsões, diagramas e respostas conceituais não se tornam entregáveis.

Não inventar datas, prazos, calendário, regras de entrega, critérios de avaliação ou arquitetura futura do projeto.

## Validar e entregar

1. Executar `.venv/bin/zensical build`.
2. Corrigir eventuais erros.
3. Verificar `git diff` e `git status`, preservando alterações preexistentes do usuário.
4. Informar:
   - arquivos criados e alterados;
   - progressão conceitual do par;
   - atualização de `java-essencial.md`;
   - atualização do índice e, se necessária, da navegação;
   - resultado do build.

Não criar checkpoints, provas, unidades ou mudanças no projeto pedagógico. Não alterar pesos de avaliação nem decidir a sequência macro da disciplina. Não fazer commit ou push sem solicitação explícita.
