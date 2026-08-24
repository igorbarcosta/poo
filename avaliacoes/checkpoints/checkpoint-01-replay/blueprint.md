# Blueprint — Checkpoint 01 Replay

## Identificação e finalidade

- Tipo: checkpoint focal da Unidade 1.
- Identificador interno: `checkpoint-01-replay`.
- Posição curricular: depois do Laboratório 04 e antes da Aula 05, conforme o cronograma de 2026.2.
- Finalidade: obter evidências individuais e determinadas de que o estudante compreende a passagem de uma solução procedural para objetos com estado, comportamento, identidade e controle de alterações.
- Uso neste momento: replay controlado do workflow governado; alterações deste contrato exigem nova aprovação humana antes que a base possa ser aprovada.

## Condições conhecidas

- Aplicação individual, presencial, em papel e sem consulta.
- Não é permitido usar IA durante a aplicação.
- Duração: 50 minutos.
- Escala bruta: 100 pontos.
- Restrição física: exatamente duas páginas A4 por exemplar do estudante, planejadas para impressão frente e verso.
- Código extenso escrito à mão não deve ser necessário.

## Contexto curricular reconstruído

Antes deste checkpoint, a turma percorreu quatro pares de aula e laboratório:

1. reconhecimento da estrutura Java mínima e construção de uma solução procedural pequena;
2. reorganização de dados e operações em classes e objetos;
3. investigação de referências, identidade e compartilhamento de estado;
4. proteção de um campo e substituição de acesso direto por capacidades de consulta e alteração controlada.

O projeto evolutivo chegou a uma classe simples cujos objetos mantêm estado próprio, oferecem comportamentos e podem ser acessados por referências compartilhadas ou independentes. A última evolução tornou um campo privado, expôs uma consulta e concentrou no objeto a regra de uma alteração válida.

## Conteúdos incluídos

### Conceitos centrais

- transição de agrupamentos procedurais para uma unidade orientada a objetos;
- classe e objeto;
- estado, comportamento e responsabilidade;
- objetos diferentes da mesma classe com estados independentes;
- criação de objeto com `new`;
- distinção entre variável de tipo de classe, referência e objeto;
- atribuição que copia uma referência, sem criar ou copiar o objeto;
- referências compartilhadas e propagação observável de mudanças no mesmo objeto;
- identidade distinta de igualdade dos valores observados;
- uso de `==` para verificar se duas referências apontam para o mesmo objeto;
- exposição direta de estado e suas consequências;
- `private` como fronteira de acesso e `public` como capacidade externa;
- acesso de pacote quando não há modificador;
- diferença entre consulta, alteração controlada e setter irrestrito;
- encapsulamento como controle das capacidades e das regras de evolução do estado;
- impacto de tornar um campo privado sobre código cliente que lia ou escrevia diretamente.

### Repertório Java disponível como suporte

- estrutura mínima de classe e método `main`;
- tipos `int`, `double`, `boolean` e `String` nas formas já apresentadas;
- campos e variáveis locais;
- parâmetros, retorno, `return` e `void`;
- chamada de métodos e acesso a membros com `.`;
- condição com `if` e comparações simples;
- valores padrão de campos numéricos e exigência de inicialização de variáveis locais;
- compilação, execução e leitura de saída com `System.out.println`;
- convenções básicas de nomes e correspondência entre classe pública e arquivo.

Esse repertório é requisito transversal, não uma evidência avaliativa autônoma. A sintaxe necessária para interpretar o código pode ser exigida, mas a precisão sintática incidental não deve prevalecer sobre o raciocínio de POO. Não criar questões de memorização de sintaxe desconectadas dos conceitos avaliados.

## Conteúdos explicitamente excluídos

- construtores explícitos, parâmetros de construtor e sobrecarga;
- `this`;
- validação e invariantes de estado inicial;
- obrigação de fornecer dados durante a criação do objeto;
- Aula 05, Laboratório 05 e qualquer conteúdo posterior;
- comunicação de falha por retorno, exceção ou outro mecanismo ainda não ensinado;
- `protected` além do reconhecimento de que ainda seria estudado;
- `null` como objeto de raciocínio ou fonte de erro;
- `equals`, `hashCode` e comparação de conteúdo por APIs;
- arrays, coleções, `package` e `import` como objeto de avaliação;
- colaboração entre múltiplos objetos como conteúdo formal;
- redução de quantidade do desafio opcional do Laboratório 04;
- qualquer regra de saque, transferência, redução ou outra operação cujo domínio não tenha sido completamente especificado;
- sintaxe abreviada não consolidada como `++`, `--` ou formas equivalentes introduzidas apenas para a avaliação.

## Evidências prioritárias e distribuição consolidada

| Família de evidência | O que o desempenho deve permitir inferir | Operações cognitivas principais | Pontos |
|---|---|---|---:|
| Estrutura e responsabilidade | Reconhece uma unidade relevante do problema, distingue estado e comportamento e atribui ao objeto uma responsabilidade coerente | identificar, classificar, decidir | 30 |
| Referências e identidade | Distingue criação de atribuição e prevê efeitos de referências compartilhadas, independentes e redirecionadas | representar, rastrear, prever, comparar | 30 |
| Encapsulamento e evolução controlada | Diagnostica exposição de estado, interpreta o impacto de `private` e escolhe capacidades que preservam uma regra explícita | diagnosticar, analisar impacto, selecionar, prever | 40 |
| **Total** |  |  | **100** |

