# Auditoria de equivalência — Checkpoint 01 Replay

## Correspondência estrutural

As variantes preservam os identificadores Q01–Q06, os subitens de Q01 e Q02, as 16 unidades corrigíveis e a distribuição `35/25/10/10/10/10`.

| Questão | Variante A | Variante B | Evidência preservada |
|---|---|---|---|
| Q01 | comparações compartilhada/distinta, confirmação do redirecionamento e consultas alterado/independente | ordem invertida das comparações, contraste após redirecionamento e consultas independente/alterado | identidade, redirecionamento, compartilhamento e independência |
| Q02 | afirmações V, V, V, V, F | mesmas distinções com polaridades F, F, F, F, V | estado/comportamento, parâmetro/campo, `void`, cópia de valor e acesso ao próprio estado |
| Q03 | resposta B | resposta E | responsabilidade atribuída ao objeto que conhece o estado |
| Q04 | resposta D | resposta B | acesso de pacote na ausência de modificador |
| Q05 | total esperado `10.0`, resposta C | total esperado `12.0`, resposta D | uso de API encapsulada, referência compartilhada, rejeição de valor inválido e efeito final |
| Q06 | resposta A | resposta C | contraste entre alteração controlada e setter irrestrito |

## Resolução integral

### Variante A

- Q01: `true`, `false`, `true`, `10.0`, `8.0`, `12.0`, `1.0`.
- Q02: V, V, V, V, F.
- Q03: B.
- Q04: D.
- Q05: C.
- Q06: A.

### Variante B

- Q01: `false`, `true`, `false`, `6.0`, `9.0`, `11.0`, `2.0`.
- Q02: F, F, F, F, V.
- Q03: E.
- Q04: B.
- Q05: D.
- Q06: C.

## Conferência de equivalência

- **Competências:** idênticas por questão e por subitem.
- **Demanda cognitiva:** Q01 preserva a mesma quantidade de objetos, referências, redirecionamentos, operações e observações; a Variante B muda valores e a ordem das comparações e consultas. Q02 preserva as cinco distinções conceituais e inverte a polaridade de todas as respostas em relação à Variante A. Q03–Q06 preservam o mesmo pedido e os mesmos distratores conceituais.
- **Dificuldade:** equivalente. Os cálculos usam apenas somas simples com números inteiros representados como `double`; nenhuma variante introduz etapa adicional.
- **Leitura e escrita:** equivalentes. Estrutura, extensão, número de blocos de código e quantidade de respostas são os mesmos.
- **Tempo esperado:** equivalente e compatível com a referência de 50 minutos da base.
- **Independência:** cada questão permanece resolvível sem resposta anterior; as mudanças propostas em Q05 e Q06 continuam analisadas separadamente.
- **Repertório:** ambas usam somente o conteúdo disponível até o Laboratório 04.

## Distratores e posições corretas

| Questão | Variante A | Variante B |
|---|---:|---:|
| Q03 | B | E |
| Q04 | D | B |
| Q05 | C | D |
| Q06 | A | C |

As posições corretas foram redistribuídas sem alterar o conteúdo conceitual. Os distratores correspondentes foram apenas reordenados em Q03, Q04 e Q06. Em Q05, a Variante B substitui os valores por equivalentes e preserva os mesmos quatro modos de erro: romper o compartilhamento, acessar diretamente o campo privado, acumular um valor que deveria ser inválido e não concluir a acumulação necessária.

### Separação dos gabaritos

- Q01: as sete respostas diferem entre A e B; S1–S5 mudam pela ordem das observações, e S6–S7 usam valores distintos.
- Q02: as cinco respostas V/F são opostas entre A e B.
- Q03–Q06: a posição correta difere em todas as quatro questões.

Assim, as 16 unidades corrigíveis possuem resposta literal ou posição correta diferente entre as variantes.

## Conclusão

As variantes são semanticamente equivalentes e estão prontas para revisão e decisão humana sobre `variantes_aprovadas`. Nenhum gate foi registrado nesta etapa.
