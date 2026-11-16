# Calibração da compreensão dos enunciados — Unidade 02

## Escopo e entradas

Esta calibração acompanha a atualização das skills de autoria/revisão e das instruções de auditoria. Usa Q15–Q17 como casos reais e três controles genéricos. Não executa a avaliação formal dos três auditores nem produz um resultado de maturação.

Cada tarefa leitora recebeu apenas o procedimento de leitura e o material estudantil indicado, em contexto novo, sem conversa de autoria, blueprint, gabarito, classificação esperada ou achados de outras tarefas. Os pacotes reais continham instruções, as três questões e o código completo do cenário. Os leitores foram orientados a reconstruir a tarefa sem resolver saídas ou selecionar alternativas.

| Leitura | Resultado observado |
| --- | --- |
| `student_reading_before` | Com a primeira redação do procedimento, recuperou a intenção da Q15 anterior e não identificou lacuna essencial. Preservou Q16/Q17. |
| `student_reading_v2` | Após explicitar a distinção entre compreensão e resposta calculável, voltou a aceitar Q15 e registrou que não precisava conhecer a classe envolvente do método. Preservou Q16/Q17. |
| `student_reading_after` | Leu somente a nova versão. Identificou por trechos explícitos a inclusão das classes Oficina e Cristal numa nova versão do programa e a operação a alterar. Preservou Q16/Q17. |
| `comprehension_controls` | Identificou o alvo não definido nos dois casos defeituosos e preservou o caso de extensão local completa. Os três controles foram lidos na mesma tarefa, como instrumentos independentes. |
| `student_reading_full` | Reconstruiu Q1–Q20 em uma nova tarefa isolada, sem resolver respostas. Apontou a associação não declarada entre I–IV e as linhas de Q13 no pacote Markdown. Não encontrou outra relação material ausente. |

## Q15 — objeção, divergência e correção

O professor apontou que “a oficina é o local onde se recarregam itens” não estabelecia sua relação com o cenário/programa, e que “será acrescentado um cristal” deixava o destino do acréscimo indefinido.

Os dois leitores da versão anterior consideraram a tarefa recuperável. Esse resultado diverge da observação editorial do professor e não foi descartado nem transformado em alegação de ambiguidade técnica. Também não demonstra que leitores estudantes reais tenham a mesma compreensão. O ajuste decorre da exigência do professor de explicitar a intervenção no programa.

| Relação a esclarecer | Âncora atual |
| --- | --- |
| Destino da alteração | “Em uma nova versão do programa do jogo” |
| Papel da oficina no programa | “a classe Oficina será responsável por recarregar objetos” |
| Dono do método exibido | “Seu método inicial é”, após a apresentação da classe Oficina |
| Destino da introdução de Cristal | “Essa versão também terá a classe Cristal” |
| Pedido | Atender equipamentos e cristais preservando a chamada de recarga, sem casts nem testes de classe concreta. |

A versão atual não exige presumir que o cristal será incluído no inventário ou que uma localidade do jogo corresponde automaticamente a uma classe. A leitura posterior confirmou essas relações explícitas. Não se reescreveram Q16/Q17 apenas para produzir mudanças: seus métodos, preparações, intervenções e pedidos já foram reconstruídos a partir das fontes fornecidas.

## Passagem pela prova inteira

Após a calibração, outra tarefa recebeu a prova estudantil completa, com instruções, vinte questões, alternativas e cenário. Não recebeu os resultados dos pilotos. Reconstruiu as tarefas com apoio no código e preservou os comandos curtos que já ofereciam situação e pedido suficientes.

O leitor apontou que Q13 mencionava I–IV sem associá-los explicitamente às quatro linhas no material Markdown. Os rótulos já existiam no Typst, mas a base e o preview dependiam da inferência da ordem. A correção na base e no Typst declara: “as chamadas do segundo bloco, identificadas como I, II, III e IV nessa ordem”. A âncora agora identifica o bloco e a correspondência solicitada, sem alterar qualquer chamada ou alternativa. Essa verificação final da frase foi feita pelo autor, sem alegação de uma segunda confirmação independente.

