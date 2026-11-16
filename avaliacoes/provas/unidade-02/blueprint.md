# Blueprint — Prova da Unidade 02

**Versão vigente:** Q13 explica erro pelo tipo declarado; Q15 avalia a restrição do parâmetro de equipar; Q16 compara recarga por soma e atribuição; Q18 compara observações de dois testes independentes; Q19 analisa tornar concreta uma operação abstrata. A matriz de evidências abaixo e a seção final desta rodada são as referências atuais. Notas de rodadas anteriores permanecem como histórico, inclusive as menções a Oficina/Cristal, UsoRegistro, teste único de Q18 e lacunas em Orbe.

## Direcionamento e pontuação atuais

- Cenário aprovado: exploração com inventário, equipamentos mágicos e consumíveis; recorte até a Aula 18, sem tratamento de exceções.
- Nova decisão autorizada: a unidade de nota da parte prática é cada impressão, não a questão que a contém. O professor permitiu escolher 20 × 3 ou 30 × 2, ambos totalizando 60 pontos, conforme a cobertura.
- Seleção adotada: **20 impressões de 3 pontos**, em 12 trechos. As oito objetivas permanecem com 5 pontos cada, somando 40. Total: **100 pontos**.
- Os 12 trechos foram mantidos para preservar focos distintos e evitar renumerar as objetivas. A quantidade de questões não orienta a seleção das impressões.
- Cada impressão é corrigida independentemente. Nos trechos com duas linhas, a) e b) são subitens de 3 pontos. Os trechos de uma linha constituem uma única unidade de 3 pontos. Não há exigência de acertar outra linha para receber os pontos de uma resposta correta.
- As questões mantêm seus IDs. A inversão anterior permanece: Q17 usa q-u02-017; Q16 usa q-u02-016. As novas unidades de linha recebem sufixos a/b, sem trocar a identidade dos trechos.
- Referência de duração mantida em 90 minutos, ainda sem resolução humana cronometrada. A base, o Typst, o preview, as cópias Java e o gabarito incorporam as correções autorizadas. O PDF é uma versão de revisão, sem aprovação da base nem liberação para impressão.
- A autorização de autoria e desta pontuação não é aprovação da base final ou liberação para impressão; os gates continuam pendentes.

## Por que 20, em vez de 30

A versão anterior emitia 34 linhas. A análise foi feita por observação, identificando o que desapareceria do diagnóstico ao retirá-la. A seleção de 20 preserva os 12 focos e as observações complementares necessárias dentro de cada foco. Manter 30 a partir da seleção disponível conservaria dez observações adicionais sem acrescentar dez evidências proporcionais de compreensão; várias seriam descrições de equipamentos pelo mesmo algoritmo, retornos já discriminados pelo estado final ou leituras de estado inicial sem papel na decisão.

| Critério | Seleção de 20 | Alternativa de 30 |
| --- | --- | --- |
| Parte de saída | 20 × 3 = 60 | 30 × 2 = 60 |
| Focos de leitura preservados | 12, com uma ou duas observações discriminantes por trecho | Os mesmos focos já estavam na versão anterior; mais linhas não resolveriam uma lacuna identificada. |
| Mudança aplicada | Retirada de 14 observações e reformulação de Q9/Q11 para observar controle e efeito com menos linhas | Exigiria conservar dez das observações retiradas ou projetar novas evidências ainda não necessárias ao recorte. |
| Decisão | Cobre adequadamente o cenário e o conteúdo, em conjunto com as oito objetivas. | Não foi identificada necessidade pedagógica de dez observações adicionais. |

A contagem usa **linhas realmente emitidas na execução**. Q3 chama Inventario.listar, cujo laço emite duas linhas, e vale 6 pontos. Não se juntaram resultados independentes em uma concatenação para reduzir artificialmente a contagem.

## Fontes curriculares

