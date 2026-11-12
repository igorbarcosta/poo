# Planejamento do fechamento da Unidade 02 — Aulas 18 e 19

## Atualização — destinação da Aula 19

O professor redefiniu a Aula 19 como correção da Prova da Unidade 02, questão
por questão, com explicitação das habilidades avaliadas e nivelamento do
repertório acumulado. A variante A conduz a resolução; a B é conferida a
partir das diferenças. O desenho atual está em
[Planejamento da Aula 19](planejamento-aula-19.md).

Essa decisão substitui a destinação da Aula 19 a exceções básicas e
consolidação pré-prova descrita abaixo. O texto anterior permanece como
histórico do planejamento; a Aula 18 e seu laboratório não são redefinidos.
Não há nova decisão sobre quando trabalhar exceções.

## Situação e estatuto deste desenho

O professor definiu o encerramento da Unidade 02 em mais duas aulas e aprovou
o desenho pedagógico registrado neste documento. A aprovação abrange a
distribuição dos conteúdos, a continuidade do inventário e o espaço reservado
à consolidação. Este planejamento orienta a autoria posterior dos roteiros;
não altera o cronograma, as avaliações ou as páginas públicas.

A numeração 18 e 19 segue o material disponível, que chega à Aula 17. A
existência dos materiais não comprova sua aplicação. A posição e os resultados
do Checkpoint 04 devem ser considerados na condução quando estiverem disponíveis,
sem presumir aqui sua realização ou criar outro instrumento.

## Diagnóstico curricular

| Repertório da Unidade 02 | Situação nos materiais |
| --- | --- |
| Variação de colaboradores e dependências | Desenvolvido desde a Aula 12 |
| Verificação com JUnit | Trabalhada na Aula 13 e retomada nas evoluções seguintes |
| Contratos e interfaces | Desenvolvidos na Aula 14 |
| Tipo declarado, objeto concreto e despacho dinâmico | Desenvolvidos na Aula 15 |
| Composição e delegação | Desenvolvidas na Aula 16 |
| Capacidades, cast e `instanceof` | Desenvolvidos na Aula 17 |
| Herança de classes, sobrescrita e classes abstratas | Ainda sem desenvolvimento nos materiais |
| Comparação entre composição e herança | Falta uma comparação apoiada em exemplos de ambas |
| Tratamento básico de exceções | Ainda sem desenvolvimento; reconhecer `ClassCastException` na Aula 17 não equivale a tratar exceções |

A decisão aprovada é concentrar herança e classe abstrata na Aula 18 e limitar o
conteúdo novo da Aula 19 a um recorte básico de exceções. A maior parte do
último encontro deve integrar e discriminar o repertório da unidade. O projeto
pedagógico exige espaço real de consolidação antes da prova, mesmo com o prazo
de duas aulas.

## Distribuição aprovada

| Encontro | Pergunta orientadora | Resultado principal |
| --- | --- | --- |
| Aula 18 — Compartilhando regras sem perder os contratos | Quando classes diferentes podem compartilhar implementação sem perder suas responsabilidades? | Ler uma hierarquia pequena, compreender estado herdado e sobrescrita, justificar uma classe abstrata e comparar herança com composição |
| Aula 19 — Falhas, contratos e decisões de projeto | Como verificar se uma solução respeita contratos e continua correta ao evoluir? | Distinguir recusa prevista de argumento inválido, acompanhar uma exceção básica e analisar soluções que combinam o repertório da unidade |

Manter o inventário da Aula 17 como contexto principal reduz a necessidade de
apresentar outro domínio enquanto se introduzem mecanismos novos. O inventário
continua sendo um cenário didático; isso não redefine o Projeto 3. O Projeto 2
de lembretes e notificações pode aparecer como transferência curta na Aula 19.

## Aula 18 — Compartilhando regras sem perder os contratos

### Aprendizagem esperada

Ao final, o estudante deverá conseguir:

