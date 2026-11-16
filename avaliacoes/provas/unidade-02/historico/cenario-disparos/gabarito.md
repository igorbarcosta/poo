# Gabarito comentado — primeira versão da Unidade 02

Material exclusivo do professor. Base até a Aula 18; sem tratamento de exceções. Cada questão vale 5 pontos; total: 100. Não constitui aprovação nem liberação para impressão.

| Questão | Alternativa ou saída (uma linha por valor) |
| --- | --- |
| Q1 | C |
| Q2 | `0`, `0`, `true` |
| Q3 | `4`, `2` |
| Q4 | B |
| Q5 | D |
| Q6 | `3`, `1`, `1` |
| Q7 | C |
| Q8 | `2`, `1`, `1` |
| Q9 | `2` |
| Q10 | `8`, `4` |
| Q11 | E |
| Q12 | C |
| Q13 | D |
| Q14 | A |
| Q15 | B |
| Q16 | C |
| Q17 | `false` |
| Q18 | D |
| Q19 | A |
| Q20 | C |

## Q1 — C

Nave consulta se a partida terminou antes de solicitar o disparo ao colaborador. Arma conta suas execuções de disparar. Partida mantém vidas, tiros e fim.

## Q2 — saída

```text
0
0
true
```

As três primeiras perdas encerram a partida. As duas seguintes retornam sem alterar vidas. registrarTiros também ignora a solicitação depois do fim.

## Q3 — saída

```text
4
2
```

Cada chamada a Nave.disparar solicita um disparo à mesma ArmaDupla. Duas chamadas produzem quatro tiros e dois acionamentos.

## Q4 — B

O objeto é ArmaDupla. Ele herda disparar de Arma; a chamada a quantidadeTiros dentro desse método chega à sobrescrita de ArmaDupla. Nenhuma arma adicional é criada.

## Q5 — D

Disparo oferece disparar, mas não getAcionamentos. Contabilizavel oferece getAcionamentos, mas não disparar. O mesmo objeto cumprir ambos não amplia as operações de cada tipo declarado.

## Q6 — saída

```text
3
1
1
```

O laço alcança duas armas diferentes: a simples registra um tiro; a dupla, dois. Cada objeto executa disparar uma vez e incrementa seu próprio contador uma vez.

## Q7 — C

O construtor e o campo de Nave dependem de Disparo. A montagem muda para new Nave(p, new DisparoTriplo()); não é necessário alterar Nave nem fazer a nova classe herdar de Arma.

## Q8 — saída

```text
2
1
1
```

O contador pertence à única arma, acionada pelas duas naves. Cada nave envia sua própria partida como argumento; os totais de tiros pertencem a partidas distintas.

## Q9 — saída

```text
2
```

DisparoRepetido conserva a referência para a ArmaSimples recebida. Reatribuir base não altera o campo do objeto repetido. São duas chamadas à arma simples, totalizando dois tiros.

## Q10 — saída

```text
8
4
```

Cada repetidor chama seu colaborador duas vezes. A composição alcança a mesma arma quatro vezes; cada acionamento da arma dupla registra dois tiros. Os repetidores não possuem contadores de acionamentos.

## Q11 — E

A nova atribuição ignora o argumento base e cria outro objeto. O código compila, mas perde a colaboração configurada pelo cliente; por exemplo, deixa de repetir uma arma dupla recebida.

## Q12 — C

Somente C usa uma vez o colaborador recebido, preserva a partida e registra um tiro adicional depois. A envia outra partida à base; B substitui o colaborador; D o chama duas vezes, sem um adicional próprio; E ignora a base.

## Q13 — D

Uma classe abstrata pode ser tipo de referência e concentrar implementação, mas não pode ser instanciada diretamente. ArmaSimples fornece a operação abstrata e herda disparar.

## Q14 — A

Os construtores da hierarquia participam da inicialização de um único objeto. O contador privado de Arma é de instância; não há segunda arma, segundo contador nem chamada a quantidadeTiros na construção.

## Q15 — B

A variação fica no colaborador recebido pelo contrato. O repetidor acrescenta a repetição usando outro objeto, sem herdar sua implementação, alterar sua classe ou duplicar a sequência para cada arma.

## Q16 — C

ArmaDupla herda de Arma a implementação de Contabilizavel. O teste reconhece essa capacidade, e o cast muda a forma de usar a referência, preservando identidade e classe do objeto.

## Q17 — saída

```text
false
```

O teste examina o próprio repetidor. Sua arma interna continua contabilizável, mas guardar esse colaborador não transfere a capacidade ao objeto externo.

## Q18 — D

As três perdas de vida encerram a partida. No original, Nave.disparar retorna sem acionar a arma, cujo contador permanece zero. Sem a guarda, a arma é acionada e seu contador passa a um. Partida ainda impede o registro de tiros após o fim; por isso, E passa nas duas versões e não revela o defeito. A, B e C também passam nas duas versões, pois a partida continua em andamento.

## Q19 — A

O registro conta todas as chamadas, mas sobrescreve ultimaPartida em cada uma. Um defeito que passe uma partida diferente na primeira chamada e p na segunda também passa nessas duas verificações. DisparoRegistro não registra tiros.

## Q20 — C

A sobrescrita registra os dois tiros, mas deixa de executar o incremento que estava em Arma.disparar. O contador privado permanece zero, e a expectativa de um acionamento falha. As outras verificações passam.

