# Auditoria de equivalência — Unidade 02

## Estado e escopo

A base foi aprovada explicitamente pelo professor: “A prova está aprovada. POde fazer a variante.” A variante A reproduz a base integralmente. A variante B altera somente valores locais de rastreio e a ordem das alternativas. Base e blueprint foram congelados; não foram editados nesta etapa. As variantes são fontes semânticas, sem identificação de versão no texto ao estudante, cabeçalho administrativo ou diagramação.

Este relatório registra a análise do agente, informada pelo contexto de autoria. Não é auditoria independente nem decisão humana de equivalência. A aprovação da base não foi interpretada como aprovação antecipada da variante B.

Base/A SHA-256: `f274ac908cabe904c62249308e7eaa484b3e5f970a9fd3cc1cddec7fa6e14e4b`.

Blueprint SHA-256: `3bd55cc2947f867933a07591a678f3b7a8bd011a100c9e81029b95802496a92f`.

Variante B SHA-256: `d5e216500aeec0830efc4b53a19b967aab9b05a0dedeb6210c2bbc585b6eb791`.

## Correspondência por questão

| Questão | Resposta A | Resposta B | Evidência e equivalência |
| --- | --- | --- | --- |
| Q1 | `100`; `7` | `100`; `9` | Mesmos ramos: teto superior, rejeição de dano negativo, piso zero, recuperação positiva e rejeição de recuperação negativa. |
| Q2 | `Amuleto: 1/2` | `Amuleto: 1/2` | Recarga supera o máximo dois em ambas; um uso posterior consome uma carga. Não se altera a saturação. |
| Q3 | `Cajado: 2/3`; `Poção vazia` | `Cajado: 1/3`; `Poção vazia` | Mesmos dois itens, ordem e estado consumido da poção; muda somente a carga inicial do cajado. |
| Q4 | `false`; `28` | `false`; `29` | Mesmas duas posições para um único cajado; sucesso seguido de recusa, sem segundo dano. |
| Q5 | `38` | `48` | Mesma reatribuição sem substituir o colaborador guardado; muda apenas a vida do alvo. |
| Q6 | `47`; `56` | `49`; `54` | Mesmos dois personagens e destinatários; ambos os efeitos continuam longe dos limites de vida. |
| Q7 | `true` | `true` | Trecho idêntico: casts preservam identidade. |
| Q8 | `true`; `0` | `true`; `0` | Trecho idêntico: vida máxima, sucesso e consumo. Alterar esses dados arriscaria perder a evidência. |
| Q9 | `false`; `63` | `false`; `62` | Mesmo ramo sem equipamento e mesmos dois ifs; cura e dano sem atingir limites, segunda tentativa recusada. |
| Q10 | `38` | `48` | Mesma classe local, zero cargas e sobrescrita; muda apenas a vida inicial do alvo. |
| Q11 | `2`; `1` | `2`; `1` | Trecho idêntico: capacidade opcional e modificação do objeto original. |
| Q12 | `95`; `95` | `96`; `96` | Mesmo número de camadas, ordem e recusa propagada. Caminho correto não atinge o teto em nenhuma versão. |
| Q13 | D | B | Mesmo erro de compilação e as mesmas cinco explicações, apenas reordenadas. |
| Q14 | E | C | Mesma proposta de herança e os mesmos cinco comentários, apenas reordenados. |
| Q15 | D | E | Mesma restrição do parâmetro e os mesmos cinco efeitos propostos, apenas reordenados. |
| Q16 | C | D | Mesma implementação defeituosa e os mesmos cinco testes, apenas reordenados. Não há novo cálculo. |
| Q17 | B | A | Mesma regra local, entradas e cinco locais/momentos de validação, apenas reordenados. |
| Q18 | A | E | Mesmos dois testes independentes e defeitos; alvo 46/48 e esperado 34/36 preservam dano 12 sem limites. |
| Q19 | B | D | Mesma implementação padrão, subclasse local e cinco consequências propostas, apenas reordenadas. |
| Q20 | C | A | Mesmo getter, limite e explicações sobre referências, apenas reordenadas. |

## Percursos e limites preservados

