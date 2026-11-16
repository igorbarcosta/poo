# Revisão da base — vinte impressões e ajustes da auditoria

Revisão integrada autorizada pelo professor, sem alegação de auditoria independente ou aprovação humana da base. O professor definiu a unidade de pontuação: cada impressão, com opção de 20 × 3 ou 30 × 2. A seleção adotou 20 × 3 após examinar o ganho de cada observação, preservando as oito objetivas de 5 pontos e o total de 100.

As seções de seleção abaixo registram a revisão anterior. As correções atuais e as pendências de derivados e duração constam em “Ajustes após a auditoria”.

## Percurso e correção por impressão

As 20 unidades e seus ganhos estão mapeados no blueprint. A solução abaixo é descrita por trecho para explicitar as transições que produzem cada linha; o gabarito mantém a saída literal. Corrigir cada linha independentemente, sem nota indivisível por questão ou dependência de acerto anterior.

| Questão | Impressões | Pontos | Percurso e distinção observada |
| --- | ---: | ---: | --- |
| Q1 | 2 | 6 | A primeira impressão observa o limite superior e a recusa de dano negativo. Depois, o dano leva a zero, a recuperação positiva leva a 7 e a negativa não altera esse resultado. |
| Q2 | 1 | 3 | O método concreto Equipamento.usar chama a operação sobrescrita Amuleto.aplicarEm duas vezes sobre o mesmo amuleto. Cada uso recupera 15 pontos, levando o alvo de 61 a 91. |
| Q3 | 2 | 6 | O laço produz duas linhas, embora contenha uma única chamada escrita a println. O cajado usa a descrição herdada de Equipamento; a poção usa sua própria implementação, já consumida. Não se conserva uma terceira descrição de equipamento que repetiria o mesmo percurso da primeira. |
| Q4 | 2 | 6 | As duas posições alcançam o mesmo cajado. O primeiro uso consome sua única carga e retira 12 pontos. O segundo uso devolve false; sua guarda impede um segundo efeito. A vida final é 28. |
| Q5 | 1 | 3 | Equipar guardou a referência ao cajado. A reatribuição de escolha não troca esse colaborador: o alvo recebe 12 de dano e fica com 38. Uma igualdade de referências adicional repetiria a inferência já necessária para essa saída. |
| Q6 | 2 | 6 | O cajado guardado por a atua em b; o amuleto guardado por b atua em a. Assim, a recebe a recuperação e termina com 47; b recebe o dano e termina com 56. |
| Q7 | 1 | 3 | As conversões permitem usar a mesma referência por contratos diferentes. Não criam cópia nem transformam o objeto; uso e recarga alcançam o mesmo cajado. Foram retiradas operações e uma descrição que não eram necessárias para observar essa identidade. |
| Q8 | 2 | 6 | A carga disponível permite o uso, que devolve true. A vida permanece em 100 por sua própria proteção de limite. A primeira impressão avalia a aceitação da operação; a segunda distingue o retorno de uma mudança efetiva no alvo. |
| Q9 | 2 | 6 | A primeira chamada não encontra objeto equipado e devolve false. O primeiro if usa a poção, sobe a vida para 69 e executa o dano, chegando a 63. No segundo if, a poção já consumida devolve false, e nenhum novo dano é executado. O saldo final discrimina a propagação correta desse retorno sem exigir outra impressão de false. |
| Q10 | 1 | 3 | O despacho executa CajadoLivre.usar, que retira cinco pontos. A sequência de Equipamento.usar, inclusive a guarda de cargas, não é executada automaticamente. A impressão do contador zero foi retirada: repetia o estado dado na construção e não discriminava esse despacho. |
| Q11 | 2 | 6 | Os dois equipamentos oferecem Recarregavel e entram no ramo; a poção não entra. A primeira impressão observa essa seleção. A segunda confirma que a recarga foi delegada ao mesmo amuleto guardado no inventário, elevando seu saldo de zero para um. Foram retiradas as três descrições finais que repetiam a apresentação avaliada em Q3. |
| Q12 | 2 | 6 | No primeiro uso, o cajado reduz a vida de 97 a 85; cada camada recupera cinco, chegando a 95. No segundo, o cajado sem cargas recusa o uso e a recusa se propaga pelas duas camadas, sem recuperação adicional. As duas observações iguais testam percursos diferentes; os retornos booleanos adicionais não eram necessários. |

## Comparação de 20 e 30

A versão anterior tinha 34 linhas efetivas. A retirada de 14 linhas não eliminou nenhum dos 12 focos de interpretação: estado protegido, chamada herdada para operação sobrescrita, lista heterogênea, recurso compartilhado, reatribuição local, destinatário, identidade após cast, sucesso versus efeito, retorno delegado, substituição de método concreto, capacidade opcional e composição em camadas.

Trinta linhas preservariam mais observações do que as necessárias para esses focos na seleção disponível. A análise rejeitou manter a terceira descrição da mesma família em Q3, repetir igualdade e efeito na Q5, pontuar o saldo inicial de Q10 como se fosse consequência do despacho e repetir as três descrições na Q11. Foram conservadas observações complementares: Q4 distingue saldo compartilhado de efeito após a recusa; Q8 distingue aceitação de variação da vida; Q11 distingue reconhecer a capacidade de realmente delegar; Q12 distingue caminho aceito de caminho recusado.

Q9 foi ajustada para que o segundo retorno condicione outra ação, em vez de ser apenas impresso. Q11 usa o mesmo amuleto no inventário e na consulta posterior, preservando a observação da delegação com duas linhas. Nenhum resultado independente foi escondido em uma impressão concatenada.

## Pontuação e identidades

São oito trechos de duas impressões (6 pontos cada) e quatro de uma impressão (3 pontos cada), totalizando 60. As objetivas somam 40. Q3 tem uma chamada sintática a println, mas duas iterações e duas impressões de 3 pontos. A quantidade de chamadas escritas não foi usada como contagem de unidades.

Os IDs das questões foram preservados, inclusive a inversão Q17/Q16. Os trechos de duas linhas receberam subitens a/b de 3 pontos com IDs próprios. Os de uma linha mantêm a própria questão como unidade. O Typst calcula o total do cabeçalho pelo número de linhas de resposta; os marcadores a/b correspondem à mesma ordem do Markdown e do gabarito.

## Repertório, dificuldade e pistas

Na seleção anterior de vinte impressões, não foram alterados os nove tipos comuns, as classes locais de Q10/Q12 ou os conteúdos das oito objetivas. Foram preservados os mecanismos ensinados até a Aula 18 e a ausência de exceções. As composições continuam distintas; a redução de respostas não transforma a prova em reprodução de getters nem elimina os percursos mais exigentes.

Nenhuma resposta de outro trecho é necessária. As saídas de Q1 são controles de estado do mesmo programa; as de Q6 observam alvos diferentes; as de Q12, apesar de iguais, distinguem execução completa e recusa em camadas. Os enunciados das objetivas não entregam essas saídas, e suas regras novas continuam locais.

A consulta de layout confirmou as vinte questões inteiras, dentro das margens, e o cenário em duas páginas consecutivas, sem gerar PDF. Os valores exibidos por questão somam 100 e correspondem a 20 impressões de 3 pontos mais oito objetivas de 5. Duração de referência de 90 minutos mantida, ainda sem validação em aplicação.

