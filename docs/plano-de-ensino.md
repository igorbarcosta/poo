# Plano de Ensino

## Identificação

**Disciplina:** Programação Orientada a Objetos — POO  
**Curso:** Bacharelado em Engenharia de Computação — IFPB Campus Campina Grande  
**Linguagem principal:** Java

POO e Laboratório de POO são componentes administrativos separados, mas formam uma experiência integrada de aprendizagem. As práticas de laboratório desenvolvem e aplicam, em projetos evolutivos, os conceitos trabalhados na disciplina. Como os dois componentes formam uma experiência integrada, o mesmo conjunto de atividades, avaliações e notas será utilizado em ambos.

## Visão da disciplina

A disciplina aborda POO a partir de problemas, responsabilidades e colaboração entre objetos. Java é usado para tornar esses conceitos concretos, e não como um fim em si mesmo. A progressão enfatiza objetos com estado e comportamento, encapsulamento, dependências, contratos, composição e polimorfismo; herança é utilizada quando for uma escolha adequada ao problema.

Além de escrever código, o estudante deverá aprender a ler, explicar, testar, criticar, modificar e refatorar software. Isso inclui avaliar código produzido por outras pessoas ou sugerido por ferramentas de inteligência artificial.

> **Princípio de domínio:** código que o aluno não consegue explicar não deve ser considerado código que ele domina.

## Objetivos de aprendizagem

Ao final da disciplina, espera-se que o estudante seja capaz de:

1. Modelar problemas por meio de objetos e responsabilidades, identificando classes, estado, comportamento e relacionamentos adequados.
2. Implementar soluções orientadas a objetos em Java, utilizando adequadamente mecanismos fundamentais do paradigma e da linguagem, como encapsulamento, composição, herança, polimorfismo e interfaces.
3. Projetar soluções orientadas a objetos e justificar decisões de projeto, distribuindo responsabilidades, estabelecendo colaborações entre objetos e avaliando alternativas de modelagem e implementação.
4. Evoluir e refatorar software orientado a objetos, incorporando novos requisitos e melhorando soluções existentes sem depender de reescritas completas.
5. Produzir código legível e manutenível, empregando nomenclatura adequada, coesão, baixo acoplamento, separação de responsabilidades e organização consistente.
6. Verificar o comportamento de aplicações orientadas a objetos, utilizando testes, depuração e análise sistemática para identificar e corrigir defeitos.
7. Ler, explicar, modificar e avaliar criticamente código produzido por terceiros ou por ferramentas de IA, verificando seu comportamento, aderência aos requisitos e qualidade das decisões de projeto.

## Metodologia

O trabalho combina discussão conceitual, leitura e análise de código, implementação em Java, práticas de laboratório, testes básicos com JUnit, depuração, comparação de soluções e pequenas refatorações. Problemas e requisitos sucessivos serão usados para revelar responsabilidades, colaborações, dependências e alternativas de projeto.

Cada unidade possui um projeto próprio. As práticas de laboratório são incrementos sucessivos desse projeto, e não uma trilha separada. A autonomia aumenta ao longo da disciplina: o primeiro projeto é bastante guiado; o segundo exige mais decisões; no terceiro, os estudantes recebem software existente para compreender e evoluir.

## Unidades

### Unidade 1 — Objetos e Responsabilidades

**Pergunta central:** quem deve ser responsável por este estado e por este comportamento?

A unidade promove a transição do pensamento procedural para a decomposição de pequenos problemas em objetos. Abrange estado, comportamento, referências, classes, atributos, métodos, construtores, encapsulamento, invariantes simples, colaboração inicial, associação, composição e organização Java progressiva.

### Unidade 2 — Colaboração, Contratos e Polimorfismo

**Pergunta central:** como projetar objetos que colaboram e acomodam variações sem espalhar decisões pelo sistema?

A unidade aprofunda responsabilidades, colaboração, composição, dependências, coesão e acoplamento. Contratos e interfaces permitem trabalhar polimorfismo e reduzir a dependência direta de implementações concretas. Herança, sobrescrita e classes abstratas são estudadas em comparação com composição, sem transformar herança no eixo organizador.

### Unidade 3 — Evolução de Software Orientado a Objetos

**Pergunta central:** como compreender, avaliar e evoluir um software orientado a objetos que eu não escrevi do zero?

A unidade integra o repertório anterior por meio da leitura e evolução de uma aplicação existente. O foco está em navegar entre classes, compreender fluxos e responsabilidades, analisar dependências e testes, avaliar impactos, incorporar requisitos e refatorar. A unidade prioriza a integração e a aplicação do repertório desenvolvido anteriormente, com menor ênfase na introdução de novos mecanismos da linguagem.

## Uso de inteligência artificial

Cada atividade relevante informará o nível máximo de uso de IA permitido:

- **Nível 0 — Sem IA:** realização sem auxílio de LLM.
- **Nível 1 — Tutor:** uso para explicações, conceitos e compreensão de erros.
- **Nível 2 — Revisor:** revisão de uma solução já construída e sugestões de melhoria.
- **Nível 3 — Colaborador:** geração de trechos ou soluções, sempre sob responsabilidade do estudante.