- identificar regras realmente comuns antes de propor uma superclasse;
- ler `extends`, `super(...)`, `abstract` e `@Override` no exemplo trabalhado;
- explicar a inicialização e a proteção do estado de um objeto de subclasse;
- prever chamadas que usam métodos herdados e sobrescritos;
- distinguir interface, classe abstrata e colaborador por composição; e
- justificar por que uma capacidade adicional não exige pertencer a uma mesma
  hierarquia de classes.

### Situação e limites do exemplo

Retomar espada, escudo, maçã, inventário, bigorna e pilha da Aula 17. Preservar
as regras: espada começa com `40/100`, aceita ferro e recupera `25`; escudo
começa com `30/80`, aceita madeira e recupera `20`. Sucesso consome uma unidade,
respeita o máximo e devolve `true`. Material errado, pilha vazia ou equipamento
completo produzem `false` sem mudança de estado.

O ponto de partida é a repetição da proteção da durabilidade e da sequência de
reparo nas duas classes. A semelhança deve ser mostrada antes da solução por
herança. Não basta haver campos com nomes iguais: ambas precisam respeitar as
mesmas regras do conceito de equipamento reparável deste recorte.

Propor uma classe abstrata `Equipamento` que cumpre `Item` e `Reparavel` e
centraliza o estado privado, a consulta da durabilidade e o algoritmo comum de
reparo. Seu construtor recebe durabilidade inicial, máximo, material aceito e
acréscimo por reparo. `Espada` e `Escudo` passam esses dados por `super(...)` e
sobrescrevem `descrever()`. Essa operação permanece abstrata na base; as duas
descrições concretas usam a consulta pública da durabilidade.

O construtor da base é `protected`, explicado como acesso necessário à
construção pelas subclasses, sem abrir uma matriz completa de visibilidade.
Os campos permanecem `private`; não usar campos `protected` para facilitar a
escrita das subclasses. Não chamar métodos sobrescrevíveis no construtor.
Usar entradas válidas neste encontro; a política para argumentos inválidos
será investigada na Aula 19.

### Trajetória proposta para 90 minutos

1. **Recuperar e localizar a repetição — 10 minutos.** Prever um reparo por
   `Reparavel` e identificar quem altera cada estado. Comparar os recortes de
   espada e escudo e marcar as regras comuns e os dados diferentes.
2. **Extrair a implementação comum — 25 minutos.** Construir a relação com
   `Equipamento`, ler `extends` e `super(...)` e acompanhar a criação de uma
   espada. Explicar que há um único objeto, cujo estado é inicializado pelos
   construtores da hierarquia; não há um segundo equipamento colaborador.
3. **Dar sentido à abstração e à sobrescrita — 20 minutos.** Perguntar o que
   significaria criar um equipamento genérico sem descrição definida.
   Formalizar classe e método abstratos. Usar `@Override` na descrição das
   subclasses e comparar com a implementação dos métodos de interface já
   conhecida. Prever chamadas por `Item`, `Equipamento` e `Reparavel`: o tipo
   declarado permite a chamada; o objeto determina a implementação executada.
4. **Comparar escolhas de projeto — 20 minutos.** Contrastar a herança de
   regras nesta solução com a colaboração entre objetos da Aula 16. Examinar
   se uma futura capacidade de reparo obrigaria qualquer objeto a estender
   `Equipamento`: não, pois o cliente da capacidade depende de `Reparavel`.
   Explicar por que `Maca` continua fora da hierarquia. Recuperar que um objeto
   pode cumprir várias interfaces, mas uma classe Java estende uma só classe.
5. **Verificar e justificar individualmente — 15 minutos.** Prever espada
   `90/100` reparada com duas unidades de ferro: retorno `true`, durabilidade
   `100/100`, saldo `1`. Comparar com o comportamento anterior à extração.
   Diagnosticar uma proposta que move as regras de reparo para `Bigorna` e
   indicar por que ela volta a depender de detalhes dos equipamentos.