## Validação técnica

O script temporário extrai os trechos atuais, compila as duas classes locais e os 12 programas com os nove tipos do cenário, executa cada caso e conta stdout.splitlines(). Confere também os pontos e subitens, a correspondência de Java entre Markdown e Typst e a preservação das oito objetivas e do cenário. A execução registrou 20 linhas reais, todas coincidentes com o gabarito, e 100 pontos (60 + 40). A verificação não é um auditor pedagógico ou evidência de aprovação.

À época da seleção, continuavam aplicáveis os testes anteriores de compilação das chamadas da Q13, das propostas de Q18, do limite das observações da Q17, da mutação da Q16, da API da Q15, da concretização da Q19 e da coleção da Q20, pois esses itens não haviam sido alterados. A nova verificação dos itens afetados pela auditoria está registrada abaixo.

## Ajustes após a auditoria

O professor autorizou as correções da auditoria, preservando o recorte, a duração e a pontuação definidos. Foram editados somente a base canônica, o blueprint e este registro; o preview HTML foi regenerado a partir da base. A fase continua anterior à aprovação humana.

### Q14 — relação de herança e reaproveitamento (q-u02-015)

O pedido continua sendo avaliar a proposta de fazer Personagem estender Inventario apenas para reaproveitar operações. A resposta é E: guardar um inventário e delegar reutiliza as operações sem estabelecer subtipagem.

| Alternativa | Análise |
| --- | --- |
| A | Confunde oferecer operações semelhantes com estabelecer uma relação adequada de subtipagem. Ter e usar um inventário não basta para representar o personagem como inventário. |
| B | A delegação usa a lista do objeto Inventario; não exige uma segunda lista em Personagem. |
| C | Encaminhar chamadas não exige reproduzir as regras já implementadas no colaborador. |
| D | Estender Inventario permite que o personagem seja recebido por um parâmetro desse tipo, efeito que a alternativa nega. |
| E | Reutiliza a implementação por colaboração e preserva a distinção entre personagem e inventário. |

Os distratores agora tratam de subtipagem, localização do estado e delegação, em vez de compartilhamento automático entre instâncias ou herança pelos itens guardados. Não há valores intermediários a recuperar. O item mantém 5 pontos e acrescenta julgamento estrutural à previsão de comportamento de Q5/Q6.

### Q15 — contrato e evolução da oficina (q-u02-018)

O pedido é aceitar equipamentos e Cristal por uma mesma operação, conservando a chamada a recarregar sem casts nem testes de classe concreta. Cristal implementa seus próprios métodos e permanece fora da hierarquia de Equipamento. A resposta continua D.

| Alternativa | Análise |
| --- | --- |
| A | A coincidência das assinaturas públicas não torna Cristal uma implementação declarada de Recarregavel. A chamada da oficina com o cristal não compila. |
| B | Implementar o contrato comum não faz Cristal estender Equipamento. O parâmetro continua recusando o cristal. |
| C | Item permite descrever, mas não declara recarregar. O corpo da oficina não compila com esse tipo de parâmetro. |
| D | Os equipamentos já cumprem Recarregavel. Cristal passa a cumprir o mesmo contrato e o parâmetro permite a chamada exigida. |
| E | Usavel permite usar, mas não declara recarregar. A capacidade adicional do objeto não amplia as operações do tipo declarado do parâmetro. |

Os candidatos são julgados pelo mesmo requisito de compatibilidade entre contrato declarado e chamada disponível. Foram retiradas as propostas de separar oficinas por classe e de contrariar expressamente a hierarquia pedida. A leitura exige relacionar o contrato de Cristal e o parâmetro da oficina; não exige novos estados numéricos. Mantêm-se 5 pontos. Q13 trata de chamadas locais; Q15 transfere essa distinção para uma API que deve admitir uma família nova.

### Repertório e Q12

- A base usa public abstract void aplicarEm e implementações públicas em Cajado e Amuleto, seguindo as operações abstratas públicas trabalhadas na Aula/Laboratório 18. O construtor protected é preservado. A alteração amplia a visibilidade dessas operações; os itens continuam analisando o controle de cargas nas chamadas a usar, sem acrescentar uma regra de acesso a aplicarEm.
- Q17 usa assertEquals(true, registro.getUltimoAlvo() == alvo), forma já presente na Aula 16. O import indicado na base foi ajustado. As duas observações e a resposta A permanecem iguais.
- O blueprint de q-u02-012-a agora registra o percurso 97 → 85 → 90 → 95 e deixa explícito que o teto de 100 não é exercitado. As duas saídas 95 de Q12 são preservadas: uma exige completar os efeitos, a outra exige não repetir as recuperações após a recusa.
- Q1–Q12 preservam integralmente os trechos, os subitens e as 20 saídas. Não houve inclusão de mecanismo Java novo ou mudança de peso.

### Duração e carga global

O blueprint passa a separar o orçamento de 90 minutos entre reconhecimento do cenário, blocos de resolução e conferência. O dimensionamento inclui consulta ao código e reserva mais tempo para Q10–Q12, além da leitura do registro de Q17. A redução de impressões não é usada como prova de redução proporcional da carga.

A base continua contendo 324 linhas Java não vazias, somadas entre trechos, alternativas e cenário. Esse inventário descreve volume, não tempo de leitura. O orçamento é uma estimativa docente: permanece pendente uma resolução humana cronometrada. Não se registra validação empírica nem se reduz cobertura para produzir uma aparência de folga.

### Derivados e validação das correções

Typst, java/, gabarito.md, README, PDF, imagens e pacote de primeira revisão não foram editados nesta fase. O preview/base.html representa a base atual. Antes da finalização, sincronizar as alternativas de Q14/Q15, a asserção/import de Q17 e a visibilidade de aplicarEm com suas cópias. As letras e saídas do gabarito permanecem válidas; os comentários dos distratores de Q14/Q15 precisam ser atualizados. As verificações antigas de layout não validam a acomodação dos novos textos.

Verificação técnica feita a partir da base canônica em diretório temporário:

- compilação dos nove tipos, das duas classes locais de saída e dos 12 programas; execução e comparação das 20 linhas com o gabarito;
- compilação de cada proposta de Q15 com clientes que fornecem Cajado, Amuleto e Cristal: somente D permite os três; A/B recusam o argumento e C/E não oferecem recarregar no parâmetro;
- execução das duas comparações de Q17 com verificações equivalentes a assertEquals e compilação da subclasse concreta correspondente a Q19 B;
- preservação dos IDs e dos pesos: 20 questões, 20 impressões de 3 pontos e oito objetivas de 5, total de 100 pontos.

A revisão não equivale a auditoria independente, aprovação da base ou liberação para impressão. A duração permanece a limitação material da estimativa.

### Sincronização posterior do Typst

O professor autorizou explicitamente modificar unidade_02.typ. A fonte passou a incorporar as alternativas de Q14/Q15, o import e a asserção de Q17 e a visibilidade pública de aplicarEm. Foram conferidos os 40 blocos Java e os textos das alternativas contra a base atual; pontuação e respostas foram preservadas.

