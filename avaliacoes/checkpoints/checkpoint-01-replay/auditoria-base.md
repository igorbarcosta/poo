# Auditoria formal da base — Checkpoint 01 Replay

## Resultado

**APROVÁVEL.** A base é mecanicamente íntegra, objetiva e compatível com o repertório até o Laboratório 04. Q05 agora coleta a evidência integradora contratada: adapta o cliente à versão encapsulada, preserva identidade, usa operações públicas, rejeita um valor inválido e prevê os efeitos nas duas referências.

## Achados oficiais

### NECESSÁRIO

- Nenhum.

### RECOMENDADO

- Nenhum.

### OPCIONAL

- Nenhum. Não foram registradas preferências de estilo.

### NÃO ALTERAR

- O cenário único `MedidorChuva`, a única `Main`, a sequência S1–S7, as cinco afirmações V/F, Q03, Q04 e Q06.
- A concentração das premissas antes dos dois artefatos Java consecutivos.
- A estrutura de seis questões, 16 unidades, 100 pontos e cobertura contabilizada em 30/30/40.

## Resolução determinística

| Questão | Unidades | Pontos | Resposta |
|---|---:|---:|---|
| Q01 | 7 | 35 | `true`, `false`, `true`, `10.0`, `8.0`, `12.0`, `1.0` |
| Q02 | 5 | 25 | V, V, V, V, F |
| Q03 | 1 | 10 | B |
| Q04 | 1 | 10 | A |
| Q05 | 1 | 10 | A |
| Q06 | 1 | 10 | B |
| **Total** | **16** | **100** |  |

Q03–Q06 têm cinco alternativas A–E e exatamente uma correta. Em Q05, somente A preserva simultaneamente identidade, encapsulamento, rejeição de `-2.0` e total `10.0` nas duas referências. As cinco afirmações V/F são determinadas. Não foram encontrados erros de nomes, tipos, membros, operadores, aspas ou sintaxe que criem causas incidentais de resposta; o acesso ilegal ao campo `private` em Q05C é deliberadamente a concepção diagnosticada.

## Passagem local e matriz de evidências

| Unidade | Evidência e ganho marginal | Demanda / carga incidental | Eixo | Pontos |
|---|---|---|---|---:|
| Q01a/S1 | reconhece o compartilhamento inicial | baixa / baixa | Referências | 5 |
| Q01b/S2 | separa identidade de estado igual | baixa / baixa | Referências | 5 |
| Q01c/S3 | rastreia atribuição sem criação ou cópia | média / baixa | Referências | 5 |
| Q01d/S4 | liga operação e referência compartilhada | média / baixa | Referências | 5 |
| Q01e/S5 | confirma independência de `principal` | média / baixa | Referências | 5 |
| Q01f/S6 | aplica novo redirecionamento a uma operação e observação cruzada | média / baixa | Referências | 5 |
| Q01g/S7 | materializa a violação permitida por campo exposto | média / baixa | Encapsulamento | 5 |
| Q02a | distingue estado e comportamento | baixa / baixa | Estrutura | 5 |
| Q02b | distingue dado temporário de estado | baixa / baixa | Estrutura | 5 |
| Q02c | distingue retorno de alteração de estado | média / baixa | Estrutura | 5 |
| Q02d | distingue cópia primitiva de acesso ao campo | média / baixa | Encapsulamento | 5 |
| Q02e | reconhece o acesso ao estado do objeto receptor | média / baixa | Estrutura | 5 |
| Q03 | atribui responsabilidade a quem conhece o estado | média / baixa | Estrutura | 10 |
| Q04 | identifica a escrita externa como quebra da fronteira | média / baixa | Encapsulamento | 10 |
| Q05 | adapta o cliente encapsulado preservando identidade, operações públicas, rejeição do inválido e efeitos compartilhados | alta / baixa | Encapsulamento | 10 |
| Q06 | compara alteração controlada e substituição arbitrária | alta / baixa | Encapsulamento | 10 |

Cada pedido é formulável em uma frase e imediatamente compreensível. Em Q05, regra, estado inicial, relação entre referências e efeitos esperados aparecem antes das alternativas; a profundidade vem da integração conceitual, não da leitura.

### Teste de remoção, sobreposição e independência

- S1–S6 possuem ganho incremental: compartilhamento inicial, distinção entre objetos com mesmo estado, redirecionamento, efeito compartilhado, independência e efeito após novo redirecionamento. S7 muda a evidência para exposição de estado.
- Q02 não verbaliza as respostas de Q01. Cada afirmação mede uma distinção estrutural autônoma.
- Q01g e Q04 formam continuidade válida entre observar e diagnosticar, sem dupla pontuação da mesma operação cognitiva.
- Q05 e Q06 não têm dependência de resposta: Q05 mede a adaptação do cliente a uma API encapsulada, enquanto Q06 repõe a regra e pergunta se ampliar essa API volta a permitir substituição arbitrária.
- Abandonar qualquer resposta não impede resolver outra unidade. Não há cascata de erro.

