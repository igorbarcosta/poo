# Prova da Unidade 02 — exploração e itens mágicos

Base aprovada pelo professor. Variante A idêntica à base e variante B derivada, com equivalência pendente de aprovação humana. Recorte até a Aula 18, sem tratamento de exceções. Duração mantida em 90 minutos. Cada versão tem vinte saídas de três pontos e oito objetivas de cinco, totalizando cem pontos.

## Arquivos atuais

- `base.md` e `blueprint.md`: fontes aprovadas e congeladas pelo workflow.
- `variants/variant-a.md`: cópia semântica exata da base aprovada.
- `variants/variant-b.md`: variante com valores locais de rastreio e alternativas reordenadas.
- `answer-key.md`: gabarito completo das duas versões; `gabarito.md` é o espelho compatível com o caminho já usado neste repositório.
- `equivalence-review.md`: correspondência por questão, percursos, limites e verificação; decisão humana de equivalência pendente.
- `variantes/variante-a.md`, `variantes/variante-b.md` e `auditoria-equivalencia.md`: aliases dos arquivos canônicos schema v2, para os caminhos em português da skill local.
- `workflow.yaml`: base aprovada, variantes em revisão; aprovação das variantes e liberação para impressão pendentes.
- `rendered/variant-a.pdf` e `rendered/variant-b.pdf`: PDFs das duas versões, com fontes Typst e hashes em `rendered/sources.json`.
- `base-review.md`: histórico de revisão e registro da aprovação da base.
- `java/`: nove tipos do cenário, comuns às duas variantes.
- `unidade_02.typ`, `unidade_02.pdf` e `preview/`: derivados existentes da base. Preservados como histórico da base.

## Variantes e conferência

A variante A preserva integralmente a versão aprovada. B mantém IDs, pontos, ordem das questões, subitens, código de consulta, classes locais e evidências. Dez das vinte saídas mudam; as oito letras corretas também mudam. Resultados estruturais iguais foram preservados deliberadamente. A comparação inclui caminhos de execução, limites de estado e esforço aritmético, não apenas quantidade de itens.

Gabarito objetivo A: **B / E / D / C / B / A / B / C**.

Gabarito objetivo B: **D / C / E / D / A / E / D / A**.

As quarenta saídas foram executadas e conferidas. Os casos de Q16 e Q18 foram executados nas duas variantes. Alternativas, IDs, pesos e cinquenta e seis respostas/subitens foram conferidos; a validação estrutural completa passou. A equivalência é proposta pelo agente, ainda sem aprovação humana. Os PDFs A/B foram gerados a pedido explícito do professor, sem alterar os registros de aprovação de equivalência.

## Composição dos PDFs

Cada PDF tem seis páginas. Q1–Q8 ocupam a página 1; Q9–Q13, a página 2; Q14–Q17, a página 3; Q18–Q20, a página 4. O código de consulta ocupa as páginas 5–6. Questões e classes ficam inteiras. Mantêm-se os tamanhos de fonte e os espaços de resposta.

Q13 pede explicar uma rejeição em compilação; Q15 avalia o impacto de trocar o tipo do parâmetro de equipar; Q16 compara testes de uma recarga defeituosa; Q18 compara o alcance de dois testes independentes; Q19 avalia uma implementação padrão na classe base. Q1–Q12, Q14, Q17 e Q20 foram preservadas.

## Verificação da base antes das variantes

- Vinte saídas, IDs e pesos inalterados. Gabarito das objetivas: D/E/D/C/B/A/B/C.
- Q13: a atribuição a Usavel é válida; descrever é rejeitado por esse tipo.
- Q15: o método com parâmetro Equipamento compila e aceita Cajado/Amuleto, mas recusa Pocao e referências declaradas apenas Usavel. Despacho dinâmico preservado.
- Q16: os cinco testes passam no original; apenas C falha com a atribuição em lugar da soma.
- Q18: A falha só em II; B só em I; C/E em ambos; D em nenhum. Objetos reiniciados em cada teste.
- Q19: Orbe não compila contra a operação abstrata original; compila com a implementação padrão, conserva estado herdado e deixa Cajado/Amuleto com suas variações próprias.
- Código comum, questões preservadas, IDs, pontuação e blocos Java da base/Typst conferidos contra snapshot anterior. HTML, PDF e imagens atualizados; seis páginas.

## Histórico de revisões

O histórico de versões anteriores permanece em `historico/`, no pacote `unidade-02-primeira-revisao.zip` e nos registros de revisão; descrições de paginações anteriores não representam a versão atual. Não houve alteração do site, commit ou publicação.

Atualização de posição: Q17 e Q18 foram invertidas; a regra de vida zero é Q17 (B) e a análise do teste é Q18 (A). Os IDs e conteúdos das questões foram preservados. Referências anteriores a esses números neste arquivo descrevem a ordem anterior.

## Ajustes de cobertura em Q1–Q12

Aplicados os ajustes autorizados: Q2 observa teto da recarga e consumo posterior (Amuleto: 1/2); Q3 chama Inventario.listar (Cajado: 2/3; Poção vazia); Q8 observa aceitação e consumo com vida no máximo (true; 0). As outras nove questões de saída, IDs e pesos permanecem preservados. Base, Typst, gabarito, blueprint, registro de revisão, HTML, PDF e seis imagens atualizados. As vinte saídas foram executadas e conferidas. Não houve alteração do site ou publicação.

## Nova abordagem das objetivas

Q18 e Q19 foram substituídas conforme orientação do professor; Q15 e Q20 foram ajustadas. Gabarito, blueprint e registro de revisão acompanham a versão atual. Preservadas as demais questões e todas as letras corretas. A prova continua em revisão, sem liberação para impressão.

## Troca da página 2 dos PDFs

Por solicitação do professor, a página 2 (Q9–Q13) foi trocada entre os PDFs A e B e suas fontes Typst. Os gabaritos `answer-key.md` e `gabarito.md` já incorporam essa troca: cada seção A/B corresponde ao respectivo PDF. Os arquivos Markdown das variantes preservam a composição anterior.