A compilação de validação foi produzida em diretório temporário ignorado pelo Git, sem substituir o PDF distribuído. A consulta de posições confirmou seis páginas e as vinte questões inteiras, dentro das margens verticais e da mesma coluna do início ao fim. O cenário permanece nas duas páginas finais. A inspeção visual das páginas 3, 4 e 6 confirmou a acomodação das alternativas, do teste e das declarações alteradas. As pendências de sincronização anteriores deixam de incluir Typst; permanecem as cópias Java e os comentários dos distratores no gabarito.

### Revisão dos enunciados solicitada pelo professor

O professor apontou que os enunciados precisavam apresentar contexto suficiente sem se tornarem prolixos. A passagem global examinou a introdução de entidades, a situação a analisar e a ação solicitada nas vinte questões. As correções foram aplicadas à base e ao Typst.

| Local | Ajuste e limite preservado |
| --- | --- |
| Abertura | Identifica o jogo e seus personagens, inventários e itens mágicos. Preserva a independência das execuções. |
| Q1–Q9 e Q11 | Mantém o comando curto: os trechos já apresentam seus objetos e operações, sem entidades narrativas adicionais a explicar. |
| Q10/Q12 | Nomeia a classe local ou apresenta o propósito de combinar uso e recuperação de vida. Não explica despacho, consumo, condições de sucesso ou ordem dos efeitos. |
| Q13/Q14 | Apresenta a análise das variáveis de tipos diferentes e a proposta concreta de reutilização para o inventário de cada personagem. |
| Q15 | Explica o papel da oficina e o significado do cristal no jogo. Mantém os mesmos critérios de contrato, extensão e chamada sem casts, sem pressupor conhecimento de outro jogo. |
| Q16 | Descreve a ação concreta: apagou-se um trecho e o restante do método permaneceu igual. Pergunta qual teste passa antes e falha depois, sem antecipar qual entrada revela o problema. |
| Q17/Q18 | Substitui “colaborador de teste” e “uma evolução” por um teste de Personagem e uma nova regra do jogo. Preserva o limite das observações e a exigência de cobrir chamadas diretas. |
| Q19/Q20 | Apresenta Orbe como esfera mágica de cura e o limite do inventário como regra já implementada. Preserva a construção requerida e o problema de contornar a verificação de inclusão. |

Foi conferida a igualdade dos 40 blocos Java, de todas as alternativas e dos cabeçalhos de questões/subitens com o estado anterior a esta revisão. As 20 saídas e as oito letras corretas continuam válidas; nenhuma nova regra numérica foi introduzida. Como o código não mudou, a validação desta passagem concentra-se na preservação semântica e na apresentação, sem repetir os testes de execução já registrados.

O preview HTML e o PDF temporário de conferência acompanham os novos enunciados. A redação foi revisada em sua composição real, preservando fonte, espaçamento e questões indivisíveis. A sincronização do Typst segue autorizada pelo professor; esta revisão não altera o estado de aprovação ou o PDF de distribuição.

### Calibração do processo de compreensão

Após nova objeção do professor, foram atualizados os procedimentos de autoria e revisão para separar apresentação compreensível de resposta tecnicamente determinável. A calibração e suas limitações estão registradas em [calibracao-enunciados-unidade-02.md](../../tests/calibracao-enunciados-unidade-02.md).

Duas leituras isoladas recuperaram a intenção da Q15 anterior sem apontar uma lacuna essencial. Esse resultado foi preservado como divergência em relação à observação editorial do professor, e não convertido em confirmação de que o problema fora resolvido. A correção atual é fundamentada na necessidade explicitada pelo professor: a redação identifica a nova versão do programa, a classe Oficina como dona do método e a introdução da classe Cristal nessa mesma versão.

Uma terceira leitura isolada, sem diagnóstico ou texto anterior, reconstruiu essas relações por trechos explícitos da nova Q15. Q16/Q17 foram preservadas como controles positivos e permaneceram compreensíveis nessa passagem. Os controles genéricos de alvo ausente e reparo narrativo superficial foram reconhecidos; a extensão local completa foi preservada. São verificações comportamentais limitadas, sem alegação de desempenho com estudantes, auditoria formal completa ou aprovação humana da base.

A passagem isolada seguinte abrangeu a prova inteira. Identificou uma referência recuperável, mas não declarada, de I–IV às linhas de Q13 na base Markdown; o Typst já trazia os rótulos. O enunciado agora associa explicitamente I–IV às chamadas do segundo bloco, na ordem apresentada. Não foram encontrados outros problemas materiais de referência nessa leitura. O registro da calibração preserva as fontes, os limites e a distinção entre essa leitura e a conferência posterior da correção pelo autor.

## Correção dos achados da nova auditoria completa

O professor autorizou corrigir os achados e sincronizar os arquivos da prova. Esta seção descreve o estado atual e substitui as pendências de API, cópias Java, comentário de Q15 e derivados registradas nas revisões anteriores. O workflow permanece em elaboração, sem aprovação da base ou liberação para impressão.

### Efeito público sem controle de cargas

O trecho anterior permitia que um cliente chamasse aplicarEm em um Cajado sem cargas: duas chamadas levavam um alvo de 50 para 26, mantendo as cargas em zero. A aplicação do efeito foi movida para um método privado de Equipamento. As subclasses agora implementam apenas getVariacaoVida, uma consulta abstrata pública: Cajado devolve -12 e Amuleto devolve 15. O código da base interpreta a variação e aplica o efeito somente dentro da sequência de usar, que verifica e consome as cargas.

A correção não se limita a restaurar protected, pois todos os tipos pertencem ao mesmo pacote neste projeto. A fronteira usada é private, já trabalhada na disciplina; a Aula 11 também contém método auxiliar privado. O formato da consulta abstrata pública corresponde às operações de descrição da Aula/Laboratório 18. Não foram acrescentados pacotes, final ou novos mecanismos de linguagem.

O controle foi verificado por comportamento: chamar a consulta não altera vida nem cargas; os usos com zero cargas devolvem false sem efeito; a chamada externa a aplicarEm não compila por acesso privado. A sobrescrita local de usar em Q10 permanece exatamente como estava, pois seu objetivo é observar que uma implementação sobrescrita substitui o algoritmo herdado.

### Itens e gabarito afetados

- Q2 mantém a saída 91. O percurso é usar → auxiliar privado aplicarEm → consulta sobrescrita Amuleto.getVariacaoVida → recuperação controlada pela base. O gabarito e o mapeamento do blueprint acompanham esse percurso.
- Q18 mantém B como resposta. D agora propõe verificar a condição no auxiliar privado da base; continua errada porque isso não impede usar de consumir a carga e devolver true. A–E foram compiladas como alterações locais e executadas com Cajado e Amuleto, em chamadas diretas e por Personagem. Somente B cumpre simultaneamente retorno false, carga preservada e vida zero em todos os casos.
- Q19 mantém B como resposta. A classe concreta precisa do construtor com super e da implementação de getVariacaoVida devolvendo 7. Somente B permite compilar a classe e executar new Orbe(2). Em execução, dois usos recuperam 14 pontos e consomem as duas cargas; o terceiro devolve false sem novo efeito.
- O comentário de Q15 foi reescrito para as alternativas atuais: A não declara o contrato; B recusa Cristal, não os equipamentos; C/E usam parâmetros que não oferecem recarregar. A letra D foi preservada.

