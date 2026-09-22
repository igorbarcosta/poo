# Desenho da Aula 11 — Revisão da Unidade 01

## Ponto de partida

A aula fecha a Unidade 01 antes da Avaliação 01. Os estudantes construíram o
Projeto 1 entre as Aulas 02 e 10 e já trabalharam classe, objeto, estado,
comportamento, responsabilidade, referências, identidade, encapsulamento,
construtores, colaboração, coleções, direção das relações, composição, estado
aberto/fechado e operações que localizam partes de uma coleção.

A revisão não reconta essas aulas nem reapresenta definições em sequência. Ela
coloca a turma diante de um sistema desconhecido e usa as decisões necessárias
para reconstruir o repertório da unidade.

## Problema organizador

Uma equipe usa robôs para investigar uma região. Cada robô possui identificação,
bateria e um sensor. Uma missão reúne robôs participantes e preserva as leituras
registradas durante a exploração. Enquanto a missão está aberta, participantes,
sensores e registros podem mudar segundo as operações oferecidas. Depois de
encerrada, a equipe e os registros ficam preservados.

A pergunta central é:

> Diante de um sistema novo, conseguimos descobrir quais objetos existem, quem
> é responsável pelo quê, quem conhece quem, qual estado muda e por que o
> sistema se comporta daquela maneira?

## Verificação de transferência em relação ao Projeto 1

Não existe correspondência direta entre as classes centrais, operações e
relações deste domínio e `Pedido → ItemPedido → Produto`:

- `Missao` mantém **duas coleções com ciclos de vida diferentes**: robôs
  existentes que participam temporariamente e leituras produzidas durante a
  missão;
- `Robot` não é uma linha criada pela missão: existe independentemente, mantém
  bateria e pode trocar o componente `Sensor` que conhece;
- `Leitura` é um registro de uma ação, preserva o contexto observado e conhece
  o robô que a produziu; não representa quantidade nem calcula subtotal;
- remover um robô da equipe não remove leituras históricas já registradas;
- registrar exige verificar participação **antes** de criar a leitura;
- não há produto, preço, quantidade, linha, subtotal, total ou acumulação
  monetária;
- `Missao.trocarSensor(...)` localiza um participante, mas a mudança do campo
  `sensor` continua sob responsabilidade de `Robot`.

Um aluno não resolve a aula renomeando as três classes do projeto: precisa
decidir quais relações são temporárias, quais formam estrutura, o que deve ser
preservado como registro e qual objeto protege cada mudança.

## Modelo final adotado

### `Sensor`

- estado: `tipo` e `unidade`;
- nasce com as duas informações pelo construtor;
- fornece consultas; não conhece robôs nem leituras.

### `Robot`

- estado: `identificador`, `bateria` e referência para `Sensor`;
- nasce com bateria entre `0` e `100`; valores fora da faixa preservam o valor
  padrão `0` nesta solução didática;
- `deslocar(int consumo)` reduz bateria apenas para consumo positivo que caiba
  na carga atual;
- `trocarSensor(Sensor novoSensor)` altera o componente mantido pelo robô;
- `usaSensor(Sensor sensor)` responde por identidade de referência;
- `realizarLeitura(double valor)` cria uma `Leitura` com referência ao próprio
  robô e com o tipo/unidade vigentes preservados no registro.

### `Leitura`

- estado: referência para `Robot`, tipo do sensor, unidade e valor observados;
- representa um registro produzido durante uma ação;
- não conhece `Sensor` diretamente e não é mantida pelo robô;
- oferece consultas e uma descrição curta do registro.

### `Missao`

- estado: `nome`, `List<Robot> robots`, `List<Leitura> leituras` e
  `boolean encerrada`;
- nasce aberta, com as duas listas vazias;
- mantém participantes por referência sem criá-los nem copiá-los;
- mantém no máximo uma entrada para a mesma identidade de `Robot`;
- registra leitura apenas se estiver aberta e o robô participar; a verificação
  antecede `new Leitura(...)`, executado indiretamente por
  `robot.realizarLeitura(...)`;
- remove participantes por identidade, sem apagar leituras já produzidas;
- localiza o robô participante antes de pedir que ele troque o próprio sensor;
- depois de `encerrar()`, não adiciona nem remove robôs, não troca sensores pela
  operação da missão e não registra novas leituras;
- percorre as leituras para contar registros de um robô sem entregar a coleção.

## Decisões conceituais importantes

- `Robot → Sensor` é uma associação que representa a configuração atual do
  robô. Embora o robô controle a substituição do componente, o modelo permite
  criar e compartilhar sensores independentemente; por isso, a relação não é
  classificada automaticamente como composição.
- `Missao → Robot` é associação: robôs existem antes, depois e fora da missão.
- `Missao → Leitura` é composição: as leituras formam o registro mantido pela
  missão e são criadas durante suas operações.
- `Leitura → Robot` é associação necessária para identificar a origem do
  registro; não exige `Robot → Leitura`.