- `specs/projeto-pedagogico.md`: responsabilidades, contratos e colaboração organizam a unidade; herança aparece quando há estado e regra comuns. Leitura, evolução e testes compõem a evidência; sintaxe incidental não deve dominar.
- Aulas 12 e 14: colaborador variável, necessidade de contrato e dependência da operação oferecida.
- Aula 13: testes, escolha de observações e limites de uma execução verificada.
- Aula 15: tipo declarado, objeto concreto, reatribuição e destino das chamadas.
- Aula 16: combinação por composição, preservação do colaborador, camadas e propagação.
- Aulas 17–18: inventário heterogêneo, capacidades independentes, cast, instanceof, estado privado, super, base abstrata e operação herdada que chama uma sobrescrita.
- Laboratórios 12–18, em especial a separação entre notificador, capacidade de contagem e base de implementação no Laboratório 18.
- `docs/materiais/java-essencial.md`, `specs/padrao-avaliacoes.md`, regressões disciplinares e contratos genéricos do Docemas.
- Retrospectiva 2026.2: o ritmo da Aula 15 foi considerado adequado; a estimativa desta prova ainda não tem evidência de aplicação.

## Cenário e limites

Nove tipos comuns: Item, Usavel, Recarregavel, Personagem, Equipamento, Cajado, Amuleto, Pocao e Inventario. Equipamento compartilha saldo e sequência de uso. A aplicação do efeito fica em aplicarEm, privado na base; as subclasses fornecem apenas a consulta abstrata getVariacaoVida, negativa para dano e positiva para recuperação. Consultar essa variação não altera o alvo nem consome cargas. Os três contratos têm papéis distintos. Pocao cumpre dois diretamente e preserva seu próprio ciclo de uso. Personagem coordena o Usavel recebido; Inventario guarda e apresenta Item.

A intenção é ler responsabilidades e percursos reais, com recurso limitado e efeitos observáveis. Não há atualização temporal, recarga automática, colisões, janela, framework, aleatoriedade, API de jogo ou contador artificial de chamadas no cenário comum. Os tipos locais de Q10 e Q12 existem apenas para suas mudanças e combinações específicas.

Premissas externas ficam antes das questões: independência das execuções e alterações, arquivos separados, imports, argumentos não nulos, índices e estados iniciais válidos. A condição inicial de equipado é nula e consta do código. O código completo fica no final; enunciados não explicam seus getters, efeitos, limites ou retornos. Cada questão possui estado inicial local, sem herdar o estado de outra.

Deliberadamente excluídos: exceções e seus tratamentos, APIs de frameworks, sobrecarga como tópico, super.metodo, construtores this(...), campos e métodos protected, matriz de acesso entre pacotes, herança de interfaces como conteúdo, streams, lambdas e matemática além de inteiros pequenos. O construtor protected permanece conforme a Aula 18. O método privado aplicarEm segue a fronteira de acesso da Aula 04 e o uso de método privado auxiliar presente na Aula 11. A consulta abstrata pública getVariacaoVida segue a forma das operações abstratas da Aula/Laboratório 18. Q17 usa assertEquals(true, ...) na comparação de referências, como na Aula 16.

## Vinte unidades de impressão