Uma tarefa isolada de leitura recebeu somente instruções, Q2/Q18/Q19 e o cenário completo, sem blueprint, gabarito ou diagnóstico. Reconstruiu as três tarefas a partir das fontes e não identificou relação essencial ausente. A consulta da variação e o papel da esfera de cura estavam sustentados pelo código e pelo enunciado. O pacote estudantil lido tem SHA-256 15732fffd8b88e39ac0e8bf97c7589b2d622a7593e76f56348a072944267dcc0. Essa leitura valida compreensão nesses itens, sem substituir a solução técnica ou a aprovação do professor.

### Regressão, derivados e duração

Foram recompilados os nove tipos comuns e os doze programas de saída, com as duas classes locais. As vinte linhas coincidem com o gabarito. Os trechos de Q1–Q17 não mudaram; entre as alternativas, somente Q18 D e Q19 B/D/E foram adaptadas à nova API. IDs, pesos, vinte impressões e oito letras corretas foram preservados. A regressão de Q16 continua distinguindo somente C após a remoção da guarda de recarga.

Os quarenta blocos Java e as alternativas estão sincronizados entre base e Typst. Os nove arquivos em java/ correspondem ao cenário canônico. O preview HTML, o PDF e as seis imagens de revisão foram atualizados. O PDF antigo e as sete imagens do cenário de disparos foram preservados no histórico. A consulta de layout confirmou seis páginas e vinte questões sem divisão de página/coluna ou extrapolação das margens; as páginas 4 e 6 foram inspecionadas visualmente.

O código da prova passa de 324 para 334 linhas Java não vazias, contando os blocos do instrumento. A leitura adicional é o auxiliar privado e a consulta abstrata; foi registrada no blueprint. Os 90 minutos continuam sendo uma referência, com resolução humana cronometrada pendente. Não se registra esse ponto como empiricamente validado nem como automaticamente resolvido pela manutenção da pontuação.

## Revisão individual de Q13–Q20

O professor solicitou revisar a escrita e aplicar melhorias com ganho identificável. As respostas e os pesos foram preservados.

| Questão | Avaliação e decisão |
| --- | --- |
| Q13 | Preservada. O enunciado situa as declarações, associa I–IV às chamadas e pede análise separada; as alternativas apresentam combinações diretamente comparáveis. |
| Q14 | A pergunta abstrata sobre “avaliar a proposta e o uso” passou a pedir a avaliação da escolha e outra forma de reutilização. B deixou de repetir a duplicação presente em C e passou a abordar uma dependência desnecessária do inventário. E permanece correta. |
| Q15 | Preservada. A classe da oficina, seu método, o cristal e as condições da alteração estão apresentados antes das alternativas; as opções testam declarações e tipos diferentes. |
| Q16 | Preservada. A remoção, o trecho, o estado inicial de cada teste e a comparação entre versões estão explícitos. Uma paráfrase não acrescentaria a informação que já está presente. |
| Q17 | A frase antes do teste agora identifica que um personagem equipa o registro. D passou a questionar se é conhecido o último argumento, aproximando o distrator da evidência do teste. A continua correta. |
| Q18 | Preservada. A regra, o retorno, a carga e as chamadas diretas estão explícitos; os locais de verificação permitem comparar seus efeitos. |
| Q19 | A pergunta passou a usar “declarar”, abrangendo construtor e método. A ficou mais direta; C apresenta um construtor correto com implementação de uma operação que não supre a abstrata. B continua correta. |
| Q20 | Preservada. A mudança em adicionar e a pergunta sobre inclusão por outra operação estão explícitas; os blocos de código permitem comparar as APIs. |

Q14 e Q19 têm alternativas reformuladas; Q17 tem um distrator reformulado. Seus comentários no gabarito acompanham os textos atuais. Não houve alteração dos blocos Java, das demais alternativas, IDs, pontuação ou respostas.

Uma leitura editorial em contexto separado recebeu apenas Q13–Q20, instruções e cenário, sem blueprint ou gabarito. Reconstruiu as tarefas e não identificou lacuna material ou pista visual decisiva; considerou as repetições restantes úteis às comparações. O pacote lido tem SHA-256 6e84b47b1d6d5e8d6d3db6c1614facfbe99a93906aa29854dba4838d69b898b9. Após essa leitura, a frase introdutória ao teste de Q17 foi encurtada de “O teste equipa o usuário com esse registro e faz duas chamadas” para “O teste equipa um personagem com o registro”; o código continua mostrando as duas chamadas. Essa última troca foi conferida pelo autor, sem alegar uma nova leitura independente.

## Transição de Q14

O professor observou que a questão começava diretamente pelo inventário, sem conduzir o leitor a partir do cenário. A abertura agora recupera uma operação existente de Personagem, apresenta a necessidade de guardar itens e, em seguida, a proposta de herança. A pergunta e as alternativas continuam pedindo que o estudante avalie a escolha. Uma leitura que consegue reconstruir o pedido não invalida a observação sobre a condução textual. Mantêm-se o objetivo, as alternativas, a resposta E e os cinco pontos.

## Reconstrução de Q14–Q19 após nova avaliação do professor

A revisão anterior considerou suficiente a possibilidade de reconstruir a tarefa. A observação do professor mostrou um limite desse critério: o texto ainda obrigava o leitor a descobrir a finalidade do teste ou o estado de uma mudança antes de resolver o problema. Esta revisão substitui o parecer anterior sobre a condução dessas questões.

| Questão | Trecho anterior e custo de leitura | Intervenção na versão atual |
| --- | --- | --- |
| Q14 | “Qual alternativa avalia essa escolha” mantinha uma comparação abstrata. | Aplicada a proposta aprovada: uma desenvolvedora sugere herança por reutilização; o estudante revisa seu argumento. B agora trata de acesso privado e D de sobrescrita versus subtipagem. |
| Q15 | “Em uma nova versão” introduzia Oficina e Cristal como novidades simultâneas; a pergunta e as opções acumulavam declarações e justificativas. | A recarga de equipamentos antecede a necessidade de atender cristais. O pedido explicita os dois pontos de decisão; cada alternativa apresenta somente a combinação de interface e parâmetro. |
| Q16 | “Cada teste começa” surgia sem explicar a finalidade dos testes apresentados. | A revisão detecta a remoção e o estudante procura um teste capaz de denunciar a mudança. Código e alternativas preservados. |
| Q17 | “Um teste de Personagem usa esta classe” exigia descobrir para que servia o auxiliar. | O objetivo de verificar o encaminhamento da chamada e do alvo antecede UsoRegistro. A pergunta pede a conclusão sustentada pelas verificações, sem fornecer seu limite. |
| Q18 | “Pela nova regra” não estabelecia claramente se a mudança já fora implementada. | “Essa regra ainda não está implementada” separa requisito proposto do código fornecido. Retorno, vida e cargas constam do requisito. |
| Q19 | “classe concreta Orbe extends Equipamento” e “operações concretas da base” comprimiam necessidade, declaração e mecanismo. | O equipamento e seus efeitos vêm primeiro; depois são apresentados a herança e o significado de new Orbe(2), seguidos da tarefa de completar a classe. |

