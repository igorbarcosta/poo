# Planejamento da Aula 17 — Inventário de jogo: interfaces e capacidades

Este documento registra o desenho pedagógico da Aula 17 para orientar a autoria
posterior do roteiro. O tema, a consolidação com interfaces, a introdução de cast
e `instanceof`, a ausência de laboratório e a posição antes do Checkpoint 04
foram definidos pelo professor. As regras numéricas e as assinaturas abaixo são
propostas deste desenho, ainda sujeitas à revisão docente.

## Contexto e escopo

- Unidade 02 — Colaboração, Contratos e Polimorfismo.
- As Aulas 14–16 trabalharam interfaces, tipo declarado e classe concreta,
  despacho dinâmico, referências, composição, delegação e verificação.
- A Aula 17 realiza uma transferência ampla para um inventário inspirado em
  Minecraft e acrescenta conversões explícitas de referências e `instanceof`.
- É a última aula antes do Checkpoint 04. O encontro inclui aplicação individual
  e discussão das respostas, sem depender de prática posterior.
- Não haverá laboratório associado, entrega ou incremento do Projeto 2.
- O jogo é um cenário da aula; não redefine o domínio do Projeto 3.
- Herança com `extends`, classes abstratas e tratamento de exceções permanecem
  para planejamento posterior. Reconhecer `ClassCastException` não equivale a
  ter estudado `try`/`catch` ou exceções de modo geral.

## Pergunta central e aprendizagem esperada

**Como um inventário guarda itens diferentes e permite operações específicas
sem exigir que todos os itens ofereçam as mesmas capacidades?**

Ao final, o estudante deve conseguir:

- reconhecer contratos distintos em um mesmo objeto e justificar a separação
  entre ser um item de inventário e aceitar reparo;
- distinguir tipo declarado, classe concreta, compilação e despacho dinâmico;
- explicar o efeito de um cast sobre o uso de uma referência, preservando a
  identidade e o estado do objeto;
- prever uma conversão incompatível e usar `instanceof` antes da conversão;
- delegar uma operação pela capacidade necessária, avaliando alternativas que
  dependem de classes concretas ou ignoram o colaborador recebido; e
- verificar resultados, consumo de recursos, invariantes e pontos de mudança.

**Uso de IA proposto: Nível 1 — Tutor.** Previsões, diagnósticos e justificativas
devem ser produzidos antes de consultar ajuda. Na condução presencial, incluir
uma resposta inicial individual, sem consulta e sem nota, seguida de discussão.
Isso é uma atividade formativa, não um novo instrumento de avaliação.

## Situação do jogo e regras do recorte

O jogador volta de uma exploração e abre o inventário. Há uma espada de ferro
danificada, um escudo danificado e uma maçã. Ele seleciona um item e tenta
repará-lo na bigorna, oferecendo uma pilha de material.

Explicar o inventário, a seleção e o reparo antes de apresentar classes. O
estudante não precisa conhecer Minecraft para resolver as situações.

A inspiração no jogo está no inventário heterogêneo, na durabilidade e no reparo
com material compatível. A arquitetura é uma proposta própria da disciplina.
Os limites, os acréscimos e a atualização do mesmo objeto são simplificações
explícitas deste modelo; não representam uma reprodução das tabelas nem da
implementação interna do Minecraft.

| Item | Estado inicial do cenário-base | Material aceito | Reparo por unidade |
| --- | --- | --- | --- |
| Espada de ferro | durabilidade `40`, máximo `100` | `"ferro"` | acrescenta `25`, limitado a `100` |
| Escudo | durabilidade `30`, máximo `80` | `"madeira"` | acrescenta `20`, limitado a `80` |
| Maçã | item sem durabilidade | não aceita reparo | operação indisponível |

Regras suficientes para determinar os resultados:

1. O inventário guarda referências. Obter um item não cria uma cópia nem o
   remove. Cada posição dos exemplos contém um objeto próprio, diferente de
   `null`; os índices usados são válidos.
2. A pilha oferecida à bigorna guarda um tipo de material e sua quantidade.
   Representa o material colocado na operação, sem implementar outro sistema
   de inventário ou remoção de pilhas nesta aula.
3. Um reparo bem-sucedido consome exatamente uma unidade e aumenta a durabilidade,
   respeitando o máximo. Uma unidade é consumida mesmo se faltar menos que o
   acréscimo normal para completar a durabilidade.