## Arquitetura obrigatória do instrumento

O instrumento terá **seis questões temáticas e 16 unidades independentemente corrigíveis**. Esta arquitetura é específica do Checkpoint 01 replay.

| Questão | Formato | Estrutura corrigível | Pontos | Papel cognitivo |
|---|---|---|---:|---|
| Q01 | leitura de saída | sete subitens a–g, correspondentes a S1–S7 | 35 | rastrear uma execução Java real que integra identidade, compartilhamento e estado |
| Q02 | verdadeiro ou falso | cinco subitens a–e | 25 | verificações conceituais rápidas de estrutura, objetos, responsabilidade e acesso |
| Q03 | múltipla escolha A–E | um pedido | 10 | atribuir uma responsabilidade a quem conhece o estado necessário |
| Q04 | múltipla escolha A–E | um pedido | 10 | interpretar e diagnosticar exposição direta do estado |
| Q05 | múltipla escolha A–E | um pedido | 10 | adaptar o cliente a uma versão encapsulada preservando identidade, operações e efeitos |
| Q06 | múltipla escolha A–E | um pedido | 10 | comparar alteração controlada e setter irrestrito sob regra explícita |
| **Total** |  | **16 unidades** | **100** |  |

Q01 usa exclusivamente as sete impressões da única `Main`: a) S1, b) S2, c) S3, d) S4, e) S5, f) S6 e g) S7, com 5 pontos cada. Q02 contém cinco afirmações inequívocas de 5 pontos sobre distinções estruturais relevantes que não repitam as inferências já pontuadas pela execução. Q03–Q06 possuem exatamente uma resposta correta entre cinco alternativas e não usam subitens.

Sempre que o próprio Java representar naturalmente identidade, valor retornado, estado observável, rastreamento, efeito ou comparação, o código deve carregar essa evidência. A `Main` é a fonte principal das evidências de execução; trechos adicionais são admitidos somente quando uma evolução de `MedidorChuva` os tornar semanticamente necessários.

### Matriz planejada de cobertura

| Eixo | Unidades | Pontos |
|---|---|---:|
| Estrutura e responsabilidade | Q02a–Q02c; Q02e; Q03 | 30 |
| Referências e identidade | Q01a–Q01f | 30 |
| Encapsulamento e evolução controlada | Q01g; Q02d; Q04; Q05; Q06 | 40 |
| **Total** | **16 unidades** | **100** |

Uma unidade pode mobilizar conceitos de mais de um eixo, mas recebe pontos em seu eixo diagnóstico principal para que a soma não seja duplicada. A auditoria da base deve justificar essa classificação unidade por unidade.

## Equilíbrio de dificuldade pretendido

- Q01 e Q02 concentram execução, compreensão e reconhecimento em respostas curtas; S7 e algumas afirmações podem exigir integração, mas sem se tornarem pegadinhas.
- Q03 e Q04 avançam para aplicação e diagnóstico em situações determinadas.
- Q05 e Q06 concentram a maior profundidade, integrando impacto de `private`, adaptação do cliente, referências compartilhadas, preservação de regra e comparação de decisões de projeto.

A dificuldade deve resultar da integração conceitual. Sintaxe desconhecida, volume de leitura, regras omitidas e pegadinhas não contam como profundidade. As questões finais não podem depender de respostas anteriores.

## Política de independência

- Cada unidade corrigível possui evidência diagnóstica e pontuação próprias na matriz de auditoria.
- Um cenário compartilhado pode fornecer vocabulário e estado inicial, mas uma resposta não pode ser necessária para resolver outra.
- Quando evidências usarem momentos diferentes de uma execução, cada questão deve indicar o trecho ou estado necessário de forma inequívoca.
- Subitens sequenciais só são aceitos quando um erro anterior não contamina automaticamente os seguintes; quando necessário, fornecer um estado intermediário explícito.
- Código, enunciados e alternativas não podem revelar outras respostas.
- A base deve ser resolvível mesmo que o estudante abandone qualquer subitem ou questão isolada.

## Compatibilidade com 50 minutos e duas páginas

| Bloco de trabalho do estudante | Tempo de referência |
|---|---:|
| Leitura das instruções e do contexto compartilhado | 4 minutos |
| Q01 — sete saídas da execução | 10 minutos |
| Q02 — cinco afirmações V/F | 8 minutos |
| Q03 e Q04 — responsabilidade e diagnóstico | 9 minutos |
| Q05 e Q06 — adaptação e comparação de decisões | 14 minutos |
| Revisão e transferência de respostas | 5 minutos |
| **Total** | **50 minutos** |