A leitura em contexto separado recebeu apenas base.md (instruções, Q14–Q19 e cenário), sem gabarito, blueprint ou diagnósticos. Reconstruiu as seis tarefas, encontrou as referências necessárias no texto/código e não identificou ambiguidade material. Isso é evidência de compreensão, não aprovação pedagógica nem medição de desempenho. Versão lida SHA-256: 7cbb8d08816453467844267ff5d42e5fb32fd01e84b8718f869254fbecb0ebb9. Depois dessa leitura, as opções de Q15 foram encurtadas às mesmas combinações de declaração e parâmetro; essa última alteração foi conferida pelo autor, sem alegar nova leitura isolada.

Verificação técnica: nove tipos comuns e doze trechos de saída compilados; vinte resultados preservados. Q16: somente C distingue original e mutante. Q18: somente B cumpre retorno, vida e cargas em chamadas diretas e delegadas. Q19: somente B compila e permite dois usos com cura e recusa do terceiro; a verificação de C inclui corretamente seu construtor com super. Em Q14, o acesso privado ao campo não impede o funcionamento dos métodos herdados e a sobrescrita não elimina subtipagem. Q15 preserva as combinações anteriores e D permanece a única que oferece o método pelo parâmetro e admite os dois objetos. Q17 preserva código e alternativas: o último argumento não registra o histórico. Letras E/D/C/A/B/B, IDs e 100 pontos mantidos.

Preview HTML atualizado e conferido contra a base. PDF e sete imagens recompilados; páginas 3–5 inspecionadas visualmente, sem cortes nas questões revistas. A paginação passou de seis para sete, mantendo o tamanho da fonte; cenário nas duas páginas finais. Não houve alteração do site, commit, publicação ou liberação para impressão.

## Revisão completa após o refinamento de Q14–Q19

Escopo: vinte questões, vinte unidades de saída, cenário com nove tipos, alternativas, gabarito, blueprint, fonte Typst, preview HTML e PDF atual de sete páginas. Somente este registro foi alterado nesta rodada. Não houve reformulação de itens nem aprovação ou liberação para impressão.

### Fontes e limites da leitura

Aplicados o processo review-assessment e seu procedimento student-reading, a extensão local revisar-avaliacao, specs/padrao-avaliacoes.md, os critérios genéricos quality-standard e exam e as regressões disciplinares. Repertório confrontado com o projeto pedagógico, Aulas 13 e 15–18 e laboratórios pertinentes: a Aula 16 fornece colaborador que registra quantidade e último argumento; a Aula 17 fornece casts, identidade e seleção por capacidade; a Aula 18 fornece construção com super, base abstrata e separação entre interface e família de implementação. Não foi identificado recurso novo incidental no instrumento. Mantém-se o recorte até Aula 18, sem exceções.

Uma leitura em contexto separado recebeu somente base.md integral, sem gabarito, blueprint, diagnósticos anteriores ou esta análise. Reconstruiu todas as tarefas e chegou às respostas previstas. Identificou como pontos de atenção a analogia direta de Q19 com Amuleto, distratores fracos de Q17 e consulta recorrente ao cenário. Não encontrou indeterminação. Esta é uma leitura independente limitada, não uma auditoria formal nem medição de desempenho estudantil. A avaliação editorial e técnica abaixo foi feita pelo autor com acesso ao histórico.

SHA-256 da base examinada: 98a3af67568a3389c11cdc9df7d84113252e8f4e0e773ab5a743aa33edf1876e.

### Exame por questão e unidade pontuada

| Questão / pontos | Pedido e solução | Evidência, carga e ganho marginal |
| --- | --- | --- |
| Q1 / 6 | Calcular vida: a) 100; b) 7. | a combina teto e recusa de dano negativo; b combina piso, recuperação e recusa de cura negativa. Estado de um objeto; abertura acessível. Recuperação a partir de zero é válida no cenário atual. |
| Q2 / 3 | Dois usos do amuleto: 91. | Seguir método herdado, auxiliar privado e consulta sobrescrita. Consulta a três classes, sem ambiguidade. |
| Q3 / 6 | a) Cajado: 2/3; b) Poção vazia. | Duas implementações de descrição e estado da mesma poção guardada. Duas linhas reais do laço, não duas avaliações da mesma saída. |
| Q4 / 6 | a) false; b) 28. | Recurso compartilhado pelas duas posições; retorno e ausência de segundo efeito são observações distintas. Mais referências que Q3, com ganho de aliasing. |
| Q5 / 3 | Vida: 38. | Reatribuir a variável não troca o colaborador já guardado. A cura não é executada. Evidência distinta de duplicar posições em Q4. |
| Q6 / 6 | a) 47; b) 56. | Distinguir solicitante e alvo em duas colaborações. Ganho menor que Q5, mas os dois destinatários e efeitos são distintos; não se recomenda retirar automaticamente uma linha. |
| Q7 / 3 | Identidade: true. | Conversões não criam outro objeto. Única comparação de identidade pontuada; enunciado curto suficiente. |
| Q8 / 6 | a) true; b) 100. | Aceitação versus efeito efetivo com vida no teto. O teto reaparece de Q1, agora integrado ao retorno do equipamento. Ganho suficiente da comparação. |
| Q9 / 6 | a) false; b) 63. | Ausência de colaborador e dois ramos condicionados pelo retorno do consumível. Estados intermediários necessários; nenhuma saída redundante. |
| Q10 / 3 | Vida: 38. | Sobrescrita substitui a sequência herdada, apesar de zero cargas. A classe local e o comando situam a tarefa sem precisar inventar história. |
| Q11 / 6 | a) 2; b) 1. | Seleção por capacidade e alteração do objeto original. Contador observa participantes; carga confirma a recarga. Percurso maior, coerente com fim do bloco. |
| Q12 / 6 | a) 95; b) 95. | Primeiro uso: 97 → 85 → 90 → 95; segundo: recusa se propaga, sem cura. Valores iguais não significam raciocínio repetido. É o trecho de saída com maior profundidade de delegação. |
| Q13 / 5 | Selecionar chamadas válidas: D. | Compilação pelo tipo declarado, distinta de prever saída. Os rótulos I–IV estão na margem no PDF; Markdown os associa pela ordem explicitamente. |
| Q14 / 5 | Revisar proposta de herança: E. | Reconhecer reutilização e relação de subtipo; composição como alternativa. Contexto e comentário de revisão conduzem a decisão. Preservar versão aprovada. |
| Q15 / 5 | Escolher declaração e parâmetro: D. | Implementação nominal e disponibilidade de recarregar no parâmetro. Evolução além de Q13, sem depender de acertá-la. C/E também acrescentam contratos cujas outras operações não foram descritas: ver ressalva abaixo. |
| Q16 / 5 | Selecionar teste discriminante: C. | Negativo distingue versões; zero não distingue. Propósito do teste e estado inicial explícitos. Não explica antecipadamente o efeito a descobrir. |
| Q17 / 5 | Limitar conclusão do teste: A. | Contagem total e último argumento não verificam o histórico. Classe auxiliar aumenta leitura com propósito claro. Melhorar a competição dos distratores; ver achado 1. |
| Q18 / 5 | Escolher local da nova proteção: B. | Retorno, ausência de efeito e ausência de consumo, por dois caminhos de entrada. Regra explicitamente ainda não implementada. Q10 não altera esta questão, conforme independência. |
| Q19 / 5 | Completar subclasse instanciável: B. | Construtor e implementação abstrata necessários. Correta e clara; reconhecimento facilitado pelo modelo Amuleto. Não equivale a demonstrar autoria de extensão. |
| Q20 / 5 | Identificar acesso que contorna limite: C. | Retorno da lista mutável permite add externo; retornar um Item não altera composição da lista. D é o distrator mais próximo; A/B/E são operações de observação mais fáceis de eliminar. |