## Perspectiva do estudante

Os comandos são compreensíveis na primeira leitura, as referências são definidas e as regras relevantes aparecem localmente. Q01 exige rastreamento conceitual com carga incidental baixa; Q02 usa afirmações curtas; Q03–Q06 apresentam claramente a forma de resposta. Em Q05, o estudante identifica imediatamente a regra, a identidade que deve permanecer e o efeito esperado; depois compara três instruções Java por alternativa.

## Passagem global

**Arco observado:** rastrear identidade e estado → consolidar distinções estruturais → atribuir responsabilidade → diagnosticar exposição → adaptar o cliente à solução encapsulada → avaliar uma capacidade pública que volta a violar a regra.

O cenário é funcional, novo, coeso e economicamente reaproveitado. As premissas estão concentradas antes de `MedidorChuva.java` e `Main.java`, que aparecem consecutivamente. Não há storytelling ornamental, troca de domínio, contexto distante, reapresentação integral desnecessária nem fragmentação narrativa. Q06 usa adequadamente o princípio do delta.

A progressão Q04→Q05→Q06 está preservada: Q04 diagnostica a escrita externa; Q05 substitui essa fragilidade por uso correto da API sem romper o compartilhamento; Q06 avalia se uma nova operação pública reabre a violação. Q05 e Q06 concentram a maior profundidade com baixa carga incidental.

### Cobertura e pontos

| Eixo | Unidades contabilizadas | Pontos |
|---|---|---:|
| Estrutura e responsabilidade | Q02a–Q02c; Q02e; Q03 | 30 |
| Referências e identidade | Q01a–Q01f | 30 |
| Encapsulamento e evolução controlada | Q01g; Q02d; Q04; Q05; Q06 | 40 |
| **Total** | **16 unidades** | **100** |

A contabilidade 30/30/40 e a evidência qualitativa de Q05 correspondem ao blueprint.

## Revisão adversarial e regressão pedagógica

A suíte P01–P17 foi aplicada ao estado atual:

- P01–P03: sem unidade descartável, verbalização do rastreamento ou vazamento retroativo.
- P04–P07: redação, representação, contexto e regras são determinados.
- P08: há arco global e progressão intencional até a adaptação e a análise da API.
- P09: o cenário tem função diagnóstica e não é decorativo.
- P10: Q05 e Q06 são profundas e claras, sob regras explícitas.
- P11–P12: Q05 apresenta somente o pequeno contexto local e alternativas comparáveis; Q06 apresenta apenas o delta necessário.
- P13–P15: premissas aparecem antes do código; a representação é adequada; as repetições mantidas sustentam evidências distintas.
- P16: cenário, respostas e distratores usam apenas classes, campos, variáveis, referências, `new`, métodos, parâmetros, `return`, `void`, `if`, comparações simples, tipos básicos, acesso com `.`, `public`, `private` e acesso de pacote. Não há mecanismo posterior ao Laboratório 04 em alternativa incorreta.
- P17: o cenário não é fragmentado; os dois arquivos aparecem juntos após as premissas.

O teste adversarial não encontrou unidade descartável nem simplificação que preserve a mesma evidência de Q05. Remover a relação `apoio = principal`, a rejeição de `-2.0` ou os dois efeitos esperados reduziria a integração contratada; acrescentar contexto aumentaria apenas a carga incidental.

## Tempo e viabilidade física

A carga estimada permanece em 50 minutos: aproximadamente 4 de leitura, 11 em Q01, 7 em Q02, 9 em Q03–Q04, 14 em Q05–Q06 e 5 de revisão. Q05 acrescenta integração conceitual, mas limita cada alternativa a três instruções e fornece localmente todos os critérios.

O preview contínuo apresenta texto e código legíveis e preserva os tokens Java. A estrutura é provavelmente componível em duas páginas A4, mas essa paginação só pode ser confirmada na fase de renderização; nenhum PDF foi gerado.

## Verificações técnicas

- `workflow.py validate`: workflow válido, `blueprint_aprovado` íntegro e `base_aprovada` pendente.
- `preview.mjs check`: `preview/base.html` íntegro e correspondente a `base.md`.
- Conferência manual de S1–S7, V/F, unicidade de Q03–Q06, sintaxe literal e inventário Java.
- Estrutura confirmada: 6 questões, 16 unidades, `35/25/10/10/10/10`, 100 pontos e contabilidade `30/30/40`.
- `git diff --check`: sem erros.

## Limitações dependentes de julgamento humano

- A duração de 50 minutos é estimativa pedagógica, não teste cronometrado com estudantes.
- A composição em exatamente duas páginas A4 depende da futura diagramação e renderização, fora deste estágio.

## Conclusão

**APROVÁVEL.** Q05 satisfaz o papel cognitivo do blueprint sem regressão de clareza, cobertura, repertório, independência ou narrativa. Nenhum gate foi executado.