4. Material incompatível, pilha vazia ou equipamento já completo fazem o reparo
   devolver `false`, preservando equipamento e quantidade de material.
5. Item sem a capacidade de reparo faz a tentativa na bigorna devolver `false`,
   sem consumir material. Nas chamadas protegidas por `instanceof`, `null`
   também não entra no ramo de reparo.
6. Um reparo bem-sucedido devolve `true`. A bigorna trabalha com o mesmo objeto
   guardado no inventário; não cria um equipamento substituto.
7. Construtores estabelecem estados válidos. Os exemplos usam durabilidade
   dentro do intervalo e quantidade não negativa; validação de entradas de
   construtores não constitui uma nova investigação nesta aula.

Não acrescentar combate, consumo de alimentos, empilhamento de itens, experiência,
encantamentos, quebra de equipamentos, interface gráfica ou regras de edição do
jogo ao núcleo. A maçã permanece como item sem capacidade de reparo; não precisa
de um contrato `Consumivel` nem de um personagem para cumprir sua função.

## Responsabilidades e forma mínima da solução

| Tipo | Responsabilidade e operações necessárias |
| --- | --- |
| `Item` | Contrato comum de apresentação: `String descrever()` |
| `Inventario` | Guardar uma `List<Item>` privada; `adicionar(Item)`, `obter(int)` e `listar()`; a listagem solicita `descrever()` a cada item |
| `Espada` | Cumprir `Item`; guardar e proteger sua durabilidade; depois assumir também `Reparavel` |
| `Escudo` | Cumprir `Item`; guardar e proteger sua durabilidade; depois assumir também `Reparavel` |
| `Maca` | Cumprir `Item`, descrevendo um item sem reparo |
| `PilhaMaterial` | Guardar tipo e quantidade; permitir consultar compatibilidade e consumir uma unidade somente quando houver saldo |
| `Reparavel` | Contrato de capacidade: `boolean repararCom(PilhaMaterial material)` e `int getDurabilidade()` |
| `Bigorna` | `boolean tentarReparar(Item item, PilhaMaterial material)`: verificar a capacidade, converter e delegar; não calcular o reparo de cada equipamento |

Na autoria, distinguir o código de apoio dos trechos que serão investigados:

- Fornecer `PilhaMaterial` e a estrutura de `Inventario` prontas, com uma breve
  explicação de suas operações. Recuperar o laço de listagem, sem reconstruir
  essas duas classes em sala.
- Concentrar a investigação em `Item`, nas conversões de referências, na
  formulação de `Reparavel` e na delegação em `Bigorna`.
- Mostrar de `Espada` e `Escudo` somente os recortes necessários para compreender
  os contratos, o estado e a regra de reparo. A versão completa serve de apoio
  à consulta; não será apresentada classe por classe.

`Espada` e `Escudo` terminam com `implements Item, Reparavel`. São duas
interfaces independentes assumidas pelo mesmo objeto; `Reparavel` não precisa
estender `Item`. Uma referência `Reparavel` não oferece `descrever()` apenas
porque o objeto também cumpre `Item`.

Cada equipamento verifica material e durabilidade antes de solicitar o consumo
à pilha. Só aumenta a durabilidade se o consumo ocorrer. A pilha protege sua
quantidade contra valores negativos; o equipamento protege seu limite. A
bigorna coordena o acesso à capacidade e devolve o resultado da delegação.

Essa organização recupera composição e colaboração: inventário e pilha são
objetos com estado próprio, e o reparo resulta de chamadas entre colaboradores.
Não é necessário acrescentar um decorador para repetir a forma da Aula 16.

## Trajetória narrativa

### Movimento 1 — O inventário já funciona com itens diferentes

Apresentar a cena e um inventário pequeno com espada, escudo e maçã. Fornecer
as implementações de apresentação, concentrando a produção discente na leitura
e na explicação da colaboração, sem pedir a escrita de todas as classes.

O contrato `Item` aparece como uma necessidade de guardar e apresentar itens
diferentes. O laço de `listar()` solicita a mesma operação, `descrever()`, e
cada objeto informa seu estado. A descrição da espada e do escudo inclui a
durabilidade; a da maçã apenas identifica o alimento.

**Produção esperada:** prever a listagem, identificar o tipo da variável do laço
e explicar qual implementação executa. Justificar por que não são necessários
testes de tipo para listar os itens.