### Achados priorizados

1. **Melhoria recomendada — força avaliativa de Q17.** C afirma que “toda execução de usar muda a vida”, embora o auxiliar mostrado não altere vida. D diz “não é possível saber se foi na última”, contradizendo diretamente getUltimoAlvo e sua asserção. A resposta A continua única. Trocar ao menos um desses distratores por uma extrapolação plausível, como concluir que houve exatamente uma delegação em cada chamada de usarEquipadoEm: o total dois, observado somente no final, não demonstra essa distribuição. Isso aproxima a escolha do objetivo de avaliar o alcance do teste. Não é necessário acrescentar mais história nem reescrever a abertura.

2. **Melhoria recomendada — paginação e consulta.** PDF: página 1 Q1–6, página 2 Q7–12, página 3 Q13–16, página 4 Q17–19, página 5 somente Q20, páginas 6–7 cenário. A quinta página fica majoritariamente vazia, e a consulta ao código exige deslocamento ao final. Avaliar distribuição das objetivas para acomodar Q20 nas quatro primeiras páginas, sem reduzir fonte ou dividir uma questão. Outra melhoria de aplicação é fornecer o cenário como folha de consulta separada, preservando seu conteúdo; depende da composição física escolhida. Não foi produzida outra renderização nesta revisão.

3. **Melhoria recomendada — quebra deliberada de linhas Java.** Há quebras automáticas sem recuo de continuação no assertEquals de Q17 e, no cenário, na assinatura de usarEquipadoEm, na concatenação de descrever e no comentário de getVariacaoVida. São legíveis, mas exigem recompor visualmente uma instrução. Recomenda-se quebrar essas linhas em pontos sintáticos e com alinhamento apropriado, sem diminuir a fonte. Não se observou supressão de código; a extração do PDF confirma integralmente as duas linhas longas de casts de Q4.

4. **Limitação de evidência, melhoria opcional — Q19.** Amuleto já contém um construtor com super e getVariacaoVida, exatamente a estrutura da resposta B, mudando nome e constantes. Isso permite acerto por adaptação próxima do exemplo. Não é vazamento de gabarito nem invalida um item de reconhecimento; a fonte comum é legitimamente consultável. Se o professor quiser avaliar diagnóstico de uma extensão, uma implementação incompleta de Orbe seguida de uma decisão de correção exigiria mobilização mais direta das obrigações. Essa mudança deve preservar o alvo curricular e não simplesmente aumentar a dificuldade.

5. **Ponto secundário — distratores de Q15.** C e E acrescentam Item e Usavel; os respectivos descrever e usar não foram prometidos em Cristal. Assim, podem ser recusados também por obrigações adicionais da classe, além da ausência de recarregar no tipo do parâmetro. A resposta D permanece única, mas há um caminho de eliminação que exige menos análise da chamada. Uma futura revisão pode tornar os candidatos completos ou trocar essas combinações para concentrar a comparação na dependência da operação, sem sobrecarregar novamente o enunciado. Não é premissa faltante para resolver a questão atual.

6. **Verificação pendente — duração.** São nove tipos comuns, três classes locais de apoio, vinte saídas e oito objetivas, com 337 linhas Java não vazias no conjunto de blocos. A concentração de esforço está em Q12/Q17 e na consulta ao cenário. O orçamento de 90 minutos no blueprint soma exatamente 90, incluindo apenas cinco de conferência; não existe aplicação cronometrada que confirme essa distribuição. Há risco de aperto, mas não evidência para afirmar que a prova é longa demais. Recomenda-se resolução cronometrada por pessoa familiarizada com o repertório da turma antes de fixar a versão de aplicação; não alterar duração ou pontuação por inferência automática.

### Visão global e verificações

A progressão distingue execução (Q1–12) de decisões e evidências (Q13–20). Q7 e Q8, mais curtas após Q4–6, são respiros aceitáveis; não há obrigação de dificuldade estritamente crescente. Nas objetivas, contratos, projeto, testes, regras, extensão e encapsulamento possuem focos distintos. Há retomada de conceitos, mas nenhum resultado de uma questão resolve outra automaticamente. A analogia de Q19 é com o cenário comum, não com resposta anterior. Q1 permite recuperação de vida zero; Q18 propõe bloqueio novo apenas local, sem contradição.

Não se recomenda acrescentar contexto narrativo às questões de saída já compreensíveis pelo código. Q10/Q12 apresentam suas classes locais suficientemente; Q14–16 e Q18 têm condução adequada na versão atual. Não se identificou fundamento para uma nova reescrita geral.

Reexecutada a verificação Java: nove tipos e doze programas compilados, vinte saídas confrontadas com gabarito; Q16 distingue somente C; Q18 somente B atende retorno/vida/cargas nas chamadas diretas e delegadas; Q19 somente B compila e cumpre os usos esperados. Demais objetivas resolvidas por inspeção e confirmadas pela leitura separada. Blocos Java, alternativas e arquivos comuns sincronizados; preview check passou. Os pesos somam 100; IDs preservados. Sete imagens e PDF inspecionados, com questões inteiras; a extração de texto confirma a distribuição de questões. Aprovação humana permanece pendente, coerente com workflow em maturing.

A documentação anterior ainda mistura notas históricas de seis páginas com o estado atual, e o README situa as questões revistas nas páginas 3–5, embora Q14–19 estejam agora nas páginas 3–4 após o enxugamento final de Q15. Convém consolidar a descrição da versão vigente na próxima edição. Isso não afeta o exemplar entregue ao estudante.

Conclusão: não foi encontrado erro de gabarito, item indeterminado ou conteúdo incidental fora do recorte verificado. Há melhorias concretas de distratores e apresentação, além da incerteza de duração. O conjunto não demanda outra reformulação integral. Esta conclusão não converte testes automatizados ou leitura do agente em validação empírica de aprendizagem.

## Correções autorizadas após a revisão completa

O professor autorizou os ajustes, excluindo duração. Aplicadas melhorias em Q15, Q17, Q19, quebras de código e paginação; a duração foi preservada e não é requisito pendente desta rodada.