| ID pontuado | Posição | Pontos | Evidência principal | Ganho da observação |
| --- | --- | ---: | --- | --- |
| q-u02-001-a | Q1 a | 3 | Limite superior da vida e recusa de dano negativo. | Discrimina aceitação de quantidade negativa ou ausência do teto. |
| q-u02-001-b | Q1 b | 3 | Limite inferior seguido de recuperação válida e recusa de recuperação negativa. | A primeira observação não verifica dano que ultrapassa a vida nem retorno a partir de zero. |
| q-u02-002 | Q2 | 3 | Recarga herdada respeita o máximo específico do objeto; o uso posterior consome uma carga. | A descrição Amuleto: 1/2 distingue recarga ignorada, teto ignorado e consumo omitido. |
| q-u02-003-a | Q3 a | 3 | Inventario.listar percorre a coleção e solicita a descrição pelo contrato Item. | A primeira posição alcança a descrição herdada do cajado, preservando a ordem de inclusão. |
| q-u02-003-b | Q3 b | 3 | A listagem alcança implementação independente e consulta o estado atual do objeto guardado. | A poção foi consumida depois de adicionada; a segunda posição descreve a mesma instância já vazia. |
| q-u02-004-a | Q4 a | 3 | Duas posições da coleção compartilham um recurso de uso limitado. | A segunda tentativa falha se ambos os acessos alcançam o único saldo, em vez de cópias. |
| q-u02-004-b | Q4 b | 3 | A recusa da segunda tentativa impede repetir o efeito sobre o alvo. | O retorno sozinho não distingue a suposição de um segundo dano antes da recusa. |
| q-u02-005 | Q5 | 3 | Reatribuição local não substitui o colaborador já guardado. | O efeito identifica qual colaborador permaneceu configurado; a igualdade adicional foi retirada. |
| q-u02-006-a | Q6 a | 3 | O solicitante de uma ação pode ser alvo da ação de outro objeto. | Determina o destinatário da recuperação, sem confundi-lo com o dono do amuleto. |
| q-u02-006-b | Q6 b | 3 | O argumento encaminhado identifica o destinatário do dano. | Complementa a recuperação em outro objeto; os dois saldos não são compartilhados. |
| q-u02-007 | Q7 | 3 | Casts entre interfaces preservam identidade. | Única igualdade de referências pontuada; não se repete por uma descrição de saldo. |
| q-u02-008-a | Q8 a | 3 | O uso pode ser aceito mesmo quando o alvo não ganha vida. | Separa o critério de sucesso da operação do efeito líquido na vida. |
| q-u02-008-b | Q8 b | 3 | O uso aceito consome recurso mesmo sem aumentar a vida do alvo. | A carga zero distingue aceitação com consumo de uma suposta preservação do recurso diante do teto de vida. |
| q-u02-009-a | Q9 a | 3 | O coordenador trata a ausência inicial de colaborador. | Avalia o ramo equipado == null e seu retorno, sem presumir objeto implícito. |
| q-u02-009-b | Q9 b | 3 | O retorno delegado controla outra ação e preserva a recusa do consumível. | Dois ifs discriminam executar o dano só no uso aceito, inclusive na tentativa posterior recusada. |
| q-u02-010 | Q10 | 3 | Sobrescrever um método concreto substitui a sequência da base. | O dano de cinco, mesmo sem cargas, discrimina guarda herdada, operação abstrata e corpo sobrescrito. |
| q-u02-011-a | Q11 a | 3 | Uma capacidade opcional seleciona os participantes da operação. | O contador distingue os dois equipamentos da poção sem depender de classes concretas. |
| q-u02-011-b | Q11 b | 3 | Após reconhecer a capacidade, a delegação altera o objeto original. | A contagem dos participantes não garante que a recarga tenha sido solicitada ou aplicada. |
| q-u02-012-a | Q12 a | 3 | Composição em duas camadas preserva ordem e multiplicidade dos efeitos. | Exige alcançar o cajado e retornar pelas duas recuperações: 97 → 85 → 90 → 95. O teto de 100 não é atingido nem verificado por esta observação. |
| q-u02-012-b | Q12 b | 3 | A recusa da base se propaga sem efeito adicional nas camadas. | O segundo uso segue outro caminho: repetir apenas as curas levaria a uma resposta diferente. |

As duas descrições de Q3 correspondem a implementações distintas: uma herdada de Equipamento e outra independente em Pocao. As duas linhas de Q6 observam alvos diferentes. As duas de Q12 podem ter o mesmo texto, mas resultam de caminhos diferentes: sucesso com composição e recusa propagada. A igualdade de valores não foi usada como critério isolado de redundância.

## Objetivas e habilidades não cobertas adequadamente por saída

