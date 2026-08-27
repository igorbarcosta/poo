# Checkpoint 1 — matriz e auditoria da versão-base

Documento interno da etapa de revisão humana. Esta matriz descreve somente `checkpoint-01-base.tex`; variantes e gabarito não integram esta etapa.

## Estrutura

- Q1: teste de mesa com 5 itens — 25 pontos;
- Q2: verdadeiro/falso com 5 itens — 25 pontos;
- Q3–Q12: 10 questões de múltipla escolha com cinco alternativas — 5 pontos cada;
- total: 100 pontos;
- duração estimada: aproximadamente 50 minutos;
- exatamente duas páginas A4.

## Matriz de evidências

| Questão | Nível | Evidência principal | Resolução interna |
| --- | --- | --- | --- |
| Q1 | Avançado | Rastrear estado por referências compartilhadas e por um objeto independente. | `1`, `true`, `2`, `false`, `1` |
| Q2 | Médio | Analisar acesso privado, retorno e regras de alteração implementadas em `subir()`. | F, V, V, V, V |
| Q3 | Fácil | Transferir a modelagem por objetos para uma nova unidade do mesmo sistema, reunindo estado e comportamento relacionados. | C |
| Q4 | Fácil | Distinguir classe, variável de referência e objeto criado. | B |
| Q5 | Fácil | Distinguir estado e comportamento pelos papéis no programa. | A |
| Q6 | Fácil | Interpretar parâmetro e retorno na assinatura de um método. | D |
| Q7 | Médio | Diferenciar valor padrão de campo e inicialização de variável local. | B |
| Q8 | Avançado | Decidir onde deve ficar a regra de lotação depois que esse estado é explicitamente acrescentado a `Elevador`. | E |
| Q9 | Médio | Acompanhar argumento, retorno e ausência de alteração do campo consultado. | D |
| Q10 | Avançado | Distinguir estados iguais, identidade e evolução independente. | C |
| Q11 | Médio | Aplicar a fronteira do acesso de pacote a uma chamada feita por classe de outro pacote. | B |
| Q12 | Avançado | Prever a consequência concreta de uma operação pública que altera um campo privado sem validar a regra. | D |

A distribuição contém quatro questões fáceis, quatro médias e quatro avançadas.

## Auditoria de clareza

- **Q1:** solicita o valor exato de cada linha indicada. As cinco linhas existem e a ordem é inequívoca.
- **Q2:** delimita que somente o trecho apresentado muda; getters e operações de porta permanecem como no cenário. Os itens verificam, separadamente, acesso externo, retorno e mudança de estado, bloqueio pela porta, limite superior e consulta por getter.
- **Q3:** apresenta um chamado de manutenção que não existe no cenário e pede uma organização para seus dados e sua ação. Assim, exige transferência da ideia de objeto em vez de repetir a estrutura já mostrada em `Elevador`.
- **Q4:** usa uma única instrução e explicita os três papéis que devem ser identificados: classe, variável de referência e objeto criado.
- **Q5:** nomeia diretamente o campo e o método cuja função deve ser classificada, sem exigir a interpretação prévia do termo genérico “membros”.
- **Q6:** explicita o dado recebido, seu tipo e a ausência de retorno.
- **Q7:** pergunta primeiro se compila e, caso negativo, qual linha impede a compilação. A leitura da variável local não inicializada causa erro de compilação na linha 5; não existe etapa posterior de execução.
- **Q8:** declara explicitamente a introdução de `quantidadePessoas`, o limite e a decisão necessária ao embarcar. Assim, não exige imaginar um estado inexistente e permite avaliar onde a regra deve ser preservada.
- **Q9:** separa `Elevador.java` de `Main.java` dentro do painel. A criação, a subida e a chamada determinam `diferenca = 2` e mantêm `andarAtual = 1`.
- **Q10:** apresenta como bloco as duas criações e a chamada; não depende de imaginar código omitido.
- **Q11:** apresenta uma chamada a partir de outro pacote, situação não resolvida pela execução mostrada no cenário, e informa explicitamente que o método permanece sem modificador.
- **Q12:** fornece a faixa válida, o método acrescentado e a chamada concreta com o valor 8. A resposta exige prever que o código compila e armazena 8 porque não existe validação.

## Auditoria de alternativas

Cada questão Q3–Q12 possui exatamente uma resposta correta. Os distratores representam confusões identificáveis: classe versus variável, objeto versus referência, estado versus comportamento, retorno versus parâmetro, valor padrão de campo aplicado indevidamente a variável local, regra deslocada para `Main`, retorno confundido com alteração de estado, igualdade de estado confundida com identidade, acesso de pacote confundido com `public` ou `private`, e campo privado confundido com preservação automática de regras.

As alternativas são semanticamente comparáveis e não dependem de erro incidental de identificador ou de regra omitida.

## Independência e redundância

- Q1 mede uma sequência temporal com alias; Q10 mede identidade e independência de dois objetos criados separadamente.
- Q2 mede consequências concretas de acesso, retorno e execução de `subir()`; Q8 mede onde deve ficar a decisão sobre uma nova regra de lotação cujo estado foi explicitamente apresentado.
- Q6 mede leitura de assinatura; Q9 mede o comportamento de uma chamada com parâmetro e retorno.
- Q8 mede quem mantém uma regra; Q12 verifica se uma operação pública realmente preserva uma regra já atribuída à classe.
- Q11 isola a fronteira do acesso de pacote em uma situação diferente do cenário; observar que `Main` chama o getter no mesmo pacote não responde o que ocorre em outro pacote.
- Q3 exige transferir a organização por objetos para um chamado de manutenção que não aparece no cenário; portanto, o cenário não fornece literalmente sua resposta.
- Q3–Q12 fornecem todas as premissas necessárias no próprio item e não dependem de respostas anteriores.

## Composição visual

Q1 e Q2 aparecem lado a lado na primeira página, com larguras proporcionais ao volume de cada questão. Q3–Q7 e Q8–Q12 formam duas colunas na segunda página. Todo trecho com mais de uma linha aparece em painel de código com numeração. O quadro de respostas contém quatro linhas: Q1, Q2, Q3–Q7 e Q8–Q12. Os títulos das questões recebem um divisor horizontal discreto, e o código dos painéis internos usa corpo visualmente equivalente ao texto das questões.

## Estado do fluxo

Foram concluídos ciclos integrados de revisão e correção. A auditoria detectou e corrigiu entregas inadvertidas de resposta pelo cenário em versões anteriores de Q3 e Q11. A rodada seguinte tornou Q2 mais variada ao combinar retorno e regras de estado, declarou o novo estado exigido por Q8 e transformou Q12 em uma previsão concreta de execução. Os enunciados passaram pelo teste de situação → ação/condição → resposta esperada.

A versão-base aguarda revisão e aprovação humana. Não gerar ou atualizar variantes e gabarito até solicitação explícita de finalização.