- Q15: C deixou de acrescentar Item a Cristal, e E deixou de acrescentar Usavel. C erra o tipo do parâmetro, que não oferece recarregar; E aceita apenas cristais, perdendo equipamentos. A/D mantêm a distinção entre ter métodos e declarar interface; B restringe à hierarquia antiga. Compilação dos cinco candidatos com clientes Cajado, Amuleto e Cristal confirmou somente D.
- Q17: C/D foram substituídos pelas inferências de uma delegação por execução e propagação do retorno. Contraexemplos executados: uma implementação faz zero delegações na primeira chamada e duas na segunda; outra delega normalmente, mas sempre retorna false. Ambas passam nos dois asserts. A pergunta agora limita explicitamente a análise ao que as verificações observam. A continua correta. Mantidos auxiliar, dados e observações.
- Q19: apresentada implementação com super("Orbe", 4, cargasIniciais), sem getVariacaoVida. As alternativas precisam reparar os dois problemas. A compila, mas produz quatro cargas iniciais e máximo dois para new Orbe(2); B produz duas iniciais, máximo quatro e cura sete. C e E deixam método abstrato pendente; D mantém a classe abstrata e impede a criação solicitada. Essa verificação substitui a antiga afirmação de que somente B compila: agora A compila e falha no comportamento requerido.
- Código: quebras explícitas com recuo no assert de Q17, na assinatura de usarEquipadoEm, na concatenação de descrever e na impressão do inventário; comentário de variação abreviado sem perda de significado. Cópias Java sincronizadas. Nenhuma alteração de comportamento no cenário comum.
- Diagramação: a página exclusiva de Q20 foi eliminada como folha separada; Q20 compartilha a página 5 com Inventario, contratos e Personagem, separados por títulos de consulta. Equipamento e demais classes ficam na página 6. Não foi necessário reduzir fonte ou dividir questão/classe. README consolidado para o estado vigente, preservando registros históricos nos demais documentos.

Verificação de regressão: nove tipos e doze programas compilados, vinte saídas inalteradas; testes discriminantes de Q16 e alternativas de Q18 preservados. Testes específicos novos de Q15/Q17/Q19 confirmam as letras D/A/B. Preview HTML regenerado e conferido, blocos Java e alternativas sincronizados com Typst, seis páginas de PDF e imagens atualizadas. A imagem obsoleta da página 7 foi retirada do diretório de preview. A conferência desta rodada é informada pela autoria; não se alega nova leitura independente.

Não houve alteração do site, commit, publicação ou aprovação final da prova.

Atualização de posição: Q17 e Q18 foram invertidas; a regra de vida zero é Q17 (B) e a análise do teste é Q18 (A). Os IDs e conteúdos das questões foram preservados. Referências anteriores a esses números neste arquivo descrevem a ordem anterior.

## Ajustes autorizados de cobertura de Q1–Q12

Revisão informada pelo contexto de autoria, sem nova leitura independente. Base resultante SHA-256: 6997531b8e21be22f2025a1b416aa3ca3dcfd13d2584e298a27c153a8bb3eba7.

O professor aprovou as três propostas apresentadas após o exame das doze questões:

- Q2: substituídos dois usos do amuleto por construção com zero cargas, recarregar(5), uso e descrever(). Saída: Amuleto: 1/2. O teto específico e o consumo posterior tornam-se observáveis; a saturação não oculta o consumo porque ocorre antes dele. Mudança conceitual explícita: a observação principal deixa de ser a recuperação do alvo, que permanece em Q6.
- Q3: substituídos List/ArrayList e laço externo por Inventario, adicionar e listar. Saídas preservadas: Cajado: 2/3 e Poção vazia. O código explicita a inclusão e o uso posterior da mesma poção; listar consulta os estados atuais na ordem de inclusão. Não há entidade ou relação implícita necessária ao pedido.
- Q8: substituído getVida por getCargas na segunda impressão. Saídas: true e 0. Observam-se aceitação e consumo mesmo com o alvo no teto; a vida final deixa de ser observada diretamente, e seu limite permanece coberto em Q1.

Os comandos de saída continuam suficientes, apoiados nos trechos e nas regras do código de consulta. Preservados IDs, pesos, vinte impressões, cem pontos e duração. Q1, Q4–Q7 e Q9–Q12 foram mantidas pelos focos distintos de estado, identidade, referências, destinatários, retornos, sobrescrita, capacidades e composição.

Verificação: nove tipos comuns e doze programas compilados em Java 21; vinte saídas conferidas com o gabarito atualizado. Os 42 blocos Java da base e do Typst coincidem, descontando espaços e a ordem de apresentação das classes de consulta. HTML regenerado e validado. PDF recompilado com seis páginas; imagens regeneradas e páginas de questões inspecionadas, sem divisão de questões ou supressão de código. A distribuição vigente consta do README. Conferência de diff e status sem alterações alheias ao escopo desta rodada. A prova continua em revisão, sem aprovação final ou liberação para impressão.

## Nova abordagem autorizada de Q13–Q20

Base resultante SHA-256: 1c327f7e636238fd83b73da6db99efbb4f0051d305e72ba7972465f07ea7d92b. Revisão informada pelo contexto de autoria; não é leitura independente nem auditoria formal. O professor autorizou manter Q13/Q14/Q16/Q17, ajustar Q15/Q20 e substituir Q18/Q19. As questões Q1–Q12 e o cenário comum permanecem idênticos.

### Leitura, mudança de evidência e resolução

| Questão | Situação e pedido ancorados no texto | Mudança e consequência |
| --- | --- | --- |
| Q15 | Oficina deve recarregar equipamentos e cristais; a tabela explicita interface de Cristal e tipo do parâmetro. | Mesmas cinco combinações; comparação direta sem repetir duas decisões em cada frase. D continua correta. |
| Q18 | “Durante a revisão de Personagem.usarEquipadoEm” situa o método sob análise; “Qual alteração incorreta ... não seria detectada” solicita avaliar defeitos hipotéticos, sem pedir que o leitor ignore a implementação conhecida. O teste equipa o cajado, chama o método e observa vida e cargas. | Retirados UsoRegistro, histórico e contagem acumulada. A habilidade preservada é delimitar observações de teste. A devolve false e passa nos dois asserts; B–E alteram ao menos um estado observado. A nova questão não afirma verificar histórico de chamadas nem substitui essa evidência por equivalência presumida. |
| Q19 | “Cada orbe recebe no construtor suas cargas iniciais e a quantidade de vida que recupera por uso” estabelece os dois parâmetros. A estrutura conserva recuperacao no campo; I e II indicam os trechos a completar. O pedido exige criar os objetos e aproveitar uso e recarga herdados. | Nova tarefa de extensão, em lugar de reparar código com dois erros. Capacidade quatro, estado inicial recebido e comportamento por instância orientam a decisão. B atende; A inverte inicial/máximo; C não cumpre o abstrato; D impede instanciar; E fixa sete e não atende outras recuperações. O campo parametrizado evita simples cópia de Amuleto por troca de constantes. Não se usa sobrecarga como distrator. |
| Q20 | Limite três já protegido por adicionar; método getItens proposto devolve a coleção; pedido pergunta se outro código ultrapassa o limite e por quê. | Troca reconhecimento do retorno List por explicação causal. C permite add sem a guarda. A confunde private com imutabilidade; B presume cópia; D confunde reatribuir referência externa com substituir campo; E exige setter indevidamente. Duas alternativas afirmam “Sim”, evitando resposta por polaridade. |