- Q1 A: 88 + 19 ultrapassa 100; B: 86 + 17 também ultrapassa. O dano de 130/125 leva ao mesmo piso zero. Recuperações finais sete/nove e valores negativos preservam os caminhos.
- Q2: cinco/quatro unidades superam a capacidade dois; o consumo posterior deixa uma carga em ambas.
- Q4: 40 → 28 em A e 41 → 29 em B; a segunda tentativa continua recusada pelo mesmo objeto sem cargas.
- Q5: 50 → 38 e 60 → 48. A variável reatribuída não muda o cajado equipado.
- Q6: A termina em 47/56; B em 49/54. Não há saturação, vida zero ou recusa nova.
- Q9: 49 → 69 → 63 e 48 → 68 → 62. A segunda tentativa da poção continua sem efeito e sem dano posterior.
- Q10: 43 → 38 e 53 → 48, executando a mesma sobrescrita.
- Q12: 97 → 85 → 90 → 95 e 98 → 86 → 91 → 96. Os dois caminhos corretos ficam abaixo de 100. Colocar uma cura antes do dano ainda atingiria o teto em ambas, preservando a distinção de ordem. No segundo uso, a recusa continua impedindo as duas curas.
- Q18: os testes reiniciam objetos. Dano simples produz 34/36; ausência de dano mantém 46/48; dano duplo produz 22/24. Os padrões de aprovação/reprovação dos testes são iguais nas alternativas correspondentes.

## Permutação das alternativas

Cada sequência abaixo indica quais alternativas da base ocupam A/B/C/D/E na variante B. O conteúdo dos distratores permanece integralmente igual; apenas o estado numérico comum da Q18 muda.

| Questão | Ordem antiga nas posições A–E de B | Correta A | Correta B |
| --- | --- | --- | --- |
| Q13 | C / D / E / A / B | D | B |
| Q14 | B / D / E / A / C | E | C |
| Q15 | C / A / E / B / D | D | E |
| Q16 | D / E / A / C / B | C | D |
| Q17 | B / E / A / D / C | B | A |
| Q18 | D / B / E / C / A | A | E |
| Q19 | E / C / A / B / D | B | D |
| Q20 | C / E / D / B / A | C | A |

## Julgamento de equivalência

- **Estrutura e pontos:** mesmos vinte IDs de questões, IDs dos subitens, ordem, vinte linhas de saída de três pontos e oito objetivas de cinco. Cem pontos em cada versão.
- **Evidências:** mantidas por unidade corrigível. Não foram trocados tipos, operações, contratos, condições, ordem de efeitos ou classes locais.
- **Dificuldade:** os números variam sem aumentar dígitos, acrescentar operações ou atravessar limites novos. Também foram preservadas as necessidades de transporte e empréstimo nas contas: Q4/Q5/Q10 continuam exigindo empréstimo, Q6 conserva seus padrões de soma/subtração e Q9 não ganha um empréstimo novo. A preservação dos percursos é a razão da equivalência proposta; respostas diferentes por si só não a demonstrariam.
- **Leitura e escrita:** mesmos enunciados, classes, número de blocos, linhas e respostas. Permutar alternativas não acrescenta informação ou sintaxe.
- **Tempo:** expectativa relativa equivalente; os 90 minutos da base permanecem referência, sem alegação de medição empírica.
- **Independência:** não foram acrescentadas pistas, resultados fornecidos por outras questões ou dependência de respostas anteriores. O cenário comum permanece byte a byte idêntico.
- **Separação:** dez das vinte saídas diferem; todas as oito letras corretas diferem. As saídas booleanas, descrições de estado consumido e alguns saldos estruturais permanecem iguais para preservar os objetivos. Não se promete proteção absoluta contra cópia.
- **Repertório:** sem recursos novos além da base aprovada.

## Verificação

Comparação determinística confirmou base/A idênticas, base e blueprint intactos, cenário comum preservado, IDs/pontos/subitens iguais, correspondência integral das alternativas e 56 respostas/subitens no gabarito. Execução em Java 21 concluída: quarenta saídas conferidas com os gabaritos; vinte resultados de testes da Q16 nas duas implementações e vinte resultados dos testes independentes da Q18 conferidos. Nas demais objetivas, as alternativas e o código são os mesmos da base aprovada, com correspondência integral verificada e resolução registrada nos dois gabaritos. A validação estrutural completa de variantes e respostas passou, mantendo a aprovação humana de equivalência pendente.

## Decisão humana

- **Aprovação da base:** registrada a partir da manifestação explícita do professor.
- **Aprovação da equivalência das variantes:** pendente.
- **Decisão:** a registrar somente após manifestação explícita do professor sobre estas versões.
- **PDFs:** versões A e B geradas por solicitação explícita do professor; seis páginas por versão, com diagramação conferida. A geração não altera a decisão humana de equivalência nem o registro de liberação para impressão.

## Compatibilidade do validador

O parser de provas já aceitava Q1, enquanto o leitor de gabaritos exigia Q01. A numeração da base congelada foi preservada. O wrapper local passou a aceitar um ou mais algarismos também nos títulos das respostas, sem normalizar rótulos nem relaxar unicidade, correspondência ou subitens. Testes de integração verificam Q1 e Q01, rejeitam respostas duplicadas e preservam o replay histórico. Cinco testes passaram. Nenhum arquivo do Docemas externo foi alterado.