| ID | Formato | Habilidade central | Demanda / carga incidental | Ganho em relação aos mais próximos |
| --- | --- | --- | --- | --- |
| q-u02-013 | Múltipla escolha | Explicar uma rejeição em compilação pelo tipo declarado da referência. | Duas linhas e cinco razões concorrentes para a chamada a descrever por Usavel. | O objeto concreto possui o método, mas a referência não o oferece. Retirada a combinação II/IV que podia ser recuperada de outras questões. |
| q-u02-015 | Múltipla escolha | Julgar herança versus composição pela relação de responsabilidades. | Comparar subtipagem, dependências e reaproveitamento por delegação. Uma evolução estrutural; sem estados intermediários. | Os distratores distinguem ter operações de ser subtipo, confundir campo privado com indisponibilidade dos métodos herdados, copiar regras e supor que sobrescrita elimina subtipagem. |
| q-u02-018 | Múltipla escolha | Avaliar o efeito de restringir uma dependência de contrato para hierarquia. | Troca local do parâmetro de Personagem.equipar, com campo e corpo preservados. | O método compila, mas perde clientes como Pocao sem necessidade para usar. Distingue atribuição, conjunto de argumentos aceitos e despacho. |
| q-u02-016 | Múltipla escolha | Escolher um caso que distingue duas implementações considerando estado anterior e limite. | Proposta de recarga com atribuição no lugar de soma; cinco testes curtos em Java, com criação, recarga e assertEquals. | Saldo zero, teto e retorno antecipado ocultam o defeito em quatro casos. O teste correto observa preservação de saldo anterior sem saturação. Não avalia mais recarga negativa. |
| q-u02-017 | Múltipla escolha | Relacionar cada observação de teste aos defeitos que ela detecta. | Dois testes independentes, retorno versus vida do alvo, e cinco comportamentos incorretos. | O erro A é detectado só por II; B só por I; C/E por ambos; D por nenhum. A comparação explicita alcance e insuficiência sem registro auxiliar ou sequência compartilhada. |
| q-u02-014 | Múltipla escolha | Localizar uma regra nova no responsável que garante todos os seus efeitos. | Situar uma precondição nova antes de dois efeitos e cobrir todas as entradas. Três critérios: vida zero, false sem consumo, chamada direta. | Decisão de responsabilidade e momento da validação. O requisito é novo e exclusivo da questão; não descreve uma regra do cenário original. |
| q-u02-019 | Múltipla escolha | Avaliar a mudança de obrigação abstrata para comportamento padrão e seu impacto em subclasses. | Corpo proposto para getVariacaoVida e uma subclasse com construtor pronto. | Orbe pode herdar a operação, enquanto Cajado/Amuleto preservam as sobrescritas. Não pontua mais completar construtor e método nem volta a medir consumo sem efeito. |
| q-u02-020 | Múltipla escolha | Explicar como a exposição de uma coleção permite contornar uma regra de inclusão. | Um getter proposto e cinco explicações sobre a referência devolvida e o limite. | Exige reconhecer add externo sem passar pelo inventário. Distratores tratam de private, cópia automática, substituição do campo por referência externa e necessidade de setter. |

Cada objetiva vale 5 pontos. Elas preservam compilação pelo tipo declarado, localização de precondição, escolha entre herança e composição, alcance de observações de teste, seleção de teste discriminante, dependência mínima, obrigações de construção e encapsulamento da coleção. A correção de auditoria reformula os distratores de Q14/Q15 e alinha a asserção de Q17 ao repertório documentado, mantendo as respostas E, D e A, respectivamente.

Na revisão posterior de Q13–Q20, Q14 passou a perguntar diretamente pela escolha de herança e por outra forma de reutilização; seu distrator B trata de dependência desnecessária, distinto da duplicação de regras em C. Após nova observação do professor, a abertura passou a recuperar que o personagem já equipa um item, apresentar a necessidade de guardar itens e situar a proposta de herança. Q17 apresenta o personagem que equipa o registro e seu distrator D questiona se o último argumento é conhecido. Q19 compara mais diretamente as obrigações de construção e implementação abstrata. As demais questões foram preservadas após exame individual, assim como as oito respostas e os pesos.

