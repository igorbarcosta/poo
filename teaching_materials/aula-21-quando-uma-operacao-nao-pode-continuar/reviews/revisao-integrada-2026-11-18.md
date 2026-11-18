# Revisão integrada — Aula 21

## Avaliação geral

Roteiro e deck coerentes com o desenho acordado. Não foram encontrados erros
conceituais, previsões incorretas ou problemas visuais relevantes. O conjunto
está pronto após ajustes pontuais de acesso e documentação. A finalização formal
do workflow ainda depende de resolver a falha de validação da revisão de projeção.

Escopo: planejamento, LessonDesign, roteiro público, Java essencial, índice e
navegação, fonte Marp, HTML, PDF, aprovação, proveniência e evidências anteriores.
Não há Laboratório 21 definido no pacote; a revisão não impõe seus requisitos.

## Necessário — pendência técnica do workflow

A emissão do ReviewRun de projeção continua falhando por resolução de schema:
`Unresolvable JSON pointer: '$defs/sha'`, encapsulado por
`WorkflowError: invalid review_run structure`. A falha foi reproduzida; a cadeia
está em `projection-full-attempt-2026-11-18.json`, que explicitamente não é um
ReviewRun validado. Corrigir o validador e reemitir a revisão é necessário para
concluir formalmente essa etapa; não é uma correção do conteúdo didático.
Não houve alteração do Docemas nem contorno de sua validação.

## Recomendado — acesso aos slides

O roteiro, inclusive seus Materiais relacionados, não oferece links HTML/PDF
para o deck já gerado. O índice também não fornece esses links. Acrescentá-los
seguindo a convenção da Aula 20 permite ao aluno localizar as distribuições.
Alterar bytes do roteiro exige conferir novamente a classificação da aprovação;
não se deve atualizar uma aprovação histórica silenciosamente.

## Recomendado — situação do material na documentação

`specs/planejamento-aula-21.md:56–57` ainda afirma que não há aprovação ou slides.
`lesson-design.md:33–34` apresenta a revisão humana como futura sem datar o
contexto. Distinguir essas descrições históricas do estado atual por referências
aos registros evita ambiguidade. A aprovação e a proveniência existentes foram
verificadas separadamente e permanecem `VALID_CURRENT`.

## Preservar

- Comparação inicial entre recarga prevista e argumento inválido.
- Responsabilidades e contratos como eixo para os cinco tipos de exceção.
- Distinção entre capturar, corrigir a causa e preservar o estado.
- Sete atividades com resposta e justificativa no slide imediatamente seguinte.
- Uso mínimo de `assertThrows`, sem transformar lambdas em conteúdo autônomo.
- Transferência aberta aos jogos individuais, sem nova mecânica ou entrega.
- Dimensionamento de referência de 90 minutos com aprofundamentos elásticos.

## Verificações e limites

- Zensical: build concluído sem problemas; `git diff --check` sem erros.
- Contagens conferidas: 39 frames no fonte, 39 seções HTML e 39 páginas PDF.
- Hashes do fonte e renderizados coincidem com os da inspeção visual anterior.
- Visão global das duas folhas de contato HTML, incluindo os 39 frames.
- Renderização direta e inspeção ampliada das páginas PDF 15, 29 e 38.
- Texto extraível nas 39 páginas; cinco tipos de exceção presentes no PDF.
- Sete respostas expansíveis na página pública; exemplos confrontados com o
  código de Corpo, Partida, Nave, Inimigo e Projetil e com PartidaTest.
- ReviewRun canônico desta revisão validado em
  `pedagogical-full-canonical-2026-11-18.json`; nenhum registro anterior substituído.
- Sem execução Java/JUnit por ausência de Java/Javac no ambiente. A verificação
  dos exemplos foi estática. Sem observação em sala nem revisor independente.

Somente evidências e este relatório foram acrescentados. Roteiro, planejamento,
Java essencial, slides, renderizados e aprovações foram preservados.
