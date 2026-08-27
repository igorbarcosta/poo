# Checkpoint 1 — matriz de evidências e auditoria

Documento interno. Escopo confirmado nas aulas, laboratórios e retrospectivas até o Laboratório 04: transição inicial do procedural para objetos; classe, objeto, campos, estado, comportamento e responsabilidade; métodos, parâmetros, retorno e `void`; `new`, variáveis de tipo de classe, referências, identidade com `==` e estados independentes; acesso por `.`, `public`, `private`, acesso de pacote, getters, encapsulamento e alteração controlada; `if`, valores padrão de campos e inicialização de variáveis locais.

Ficam fora: `!`, `++`, `--`, `+=`, construtores explícitos, `this`, `null`, exceções, arrays como conteúdo avaliativo de POO, coleções, APIs e conceitos posteriores. O material de Java já registra assuntos posteriores, mas eles não integram o recorte deste checkpoint.

## Estrutura preservada

- Q1: teste de mesa com 5 itens de 5 — 25 pontos;
- Q2: verdadeiro/falso com 5 itens de 5 — 25 pontos;
- Q3–Q12: 10 questões de múltipla escolha, com cinco alternativas e 5 pontos cada — 50 pontos;
- total: 100 pontos na escala bruta de correção;
- cenário único `Elevador`, duas variantes e exatamente duas páginas A4 por variante do estudante.

## Matriz questão → evidência principal

| Questão | Nível | Evidência principal | Variante A | Variante B |
| --- | --- | --- | --- | --- |
| Q1 | Avançado | Rastreia a evolução do estado em uma sequência com referências compartilhadas e objeto independente. | `1`, `true`, `2`, `false`, `1` | `true`, `1`, `1`, `false`, `2` |
| Q2 | Médio | Analisa o impacto do encapsulamento sobre compilação e regras de alteração. | F, V, V, F, F | F, F, F, V, V |
| Q3 | Fácil | Reconhece uma unidade coerente do domínio que deve reunir dados e comportamentos relacionados. | C | E |
| Q4 | Fácil | Distingue classe/tipo, variável que mantém referência e objeto criado em um trecho concreto. | B | C |
| Q5 | Fácil | Distingue estado e comportamento pelo papel exercido durante a execução. | A | B |
| Q6 | Fácil | Interpreta o contrato de um método pela combinação de parâmetro e tipo de retorno `void`. | D | A |
| Q7 | Médio | Aplica a diferença entre valor padrão de campo `int` e inicialização obrigatória de variável local. | B | D |
| Q8 | Avançado | Distribui no próprio `Elevador` uma nova regra de lotação que depende de seu estado. | E | C |
| Q9 | Médio | Interpreta parâmetro, retorno e ausência de alteração de estado em uma chamada de método. | D | B |
| Q10 | Avançado | Distingue estados inicialmente equivalentes de identidade e evolução independente. | C | E |
| Q11 | Médio | Aplica o acesso de pacote a uma chamada concreta entre classes do mesmo pacote. | A | C |
| Q12 | Avançado | Reconhece que tornar um campo privado não basta quando uma operação pública ainda aceita estados sem preservar regras. | D | B |

## Detalhamento de Q1

### Variante A

Há dois objetos. `principal` e `painel` mantêm a mesma referência; `servico` mantém uma referência para o segundo objeto.

1. `principal.subir()` leva o objeto compartilhado ao andar 1.
2. `painel.abrirPorta()` abre a porta desse mesmo objeto.
3. Linhas 10 e 11 imprimem `1` e `true` por `principal`.
4. `painel.fecharPorta()` fecha a porta e `painel.subir()` leva o mesmo objeto ao andar 2.
5. Linhas 16 e 17 imprimem `2` e `false` por `painel`.
6. No objeto independente, `servico.subir()` e `servico.abrirPorta()` produzem andar 1 e porta aberta.
7. A linha 22 imprime o andar `1`; a porta do segundo objeto não é impressa.

### Variante B

Há dois objetos. `cabine` e `painel` mantêm a mesma referência; `carga` mantém uma referência para o segundo objeto.

1. `painel.subir()` leva o objeto compartilhado ao andar 1.
2. `cabine.abrirPorta()` abre a porta desse mesmo objeto.
3. Linhas 10 e 11 imprimem `true` e `1` por `painel`.
4. `cabine.fecharPorta()` fecha a porta sem alterar o andar.
5. Linhas 15 e 16 imprimem `1` e `false` por `cabine`.
6. No objeto independente, duas chamadas a `subir()` e uma a `abrirPorta()` produzem andar 2 e porta aberta.
7. A linha 22 imprime o andar `2`; a porta do segundo objeto não é impressa.

