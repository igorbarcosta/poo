# Desenho da Aula 20 — Entendendo a estrutura de um jogo orientado a objetos

Artifact identity: `lesson-design-poo-aula-20`.

O desenho aprovado está em `specs/planejamento-aula-20.md`. O roteiro
corresponde a `docs/aulas/aula-20-entendendo-a-estrutura-de-um-jogo.md`,
identidade `lesson-poo-aula-20`; não é duplicado neste pacote.
O professor autorizou implementar o desenho, publicar o roteiro e, após
a publicação, solicitou: “ok. faça os slides.” Esse pedido registra a
aceitação do roteiro atual para derivação, sem nova decisão curricular.

## Intenção e trajetória

Compreender o Megamania como referência para os jogos individuais iniciados
no Lab 19. A pergunta central é como encontrar no exemplo uma solução útil
ao desenvolvimento do próprio jogo.

1. Movimento: entrada, coordenação, alteração de posição e desenho.
2. Disparo: solicitação, recusa, criação e permanência em uma coleção.
3. Impacto: contrato, efeito local, pontuação, remoção e término.
4. Transferência: delimitar uma evolução própria, localizar a colaboração
   relevante e identificar sua verificação.

O aluno deve seguir chamadas e alterações de estado, distinguir as
responsabilidades e justificar adaptações ao seu domínio. O mapa das
classes surge dos percursos, sem catálogo inicial de arquivos.

## Limites e projeção

Não incorporar mecânica nova, impor a estrutura completa do Megamania nem
definir o incremento ainda aberto do Lab 20. Não aprofundar biblioteca
gráfica, infraestrutura ou geometria de colisão. Explicar Java somente
para ler os trechos necessários. Retomar contratos, composição e herança
no contexto das colaborações existentes.

Referência de 90 minutos: observação inicial 10; movimento 15; disparo 20;
impacto 20; transferência e síntese 25. Reservar tempo real de elaboração.
Como aprofundamento elástico, examinar a pontuação sem conferir o retorno
de impacto, ou a substituição da partida no reinício.

Seguir `slides/presentation-profile.md` e o tema compartilhado. Cada
atividade deve ter resposta visível no frame imediatamente seguinte.
O Projeto 3 permite IA Nível 3, com responsabilidade por compreender,
verificar e modificar o código incorporado. Não criar nota ou entrega.
