# Blueprint — Prova da Unidade 02

## Identificação e direcionamento

- Tipo: exam; identificador: unidade-02.
- Finalidade: primeira versão para avaliação humana, após auditoria da prova anterior.
- Direcionamento: o professor aprovou a proposta em conversa e solicitou o código completo em Typst, seguindo o modelo da Unidade 01.
- Recorte confirmado pelo professor: até a Aula 18, sem tratamento de exceções.
- Composição atual: vinte questões, sendo treze de múltipla escolha e sete de resposta aberta de saída de código; 5 pontos cada, total 100. Nas de múltipla escolha há uma única alternativa correta.
- Duração de referência: aproximadamente 90 minutos, conforme política da disciplina; estimativa ainda sem aplicação.
- Não houve aprovação da base, do blueprint final, de variantes ou liberação para impressão.

## Fontes e limites

Fontes: specs/projeto-pedagogico.md, specs/padrao-avaliacoes.md, Aulas e Laboratórios 12–18, Aula 17 (capacidades), materiais/java-essencial.md, Checkpoint 04, retrospectiva 2026.2, padrões genéricos de qualidade e prova do Docemas. Referência visual: avaliacoes/provas/unidade_01.typ.

Inclui colaboração, dependências, interfaces, tipo declarado, despacho, composição, identidade, referências compartilhadas, herança, super, base abstrata, capacidades, instanceof e cast compatível, leitura de assertEquals/assertTrue, diagnóstico e evolução. Fundamentos de estado aparecem integrados.

Exclui Greenfoot, libGDX, geometria, colisões, aleatoriedade, renderização de jogo, sobrecarga como tópico, this(...) em construtores, throw, try/catch, taxonomia de exceções, APIs avançadas de teste e recursos Java não ensinados. Protected aparece apenas no construtor e operação abstrata da base, sem matriz de visibilidade. Não há campos protected.

## Arquitetura e regras do cenário

O jogo é um recorte de simulação. Partida preserva vidas e fim e registra tiros acumulados. Nave conserva Partida e Disparo; sua operação disparar consulta o fim da partida antes de delegar ao colaborador. Arma compartilha algoritmo e contador privado, deixando quantidadeTiros abstrata. ArmaSimples e ArmaDupla sobrescrevem essa operação. DisparoRepetido combina objetos por um contrato. Contabilizavel dá acesso opcional à contagem. DisparoRegistro torna a interação observável, registrando somente o último argumento.

Premissas de independência, arquivos, imports e ausência de null precedem as questões. O código de referência fica ao final da prova; o estudante deve inferir dele o comportamento e o significado dos contadores, sem explicações de apoio. O fim bloqueia tiros da partida; uma chamada direta a Arma.disparar ainda conta acionamento, pois a contagem é por execução da arma. A Q18 compara esse comportamento na versão defeituosa de Nave, sem a guarda: tiros continuam bloqueados na partida, mas o contador de acionamentos revela a colaboração indevida. Não há pontos, coordenadas ou meteoros no recorte: foram retirados para dedicar leitura à colaboração.

## Dimensões e pesos

| Dimensão | Questões | Peso |
| --- | --- | ---: |
| Estado e responsabilidades | 1–3 | 15 |
| Contratos e polimorfismo | 4–7 | 20 |
| Composição e referências | 8–11 | 20 |
| Comparação de implementação e herança | 12–15 | 20 |
| Capacidades e cast | 16–17 | 10 |
| Testes e evolução | 18–20 | 15 |

## Evidência por unidade pontuada

Todos os itens têm 5 pontos e IDs estáveis. A coluna de ganho distingue inferências relacionadas para evitar dupla pontuação da mesma operação.