## Controles genéricos

Os controles correspondem aos casos mantidos em `Docemas/assessments/examples/auditor-evaluation/`. O leitor recebeu rótulos neutros A/B/C e somente as bases estudantis, sem os nomes diagnósticos ou blueprints.

| Caso | Expectativa | Observação |
| --- | --- | --- |
| `unanchored-change` | Reconhecer que um novo máximo não foi associado nem ao total de um registro nem à quantidade de registros. | Identificou as duas leituras e seus apoios literais, sem escolher uma resposta. |
| `narrative-only-repair` | Reconhecer que explicar onde registros ficam não identifica qual grandeza recebe o máximo. | Localizou a relação ainda ausente apesar das frases adicionais. |
| `explicit-local-extension` | Preservar a extensão que informa tipo, operação, limite e pedido. | Reconstruiu a tarefa sem exigir história adicional ou inclusão prévia no cenário comum. |

Esses controles demonstram o comportamento observado nesses exemplos, não uma taxa de detecção ou garantia de clareza em outras questões. As expectativas estruturadas dos fixtures não substituem a inspeção qualitativa das reconstruções.

## Identidade dos materiais

| Material | SHA-256 |
| --- | --- |
| Procedimento revisado de leitura | `3d195e51cf7ee4ea5fc3d9da7415d0e06d73ab497ff7a2823b1e68ed429ae6b1` |
| Pacote estudantil anterior Q15–Q17 | `6bfe78be37f630f193e7739f88b38a8c4b56dafca632886f21503550a0bfcb61` |
| Pacote estudantil posterior Q15–Q17 | `1f8d4fd36ec8052a803cfc3cc0ad49e0d26625e7f8d881c134b1517fea50065c` |
| Prova estudantil completa lida antes da correção de Q13 | `e25d7ad556e1c3ac9a425681bfec886442f395f4f686b4cb8657f041c39f442a` |
| Controle A — extensão explícita | `5b8b70f6d1d82e7d05b7dc33d7341cd7686806205b99f2d7b8325fcfc08bdfd3` |
| Controle B — reparo narrativo | `07bef02aae84c6d6821b2db74226a92bbeb5add1886352e5f678c6c252e056f8` |
| Controle C — alvo ausente | `3f88f7237fb239e4525347c153dd069249757d6f46be352dea7b4e284f2d7ef7` |

O procedimento corresponde à referência `review-assessment/references/student-reading.md`. Os pacotes foram derivados da base sem front matter nem IDs de engenharia. As execuções locais ficaram em diretório temporário; as relações relevantes e os limites do ensaio estão preservados neste registro.

## Limite operacional

O runner formal de auditoria continua fornecendo o snapshot completo, incluindo o blueprint. Suas três tarefas isoladas não equivalem a uma primeira leitura sem intenção autoral. As leituras descritas acima foram tarefas separadas de calibração, com entrega controlada de entradas estudantis. A atualização das skills deve preservar essa distinção e não registrar “leitura cega” quando o contexto já incluía a intenção do autor.

## Verificação da implementação

- As seis skills alteradas passaram no validador de skills: autoria, revisão, auditoria pedagógica e adversarial no Docemas, e as duas interfaces locais de POO.
- `npm test` no Docemas passou: 130 testes de avaliações e 123 de materiais didáticos. A cópia testada antes da instalação também passou nos mesmos 253 testes.
- As versões antigas das três skills de auditoria foram preservadas para baseline-v1, sem alterar os hashes históricos. Uma regressão verifica as instruções efetivamente entregues aos três adapters quando o runner recebe uma seleção explícita de versões. A alteração de software está registrada no OpenSpec `preserve-frozen-assessment-skills`.
- Foram conferidos os 40 blocos Java, todas as alternativas e todos os IDs/pesos da prova contra o estado anterior à calibração. Apenas os enunciados de Q13/Q15 mudaram nesta passagem.
- O preview corresponde à base atual, o workflow permanece válido e o Typst compilou. A consulta de layout confirmou seis páginas, vinte questões inteiras na mesma coluna do início ao fim e dentro das margens; a página alterada foi inspecionada visualmente.