Q1 não imprime `==` nem solicita contagem explícita de objetos. A evidência vem da execução temporal: o estudante precisa acompanhar chamadas realizadas por nomes diferentes e preservar a independência do segundo objeto.

## Detalhamento de Q2

| Item | Evidência | A | Motivo A | B | Motivo B |
| --- | --- | --- | --- | --- | --- |
| a | Acesso externo direto a campo privado | F | `principal.andarAtual` não é acessível em `Main`. | F | `cabine.portaAberta` não é acessível em `Main`. |
| b | Acesso da própria classe ao campo privado | V | `subir()` pertence a `Elevador` e pode alterar seu campo. | F | `private` não impede os métodos de `Elevador` de acessar o campo. |
| c | Solicitação rejeitada pela regra da porta | V | Com porta aberta, o `if` externo impede a subida. | F | Com porta aberta, o elevador permanece no térreo. |
| d | Limite preservado pelo comportamento | F | No andar 3, o `if` interno impede chegar ao 4. | V | Com porta fechada no andar 2, a chamada chega ao 3. |
| e | Efeito das operações inalteradas sobre o estado encapsulado | F | Abrir, fechar e subir deixa a porta fechada e permite chegar ao andar 1. | V | A mesma sequência termina no andar 1. |

Todos os identificadores usados existem na respectiva variante. Nenhum item depende de variável ausente, membro não declarado, sintaxe acidental ou conteúdo posterior.

## Auditoria das alternativas Q3–Q12

### Q3 — objeto reunindo estado e ações relacionadas

A resposta reúne em `Elevador` o andar, a porta e os métodos que realizam as ações correspondentes. Os distratores mantêm dados soltos, separam artificialmente dados e ações ou criam classes sem uma responsabilidade coerente.

### Q4 — classe, variável e objeto

A resposta identifica `Elevador` como classe/tipo, o identificador em minúsculas como variável que mantém uma referência e `new Elevador()` como criação do objeto. Os distratores trocam os papéis de classe, variável e objeto ou tratam todos como o mesmo elemento.

### Q5 — estado e comportamento

A resposta reconhece `portaAberta` como informação que muda durante a execução e `abrirPorta()`/`fecharPorta()` como operação. Os distratores invertem os papéis, confundem acesso por ponto com comportamento ou confundem membro com classe/objeto.

### Q6 — contrato de método

A resposta recebe o andar de destino em um parâmetro `int` e declara retorno `void`. Os distratores omitem o parâmetro, declaram retorno `int` ou recebem um `float portaAberta` que não corresponde ao dado solicitado. Não é necessário implementar o método.

### Q7 — campo e variável local

A resposta reconhece que a leitura do campo `andarAtual` é válida, mas a leitura da variável local sem inicialização impede a compilação na linha 5. Os distratores confundem erro de compilação com erro de execução, aplicam valor padrão à variável local ou rejeitam a leitura válida do campo.

### Q8 — responsabilidade

A resposta mantém em `Elevador.embarcar(quantidade)` a regra de lotação que depende do estado do próprio elevador. Os quatro distratores espalham a decisão entre `Main`, método auxiliar, clientes diferentes ou setter genérico. A questão permanece no cenário, mas introduz uma regra diferente da subida analisada em Q2.

### Q9 — parâmetro, retorno e estado

A resposta acompanha o argumento até o parâmetro, calcula o valor retornado e percebe que o método apenas consulta `andarAtual`, sem modificá-lo. Os distratores confundem retorno com alteração de estado, rejeitam incorretamente parâmetro em método com retorno ou interpretam `void` como requisito para retornar valor.

### Q10 — estado e identidade

Os dois objetos foram criados separadamente e começam com estados equivalentes. Logo, `==` é `false`. Alterar somente o primeiro muda apenas seu próprio estado. Os distratores confundem igualdade de estado com identidade, preveem propagação entre objetos independentes ou atribuem a mudança ao objeto errado.

### Q11 — acesso de pacote

A resposta aplica ao getter sem modificador a informação explícita de que `Main` e `Elevador` estão no mesmo pacote. Os distratores confundem acesso de pacote com `private`, vinculam indevidamente a visibilidade do método à do campo ou atribuem ao modificador efeito em tempo de execução.

### Q12 — fronteira e preservação de regras

A resposta reconhece que o campo deixou de aceitar acesso externo direto, mas a operação pública ainda permite qualquer valor ou mudança. Os distratores tratam `private` ou o tipo do parâmetro como validação automática e negam incorretamente o acesso da própria classe ao campo.

