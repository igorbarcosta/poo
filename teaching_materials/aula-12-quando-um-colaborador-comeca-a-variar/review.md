# Revisão da Aula 12 e do Laboratório 12

Revisão editorial e técnica dos materiais produzidos nesta tarefa. A aprovação
semântica é registrada pelo workflow Docemas; esta revisão não é um ReviewRun formal.

## Narrativa e continuidade

A fonte de verdade foi o estado local na branch `draft`, inicialmente sem
alterações. Foram lidos AGENTS, plano, cronograma, specs, retrospectiva, Aulas
06–11 e Laboratórios 06–10, além dos decks 10–11 e do tema compartilhado.

O arco é: Projeto 1 válido → nova responsabilidade de entrega → colaboração
adequada com EntregaNormal → alternativa Expressa não aceita pela operação de fechamento
atual → propostas e impactos → RetiradaLocal → estável/variável → ponto de
variação → dependência concreta → necessidade de verificações → pergunta aberta.

A pergunta central é “Como evoluir uma colaboração quando o objeto que realiza
o trabalho pode variar?”. As Aulas 09–10 fornecem a referência de evolução que
preserva responsabilidades. A Aula 11 fornece o contraste entre trocar
instâncias de Sensor e precisar de classes colaboradoras diferentes.

## Conferência do escopo pedagógico

1. A retomada do Projeto 1 é curta e usa a API final da Versão 10.
2. A primeira solução atende ao requisito; não há código defeituoso fabricado.
3. A primeira colaboração é apresentada explicitamente como adequada.
4. A limitação só aparece após o requisito de entrega expressa.
5. Condições são analisadas por responsabilidade, inclusive a guarda válida de fechamento.
6. Dependência e acoplamento permitem colaboração; não são defeitos automáticos.
7. Não há declaração de interface, implements ou antecipação da solução formal.
8. Não há anotações, asserts ou estrutura formal de JUnit.
9. O laboratório transfere para notificações e não reutiliza pedido/frete.
10. Os três incrementos do laboratório mudam código e incorporam previsão e verificação.
11. Respostas de investigação aparecem no próprio material; a pergunta final permanece aberta por instrução do professor.
12. Há duas pontes: verificar comportamentos na Aula 13 e representar a necessidade comum na Aula 14.

## Laboratório

Prática em casa, Nível 1 — Tutor confirmado pelo professor. Código inicial
completo em três arquivos; A acrescenta origem ao canal de e-mail; B integra SMS
mantendo e-mail; C integra painel e verifica novamente e-mail. O mesmo lembrete
preserva mensagem e conta cada aviso. As três classes de notificação permanecem
concretas e a integração usa apenas recursos conhecidos. O aluno pode escolher
campos, parâmetros, operações específicas ou seleção numérica.

Entrega somente código; nenhuma nova data, nota, peso ou regra institucional.
Início do Projeto 2 — Sistema de lembretes e notificações, conforme decisão
posterior do professor. Introdução da transição, cenário da agenda e divisão
de responsabilidades antecedem o código e os incrementos.

## Validação técnica

- `bash slides/render.sh aula-12-quando-um-colaborador-comeca-a-variar`:
  preflight OK; Node 24.19.0, Marp local, Chrome Linux; **40 no fonte = 40 seções
  HTML = 40 páginas PDF**. Artefatos promovidos pelo pipeline oficial.
- Inspeção global das 40 miniaturas e ampliada dos frames com código mais denso,
  especialmente 11 e 35, e do diagrama em tema escuro. Uma linha vazia foi retirada
  do frame 11 para recuperar espaço; fonte não reduzida. Após nova renderização,
  40 frames a 1280 × 720 sem overflow detectado. Tema e componentes existentes
  reutilizados; Mermaid usa classes semânticas e cores do CSS compartilhado.
- `.venv/bin/python /tmp/aula12-java-check.py`, verificação temporária usando
  o JDK Windows instalado (javac 24.0.2): trechos extraídos do roteiro, operações
  da Versão 10 recompostas para dar contexto e duas execuções da aula conferidas
  (`380.0/10.0` e `380.0/300.0/450.0/450.0/10.0`). A tentativa com Expressa
  falhou na compilação pelo motivo previsto. Código inicial e uma implementação
  possível de cada incremento do laboratório compilaram e produziram as saídas
  especificadas. Nenhum JDK ou dependência foi instalado.
- `.venv/bin/zensical build`: sem problemas.
- `npm run avaliacoes:test`: **4 testes passaram**.
- `.venv/bin/python -m unittest discover -s tests -v`: **9 passaram, 2 falharam**.
  Falhas anteriores à tarefa: `test_aula_05_phase_e_candidate_is_bound_to_approved_current_state`
  espera hash antigo da Aula 05; `test_aula_05_phase_e_v2_is_separate_current_and_bounded`
  espera provenance atual, mas recebe histórica. A Aula 05 atual é idêntica ao
  arquivo em HEAD, com SHA256
  `d17cc61a617582998d21b489fd27c3a22b18c4e303474cb8addfc516ee70be4c`.
  Os testes e os registros históricos não foram alterados nesta tarefa.
- `git diff --check`: passou. `git diff` e `git status` revisados; alterações
  restritas aos materiais 12, seus índices, navegação, cronograma e apoio de Java.

As capturas e scripts temporários estão em `/tmp/aula12-review` e `/tmp/aula12-*`.
São evidências da inspeção desta sessão, não artefatos oficiais do pipeline.

## Aprovação humana e elegibilidade da derivação

Após revisar os materiais, o professor aprovou a Aula 12 e sua publicação no
site. A decisão foi registrada para os bytes exatos da página e deste desenho.
O workflow Docemas validou aquela aprovação como `VALID_CURRENT` na publicação;
o registro 01 corresponde à versão histórica. A revisão posterior foi autorizada
explicitamente pelo professor, que aprovou o plano de ajustes e pediu a
introdução do cenário do Projeto 2. O registro 02 representa essa revisão.

A aprovação também aceitou o ritmo das hipóteses abertas e a transferência para
notificações simuladas no laboratório. O nível de IA já havia sido confirmado.

## Revisão posterior — fechamento e continuidade do Projeto 2

Plano aprovado pelo professor e implementado: Pedido() continua criando pedido
aberto; fechar(EntregaNormal) recebe e conserva a escolha, exigindo colaborador
existente. Exemplos consultam custo apenas após fechar. O limite de Expressa
aparece agora no argumento de fechar, sem alterar a pergunta central.

Laboratório 12 apresenta a transição U1 → U2 e a agenda de estudos antes do
código. A Versão 1 do Projeto 2 é preservada para os próximos laboratórios;
aulas continuam com Pedido. E-mail, SMS e painel permanecem incrementos concretos
simulados, com IA Nível 1 e entrega apenas de código. Specs, índice e cronograma
acompanham a decisão; nenhuma data nova foi definida.

Validações desta revisão: build Zensical sem problemas; exemplos e incrementos
compilados e executados com saídas conferidas; incompatibilidade Expressa/Normal
confirmada; fechamento com null preserva pedido aberto e fechamento válido
bloqueia edição. Renderização final: 40 fontes/seções/páginas; revisão global e
ampliada do código, sem overflow na inspeção geométrica final. Retirado comentário
do frame 35 e levado o contexto dos preços à pergunta para ampliar a margem.
Git diff --check passou. Registros 01 preservados; aprovação e provenance 02
validados como VALID_CURRENT. Alterações permanecem locais na branch draft.