| ID | Evidência pretendida | Operação / carga incidental | Ganho em relação aos demais |
| --- | --- | --- | --- |
| q-u02-001 | Identificar responsabilidades e donos de estado. | Sem conta numérica. | Localiza os donos do estado; não solicita rastreamento numérico. |
| q-u02-002 | Rastrear uma invariante e a guarda do estado final. | Contagem pequena, com estado inicial local. | Verifica guarda e invariante de fim, sem interferência da nave. |
| q-u02-003 | Acompanhar uma solicitação da nave até o colaborador configurado. | Duas chamadas; consultar tiros e acionamentos. | Estabelece a colaboração via Nave; Q6 acrescenta uma lista heterogênea e Q8 acrescenta compartilhamento entre naves. |
| q-u02-004 | Acompanhar despacho para uma operação sobrescrita a partir de método herdado. | Sem conta numérica. | Relaciona implementação herdada e operação sobrescrita no mesmo objeto. |
| q-u02-005 | Distinguir operações permitidas por dois tipos declarados. | Sem conta numérica. | Analisa disponibilidade de operações, não a implementação executada. |
| q-u02-006 | Percorrer colaboradores heterogêneos e distinguir seus efeitos e estados. | Contagem pequena, com estado inicial local. | Integra lista heterogênea e estados independentes por objeto. |
| q-u02-007 | Analisar extensão do sistema por um contrato sem dependência da base concreta. | Sem conta numérica. | Examina extensão pelo contrato sem exigir a superclasse. |
| q-u02-008 | Distinguir estado do colaborador compartilhado e estado de seus clientes. | Contagem pequena, com estado inicial local. | Distingue contador compartilhado e partidas distintas. |
| q-u02-009 | Distinguir reatribuição local e referência conservada pelo colaborador. | Contagem pequena, com estado inicial local. | Examina reatribuição externa após a construção. |
| q-u02-010 | Acompanhar uma cadeia de delegação e a multiplicidade das chamadas. | Contagem pequena, com estado inicial local. | Examina profundidade de delegação e multiplicidade, não reatribuição. |
| q-u02-011 | Diagnosticar construção que ignora a dependência fornecida. | Sem conta numérica. | Examina construtor que ignora o argumento recebido. |
| q-u02-012 | Evoluir a composição para acrescentar um efeito preservando a delegação. | Sem conta numérica. | Compara corpos por dois critérios explícitos: destinatário e argumento. |
| q-u02-013 | Compreender a classe abstrata como base de implementação e tipo de referência. | Sem conta numérica. | Examina limite de instanciação e utilidade da base abstrata. |
| q-u02-014 | Distinguir encadeamento de construtores, identidade e estado de instância. | Sem conta numérica. | Examina inicialização e objeto único, sem rastrear disparos. |
| q-u02-015 | Justificar composição para combinar um comportamento com implementações diferentes. | Sem conta numérica. | Exige justificativa da estrutura frente à variação de colaborador. |
| q-u02-016 | Reconhecer capacidade e preservar identidade no cast. | Sem conta numérica. | Examina identidade no cast compatível. |
| q-u02-017 | Distinguir capacidades do objeto externo e do colaborador interno. | Sem conta numérica. | Examina a capacidade do objeto externo, sem cast. |
| q-u02-018 | Selecionar teste que revela acionamento indevido após o fim da partida. | Comparar guarda original e sua remoção; distinguir duas observações. | Detecta interação indevida mesmo quando o total de tiros está protegido por outra classe. |
| q-u02-019 | Interpretar o alcance e o limite das observações de um teste. | Sem conta numérica. | Explicita o limite de um registro que conserva apenas o último argumento. |
| q-u02-020 | Verificar regressão de regra compartilhada após sobrescrita. | Sem conta numérica. | Verifica regressão causada por sobrescrita que contorna a regra comum. |

## Progressão, tempo e representação

O cenário permanece ao final. O Typst já prevê linhas de resposta nos itens abertos e quadro de letras apenas para múltipla escolha. A paginação e as dimensões finais dos espaços serão conferidas após fechar o conteúdo. Base de cálculo de tempo: 15 minutos de leitura do cenário, 60–65 de resolução e 10 de revisão. Estimativa de autor, sem evidência de aplicação.

