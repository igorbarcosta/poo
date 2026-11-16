# Planejamento da Aula 20 — Entendendo a estrutura de um jogo orientado a objetos

## Decisão do professor e escopo

O professor aprovou uma aula dedicada a compreender o Megamania como
referência para a evolução dos jogos individuais. Não haverá incorporação
de uma mecânica nova nesta aula. Os avanços no exemplo comum começam nos
encontros seguintes, conforme planejamento posterior.

O ponto de partida é o Laboratório 19: execução da base, implementação e
teste de uma regra própria, integração entre comando, modelo, apresentação
e reinício. A aula não presume que os jogos individuais já possuam inimigos,
projéteis, colisões ou uma classe `Partida`.

Este documento registra o desenho aprovado e orienta a autoria do roteiro.
Não é a página pública, um deck ou o roteiro definitivo do Laboratório 20.
Não estabelece datas, entregas ou critérios de nota.

## Pergunta orientadora e objetivos

**Como encontro, no Megamania, uma solução que me ajude a desenvolver meu jogo?**

Ao final, o estudante deve conseguir:

- seguir um comando da entrada até os objetos que alteram o estado;
- distinguir infraestrutura, apresentação, coordenação e regras dos objetos;
- acompanhar criação, permanência e remoção de objetos na partida;
- localizar uma colaboração útil ao próprio jogo e justificar sua adaptação.

O avanço esperado é passar da leitura de uma regra isolada para a leitura
de uma execução que atravessa vários objetos. Não é necessário apresentar
novas abstrações ou exigir a reprodução da arquitetura completa.

## Trajetória narrativa

Começar pelo comportamento executável. Observar movimento, disparo e impacto
antes de procurar suas implementações. Construir o mapa de responsabilidades
durante a investigação; evitar abrir com uma lista de todas as classes.

### Percurso 1 — Da tecla ao movimento visível

Seguir `JogoMegamania.atualizar` → `Partida.atualizar` → `Nave.atualizar`,
depois localizar a consulta da posição em `JogoMegamania.desenhar`.

A entrada é traduzida em direção; a partida coordena a atualização; a nave
altera e limita sua posição; a apresentação consulta o resultado. A engine
fornece o ciclo, sem decidir as regras do domínio.

Previsão a explorar: desenhar duas vezes sem atualizar deve preservar a
posição. Comparar esse caminho com `MeuJogo` → `Jogador.mover`, já conhecido
da base individual. A classe intermediária se justifica pela colaboração
que coordena; não deve ser imposta apenas para igualar nomes.

### Percurso 2 — Da solicitação ao projétil na partida

Seguir `entrada.acao()` → `Partida.atualizar` → `Nave.tentarDisparar`.
Localizar o retorno do novo projétil, sua inclusão em `projeteis`, a
atualização de sua posição e sua representação na tela.

A nave decide se pode disparar, considerando vida e recarga. A partida
guarda a referência ao projétil aceito e passa a atualizá-lo. Um disparo
recusado retorna `null` e não acrescenta objeto à coleção.

Previsões a explorar: solicitar duas vezes sem transcorrer a recarga não
cria dois projéteis; recriar a coleção a cada atualização perderia os
objetos em movimento. Distinguir a criação do projétil de seu desenho.

Explicar a recarga apenas no nível necessário à leitura do código existente.
Não transformar tempo, coordenadas ou infraestrutura gráfica em novos
tópicos autônomos desta aula.

### Percurso 3 — Do impacto às consequências da partida

Seguir a atualização dos projéteis em `Partida`, a chamada a
`Projetil.tentarAtingir` e o efeito de `Inimigo.receberImpacto`. Voltar à
partida para localizar pontuação, remoção e verificação do estado final.

Em um acerto válido, o projétil solicita o impacto, torna-se inativo e
retorna `true`. A partida acrescenta os pontos do inimigo. A remoção dos
inimigos mortos e projéteis inativos ocorre depois da investigação dos
impactos. A vitória é verificada após a limpeza, desde que não se aplique
uma condição de derrota, que tem precedência no código.

Previsão a explorar: o mesmo projétil não elimina um segundo inimigo depois
de ficar inativo. Matar o último inimigo não equivale a alterar imediatamente
o estado dentro de `Inimigo`: a partida avalia o resultado coletivo.