As estimativas orientam a autoria e a condução, sem constituir um cronograma
público. Fornecer o código de apoio conhecido; não reconstruir inventário,
pilha e testes desde o início.

### Evidências e aprofundamentos

O núcleo precisa produzir uma previsão de execução justificada, uma explicação
do estado no único objeto e uma comparação entre herança e composição.
Acertar apenas os nomes das palavras-chave não é evidência suficiente.

Se houver tempo, comparar a base com uma alternativa em que os equipamentos
guardam um colaborador responsável pela durabilidade. Discutir o custo da
delegação e a flexibilidade obtida sem exigir sua implementação completa.
Evitar hierarquias profundas, catálogo de padrões e uma exploração de todos os
mecanismos de herança da linguagem.

## Aula 19 — Falhas, contratos e decisões de projeto

### Conteúdo novo com escopo limitado — cerca de 20 minutos

Retomar a diferença entre uma tentativa permitida que não se realiza e uma
entrada que viola as condições de construção. Material incompatível continua
produzindo `false`: isso já pertence às regras da operação e não será mudado
para justificar exceções.

Propor a regra explícita de construção: máximo e acréscimo positivos,
durabilidade entre zero e o máximo e material não nulo nem vazio. Argumentos
fora dessas condições provocam `IllegalArgumentException`, antes de concluir
a construção, em vez de correção silenciosa. Trata-se de uma regra nova desta
sequência aprovada, e não de um comportamento já adotado
na Aula 17.

Trabalhar apenas `throw new IllegalArgumentException(...)` e um `try`/`catch`
no código de demonstração que cria os objetos. Comparar um cenário válido,
uma construção inválida sem tratamento e a mesma construção com tratamento.
O estudante deve localizar a interrupção, reconhecer que a atribuição da
expressão `new` não se completa e explicar de onde a execução continua após
o `catch`. A mensagem da falha não substitui a verificação dos argumentos.

Não abrir taxonomia de exceções, exceções próprias, `throws`, `finally` ou
tratamento de recursos. Não capturar falhas indiscriminadamente nem usar
`catch` para corrigir um cast desnecessário. O objetivo é uma primeira leitura
e um uso básico, sem prometer domínio abrangente em um trecho de aula.

### Consolidação e integração — cerca de 60 minutos

Organizar situações curtas de previsão individual, comparação e discussão,
com estado inicial e tarefa explícitos:

1. **Ler a colaboração completa.** Acompanhar inventário → bigorna → equipamento
   → pilha. Separar compilação, compatibilidade de cast, despacho e regras de
   estado. Incluir uma recusa prevista e uma entrada inválida em cenários
   independentes.
2. **Escolher a estrutura pelo requisito.** Comparar um cliente que depende de
   `Reparavel`, uma hierarquia que força a maçã a oferecer reparo e uma solução
   em que a bigorna reconhece cada classe concreta. Justificar responsabilidades
   e os pontos de alteração para acrescentar outro equipamento.
3. **Transferir para composição.** Retomar o notificador com prefixo do Projeto
   2. Perguntar por que uma classe que recebe um `Notificador` permite combinar
   o prefixo com canais diferentes. Comparar com criar uma subclasse específica
   para cada canal com prefixo. Não exigir uma refatoração do projeto.
4. **Escolher testes que discriminam soluções.** Contrastar um reparo correto
   com uma versão que ultrapassa o máximo ou consome material antes de validar
   sua compatibilidade. Indicar dados e expectativas que revelem cada defeito,
   observando durabilidade e saldo. Usar o JUnit já conhecido como apoio,
   sem exigir novas APIs de teste no núcleo.

As respostas devem exigir justificativa, não apenas escolher entre interface,
herança e composição por palavras-chave. Também cabe concluir que um requisito
não precisa de abstração adicional.

### Fechamento individual — cerca de 10 minutos

Propor três tarefas curtas, formativas e sem nova nota: prever uma chamada e
seus efeitos; diagnosticar uma responsabilidade mal colocada; e justificar uma
mudança e a verificação que a acompanha. Usar as respostas para explicitar os
modelos mentais necessários à conclusão do bloco.

