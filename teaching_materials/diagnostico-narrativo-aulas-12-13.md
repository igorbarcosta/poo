# Diagnóstico narrativo — slides das Aulas 12 e 13

## Evidência da aplicação

O professor relatou, após ministrar as aulas, várias frases e perguntas
ambíguas, sequências estranhas e perda do storytelling percebido na Unidade 01.
Este documento registra uma análise dos fontes dos decks, comparados com a
Aula 06 e com os roteiros. Não apresenta uma revisão visual dos renderizados.

## Achados

- **NECESSÁRIO — Aula 12, slides 19–21:** “Duas referências concretas” e
  “Guardar a escolha no pedido” aparecem como propostas alternativas, mas o
  método seguinte usa ambas. Explicitar que estamos completando uma mesma
  hipótese, com campos, escolha e seleção; manter seu estado visível.
- **RECOMENDADO — Aula 12, slides 26–33:** consequências, ponto de variação,
  necessidade, acoplamento e localização da escolha sucedem-se com pouco avanço
  concreto. O campo inicial também retorna depois das hipóteses sem anunciar
  qual versão está sendo examinada. Usar o terceiro canal para mostrar o impacto
  na mesma hipótese e nomear as ideias depois dessa observação.
- **RECOMENDADO — Aula 12, fechamento:** a preocupação com regressões aparece,
  mas a pergunta final volta à representação do contrato. A aula seguinte é de
  testes. Dar maior peso à pergunta imediata: como detectar o que uma mudança
  quebrou? Manter a questão do tipo como problema a retomar na Aula 14.
- **RECOMENDADO — Aula 13, slides 3–15:** a repetição do cenário e de suas
  descrições demora a produzir uma consequência nova. A entrega que motivou a
  aula retorna no slide 25. Manter explícito o comportamento que se quer
  preservar e fazer cada passo da verificação responder a uma necessidade
  visível, em vez de apenas reformular o passo anterior.
- **NECESSÁRIO — Aula 13, slides 23–24 e roteiro correspondente:** a operação
  que deixa o total em `230.0` não é especificada, e não se mostram dois estados
  distintos com esse total. A ideia geral é válida, mas a atividade não sustenta
  uma investigação determinada. Definir operação, estados e observações no
  roteiro antes de reprojetar o exemplo no deck.
- **NECESSÁRIO — Aula 13, slides 26–27:** o método alterado não informa a classe
  a que pertence, e os testes da suíte aparecem apenas como descrições. Mostrar
  `EntregaNormal.java` e identificar os testes efetivamente executados antes da
  previsão da falha.

## Comparação com a Unidade 01

Na Aula 06, a alteração de preço gera dois itens com preços divergentes; essa
consequência visível exige uma decisão de responsabilidade. A separação de
estado cria, por sua vez, a necessidade de colaboração. Cada passo nasce do
efeito do anterior. Nos trechos identificados das Aulas 12 e 13, o avanço fica
mais dependente de perguntas gerais e da reconstrução oral do exemplo.

Preservar os domínios, as regras e os objetivos. A recuperação deve se concentrar
na progressão dos cenários, na precisão das perguntas e na identificação da
versão do código em uso. Quantidade de slides e número de perguntas não são,
isoladamente, critérios de narrativa.

## Limitação do registro

Este é um diagnóstico consultivo, não um `ReviewRun` validado. A emissão pela
fronteira pública `emit_review_run` do Docemas falhou na validação de um
`ProjectionSnapshot` com `Unresolvable JSON pointer: '$defs/sha'`.
A proveniência da Aula 12 foi classificada como `VALID_CURRENT` antes da falha.
Nenhum roteiro ou fonte de deck foi alterado por esta análise.