Usar `Alvo` e `Corpo` como retomada pontual de contratos e comportamento
compartilhado, quando o percurso exigir. Não abrir uma investigação paralela
de toda a hierarquia, do movimento da formação ou da biblioteca gráfica.

## Mapa de responsabilidades ao final

| Parte | Responsabilidade observada |
| --- | --- |
| Engine fornecida | Janela, ciclo de execução, entrada e operações de desenho. |
| `JogoMegamania` | Tradução da entrada e apresentação; também controla início e pausa na implementação atual. |
| `Partida` | Coordenação dos objetos, coleções, pontuação e condições de término. |
| `Nave`, `Inimigo` e `Projetil` | Estado e comportamento próprios, com suas guardas e consequências locais. |

O mapa descreve o código atual e serve à análise. Não afirmar que toda
decisão presente no exemplo seja uma solução obrigatória para qualquer jogo.

## Transferência para os jogos individuais

Trabalhar com uma intenção concreta de evolução do jogo de cada aluno:

1. Delimitar o comportamento desejado e seu resultado observável.
2. Localizar um percurso do Megamania que ofereça referência relevante.
3. Identificar os objetos e responsabilidades correspondentes no próprio domínio.
4. Explicar o que pode ser aproveitado e o que precisa ser adaptado.
5. Indicar como verificar o comportamento sem depender apenas da janela.

Exemplo possível: um objeto coletável pode usar como referência o percurso
de uma interação, mas seu efeito pertence às regras do jogo do aluno.
Não exigir que um jogo de exploração tenha disparos ou formação de inimigos.

Uma evidência de compreensão é conseguir apontar quem solicita uma ação,
quem decide sua validade, quem guarda o estado e quem mostra seu resultado.
Não instituir relatório, entrega ou validação oral obrigatória.

## Dimensionamento de referência — 90 minutos

| Etapa | Tempo | Foco |
| --- | --- | --- |
| Executar e observar | 10 min | Formular perguntas a partir do comportamento. |
| Movimento | 15 min | Seguir chamadas e separar atualização de desenho. |
| Disparo | 20 min | Criação, referência, coleção e colaboração. |
| Impacto | 20 min | Efeitos locais e consequências coletivas. |
| Transferência e síntese | 25 min | Usar o exemplo para orientar uma evolução própria. |

Núcleo necessário: os três percursos e a transferência. Como aprofundamento
elástico, analisar o defeito de pontuar por sobreposição sem consultar o
retorno de `tentarAtingir`, ou comparar o estado após reiniciar com o estado
anterior. Não acrescentar exposição apenas para ocupar tempo.

## Articulação com o laboratório seguinte

O laboratório deve evoluir o projeto iniciado no Lab 19 com um incremento
pequeno apoiado em um mecanismo compreendido nesta aula. O comportamento
e sua verificação precisam ser delimitados no roteiro específico, preservando
as diferenças entre os jogos.

Possibilidades preparadas pela aula: acrescentar um objeto participante,
coordenar uma ação, manter vários objetos ou realizar uma interação entre
dois objetos. São alternativas para detalhamento, não requisitos cumulativos.
Não exigir uma regra temporal nova, uma classe `Partida` ou uma hierarquia
somente para reproduzir a estrutura do exemplo.

## Orientações para autoria

- Apresentar recortes pequenos do código real, identificando classe e método.
- Situar cada previsão com estado inicial e chamadas suficientes para respondê-la.
- Oferecer respostas imediatas e expansíveis no roteiro autoguiado.
- Preparar os mecanismos Java necessários à leitura, inclusive `null`,
  coleções, iteração, retornos booleanos e remoção por índice, sem aula de sintaxe isolada.
- Manter decisões de condução e estimativas fora da página pública.
- Produzir e revisar o roteiro antes de derivar slides.

## Referências locais

- [Projeto pedagógico](projeto-pedagogico.md).
- [Planejamento da Unidade 03](planejamento-unidade-03.md).
- [Padrão de aula](padrao-aula.md).
- [Padrão de laboratório](padrao-laboratorio.md).
- [Laboratório 19](../docs/aulas/laboratorio-19-iniciando-seu-jogo.md).
- [Base de desenvolvimento e exemplo](../jogos/README.md).