O aluno começa com estado, acompanha contratos, analisa composição e herança e termina verificando mudanças. Questões independentes reutilizam o cenário, sem modificar premissas de outras questões. Alternativas de código mantêm estrutura comum no enunciado. JUnit usa somente assertEquals e assertTrue.

## Evolução motivada

- A mecânica de meteoros, posições e sorteio foi retirada para diminuir exigências externas e navegação.
- A mecânica de tempo e recarga foi retirada por solicitação do professor. Nave oferece disparar(), com uma ação explícita por chamada e colaboração pelo contrato Disparo.
- A nave especial como fonte de variação foi substituída por Disparo, preservando a ideia de tiro duplo e avaliando contratos. A herança reaparece onde existe sequência comum e estado comum, em Arma.
- O peso de contratos foi distribuído entre questões locais, compartilhamento, evolução e comparação; herança também aparece integrada, sem organizar toda a unidade.
- Q19 explora limites de um teste em vez de declarar que observar o último argumento prova a identidade de todos os argumentos.
- Houve distribuição preliminar em Typst/PDF para a primeira leitura. Por orientação posterior do professor, a revisão atual mantém base Markdown e fonte Typst sincronizadas; renderização e conferência final da composição ficam para quando a prova estiver finalizada.

## Decisões abertas para esta primeira avaliação

- Aceitação pelo professor do recorte de disparos, sem movimento/meteoritos.
- Adequação da duração, da contagem opcional e das composições de dois repetidores.
- Aprovação semântica da base e do blueprint permanece pendente.

## Ajustes solicitados pelo professor

- Cenário e código de referência transferidos para o final; premissas gerais mantidas antes das questões.
- Removidas explicações dos efeitos de getTiros, Arma.disparar, DisparoRepetido e DisparoRegistro: são inferências de leitura do código.
- Após uma primeira tentativa de clarificar a entrada de Nave.atualizar, o professor solicitou uma abstração melhor. A operação foi substituída por disparar(), sem parâmetro booleano ou recarga, e os itens dependentes foram revisados.

## Formato das respostas e edição atual

- Q2, Q3, Q6, Q8, Q9, Q10 e Q17 pedem a saída dos println explícitos, sem alternativas. O estudante deve produzir os valores e sua ordem.
- Q16 mantém o foco no efeito do cast, com atribuição do retorno da consulta a uma variável, sem print.
- Demais questões continuam de múltipla escolha. IDs, recorte e pesos foram preservados.
- Base Markdown e fonte Typst são os arquivos de trabalho, com gabarito correspondente. O Typst acompanha os ajustes de conteúdo, sem gerar PDF. PDF e previews representam a versão anterior e serão atualizados quando o professor finalizar a prova.
- A estimativa de duração continua sujeita à revisão: a resposta aberta retira as alternativas como apoio à previsão.

## Revisão da abstração de Nave

- A nave recebe Partida e Disparo no construtor; disparar() consulta o fim e encaminha a mesma partida ao colaborador. Nenhuma classe de tempo foi acrescentada.
- Q1 descreve os responsáveis no novo cenário; Q4 e Q7 usam a nova operação; Q8 preserva o compartilhamento da arma.
- Q3 passou a usar uma ArmaDupla acionada duas vezes por uma nave: saídas 4 e 2. A mecânica de recarga deixa de ser evidência avaliada.
- Q18 remove apenas a guarda de fim. D detecta o acionamento da arma após o fim; E observa o total protegido por Partida e passa nas duas versões. A resposta permanece D.
- A fonte Java, o cenário Markdown e o Typst apresentam o mesmo código. Os demais tipos preservam suas responsabilidades: Partida protege seu estado; Arma concentra a sequência comum e seu contador; implementações e repetidor variam o disparo pelo contrato.