Na composição, a primeira página deve comportar cabeçalho, área de respostas, contexto comum e uma parte coerente das questões; a segunda, as questões restantes. Trechos compartilhados devem aparecer uma única vez como referência. Se as 16 unidades não couberem com código e alternativas legíveis, a base deve reduzir texto ou simplificar o cenário, não ocultar unidades de correção nem comprimir a tipografia.

## Requisitos e limitações de cenário

- Usar o cenário simples de medição de chuva com uma classe `MedidorChuva` e uma única `Main` curta, coerente e contínua.
- Não reutilizar o domínio evolutivo de itens de pedido nem os domínios já usados para transferência nas aulas.
- Limitar o cenário ao mínimo de classes e regras necessário para observar as evidências prioritárias.
- Declarar explicitamente estado inicial, operações permitidas, limites e resultados esperados relevantes.
- Permitir observar tanto referências compartilhadas quanto objetos independentes sem exigir colaboração formal entre objetos.
- Quando houver alteração controlada, fornecer uma regra simples, total e verificável para aceitar ou rejeitar a solicitação.
- Não criar pequenos programas independentes para sustentar questões isoladas.

## Riscos de ambiguidade a controlar

- confundir variável, referência e objeto quando essa distinção for mobilizada pelo código;
- pedir comparação de “igualdade” sem dizer se o foco é identidade ou valores;
- omitir o estado anterior a uma operação ou a ordem das chamadas;
- usar uma regra de domínio incompleta, especialmente para redução, saque, transferência ou limites;
- tornar uma afirmação falsa por erro incidental de nome, acesso ou sintaxe, e não pelo conceito diagnosticado;
- tratar todo setter como inadequado sem fornecer o contexto da responsabilidade;
- exigir conhecimento de construtores porque `new Classe()` contém parênteses;
- presumir que variável local recebe o mesmo valor padrão de um campo;
- usar código externo sem explicitar se está na própria classe, no mesmo pacote ou em outro pacote;
- fazer cenário, alternativas ou questões posteriores revelarem respostas anteriores.

## Critérios para objetividade e correção

- Toda resposta deve ser determinada pelo código, estado inicial e regras declaradas.
- Cada unidade corrigível deve possuir uma evidência diagnóstica registrada; pedidos corrigíveis independentes devem aparecer como subitens.
- A resolução interna futura deve executar todas as sequências e conferir nomes, tipos, membros e acessos.
- Questões sobre compilação devem ter exatamente uma causa pretendida e não depender de outro erro incidental.
- Questões de múltipla escolha devem ter cinco alternativas A–E, exatamente uma correta e quatro distratores conceitualmente plausíveis.
- Afirmações V/F devem permanecer verdadeiras ou falsas sob todas as condições fornecidas.
- Pontuação deve refletir importância da evidência e esforço, totalizando exatamente 100.
- O critério de correção deve priorizar a compreensão de objetos e responsabilidades, sem deixar pequeno erro sintático eclipsar raciocínio conceitualmente correto quando o formato admitir produção.

## Evidências contextuais da oferta

- A Aula 03 foi concluída em aproximadamente 45 minutos; a retrospectiva recomenda aprofundar previsão, comparação, diagnóstico e transferência, sem acrescentar conceito novo.
- A Aula 04 revelou que operações sem regras de domínio determinadas produzem respostas plausíveis concorrentes; o instrumento deve declarar integralmente qualquer regra necessária.
- No Laboratório 04, previsão, execução e análise foram úteis, mas instruções devem deixar claro o que o estudante precisa fazer e responder.
- O desafio opcional de redução possuía regras explícitas, mas não há evidência de que tenha integrado o núcleo realizado por todos; por isso, não entra no recorte obrigatório.

Essas observações calibram este blueprint e não são promovidas a regras permanentes.

## Decisões delegadas à redação da base

A redação decide a formulação exata das cinco afirmações V/F e das alternativas A–E, preservando a estrutura obrigatória, a matriz 30/30/40, a determinação das respostas e o nível conceitual. Essas escolhas não criam gates adicionais e serão julgadas no futuro gate `base_aprovada`.

## Fontes consultadas

- `AGENTS.md`;
- `specs/projeto-pedagogico.md`;
- `specs/padrao-avaliacoes.md`;
- `specs/contrato-artefatos-avaliacoes.md`;
- `docs/cronograma.md`;
- `docs/aulas/aula-01-apresentacao-da-disciplina.md`;
- `docs/aulas/laboratorio-01-java-minimo-e-problema-inicial.md`;
- `docs/aulas/aula-02-do-procedural-aos-objetos.md`;
- `docs/aulas/laboratorio-02-primeiros-objetos-em-java.md`;
- `docs/aulas/aula-03-objetos-referencias-e-identidade.md`;
- `docs/aulas/laboratorio-03-referencias-e-identidade-na-pratica.md`;
- `docs/aulas/aula-04-protegendo-o-estado-dos-objetos.md`;
- `docs/aulas/laboratorio-04-controlando-alteracoes-de-estado.md`;
- `docs/materiais/java-essencial.md`, somente nas seções correspondentes ao repertório anterior à Aula 05;
- `retrospectivas/2026-2.md`, somente nas entradas da Aula 03, Aula 04 e Laboratório 04.