Não há um único nível para todo o curso. Em qualquer nível, o estudante deve compreender, verificar, avaliar e ser capaz de modificar o código entregue. Uma resposta de IA é uma proposta a ser analisada, não uma fonte de verdade.

## Avaliação

Cada uma das três unidades possui um projeto evolutivo desenvolvido nas práticas de laboratório, dois checkpoints individuais e uma prova individual ao final da unidade. Esses instrumentos têm funções diferentes e complementares:

- os projetos permitem aprender construindo e evoluindo software;
- os checkpoints ajudam cada estudante a acompanhar a própria aprendizagem e a se preparar para as provas;
- as provas verificam individualmente o domínio desenvolvido em cada unidade.

Como POO e Laboratório de POO formam uma experiência integrada, esse mesmo processo avaliativo e as mesmas notas serão utilizados nos dois componentes.

### Formação das notas

| Nota | Composição |
| --- | --- |
| **N1** | Prova individual da Unidade 1 |
| **N2** | Prova individual da Unidade 2 |
| **N3** | Prova individual da Unidade 3 |
| **N4 — Projetos e Checkpoints** | Projetos: 60 pontos + Checkpoints: 40 pontos |

Na N4, a pontuação é formada assim:

- Projeto da Unidade 1: até 20 pontos;
- Projeto da Unidade 2: até 20 pontos;
- Projeto da Unidade 3: até 20 pontos;
- seis checkpoints ao longo do semestre, dois por unidade, valendo até 10 pontos cada;
- para a N4, são considerados os quatro melhores resultados entre os seis checkpoints.

Assim, os projetos somam até **60 pontos**, os checkpoints considerados somam até **40 pontos** e a **N4 totaliza 100 pontos**. N1, N2, N3 e N4 possuem o mesmo peso na média.

### Provas de unidade

As três provas serão individuais, presenciais, em papel, sem consulta e terão duração aproximada de 1h30. O foco será a compreensão de POO, com pouco ou nenhum código extenso escrito à mão. As questões valorizarão principalmente:

- leitura e compreensão de código;
- previsão de comportamento;
- identificação de responsabilidades;
- comparação de soluções;
- diagnóstico de problemas;
- análise do impacto de mudanças;
- evolução diante de novos requisitos;
- justificativa de decisões.

A compreensão dos conceitos de POO será mais importante que pequenos detalhes sintáticos de Java.

### Checkpoints

Haverá seis checkpoints no semestre, dois por unidade. Eles serão individuais, presenciais, em papel e terão duração aproximada de 30 a 40 minutos. São oportunidades frequentes para verificar se a aprendizagem está acompanhando a evolução da disciplina e para se preparar para as provas. Cada checkpoint vale até 10 pontos, mas somente os quatro melhores resultados serão utilizados na N4.

### Projetos

Em cada unidade, as práticas de laboratório fazem o projeto evoluir gradualmente. Assim, o projeto não aparece apenas como uma atividade ou entrega adicional ao final: ele acompanha o estudante durante toda a unidade. Os projetos poderão ser desenvolvidos em dupla, mas cada estudante realizará sua própria entrega.

### Avaliação Substitutiva Cumulativa

Ao final do percurso regular, haverá uma Avaliação Substitutiva Cumulativa. Ela será individual, em papel, sem consulta e abrangerá todo o conteúdo da disciplina. Essa avaliação também será o instrumento utilizado para reposição ao final do período.

Ela poderá ser utilizada em duas situações:

1. O estudante que deixou de realizar uma das provas N1, N2 ou N3 poderá utilizar a Avaliação Substitutiva Cumulativa como avaliação de reposição para essa nota.
2. O estudante que realizou as três provas poderá fazer a Avaliação Substitutiva Cumulativa para tentar melhorar sua menor nota entre N1, N2 e N3. Nesse caso, a substituição ocorrerá somente se a nota da avaliação cumulativa for maior.

A N4 não poderá ser substituída. A segunda chamada é uma situação distinta e segue o Regulamento Didático do IFPB.

### Avaliação Final

Para os estudantes que não forem aprovados por média, a Avaliação Final seguirá as regras institucionais do IFPB. Ela não se confunde com a segunda chamada nem com a Avaliação Substitutiva Cumulativa utilizada para substituição ou reposição.

## Planejamento evolutivo

A estrutura, os objetivos e a organização geral das unidades orientam todo o semestre. O cronograma detalhado poderá ser ajustado conforme o ritmo e as necessidades de aprendizagem da turma. Poderão ser ajustados o tempo dedicado aos conteúdos, a sequência fina, os requisitos dos projetos e atividades específicas.

As datas do planejamento e a macroestrutura atualizada estarão disponíveis no [Cronograma](cronograma.md). Avisos, orientações operacionais, submissões, atividades, avaliações e notas serão comunicados pelo [Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).
