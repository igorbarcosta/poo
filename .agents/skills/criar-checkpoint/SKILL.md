---
name: criar-checkpoint
description: Cria um checkpoint focal desta disciplina, com variantes A e B, gabarito separado e exatamente duas páginas A4 por variante do estudante. Use quando o professor pedir a elaboração ou implementação de um checkpoint real; não use para provas acumulativas, exercícios formativos ou para decidir conteúdo ainda não ensinado.
---

# Criar checkpoint

Produzir um instrumento curto que gere evidências determinadas sobre os aprendizados recentes, sem introduzir conteúdo e sem começar pela diagramação.

## Preparar o escopo

1. Ler `AGENTS.md`, `specs/projeto-pedagogico.md` e `specs/padrao-avaliacoes.md` integralmente.
2. Identificar quais aulas delimitam o checkpoint. Se esse recorte não estiver no pedido nem puder ser determinado pelo cronograma e pelo estado da oferta, pedir a decisão ao professor.
3. Ler integralmente as aulas e os laboratórios do recorte; consultar encontros anteriores apenas para dependências necessárias.
4. Procurar em `retrospectivas/` evidências relevantes do que foi efetivamente trabalhado, das dificuldades observadas e de atividades que se mostraram ambíguas. Tratar retrospectivas como contexto, não como regra permanente.
5. Consultar `docs/materiais/java-essencial.md` e outros materiais de Java somente no necessário para confirmar o repertório já apresentado.
6. Registrar o que foi efetivamente ensinado, as formas de sintaxe usadas, os conhecimentos prioritários e tudo que permanece fora do escopo.

Não inventar recorte, conteúdo, regra de domínio, data ou condição de aplicação. O padrão é 50 minutos e 10,0 pontos.

## Construir antes de diagramar

1. Escolher as evidências necessárias; não fixar quantidade de questões, subitens ou pesos. Distribuir pontos conforme importância e esforço cognitivo.
2. Preferir um único cenário novo que exija transferência real. Rejeitar simples renomeação de exemplos ou repetição da estrutura cognitiva de aula ou laboratório.
3. Elaborar questões predominantemente objetivas e determináveis, usando os formatos aceitos em `specs/padrao-avaliacoes.md`.
4. Evitar por padrão solicitações abertas de explicação, justificativa, discussão ou opinião.
5. Montar a matriz interna **questão → evidência de aprendizagem**, registrando o conhecimento novo verificado por cada item.
6. Auditar cobertura, redundância, dependências entre itens e entrega inadvertida de respostas.
7. Resolver integralmente o checkpoint e produzir o gabarito com pontuação, critérios semânticos e implementações equivalentes aceitáveis.
8. Confirmar que cada resposta é determinada pelas informações fornecidas e que nenhuma regra de domínio necessária ficou implícita.
9. Comparar toda sintaxe, API, mecanismo, convenção e conceito com os materiais lidos. Substituir qualquer forma ainda não ensinada pela forma efetivamente conhecida; não ensinar durante o checkpoint.
10. Quando houver múltipla escolha, exigir exatamente cinco alternativas A–E, uma correta por padrão, quatro distratores plausíveis e distribuição não previsível das letras corretas. Auditar paralelismo gramatical, extensão e pistas involuntárias.

## Produzir variantes equivalentes

Criar Variante A e Variante B com as mesmas competências, distribuição de pontos, estrutura geral, dificuldade aproximada, tempo esperado e volumes comparáveis de leitura e escrita. Não gerar a segunda variante somente trocando nomes ou números de modo superficial.

Resolver ambas e auditar se alguma recebeu pista, ambiguidade, dependência ou carga adicional. O gabarito deve separar claramente as respostas de A e B.

Manter a identificação das variantes somente nos nomes internos dos arquivos e no gabarito. O estudante não pode encontrar variante ou código equivalente no cabeçalho, rodapé ou nome visível do instrumento.

## Diagramar e validar

1. Criar um diretório próprio em `avaliacoes/checkpoints/` e manter nele fontes, matriz interna, variantes, gabarito e PDFs.
2. Reutilizar `avaliacoes/templates/avaliacao-poo.sty` e o esqueleto de checkpoint.
3. Em instrumentos objetivos, preferir **Cabeçalho → Quadro de respostas → Cenário → Questões**, em A4, com exatamente duas páginas para o estudante, salvo razão explícita para outra composição. Tornar o cenário uma área de referência visualmente distinta.
4. Usar cabeçalho compacto com instituição, checkpoint, disciplina, nome e nota, sem matrícula. Não exibir variante, duração nem valor máximo; permitir pontuação individual e usar somente paginação discreta no rodapé.
5. Preferir questões diretas no formato **Questão X — enunciado**, sem exigir subtítulo temático. Tratar código inline com fonte monoespaçada, fundo neutro claro e separação visual do texto.
6. Fazer o quadro refletir exatamente itens e subitens e priorizar escrita simples de valores, V/F e letras, sem bolhas, coluna de correção, nota repetida ou tabelas pesadas.
7. Permitir syntax highlighting discreto sobre fundos brancos ou cinza muito claros, assegurando código legível em escala de cinza.
8. Compilar cada variante e o gabarito. A validação do template deve falhar se uma variante do estudante não tiver duas páginas.
9. Confirmar papel A4 e quantidade de páginas por ferramenta de inspeção de PDF.
10. Renderizar e inspecionar visualmente todas as páginas, verificando composição, hierarquia, margens, corpo aproximado de 11 pt, código e números de linha, cabeçalho, escala de cinza, quadro de respostas, equilíbrio, densidade e ausência de cortes.
11. Se não couber, remover redundância, condensar texto, melhorar a composição e reorganizar blocos antes de ajustar espaçamentos ou considerar pequena redução tipográfica.
12. Aplicar os critérios de `.agents/skills/revisar-avaliacao/SKILL.md` na revisão final, executar `git diff --check` e verificar `git diff` e `git status`.

Relatar arquivos, escopo, matriz de evidências, equivalência das variantes, resolução integral, duração estimada, páginas e inspeção visual. Não colocar avaliações em `docs/`, alterar aulas ou laboratórios, publicar, fazer commit ou push sem solicitação explícita.