**Transição:** o jogador seleciona a espada e clica em reparar. A referência
obtida do inventário tem tipo `Item`; a operação `repararCom(...)` existe na
espada, mas não pertence a esse contrato.

### Movimento 2 — O objeto oferece a operação; a referência não permite chamá-la

Inicialmente, `Espada` e `Escudo` oferecem o método público `repararCom(...)`,
mas `Reparavel` ainda não foi introduzida. Retomar a diferença entre operações
do objeto e chamadas permitidas pelo tipo declarado:

```java
Item selecionado = inventario.obter(0);
selecionado.repararCom(ferro); // não compila
```

Fornecer previamente a montagem do inventário e da pilha `ferro`. Tratar essa
linha como análise de compilação, separada dos trechos executáveis.

Após a previsão, apresentar a conversão explícita:

```java
Espada espada = (Espada) selecionado;
boolean reparou = espada.repararCom(ferro);
```

No cenário-base com duas unidades de ferro, o reparo devolve `true`, a
durabilidade passa de `40` para `65` e resta uma unidade. A listagem do
inventário também passa a mostrar `65` para a espada.

**Produção esperada:** explicar por que a segunda versão compila, desenhar as
duas referências para o mesmo objeto e apontar a classe e o tipo declarado de
cada referência. `selecionado` continua tendo tipo declarado `Item` e não passa
a oferecer `repararCom(...)` depois da criação da variável `espada`.

Formalizar o cast como uma conversão que permite usar a referência por outro
tipo compatível. Ele não cria, copia ou transforma o objeto. O despacho do
método de instância continua dependendo do objeto alcançado.

### Movimento 3 — Escrever o cast não garante que o objeto seja compatível

Em um cenário independente, selecionar a maçã e tentar a mesma conversão:

```java
Item selecionado = inventario.obter(2);
Espada espada = (Espada) selecionado;
```

**Resposta esperada:** a conversão é aceita pelo compilador considerando o
tipo declarado `Item`, mas falha durante a execução com `ClassCastException`.
Nenhuma espada é criada e nenhum reparo acontece. Linhas posteriores não são
executadas nesse programa sem tratamento da falha.

Introduzir a verificação antes da conversão, na sintaxe tradicional:

```java
if (selecionado instanceof Espada) {
    Espada espada = (Espada) selecionado;
    espada.repararCom(ferro);
}
```

**Produção esperada:** comparar espada, escudo e maçã; explicar quando o ramo é
executado e por que a verificação deve anteceder o cast. Com escudo e maçã, o
ramo não executa. Com referência `null`, `instanceof` resulta em `false`.

Reconhecer `ClassCastException` como falha de conversão neste contexto, sem
abrir uma unidade sobre tratamento de exceções. Não ensinar pattern matching
junto com a primeira leitura de cast e `instanceof`.

**Transição:** o escudo também aceita reparo. Uma proposta acrescenta um ramo
para espada e outro para escudo, repetindo a estrutura. Que capacidade a
bigorna realmente precisa?

### Movimento 4 — Verificar a capacidade e delegar pelo contrato

Pedir que a turma formule o papel compartilhado antes de revelar `Reparavel`.
Comparar três propostas, com critérios explícitos:

- exigir `repararCom(...)` de todo `Item`, inclusive da maçã;
- identificar `Espada`, `Escudo` e cada futura classe por ramos separados;
- manter `Item` para o inventário e acrescentar `Reparavel` para quem oferece
  essa capacidade.

**Análise esperada:** o inventário precisa apresentar e guardar todos os itens;
o reparo exige uma capacidade adicional. O contrato separado expressa essa
exigência sem oferecer um falso reparo para a maçã e sem nomear todas as classes.

Apresentar a declaração mínima de `Reparavel` e explicar a sintaxe
`implements Item, Reparavel`. A tentativa da bigorna passa a ser:

```java
public boolean tentarReparar(Item item, PilhaMaterial material) {
    if (item instanceof Reparavel) {
        Reparavel equipamento = (Reparavel) item;
        return equipamento.repararCom(material);
    }
    return false;
}
```

**Produção esperada:** reconstruir o caminho da chamada até o equipamento e a
pilha, identificar o estado alterado em cada objeto e explicar por que a mesma
bigorna atende espada e escudo, mesmo com materiais e acréscimos diferentes.