Se houver resultados do Checkpoint 04, substituir parte das situações de
consolidação por seus erros de raciocínio mais relevantes, preservando o
espaço de aplicação. Não acrescentar uma correção longa ao encontro já cheio.

## Decisões para a autoria posterior

- Preservar o recorte aprovado: herança e classe abstrata na Aula 18; exceções básicas e
  consolidação na Aula 19, mantendo o inventário como fio principal.
- Não acrescentar conteúdo novo ao encontro final além do recorte de exceções.
- Na decisão posterior descrita abaixo, o professor solicitou o laboratório
  da Aula 18 e definiu sua continuidade no Projeto 2. Não presumir outras
  práticas ou novas regras de entrega.
- O planejamento não redefine datas, posição da prova ou escopo de avaliação.
- Elaborar primeiro o roteiro da Aula 18, com perguntas
  e respostas imediatas conforme o padrão. Slides dependem da aprovação
  pedagógica do roteiro.

## Laboratório 18 — decisão posterior e recorte de implementação

Após a revisão da Aula 18, o professor pediu os ajustes e o laboratório
correspondente. Ao definir o recorte, escolheu continuar o Projeto 2 com
contagem por notificador. A prática parte da solução final do Laboratório 16;
não há um Laboratório 17 intermediário a reconstruir.

O requisito novo é consultar quantos envios cada objeto de canal realizou.
Os quatro canais de console seguem uma única sequência: obter a identificação,
imprimir uma linha e incrementar o próprio contador. A base abstrata
`NotificadorConsole` concentra essa sequência e o contador privado, iniciado
em zero. As subclasses implementam `descreverCanal()`; o e-mail conserva sua
origem. O construtor protegido da base é chamado por `super()`, sem chamadas
a operações sobrescrevíveis durante a construção.

`Lembrete` mantém sua contagem por lembrete e sua dependência de `Notificador`.
O objeto com prefixo e o registro de testes continuam fora da base de console,
pois não seguem seu algoritmo. As implementações desses colaboradores e da
interface são preservadas. O compartilhamento de um canal entre clientes
permite discriminar as duas contagens sem novos mecanismos Java.

Dimensionamento de referência, incluindo leitura, implementação, previsão e
correção: base e três canais simples, 35 minutos; e-mail e integração com
prefixo/lista, 25 minutos; seis testes e execução da suíte, 30 minutos.
Os testes antigos e o cenário anterior de `Main` permanecem como regressão.
IA Nível 1 e entrega somente de código seguem o padrão das práticas anteriores,
sem novas datas ou regras de avaliação.

A Aula 18 ganha uma ponte curta para a chamada de uma operação sobrescrita
por um método herdado. Herança, estado privado, construtores, sobrescrita e
tipo declarado estão no roteiro; composição está na Aula/Laboratório 16;
listas e referências repetidas, na Aula/Laboratório 15; JUnit, na Aula 13.
O laboratório não exige exceções, captura de console em teste ou novas APIs.

O desenho da prática foi escolhido pelo professor; a autoria dos roteiros
não constitui aprovação semântica de sua versão final nem autorização para
derivar slides ou publicar o site.

## Base local consultada

- [Projeto pedagógico](projeto-pedagogico.md).
- [Padrão de aula](padrao-aula.md) e [padrão de laboratório](padrao-laboratorio.md).
- [Planejamento da Aula 17](planejamento-aula-17.md) e seu
  [roteiro](../docs/aulas/aula-17-inventario-de-jogo-interfaces-e-capacidades.md).
- [Aula 16](../docs/aulas/aula-16-combinando-comportamentos-por-composicao.md)
  e [Laboratório 16](../docs/aulas/laboratorio-16-acrescentando-informacao-antes-do-envio.md).
- [Retrospectiva da oferta](../retrospectivas/2026-2.md).
