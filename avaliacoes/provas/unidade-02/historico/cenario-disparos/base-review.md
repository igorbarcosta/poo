# Revisão da base — primeira versão da Unidade 02

Revisão do próprio autor, sem alegação de auditoria independente ou aprovação humana. A solução comentada completa está em gabarito.md; o mapa de evidências e de ganho marginal está em blueprint.md. A primeira versão teve distribuição preliminar em Typst/PDF. Na revisão atual, por orientação do professor, o trabalho mantém base Markdown, fonte Typst e gabarito sincronizados, com renderização adiada até a finalização.

## Mapa e teste de remoção

Vinte unidades independentes, 5 pontos cada, total 100. A remoção de cada unidade perde a inferência específica descrita em blueprint.md; relações mais próximas foram diferenciadas: Q4 integra herança ao despacho, Q5 examina disponibilidade; Q8 examina compartilhamento, Q9 reatribuição, Q10 profundidade; Q12 acrescenta requisito novo, em vez de copiar um corpo já fornecido; Q18 seleciona cenário, Q19 limita a conclusão de um teste e Q20 localiza regressão de regra herdada.

## Percurso do estudante e carga observável

| ID | Primeiro passo | Fontes | Estados, regras e decisões coordenados | Erros de leitura a observar |
| --- | --- | --- | --- | --- |
| q-u02-001 | Localizar campos e métodos que os alteram. | Partida, Nave e Arma. | Relacionar três donos de estado; sem valores intermediários. | Troca de donos e responsabilidades. |
| q-u02-002 | Seguir perderVida desde vidas=3. | Partida.perderVida e registrarTiros. | Cinco tentativas; reconhecer guarda após a terceira; consultar três resultados. | Guarda ignorada, vidas negativas ou fim não registrado. |
| q-u02-003 | Seguir duas chamadas a Nave.disparar. | Nave, Arma e ArmaDupla. | Dois pedidos à mesma arma; quatro tiros e dois acionamentos. | Confundir quantidade de tiros com acionamentos ou supor criação de outra arma. |
| q-u02-004 | Seguir a chamada ao Disparo guardado. | Nave, Arma e ArmaDupla. | Uma referência e duas resoluções: método herdado e operação sobrescrita. | Interface com corpo inexistente, troca do destinatário ou criação extra. |
| q-u02-005 | Ler o tipo declarado de d e c. | Disparo e Contabilizavel. | Quatro chamadas analisadas separadamente; dois contratos. | Usar classe concreta para ampliar operações da referência. |
| q-u02-006 | Percorrer as duas entradas da lista. | Arma, subclasses e laço local. | Duas chamadas; três totais solicitados; sem reatribuição. | Fórmula única, contagem global ou contador não herdado. |
| q-u02-007 | Conferir o parâmetro do construtor de Nave. | Disparo e Nave. | Um novo colaborador; localizar o ponto de montagem. | Dependência concreta, teste de tipo ou herança obrigatória. |
| q-u02-008 | Identificar a arma única e as duas partidas. | Trecho local, Nave e Arma. | Duas chamadas; um contador compartilhado e dois totais separados. | Cópia do colaborador, contador global de tiros ou atribuição à partida errada. |
| q-u02-009 | Marcar qual referência foi guardada na construção. | Trecho local e DisparoRepetido. | Uma reatribuição posterior; dois acionamentos do objeto anterior. | Campo acompanhar variável local. |
| q-u02-010 | Desenhar as duas camadas e a arma. | Trecho local, DisparoRepetido e ArmaDupla. | Dois níveis; quatro chamadas finais; distinguir 8 tiros de 4 acionamentos. | Contar camadas em lugar de chamadas, perder multiplicação ou misturar contadores. |
| q-u02-011 | Ler a única atribuição substituída. | Construtor de DisparoRepetido. | Um campo e um argumento ignorado; comparar comportamento configurado. | Confundir criação por objeto, estado estático ou alteração da interface. |
| q-u02-012 | Inventariar destinatário, argumento e adicional. | Requisito local e API de Disparo/Partida. | Três critérios explícitos: uma chamada à base, mesma partida, adicional posterior. | Argumento substituído, base ignorada, duplicação ou resultado fixo. |
| q-u02-013 | Separar referência de instanciação. | Arma e ArmaSimples. | Uma operação abstrata e duas concretas. | Instanciar base, não herdar corpo ou impedir uso por referência abstrata. |
| q-u02-014 | Ler os dois construtores encadeados. | ArmaDupla e Arma. | Um objeto e um contador; não há chamadas a operação sobrescrita na construção. | Segundo objeto, contador duplicado/global ou inicialização adiada. |
| q-u02-015 | Relacionar o requisito ao campo do repetidor. | DisparoRepetido e interface Disparo. | Combinar o mesmo comportamento de repetição com dois colaboradores possíveis. | Herança de interface como herança de campos, fusão de objetos ou alteração de classe. |
| q-u02-016 | Identificar o objeto concreto alcançado. | ArmaDupla, Arma e Contabilizavel. | Um teste de capacidade seguido de cast compatível; sem erro de execução. | Cast criar, transformar ou acrescentar capacidade. |
| q-u02-017 | Examinar a classe do objeto externo. | DisparoRepetido e Contabilizavel. | Distinguir objeto testado de seu campo base. | Transferir capacidade ao invólucro ou removê-la do colaborador. |
| q-u02-018 | Comparar a guarda de fim com sua remoção. | Nave.disparar, Partida e Arma. | Cinco testes independentes; distinguir total protegido e acionamento indevido. | Observar apenas tiros ou testar uma partida ainda em andamento. |
| q-u02-019 | Conferir o que cada assert observa. | DisparoRegistro e teste local. | Duas observações: contagem e último argumento; considerar primeiro argumento não guardado. | Generalizar última observação para todo o histórico ou confundir registro com tiros. |
| q-u02-020 | Identificar a regra omitida pela sobrescrita. | Novo corpo e Arma.disparar/getAcionamentos. | Uma chamada; dois tiros corretos e contador zero; escolher observação relevante. | Testar efeito preservado em vez da regra regredida. |