Q13 permanece sobre disponibilidade pelo tipo declarado; Q14 sobre reutilização e subtipagem; Q16 sobre teste discriminante; Q17 sobre localização e momento da precondição. Foram mantidas porque sua carga é pertinente à habilidade, sem mudança apenas estilística. As novas Q18/Q19 deixam de depender da classe auxiliar de teste e de uma montagem inicial de erros, respectivamente. Q18 complementa Q16 sem repetir sua tarefa: teste dado e falha não detectada versus defeito dado e teste discriminante.

### Verificações

Cinco mutações de Q18 executadas em Java 21: A passa com vida 22/cargas 1; B deixa 34/2; C deixa 34/1; D deixa 22/2; E deixa 10/0. Duas cargas são necessárias para tornar o segundo uso indevido observável. Q19: candidatos A/B/E compilados e executados com recuperação sete e cinco, recarga excedente e esgotamento; só B atende ao conjunto. C falha por método abstrato ausente; a criação do candidato D falha por classe abstrata. Q20: inclusão pública bloqueada no quarto item, add externo alcança quatro e reatribuição da variável externa não altera o campo. Blocos Java da base/Typst comparados; questões preservadas, IDs e pesos conferidos contra snapshot anterior. Letras e cem pontos mantidos.

A primeira composição visual de Q19 trouxe texto excessivo e sete páginas. O segundo ajuste retirou a repetição do exemplo e consolidou os requisitos, preservando todos os dados necessários e as alternativas; o PDF voltou a seis páginas sem reduzir fonte. Esta rodada não produz variante, aprovação ou publicação. O gabarito e os derivados de revisão foram sincronizados conforme o escopo autorizado em conversa.

Conferência final: HTML atualizado e validado; PDF de seis páginas e imagens regenerados; páginas 3 e 4 inspecionadas com tabela, código, alternativas e questões inteiras dentro das margens. A imagem intermediária da sétima página foi retirada. Diff conferido contra snapshot anterior e status consultado; nenhuma alteração em docs/, commit ou push.

## Correções da auditoria e redesenho de cinco objetivas

Base SHA-256: 94b175027073b7baf8c13cc3481cd5a8334b8f704924b2ab6d12c9bdd5b72833. Escopo autorizado: corrigir Q13 e redesenhar Q15/Q16/Q18/Q19; as demais questões foram explicitamente consideradas satisfatórias pelo professor e permanecem idênticas. Esta revisão é informada pela autoria, sem alegação de leitura independente ou auditoria formal.

### Reconstrução e ganho de cada mudança

| Questão | Âncoras do pedido e relações necessárias | Evidência e resolução |
| --- | --- | --- |
| Q13 | “O compilador rejeita a chamada a descrever” fixa o problema; Usavel escolha e new Amuleto explicitam referência e objeto distintos. | D explica a indisponibilidade pelo tipo declarado. A nega uma atribuição válida; B confunde verificação com despacho; C/E negam métodos herdados ou concretos na classe abstrata. As chamadas válidas anteriores já não selecionam uma combinação de respostas. |
| Q15 | A troca do parâmetro é local a equipar; campo e corpo são mantidos. A justificativa é precisar de usar. | D mostra perda de clientes sem necessidade. A ignora a restrição do tipo; B erra a atribuição ao contrato; C confunde mesma assinatura com subtipagem; E elimina despacho indevidamente. “Trocar” substitui “restringir” no enunciado para não antecipar a consequência. |
| Q16 | Proposta completa de recarregar; cada linha define novo Cajado, recarga e saldo esperado. | C distingue soma de substituição antes de saturar. A mascara pelo zero inicial; B/D pelo máximo; E pelo retorno antecipado. Rejeição de negativos deixa de ser o alvo específico, sem perda do objetivo de teste discriminante. |
| Q18 | “Cada teste começa com seus próprios objetos novos” impede leitura sequencial; I observa retorno, II executa usar e observa vida. | Só A é identificada por II e não por I. B é o oposto; C/E falham nos dois; D passa nos dois embora não consuma. Diferença entre retorno, efeito e saldo é explícita e não exige reconstruir histórico ou classe auxiliar. |
| Q19 | Troca apenas getVariacaoVida; Equipamento permanece abstrata e outros métodos são mantidos; Orbe tem construtor completo. | B reúne instanciabilidade de Orbe e preservação de sobrescritas. A confunde base abstrata com todas as subclasses abstratas; C nega implementação herdada de contratos; D exige duplicação de campos; E confunde implementação padrão com substituição das sobrescritas. A nova correta trata de obrigação e despacho, não de consumo sem efeito já observado em Q8. |

A Q19 passa a avaliar evolução do contrato abstrato, em vez de preenchimento de construtor e método. Não se afirma que sejam evidências idênticas. O construtor aparece pronto como suporte. O novo Orbe é local à questão; nenhum valor ou regra é transportado para as demais. Q15 não fornece a explicação de descrever em Q13; Q13 não decide quais objetos equipar aceita após mudar o parâmetro. Q16 observa recarga com saldo anterior não nulo e sem atingir o teto, distinto do foco de Q2. Q18 usa vida inicial 46 para não reproduzir o estado e a resposta de Q4, e seus testes não determinam compartilhamento, reatribuição ou composição nas questões de saída.

### Verificação técnica e visual

Q13 compilada: erro em descrever, não na atribuição. Q15 compilada com clientes Pocao/Cajado/Amuleto e Usavel antes/depois: perda de Pocao e da referência Usavel; atribuição ao campo e despacho preservados. Q16 executada nas versões original/proposta: somente C difere. Q18 executada com cinco implementações defeituosas e instâncias novas por teste: resultados I/II A=true/false, B=false/true, C=false/false, D=true/true, E=false/false. Q19 compilada antes/depois: ausência de implementação impede o Orbe original de compilar; com o corpo concreto, variações 0/-12/15 e estado herdado verificados. Erros esperados de compilação são evidência das alternativas, não falhas de execução da verificação.

Comparação automática preservou Q1–Q12, Q14, Q17, Q20, cenário, IDs e pesos. Blocos Java da base e Typst sincronizados. Gabarito e matriz de evidências atualizados; descrições antigas identificadas como histórico. PDF segue com seis páginas e fontes preservadas; páginas 2–4 inspecionadas, com questões e alternativas inteiras. Sem alterações do site, commit, publicação ou aprovação final.

## Q16 — alternativas em Java

A pedido do professor, a tabela de Q16 foi convertida em cinco testes independentes de três linhas: construção do cajado, recarregar e assertEquals. Os cinco conjuntos de valores foram preservados literalmente; o enunciado explicita a independência. Método proposto, gabarito C, habilidade, ID e cinco pontos mantidos. Nenhuma outra questão foi alterada.

## Aprovação humana da base e geração de variantes

O professor aprovou explicitamente: “A prova está aprovada. POde fazer a variante.” A aprovação foi registrada pelo caminho de revisão humana do workflow, sem declaração de maturação automática. Base e blueprint foram congelados sem alterações. A variante A é idêntica à base; B e seus gabaritos foram derivados e verificados. A análise de equivalência está em equivalence-review.md; a decisão humana desse segundo gate permanece pendente.