- `Sensor` não conhece robôs, missões ou leituras.
- `Robot` não conhece missões. A missão protege seu próprio encerramento antes
  de pedir comportamentos ao robô.
- Os textos de tipo e unidade são preservados na leitura para que uma troca
  posterior de sensor não reinterprete registros antigos.

## Trajetória narrativa e dimensionamento

O encontro tem núcleo de aproximadamente 90 minutos. Os slides são curtos; os
frames de resposta e os diagramas são revelações rápidas da mesma discussão.

### 11.1 — Do problema ao primeiro grafo de objetos

Apresentar somente a missão, sem classes. Perguntar o que precisa de estado,
comportamento e responsabilidade e qual substantivo não precisa virar classe.
Fazer `Sensor` surgir pela necessidade de representar tipo e unidade. Contrastar
criação vazia com construtor e recuperar argumento, parâmetro, campo, `this`,
`null` e estado inicial válido.

Usar duas sequências de criação para um bloco forte de referências e identidade:
aliasing em `s1`/`s2`, duas execuções de `new`, diagramas concretos e `==`.
Somente depois introduzir `Robot`, a referência armazenada para `Sensor` e a
bateria protegida por operações significativas.

### 11.2 — Da colaboração à estrutura da missão

Fazer `Leitura` surgir da necessidade de registrar uma observação. A turma
decide quem cria, que dados o registro preserva e quais referências são
necessárias. `Robot.realizarLeitura(...)` cria o registro usando informações do
sensor, mas não mantém uma lista histórica.

Fazer `Missao` surgir quando vários robôs precisam formar uma equipe. Introduzir
as listas somente depois de escolher quem mantém participantes e registros.
`registrarLeitura(robot, valor)` integra busca, coleção, colaboração,
coordenação e criação condicional.

Parar para desenhar apenas as relações mantidas e discutir direção, associação,
dependência, composição e custo de relações reversas desnecessárias.

### 11.3 — Regras, mudanças e leitura integrada

Introduzir o encerramento como estado individual de cada missão. Todas as
operações de edição verificam a regra no objeto que mantém a estrutura.
Destacar que a verificação de registro ocorre antes da criação da leitura.

Evoluir com remoção de participante e troca de sensor. `Missao` localiza; o
`Robot` encontrado continua responsável pelo campo `sensor`. Reaplicar
identidade com outro robô que possui o mesmo texto de identificação.

Mudar a dinâmica para quatro `main` independentes:

1. criação, aliasing, estado equivalente e `==`;
2. mudanças válidas e recusadas na bateria;
3. colaboração, duas coleções e relações finais;
4. integração com registro, troca, remoção, encerramento, operações recusadas,
   contagem de objetos e estado final.

Encerrar com um desafio curto em biblioteca/campeonato e uma síntese visual da
trajetória, não com definições.

## Pausas e perguntas

O deck deve distribuir entre 35 e 50 perguntas abertas. Cada pausa apresenta
um problema concreto, aguarda previsão ou desenho e usa um frame posterior para
revelar resultado, diagrama ou decisão. Não usar múltipla escolha. Perguntas
rápidas de acompanhamento podem permanecer em frames narrativos neutros; pausas
`activity` são reservadas para produção real.

## Cobertura das Aulas 02–10

| Aula | Recuperação na narrativa |
| --- | --- |
| 02 | seleção de classes, objeto, estado, comportamento, responsabilidade e `new` |
| 03 | aliases, contagem de objetos, identidade, `==` e diagramas de referência |
| 04 | bateria exposta, `private`, operação significativa e recusa de estado inválido |
| 05 | construtor de `Sensor`/`Robot`, argumentos, parâmetros, `this`, padrões e estado inicial |
| 06 | `Robot → Sensor`, objeto como argumento e criação colaborativa de `Leitura` |
| 07 | duas listas, referências, `add`, enhanced `for`, coordenação e delegação |
| 08 | direção, associação, composição, dependência e conhecimento mínimo |
| 09 | aberto/encerrado por instância, guarda interna e verificação antes da criação |
| 10 | busca por identidade, remoção, coleção privada e coordenador localizando a parte |

## Aprofundamentos elásticos

- comparar a preservação de tipo/unidade na leitura com uma referência direta
  ao sensor atual;
- desenhar o grafo completo após troca de sensor e remoção de participante;
- discutir quais relações poderiam mudar se surgisse consulta histórica no
  próprio robô.

Esses aprofundamentos podem ser pulados sem quebrar os quatro `main` nem a
síntese final.

## Limites deliberados

Não introduzir JUnit, interfaces, herança, polimorfismo, classes abstratas,
`equals`, `hashCode`, exceções, `Stream`, lambdas, Generics como tópico, UML,
SOLID, padrões de projeto, persistência, camadas ou conteúdos da Unidade 02.
Não transformar robótica em conteúdo técnico: sensores e robôs são apenas um
domínio intuitivo para raciocinar sobre objetos.