## Determinação e representação

- Cada questão tem uma resposta determinada: uma alternativa nas treze questões de múltipla escolha ou uma sequência de linhas nas sete questões de saída; a solução foi confrontada com os corpos de método. As questões 2–20 com código dependem de construções Java ou APIs já trabalhadas; as operações novas do domínio estão declaradas no material.
- Os imports, os arquivos separados sem package, a ausência de null e a independência dos trechos vêm antes do primeiro código. Não se depende de ordem de execução de framework.
- Q5 pede analisar chamadas isoladamente; assim uma chamada inválida não impede a análise das demais. Não usa regras de protected entre pacotes.
- Q12 explicita os três critérios antes das cinco alternativas comparáveis. As duas linhas variáveis aparecem como código; não há assinaturas repetidas.
- Q18 compara cinco testes com a remoção da guarda de fim. D observa o contador da arma após encerrar a partida; E observa tiros, que continuam bloqueados por Partida. A, B e C mantêm a partida em andamento e passam nas duas versões. A dificuldade está na escolha da observação, sem simular tempo.
- Q19 não afirma que a última referência prova todo o histórico; o contraexemplo de primeira partida diferente confirma o limite.
- Não há afirmações que entreguem a saída numérica de outra questão. Regras do próprio cenário reaparecem para analisar operações diferentes, sobretudo na transferência para testes.

## Passagem global

O arco começa pelo estado conhecido, passa por contratos e referências, combina comportamentos, analisa herança e termina na verificação. O domínio não exige jogar nem conhecer geometria ou bibliotecas. Há navegação para nove tipos pequenos nas duas páginas de referência; esse custo existe, sobretudo em Q4, Q8 e Q10. A paginação anterior mantinha as questões completas, com duas questões por coluna. A composição será revista depois de fechar o conteúdo, para acomodar as respostas abertas.