## Distribuição de pontos

| Trechos | Impressões | Valor por impressão | Pontos |
| --- | ---: | ---: | ---: |
| Q1–Q6 | 10 | 3 | 30 |
| Q7–Q12 | 10 | 3 | 30 |
| Q13–Q20 | — | 5 por objetiva | 40 |
| Total | 20 | — | 100 |

Contagens por trecho de Q1 a Q12: **2, 1, 2, 2, 1, 2, 1, 2, 2, 1, 2, 2**. O cabeçalho de cada questão mostra a soma das suas impressões, não um valor fixo de 5.

## Remoções e reformulações motivadas

- Q1: a impressão intermediária de zero foi retirada; a recuperação posterior ainda distingue a proteção do limite inferior.
- Q2: a repetição de dois usos foi substituída por recarga acima do máximo, uso e descrição do saldo restante. O efeito específico do amuleto permanece observável em Q6.
- Q3: dois tipos bastam para observar as duas implementações de descrição. A chamada a Inventario.listar substitui o laço externo e observa os objetos na ordem de inclusão.
- Q4: o primeiro sucesso deixa de ser impresso; a recusa pela segunda posição e o saldo do alvo distinguem compartilhamento e ausência de segundo efeito.
- Q5: o efeito no alvo identifica o colaborador conservado. A comparação adicional de referências repetia essa inferência.
- Q7: permaneceu a igualdade após casts. A recarga e o uso antes da descrição se compensavam numericamente e não acrescentavam observação necessária sobre identidade.
- Q8: permanecem duas observações, agora aceitação e consumo mesmo com a vida no máximo. A vida final deixa de ser impressa; seu limite já é observado em Q1.
- Q9: dois ifs fazem o estado final depender do retorno no uso aceito e no recusado, dispensando imprimir também esse segundo retorno.
- Q10: o efeito no alvo identifica qual corpo foi escolhido. A impressão do saldo inicial zero não distinguia o despacho e foi retirada com o retorno adicional.
- Q11: capacidade e efeito são observados pelo contador de participantes e pela carga do amuleto original; foram eliminadas as três descrições de listagem.
- Q12: dois estados do alvo observam ordem e interrupção das camadas. Os retornos booleanos adicionais eram inferíveis dos mesmos percursos.

## Clareza e contexto dos enunciados

O professor definiu que objetividade deve vir acompanhada de contexto suficiente para compreender a situação. Uma entidade nova precisa ter sua função apresentada antes de ser usada na pergunta. A dificuldade pretendida deve estar na análise de POO, sem exigir que o estudante decifre expressões do processo de autoria ou conheça regras externas de jogos.

A abertura identifica o jogo, seus personagens, inventários e itens mágicos. Q10/Q12 apresentam as classes locais pelo nome ou finalidade; Q13/Q14 explicitam a situação das referências e do inventário. Na calibração posterior, Q15 passa a declarar uma nova versão do programa com a classe Oficina, à qual pertence o método mostrado, e a classe Cristal. A mudança introduz tipos nessa versão do programa, sem pressupor a inclusão de uma instância no inventário e sem acrescentar regras de consumo ou limites. Q16 descreve a remoção de um trecho do método, sem usar “guarda” como premissa de compreensão. Q17 apresenta a classe como parte de um teste de Personagem; Q18 descreve a nova regra de uso; Q19 identifica Orbe como esfera mágica de cura; Q20 apresenta o limite do inventário antes de perguntar como a inclusão poderia escapar da verificação.

Os comandos de saída cujos objetos e ações já estão claros no código permanecem curtos. Não se acrescentam narrativas que repitam a execução, forneçam saídas ou expliquem antecipadamente os mecanismos avaliados. A revisão de enunciados anterior à correção da API modificou somente a redação, preservando código e alternativas. A correção posterior da API está descrita abaixo; respostas, evidências centrais, IDs e pontuação continuam preservados.

