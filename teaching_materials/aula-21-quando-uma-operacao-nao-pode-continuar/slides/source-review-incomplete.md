# Revisão do fonte da Aula 21 — registro incompleto

A leitura do fonte contra o roteiro aprovado e o perfil POO não identificou
ajustes necessários ou recomendados. A sequência preserva contratos, fluxo,
cinco tipos de exceção, leitura do stack trace, teste com JUnit e transferência.
As sete atividades têm respostas visíveis no slide imediatamente seguinte.
Não há nova mecânica, currículo, laboratório ou entrega.

## Pendência do workflow

A chamada oficial `emit_review_run` falhou na validação do ProjectionSnapshot:
`WorkflowError: invalid review_run structure`, causada por
`jsonschema.exceptions._RefResolutionError: Unresolvable JSON pointer: '$defs/sha'`.
O erro ocorreu ao resolver os schemas compartilhados de snapshots e proveniência.
Não foi gravado um ReviewRun validado nem contornado o validador. Este relatório
é apenas um registro derivado; a revisão formal permanece incompleta.

A aprovação e a proveniência do deck foram validadas separadamente como
`VALID_CURRENT`. A renderização oficial confirmou fonte=HTML=PDF=39.
A inspeção visual está registrada no arquivo `.visual-review.json` deste diretório.

Limitações: revisão pelo próprio autor; sem execução Java/JUnit e sem observação
em sala. Esta revisão não autoriza publicação. Não houve alteração do Docemas.