O tempo de 90 minutos é uma estimativa a confirmar pelo professor. A prova contém mais comparação e diagnóstico que o instrumento antigo. A primeira revisão deve observar se o volume de leitura e Q10/Q19 estão proporcionais ao repertório da turma.

## Ciclos e verificações

1. Primeira revisão: uma questão de comparação repetia literalmente a implementação fornecida. Foi substituída pela evolução DisparoComExtra, mantendo os três critérios locais. Os getters de Partida foram compactados sem alteração semântica para manter o código de referência em duas páginas.
2. Validação técnica: consultar README.md desta pasta para os resultados de compilação do cenário, execução dos cenários e conferência da renderização.

Nenhum gate de aprovação foi registrado. A presente revisão não é evidência de maturação independente nem liberação para impressão.

## Revisão dos ajustes solicitados pelo professor

O cenário foi deslocado para o final, após Q20, em base.md e na prévia Typst/PDF. As premissas externas (independência, arquivos, imports e colaboradores não nulos) continuam antes das questões. Foram retiradas explicações que antecipavam a interpretação dos métodos e contadores. Uma primeira revisão tentou clarificar a entrada de Nave.atualizar; posteriormente, a pedido do professor, a operação foi substituída por disparar(), com revisão de Q3 e Q18 conforme o registro abaixo.

## Questões de saída sem alternativas

Q2, Q3, Q6, Q8, Q9, Q10 e Q17 passaram a pedir a saída exata dos println. Os prints foram colocados após as operações já existentes, preservando os estados e as inferências avaliadas. As alternativas foram retiradas e o gabarito passou a mostrar as linhas impressas. Q16 continua conceitual, com consulta atribuída a uma variável em vez de print. Instruções gerais ajustadas aos dois formatos; vinte itens de 5 pontos mantidos. Sem recomposição ou renderização nesta etapa.

## Sincronização da fonte Typst

As sete questões abertas foram transferidas para unidade_02.typ, com os mesmos enunciados e trechos da base, sem alternativas. O quadro de letras inclui apenas as treze questões de múltipla escolha; os itens de saída têm linhas próprias sob o código. Instruções gerais e Q16 sincronizadas. Nenhum PDF ou preview foi gerado; a paginação será conferida na finalização.

## Revisão da abstração de Nave

Nave.disparar() verifica o fim da partida e solicita o disparo ao colaborador recebido, encaminhando a mesma partida. Foram retirados campo de recarga, parâmetro booleano, método atualizar e getter de recarga. A operação passa a corresponder diretamente à ação do domínio. Partida continua protegendo seu estado, enquanto a guarda em Nave impede o próprio acionamento do colaborador após o fim; são efeitos diferentes e observáveis. Não foi criada uma classe de tempo para sustentar uma mecânica sem papel necessário no recorte.

Q1, Q4, Q7 e Q8 foram adaptadas ao novo código. Q3 acompanha duas chamadas a uma nave com ArmaDupla e imprime 4 e 2. Ela estabelece o percurso pela nave; Q6 amplia para lista heterogênea, Q8 para estado compartilhado e Q10 para duas camadas de repetição. Há proximidade na distinção entre tiros e acionamentos, mas operações adicionais diferentes. Q18 agora diagnostica a remoção da guarda: D falha por observar um acionamento indevido, enquanto E passa porque a guarda de Partida protege o total. O cenário e o gabarito foram sincronizados em Markdown, Typst e Java. IDs, formatos e pesos foram mantidos. Sem renderização.

Validação desta revisão: nove tipos compilados, sete saídas confrontadas com o gabarito e cinco alternativas de Q18 executadas nas duas versões. Somente D distingue as versões. Um registro de chamadas confirma a identidade da partida encaminhada e o bloqueio após o fim. Os vinte trechos de questões e o cenário correspondem entre Markdown e Typst; PDF e previews foram preservados.