## Independência, progressão e dificuldade

Cada trecho inicia seus objetos e mantém locais suas alterações e classes adicionais. Nenhum resultado de uma questão é fornecido em outra. As unidades a/b compartilham deliberadamente o mesmo programa, mas têm critérios de correção independentes; uma resposta errada não é transportada para a nota da seguinte.

O percurso continua de estado para despacho, contratos, identidade, composição e avaliação de decisões. A redução incidiu sobre observações, sem eliminar sobrescrita de método concreto, múltiplas interfaces, capacidade opcional ou composição em duas camadas. A dificuldade continua conceitual; não foi aumentada com contas longas, concatenações de resultados ou recurso Java futuro.

A estimativa de 90 minutos é mantida como referência, sem evidência de aplicação. A quantidade de respostas escritas diminui; a leitura de código e os percursos conceituais permanecem. Não se presume que cada impressão exija o mesmo tempo apenas por ter o mesmo valor.

O orçamento abaixo é uma estimativa de trabalho para revisão docente, não uma medição de desempenho de estudantes:

| Bloco | Referência | Trabalho considerado |
| --- | ---: | --- |
| Instruções e reconhecimento do cenário | 12 min | Ler os três contratos, localizar os estados e identificar os percursos de uso, recarga e descrição nos nove tipos. |
| Q1–Q3 | 10 min | Limites de vida, teto da recarga seguido de consumo e listagem por contrato comum. |
| Q4–Q9 | 18 min | Referências compartilhadas, reatribuição, dois destinatários, casts e dois ramos condicionados pelo retorno. |
| Q10–Q12 | 20 min | Ler duas classes locais e acompanhar sobrescrita, seleção de capacidades e composição em duas camadas. |
| Q13–Q20 | 25 min | Comparar contratos e decisões de projeto, analisar os dois testes de Q18 e a alteração da base em Q19. |
| Conferência das respostas | 5 min | Revisar as 20 linhas e as oito alternativas. |
| Total | 90 min | Inclui consulta repetida ao cenário; depende de familiaridade com o repertório da unidade. |

O principal risco de ultrapassagem está na leitura inicial e nas classes locais de Q10/Q12 e na extensão de Q19. A execução automática dos trechos não mede esse esforço. A resolução cronometrada por uma pessoa continua sendo a verificação pendente de duração; o orçamento não equivale a validá-la. Não se alteram os 90 minutos, a cobertura ou a pontuação sem nova evidência ou decisão do professor.

A correção do efeito público acrescenta um auxiliar privado e uma consulta abstrata à leitura do cenário. As saídas e a pontuação são preservadas, mas a leitura adicional também deve entrar na verificação humana de duração. A duração não foi considerada validada por essa correção.

## Correção da API e do gabarito após a nova auditoria

O professor autorizou corrigir os achados. Tornar aplicarEm público permitia alterar o alvo sem passar pelo controle de cargas. A correção mantém a aplicação privada em Equipamento e deixa nas subclasses apenas a consulta da variação. Não basta restaurar protected: no projeto sem package, um cliente do mesmo pacote ainda poderia chamar um método protegido. Não se introduzem pacotes, final ou mecanismos futuros para corrigir esse ponto.

Q18 preserva a decisão de verificar a condição em usar antes do efeito e do consumo. Sua alternativa D passa a propor a verificação no auxiliar privado da base; ela continua errada porque usar ainda consumiria a carga e devolveria true. Q19 passa a pedir a implementação da consulta abstrata devolvendo 7; a resposta continua B. Q10 preserva sua sobrescrita local de usar como comportamento a analisar, sem tornar o método final. O comentário de Q15 passa a justificar as alternativas atuais, sem mudar a letra D.

## Representação e estado de revisão