O `instanceof` responde se o item selecionado oferece reparo. O despacho
dinâmico escolhe a implementação do método chamado por `Reparavel`. Se o código
já recebe uma referência `Reparavel`, pode solicitar o reparo diretamente;
não precisa repetir uma investigação sobre sua classe.

**Atividade — oferecer reparo garante que ele acontecerá?** Comparar três
cenários independentes usando a versão com `Reparavel`:

1. Espada com durabilidade `100/100` e pilha de ferro com `2` unidades.
2. Espada com durabilidade `40/100` e pilha de madeira com `2` unidades.
3. Maçã e pilha de ferro com `2` unidades.

Para cada cenário, prever `item instanceof Reparavel`, o retorno de
`tentarReparar(...)` e o estado final dos objetos.

**Respostas esperadas:**

| Cenário | `instanceof Reparavel` | Retorno da tentativa | Estado final |
| --- | --- | --- | --- |
| Espada completa e ferro | `true` | `false` | espada `100/100`; ferro `2` |
| Espada danificada e madeira | `true` | `false` | espada `40/100`; madeira `2` |
| Maçã e ferro | `false` | `false` | item e pilha preservados |

Explicitar a distinção: cumprir `Reparavel` permite solicitar a operação, mas
as regras de material e estado determinam se ela será realizada. Nas duas
primeiras situações, a conversão é válida e o método do equipamento executa,
recusando o reparo. Na terceira, o ramo de reparo da bigorna nem é executado.
Recuperar a Aula 15: um argumento de tipo aceito também não garantia um segundo
fechamento do pedido.

Contrastar também dois erros retomados da Aula 16: criar uma espada nova dentro
da bigorna em vez de usar o item recebido, ou aplicar um acréscimo fixo ali,
ignorando a regra do equipamento.

### Movimento 5 — Verificar, evoluir e justificar individualmente

Apresentar pequenos cenários independentes, sempre informando o estado inicial.
Pedir a previsão antes de mostrar as expectativas de testes JUnit conhecidos.
Não exigir escrita extensa de testes nem APIs de teste ainda não estudadas.

Fixar três testes prioritários para o encontro: reparo bem-sucedido, material
incompatível e respeito ao limite de durabilidade. Em cada um, observar tanto
o retorno e a durabilidade quanto a quantidade de material restante.

| Cenário independente | Resultado esperado |
| --- | --- |
| Espada `40/100`, ferro com `2` unidades | `true`; espada `65/100`; ferro `1` |
| Espada `40/100`, madeira com `2` unidades | `false`; espada `40/100`; madeira `2` |
| Espada `90/100`, ferro com `2` unidades | `true`; espada `100/100`; ferro `1` |

Manter os casos abaixo como consulta no roteiro. Eles complementam a cobertura
e não constituem outra sequência obrigatória de testes a discutir em sala:

| Cenário independente | Resultado esperado |
| --- | --- |
| Escudo `30/80`, madeira com `2` unidades | `true`; escudo `50/80`; madeira `1` |
| Espada `100/100`, ferro com `2` unidades | `false`; espada `100/100`; ferro `2` |
| Espada `40/100`, ferro com `0` unidades | `false`; espada `40/100`; ferro `0` |
| Maçã e ferro com `2` unidades | `false`; item e pilha preservados |

Discutir o alcance dessas verificações: os três testes prioritários não revelam
um reparo indevido da maçã nem verificam a regra do escudo. Os cenários da
atividade anterior e os casos complementares ajudam a identificar essas
diferenças de cobertura. Conferir só a durabilidade também não verifica o
consumo.

Como evolução, propor uma `Picareta` que cumpre `Item` e `Reparavel`, aceita
ferro e acrescenta `25` até o máximo didático de `100`. A turma deve indicar
onde entram sua implementação e sua criação, justificando por que o laço de
listagem e a tentativa da bigorna podem permanecer iguais.

O fechamento individual deve combinar quatro decisões curtas:

1. distinguir uma chamada que não compila de um cast que compila e falha;
2. explicar identidade e estado depois de um reparo por outra referência;
3. justificar uma conversão para `Reparavel` e a implementação executada; e
4. escolher um cenário que revele uma solução que ignora o colaborador ou
   consome material quando deveria recusar o reparo.

