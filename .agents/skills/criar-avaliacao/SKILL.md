---
name: criar-avaliacao
description: Cria uma prova acumulativa e integrativa desta disciplina, com variantes A e B e gabarito separado, articulando o conteúdo efetivamente ensinado até o momento. Use quando o professor pedir uma avaliação, prova de unidade ou substitutiva; não use para checkpoints focais, exercícios formativos ou para decidir conteúdo ainda não ensinado.
---

# Criar avaliação

Produzir uma prova que reúna poucas evidências fortes de articulação do repertório construído, sem reduzir o instrumento a uma questão independente por tópico.

## Preparar o escopo

1. Ler `AGENTS.md`, `specs/projeto-pedagogico.md` e `specs/padrao-avaliacoes.md` integralmente.
2. Identificar o tipo da avaliação, seu limite curricular, duração, valor e quantidade de páginas. Se esses parâmetros não estiverem definidos no pedido nem nas fontes do repositório, pedir a decisão ao professor.
3. Ler integralmente todas as aulas e os laboratórios pertencentes ao escopo acumulativo.
4. Consultar em `retrospectivas/` evidências relevantes do que ocorreu na oferta, dificuldades observadas e atividades ambíguas. Usá-las para calibrar o instrumento, sem convertê-las em norma.
5. Consultar `docs/materiais/java-essencial.md` e outros materiais de Java quando necessário para confirmar exatamente as formas já ensinadas.
6. Registrar o conteúdo efetivamente ensinado, os conceitos estruturantes prioritários, as formas de sintaxe disponíveis e o que permanece fora do escopo.

Não inventar parâmetros avaliativos, recorte, conteúdo ou regras de domínio.

## Construir antes de diagramar

1. Escolher poucas evidências fortes que integrem vários conhecimentos em problemas comuns. Não fixar quantidade de questões, subitens ou pesos; distribuir pontos conforme importância e esforço cognitivo.
2. Construir situações novas que exijam transferência, evitando reprodução literal ou simples renomeação de exercícios anteriores.
3. Usar Java como meio para ler, prever, diagnosticar, modificar e expressar conceitos de POO, não como checklist sintático.
4. Elaborar questões predominantemente objetivas e determináveis conforme `specs/padrao-avaliacoes.md`; evitar por padrão comandos abertos de explicação, justificativa, discussão ou opinião.
5. Montar a matriz interna **questão → evidência de aprendizagem** e registrar o conhecimento novo verificado por cada item.
6. Auditar cobertura dos aprendizados prioritários, redundância, dependências entre questões e entrega inadvertida de respostas.
7. Resolver integralmente a prova e produzir o gabarito com respostas, pontos, critérios semânticos e implementações equivalentes aceitáveis.
8. Confirmar que toda resposta é determinada e que regras de domínio necessárias estão explícitas.
9. Comparar sintaxe, APIs, mecanismos, convenções e conceitos com os materiais lidos. Não introduzir conteúdo novo durante a avaliação.
10. Quando houver múltipla escolha, exigir exatamente cinco alternativas A–E, uma correta por padrão, quatro distratores plausíveis e distribuição não previsível das letras corretas. Auditar paralelismo gramatical, extensão e pistas involuntárias.

## Produzir variantes equivalentes

Criar Variante A e Variante B com as mesmas competências, distribuição de pontos, estrutura geral, dificuldade aproximada, tempo esperado e volumes comparáveis de leitura e escrita. A equivalência deve resultar do desenho dos problemas, não de mera substituição superficial de nomes ou números.

Resolver ambas e verificar que nenhuma variante oferece pista, ambiguidade, dependência ou carga adicional. Separar claramente A e B no gabarito.

Manter a identificação das variantes somente nos nomes internos dos arquivos e no gabarito. O material do estudante não pode revelar variante ou código equivalente no cabeçalho, rodapé ou nome visível do instrumento.

## Diagramar e validar

1. Criar um diretório próprio em `avaliacoes/provas/` e manter nele fontes, matriz interna, variantes, gabarito e PDFs.
2. Reutilizar `avaliacoes/templates/avaliacao-poo.sty`; adaptar a composição ao valor, à duração e à quantidade de páginas definidas para a prova.
3. Manter A4, margens curtas, corpo confortável e cabeçalho compacto com nome e nota, sem matrícula, variante, duração ou valor máximo no material do estudante.
4. Preferir **Questão X — enunciado**, sem subtítulo temático obrigatório. Tratar código inline e blocos com fonte monoespaçada e fundo neutro claro; syntax highlighting discreto é permitido se permanecer legível em escala de cinza.
5. Incluir quadro de respostas quando favorecer correção rápida, refletindo a numeração e priorizando escrita simples, sem bolhas ou aparência administrativa. Em instrumentos predominantemente objetivos, posicioná-lo por padrão logo após o cabeçalho, salvo razão explícita para outra composição.
6. Compilar variantes e gabarito, confirmar o formato e a quantidade de páginas, renderizar e inspecionar visualmente todas as páginas.
7. Corrigir cortes, paginação, densidade, espaços de resposta e problemas de legibilidade sem reduzir agressivamente a fonte.
8. Aplicar os critérios de `.agents/skills/revisar-avaliacao/SKILL.md` na revisão final, executar `git diff --check` e verificar `git diff` e `git status`.

Relatar arquivos, escopo acumulativo, conceitos estruturantes, matriz de evidências, equivalência das variantes, resolução integral, duração estimada, paginação e inspeção visual. Não colocar avaliações em `docs/`, alterar aulas ou laboratórios, publicar, fazer commit ou push sem solicitação explícita.