- O Typst incorpora as correções da auditoria e mantém duas colunas, intervalo de 18 pt, caixas com 8 pt de afastamento e alternativas separadas da letra por uma coluna de 8 pt.
- Na finalização, preservar questões indivisíveis e os espaços a/b nos trechos com duas saídas; os de uma saída têm uma única linha.
- As duas caixas e os rótulos I–IV de Q13 foram preservados. A compilação atual confirmou seis páginas, cenário nas duas últimas e acomodação dos novos textos sem dividir questões. Houve inspeção visual das páginas alteradas; o PDF é de revisão e a liberação para impressão permanece pendente.
- As 20 saídas e as letras do gabarito continuam válidas. Os comentários acompanham as alternativas e a API atuais. As cópias Java e o HTML semântico estão sincronizados; o PDF e suas imagens são derivados de revisão. Os derivados antigos do cenário de disparos são preservados no histórico.
- A revisão do autor não é auditoria independente nem aprovação automática. As verificações técnicas e o percurso estão em base-review.md e README.md.

## Refinamento aprovado de Q14 e condução de Q15–Q19

Q14 assume a forma de revisão de uma proposta de código: reconhecer o ganho real de reutilização e criticar a subtipagem criada. Q15 apresenta uma rotina de recarga e a necessidade de aceitar objetos fora da hierarquia; os dois pontos de alteração são a declaração de Cristal e o parâmetro. Q16 situa a escolha de teste como detecção de uma mudança observada na revisão de código. Q17 apresenta a finalidade do teste antes do colaborador e pede uma conclusão limitada às verificações. Q18 declara que a restrição ainda será implementada, com efeito, retorno e consumo explícitos. Q19 parte do equipamento desejado e explica a criação com duas cargas antes de pedir as declarações necessárias. Preservam-se os objetivos, IDs, pesos e respostas E/D/C/A/B/B. As alternativas de Q14 foram substituídas pela versão aprovada; as de Q15 foram reduzidas às duas decisões de declaração, preservando suas combinações; as de Q16–Q19 foram conservadas após análise de cada distrator.

## Aplicação dos achados da revisão completa

Por orientação do professor, a duração está fora do escopo dos ajustes e permanece inalterada. Q15 C agora declara apenas Recarregavel e escolhe Item como parâmetro; E escolhe Cristal, que recusa os equipamentos. Os distratores não exigem implementar descrever/usar. Q17 C extrapola contagem total para uma delegação por execução; D extrapola o retorno do colaborador para o retorno de Personagem. A pergunta limita expressamente a conclusão às verificações. Q19 apresenta uma classe incompleta com argumentos de super invertidos e consulta abstrata ausente: o aluno precisa reparar construção e concretização. A passa a compilar, porém não atende aos valores requeridos; B continua correta. A comparação já não depende apenas de reconhecer a estrutura de Amuleto.

A fonte Typst reúne Q20 e o início do cenário na página 5, reduzindo o PDF de sete para seis páginas sem diminuir fontes ou partir questões/classes. As demais classes ocupam a página 6. Há recuos explícitos nas linhas Java longas. Este é o estado atual; descrições de versões anteriores acima constituem histórico. Respostas Q15 D, Q17 A e Q19 B, objetivos centrais, IDs e pontuação preservados.

Atualização de posição: Q17 e Q18 foram invertidas; a regra de vida zero é Q17 (B) e a análise do teste é Q18 (A). Os IDs e conteúdos das questões foram preservados. Referências anteriores a esses números neste arquivo descrevem a ordem anterior.

## Refinamento autorizado de Q1–Q12: cobertura e ganho diagnóstico

Após a revisão completa das doze questões, o professor autorizou substituir Q2 por recarga acima do máximo seguida de uso (Amuleto: 1/2), acionar Inventario.listar em Q3 (Cajado: 2/3; Poção vazia) e observar cargas em Q8 (true; 0). As demais questões permanecem iguais. A mudança em Q2 desloca a evidência principal para teto e consumo; Q6 conserva a observação do efeito específico do amuleto. Q3 mantém despacho de descrição e acrescenta a chamada à operação do inventário. Q8 verifica consumo sem aumento de vida, cujo teto continua em Q1. Preservados IDs, vinte linhas de três pontos, total de cem pontos e duração. Registros anteriores descrevem versões históricas; a matriz de unidades acima representa a versão vigente.