## Auditoria explícita de redundância

- **Q1 × Q9/Q10:** Q1 mede execução temporal de chamadas por referências compartilhadas e por objeto independente. Q9 mede fluxo de argumento, cálculo de retorno e ausência de efeito colateral. Q10 mede a consequência de estado equivalente não implicar identidade.
- **Q9 × Q10:** Q9 interpreta o contrato em execução de um único método de consulta; Q10 compara identidade e evolução independente de dois objetos.
- **Q3 × Q5:** Q3 mede a decisão de representar uma unidade coerente do domínio. Q5 classifica o papel exercido por membros específicos dentro dessa unidade.
- **Q5 × Q8:** Q5 distingue campo e método pelos papéis que exercem. Q8 decide onde deve morar uma nova regra de lotação; reconhecer um método não resolve automaticamente a distribuição da responsabilidade.
- **Q2 × Q8:** Q2 analisa consequências determinadas da regra de subida. Q8 permanece em `Elevador`, mas introduz lotação e embarque sem reapresentar a implementação de Q2 como resposta literal.
- **Q2 × Q11:** Q2 mede campos privados e comportamento controlado; Q11 isola o acesso de pacote de um método sem modificador.
- **Q8 × Q12:** Q8 decide quem deve assumir uma regra; Q12 diagnostica se uma fronteira concreta realmente preserva regras depois que o campo se torna privado.

## Auditoria de entrega de respostas

- Q1 exige rastreamento de referências e não apresenta o método de cálculo usado em Q9 nem imprime identidade para Q10.
- Q2 apresenta a regra de subida; Q8 usa uma nova regra de lotação e não repete seu código. O item de getter foi retirado de Q2 para não entregar Q11.
- Q3 apresenta organizações completas, sem definir isoladamente os papéis de `portaAberta` e dos métodos pedidos em Q5.
- Q4 esclarece os papéis em uma declaração de criação, enquanto Q9 exige acompanhar argumento, retorno e estado em uma chamada posterior.
- Nenhuma letra correta ou saída aparece como pista em outra questão.

Os conceitos se apoiam, como esperado em um único sistema, mas nenhuma questão fornece a resposta determinada de outra.

## Auditoria de independência

- Q1 e Q2 usam o cenário principal, mas cada saída ou afirmação pode ser resolvida diretamente do código fornecido.
- Q3–Q12 fornecem no próprio enunciado o requisito ou trecho necessário.
- Nenhuma resposta de Q3–Q12 depende de um valor calculado anteriormente.
- Um erro no teste de mesa não cria cascata nas questões conceituais.

## Determinação e equivalência das variantes

- Há exatamente uma alternativa correta em Q3–Q12.
- Os distratores representam confusões plausíveis: variável como objeto, retorno como alteração de estado, estado equivalente como identidade, `private` impedindo a própria classe, `void` sem ação, inicialização local automática, erro de compilação como erro de execução e regra mantida por `Main`.
- As variantes preservam o mesmo grafo conceitual em Q1: duas referências compartilhadas, um objeto independente, seis chamadas e cinco saídas. A distribuição das chamadas e a ordem das observações mudam, produzindo estados finais diferentes com esforço equivalente.
- Q2 cobre as mesmas cinco evidências nas duas variantes, alternando a formulação de itens verdadeiros e falsos.
- Q3–Q12 mantêm a mesma competência e volume; variam nomes, pequenas operações equivalentes e ordem dos distratores.
- A distribuição de dificuldade é equilibrada: quatro questões fáceis, quatro médias e quatro avançadas. A classificação considera a operação cognitiva principal, não apenas o tamanho do enunciado.
- Distribuição das respostas Q3–Q12: A = C, B, A, D, B, E, D, C, A, D; B = E, C, B, A, D, C, B, E, C, B. Não há sequência previsível.

## Resolução integral

### Variante A

- Q1: `1`, `true`, `2`, `false`, `1`.
- Q2: F, V, V, F, F.
- Q3–Q12: C, B, A, D, B, E, D, C, A, D.

### Variante B

- Q1: `true`, `1`, `1`, `false`, `2`.
- Q2: F, F, F, V, V.
- Q3–Q12: E, C, B, A, D, C, B, E, C, B.

## Duração estimada

- leitura do cenário: 7–8 min;
- Q1: 7–9 min;
- Q2: 7–9 min;
- Q3–Q12: 21–23 min;
- quadro de respostas e revisão: 5 min.

Total estimado: 47–54 minutos, com referência operacional próxima de 50 minutos.