Respostas esperadas: fundamentação no tipo declarado para a compilação, no
objeto real para a compatibilidade e o despacho, nas referências compartilhadas
para o estado observado e nas regras explícitas para o resultado do teste.
O roteiro posterior deve concretizar cada questão e colocar sua resposta
imediatamente depois, em bloco expansível.

## Dimensionamento e condução

O núcleo foi pensado para um encontro de referência de 90 minutos. Distribuir
o esforço entre recuperação e inventário, cast e falha, capacidade de reparo e
integração final. Evitar transformar cada classe em uma exposição independente.

A recuperação deve ser breve; o maior esforço está nas conversões e na
passagem de classe concreta para capacidade. A atividade sobre capacidade e
condições de reparo integra a investigação da bigorna. Depois dela, trabalhar
os três testes prioritários, a evolução com a picareta e o fechamento individual.
Preservar espaço efetivo para essa produção final e sua discussão, sem ocupá-lo
com a reconstrução do código de apoio ou a exposição dos testes complementares.
O professor controla o tempo; as estimativas não devem aparecer como cronograma
na página pública.

Apresentar o código progressivamente por recortes, com os colaboradores e
estados necessários visíveis. A fonte posterior deve permitir reconstruir a
solução, sem exigir a leitura simultânea de todas as classes. Toda pergunta
deve indicar os objetos, a tarefa e se o cenário continua ou reinicia.

Como aprofundamentos, ampliar os diagnósticos e discutir o efeito de reatribuir
a variável local depois de obter o item. Não tornar o conhecimento cobrado no
checkpoint dependente de um aprofundamento que possa não ser trabalhado.

## Relação com o Checkpoint 04

A aula oferece uma última oportunidade de aplicação e feedback antes do
checkpoint. Não constitui o blueprint nem cria questões para esse instrumento.
Seu escopo e a ênfase em cast e `instanceof` ainda serão definidos no planejamento
da avaliação, considerando o que efetivamente for trabalhado em sala.

| Repertório recuperado ou introduzido | Evidência oferecida pela aula |
| --- | --- |
| Contratos e dependências | Separar `Item` e `Reparavel`; justificar o papel necessário a cada cliente |
| Tipo declarado e objeto concreto | Decidir sobre chamadas e conversões |
| Polimorfismo | Acompanhar listagem e reparo por referências de interface |
| Referências e identidade | Reconhecer o mesmo equipamento no inventário e no reparo |
| Composição, delegação e responsabilidades | Seguir a colaboração entre inventário, bigorna, equipamento e pilha |
| Encapsulamento e regras de estado | Preservar limites de durabilidade e quantidade |
| Verificação e análise de impacto | Distinguir implementações por testes e acrescentar um equipamento |

A Aula 17 não encerra automaticamente a Unidade 02. A sequência depois do
Checkpoint 04, incluindo os conteúdos novos ainda pendentes e o espaço de
consolidação antes da prova, será decidida pelo professor em planejamento
posterior. Não alterar o macrodesenho nem antecipar datas nesta etapa.

## Referências para a autoria

- [Projeto pedagógico](projeto-pedagogico.md), [padrão de aula](padrao-aula.md)
  e [estrutura do site](estrutura-site.md).
- [Aula 15](../docs/aulas/aula-15-polimorfismo-a-mesma-mensagem-comportamentos-diferentes.md)
  e [Aula 16](../docs/aulas/aula-16-combinando-comportamentos-por-composicao.md).
- [Retrospectiva da oferta](../retrospectivas/2026-2.md): preservar a progressão
  por situações e formular perguntas com contexto local suficiente.
- [Minecraft — Taking Inventory: Anvil](https://www.minecraft.net/en-us/article/taking-inventory--anvil):
  referência para a mecânica de reparo com materiais.
- [Minecraft — Taking Inventory: Shield](https://www.minecraft.net/pl-pl/article/taking-inventory--shield):
  referência para reparo de escudos com tábuas.
- [Java — Casting Objects](https://dev.java/learn/inheritance/what-is-inheritance/):
  referência para conversão explícita, compatibilidade em execução e `instanceof`.

## Próximos artefatos

Este arquivo é o desenho docente, não a página pública nem o deck. A autoria
posterior deve seguir o fluxo roteiro → revisão pedagógica → validação do
professor → slides → revisão visual. Não criar laboratório associado ou
publicar conteúdo por inferência a partir deste planejamento.