## Substituição autorizada de Q18/Q19 e ajustes de Q15/Q20

Esta seção e a matriz de objetivas acima representam a versão vigente; descrições anteriores de UsoRegistro e da classe Orbe defeituosa pertencem ao histórico. O professor autorizou preservar Q13/Q14/Q16/Q17, ajustar Q15/Q20 e substituir Q18/Q19 a partir das habilidades.

Q15 mantém as cinco combinações em uma tabela de decisões. Q18 troca a classe de registro por um teste com cajado, vida e cargas; a falha de retorno escapa ao teste. A evidência de histórico e contagem acumulada é retirada explicitamente. Q19 parte do requisito de orbes configuráveis: construtor e campo próprios, capacidade comum quatro e operação abstrata que devolve a recuperação recebida. A estrutura é compartilhada para evitar cinco classes completas; o candidato de retorno fixo sete distingue atender um exemplo de atender a todos os orbes. Não se introduzem sobrecarga, exceções ou APIs novas. Q20 apresenta o getter e pede explicar a possibilidade de contornar o limite, em vez de localizar o único retorno de lista entre métodos distintos. Há duas respostas afirmativas concorrentes, com razões diferentes, evitando que a polaridade entregue a correta.

Preservados os IDs, cinco pontos por objetiva, letras D/E/D/C/B/A/B/C e cem pontos totais. A duração permanece inalterada. As questões de saída e o código comum não foram alterados nesta rodada. Os novos textos e distratores foram resolvidos e verificados; não há aprovação final implícita.

## Redesenho após auditoria e nova revisão docente

O professor autorizou corrigir a pista de Q13 e redesenhar Q15/Q16/Q18/Q19, preservando todas as outras questões. IDs, cinco pontos por objetiva, vinte impressões e cem pontos permanecem. Letras: D/E/D/C/B/A/B/C.

Q13 não pergunta mais pela combinação de chamadas que compilam. Os usos válidos de interfaces nas questões de saída não selecionam sua alternativa; é necessário explicar por que descrever não está disponível pelo tipo Usavel. Q15 abandona a oficina e as duas declarações em tabela: avalia o impacto de trocar o parâmetro de equipar de Usavel para Equipamento, mantendo a atribuição ao campo Usavel. Q16 substitui a retirada da guarda de negativos pela atribuição cargas = quantidade; quatro casos ocultam a diferença por zero inicial, teto ou retorno antecipado. A recarga negativa deixa de ser observação direta, mas o objetivo de selecionar teste discriminante é mantido. Q18 abandona a pergunta sobre falha não detectada por um único teste e compara explicitamente retorno e vida em execuções independentes. Q19 abandona lacunas e a recuperação configurável: considera a evolução da base de uma obrigação abstrata para implementação padrão. A correção de construtores deixa de ser objetivo próprio; permanecem abstração, instanciabilidade, estado herdado e preservação de sobrescritas. Sua correta não retoma consumo sem efeito de Q8.

A duração é preservada. A carga foi redistribuída para comparação de estados e consequências de projeto, sem classe de teste auxiliar, novo framework ou conteúdo fora do recorte. As alternativas foram resolvidas e validadas tecnicamente. Não há equivalência presumida entre todas as evidências antigas e as novas: as mudanças acima são deliberadas e ficam registradas.

## Apresentação de Q16 em código

Por solicitação do professor, as cinco linhas de casos foram substituídas por trechos Java independentes. Cada alternativa cria seu Cajado, solicita a recarga e verifica o saldo com assertEquals. Preservados os trios inicial/recarga/esperado (0/1/1, 2/3/3, 1/1/2, 3/5/3, 2/0/2), o método proposto, a habilidade, os cinco pontos e a resposta C.
