# Desenho da Aula 12 — Quando um colaborador começa a variar

## Intenção e fonte

Abrir a Unidade 02 pelo limite de uma colaboração concreta adequada. A fonte
canônica da aula é `docs/aulas/aula-12-quando-um-colaborador-comeca-a-variar.md`;
este arquivo guarda somente o desenho e as decisões materiais.

O professor forneceu o arco, o requisito, três alternativas de entrega, os
limites e as pontes em seu pedido de criação da Aula 12, Laboratório 12 e slides.
Essa instrução autorizou produzir o conjunto nesta tarefa, com revisão do roteiro
antes do deck. Depois de revisar os materiais, o professor aprovou-os
explicitamente para publicação no site. O registro Docemas abaixo liga a decisão
à versão então publicada. Posteriormente, o professor aprovou o ajuste para
entrega no fechamento e a adoção de lembretes e notificações como Projeto 2
contínuo nos laboratórios, solicitando a introdução do cenário antes dos
incrementos. Esta revisão implementa essas decisões, sem nova publicação.

## Continuidade efetiva

- Aulas/Laboratórios 06–07: Produto fornece preço, ItemPedido calcula subtotal,
  Pedido reúne itens e coordena total.
- Laboratório 08: Pedido passa a criar seus itens recebendo Produto e quantidade;
  a coleção fica privada e consultas desnecessárias do item são retiradas.
- Aula/Laboratório 09: fechado impede criação e inclusão; total continua igual.
- Aula/Laboratório 10: uma linha por identidade de Produto; remoção inteira;
  alteração positiva delegada ao item; zero remove; negativo preserva;
  fechamento bloqueia todas as edições.
- Aula 11: transferência para missão, robôs, sensores e leituras; trocar objetos
  Sensor não varia a classe do colaborador. Não existe Laboratório 11 no estado
  consultado. Não inventar um para completar a numeração.
- O cronograma só contém datas confirmadas até o par 05. Acrescentar ligação
  para a abertura da U2 sem inventar data nem consolidar encontros 13–14.

## Pergunta e transformação

Como evoluir uma colaboração quando o objeto que realiza o trabalho pode variar?

Passar de “um objeto solicita trabalho a um colaborador concreto” para
“a responsabilidade permanece estável, mas diferentes classes podem realizá-la”.
Chegar a uma necessidade em linguagem natural e manter aberta sua expressão em
Java. Não entregar a solução formal.

## Decisões do exemplo

- Usar cópia de trabalho da Versão 10; não declarar nova versão oficial do projeto.
- Normal 10.0, expressa 25.0, retirada 0.0; sem regra financeira adicional.
- `calcularTotal()` continua sendo total dos itens; entrega é consulta separada.
- Pedido nasce aberto sem entrega; fechar(EntregaNormal) recebe a escolha,
  exige colaborador existente e conserva a escolha após fechamento. Consultar
  custo apenas depois de fechar, sem introduzir tratamento de consulta antecipada.
- `calcularCusto(Pedido)` recebe contexto, mas regras fixas não o consultam.
- `this` como argumento tem apoio mínimo no roteiro, deck e Java essencial.
- Campos múltiplos e indicador são hipóteses analisadas após o novo requisito;
  não viram arquitetura prescrita ou defeito artificial do ponto de partida.
- O indicador numérico evita ensinar comparação textual para analisar seleção.
- Dependência e `if` são avaliados pela responsabilidade e impacto, sem condenação.

## Núcleo, pausas e elasticidade

90 minutos de referência, incluindo leitura, respostas individuais, coleta de
hipóteses e revelações: colaboração adequada e previsão 25; segunda alternativa
e análise de propostas 30; terceira e formalizações 20; verificações e síntese 15.

As pausas pedem atribuição de responsabilidade, previsão de compilação,
comparação de alternativas e seleção de evidências de comportamento. A página
autoguiada oferece respostas imediatas expansíveis, com exceção deliberada da
pergunta final aberta, determinada pelo professor.

Elasticidade: comparar mudança de fórmula com duas instâncias da mesma classe;
localizar a seleção concreta em Main e explicar por que ainda falta um tipo
adequado no pedido. Não preencher tempo com conceitos futuros.

## Laboratório de transferência

Prática em casa, início do Projeto 2 — Sistema de lembretes e notificações.
Apresentar transição do Projeto 1 e cenário de agenda de estudos antes do código.
Aulas mantêm Pedido; laboratórios continuam o novo projeto ao longo da U2.
O Laboratório 12 entrega a Versão 1, preservada para os próximos incrementos.
Lembrete mantém mensagem e contador; NotificadorEmail simula envio no console.
Primeiro mudar a apresentação do canal existente sem mudar Lembrete. Depois
introduzir SMS e painel local, manter alternativas coexistindo usando recursos
conhecidos e observar mudanças no coordenador. Cada incremento modifica código
e incorpora previsão, execução, evidência e reflexão. Entrega apenas código;
nenhum prazo ou peso novo.

Nível de IA: Nível 1 — Tutor, confirmado pelo professor nesta tarefa.

## Fronteiras e pontes

Não introduzir interface/implements, herança, classe abstrata, polimorfismo
formal, SOLID, padrões, injeção como conceito formal, mocks, UML ou JUnit formal.
Não converter `List`/`ArrayList`, conhecidos pragmaticamente, em antecipação.

Problemas abertos: verificar comportamentos antes de mudar a estrutura (Aula 13)
e expressar em Java a responsabilidade necessária sem uma classe concreta única
(Aula 14). A sequência foi fornecida pelo professor; não criar essas aulas.

## Revisão manual

Na aprovação, o professor aceitou o ritmo das hipóteses abertas e a adequação
das notificações simuladas à prática em casa. A duração real ainda poderá ser
registrada na retrospectiva da oferta.
