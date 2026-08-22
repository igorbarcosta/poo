# Projeto pedagógico da disciplina

Este documento registra o macrodesenho pedagógico da experiência integrada de Programação Orientada a Objetos e Laboratório de POO. Ele orienta futuras alterações no plano de ensino, no cronograma, nas aulas, nas atividades e nas avaliações.

Não é um cronograma aula por aula. O planejamento fino deve ser construído progressivamente e permanecer adaptável ao desenvolvimento da turma.

## Propósito e contexto

- **Disciplina:** Programação Orientada a Objetos — POO.
- **Curso:** Bacharelado em Engenharia de Computação — IFPB Campus Campina Grande.
- **Linguagem principal:** Java.
- POO e Laboratório de POO são componentes administrativos separados, mas pedagogicamente constituem uma experiência integrada.
- O site concentra conteúdos permanentes, plano de ensino, organização pedagógica, materiais, aulas, referências e navegação.
- O Google Classroom é o ambiente oficial para avisos, submissões, atividades, avaliações, notas e comunicação operacional.

A disciplina oferece fundamentos para componentes posteriores, como Análise e Projeto de Sistemas, Testes de Software e Padrões de Projeto. Ela não deve antecipar indevidamente o conteúdo desses componentes.

## Princípios pedagógicos estáveis

### Responsabilidades como eixo

A progressão não deve reproduzir uma lista tradicional de recursos — classe, objeto, encapsulamento, herança, classe abstrata, interface e polimorfismo. Deve partir de problemas e avançar por responsabilidades, estado e comportamento, encapsulamento, colaboração, dependências, contratos, composição e polimorfismo. Herança entra quando fizer sentido para o problema.

### Compreensão antes de geração

> Código que o aluno não consegue explicar não deve ser considerado código que ele domina.

Esse é um princípio pedagógico e avaliativo, não um objetivo de aprendizagem adicional. Escrever código é importante, mas deve caminhar com a capacidade de ler, explicar, prever comportamento, verificar, criticar, modificar, refatorar e comparar alternativas.

### POO acima da sintaxe de Java

Java torna os conceitos de POO concretos e explícitos; ensinar todos os seus recursos não é objetivo da disciplina. Em avaliações, pequenos erros sintáticos não devem eclipsar raciocínio orientado a objetos correto.

### Software como algo que evolui

O estudante deve incorporar requisitos e melhorar soluções existentes sem depender de reescritas completas. Leitura, análise de impacto, testes e refatoração atravessam o percurso.

### IA exige julgamento

Código produzido por LLM é uma proposta que deve ser compreendida, verificada e avaliada criticamente, nunca uma fonte de verdade. O estudante permanece responsável pelo que entrega.

### Domínio individual

Mesmo quando há colaboração em projetos, a compreensão individual é verificada presencialmente por checkpoints e provas.

## Objetivos de aprendizagem

1. Modelar problemas por meio de objetos e responsabilidades, identificando classes, estado, comportamento e relacionamentos adequados.
2. Implementar soluções orientadas a objetos em Java, utilizando adequadamente mecanismos fundamentais do paradigma e da linguagem, como encapsulamento, composição, herança, polimorfismo e interfaces.
3. Projetar soluções orientadas a objetos e justificar decisões de projeto, distribuindo responsabilidades, estabelecendo colaborações entre objetos e avaliando alternativas de modelagem e implementação.
4. Evoluir e refatorar software orientado a objetos, incorporando novos requisitos e melhorando soluções existentes sem depender de reescritas completas.
5. Produzir código legível e manutenível, empregando nomenclatura adequada, coesão, baixo acoplamento, separação de responsabilidades e organização consistente.
6. Verificar o comportamento de aplicações orientadas a objetos, utilizando testes, depuração e análise sistemática para identificar e corrigir defeitos.
7. Ler, explicar, modificar e avaliar criticamente código produzido por terceiros ou por ferramentas de IA, verificando seu comportamento, aderência aos requisitos e qualidade das decisões de projeto.

## Escopo

### Núcleo de POO

- transição do pensamento procedural para o orientado a objetos;
- objeto, classe, estado, comportamento, identidade e referências;
- atributos, métodos e construtores;
- encapsulamento, proteção do estado e invariantes simples;
- responsabilidades e colaboração entre objetos;
- associação, composição e dependências;
- interfaces e contratos;
- polimorfismo;
- herança, sobrescrita e classes abstratas;
- comparação entre composição e herança;
- coesão, acoplamento e separação de responsabilidades;
- leitura e evolução de software orientado a objetos.

### Java como suporte

- sintaxe essencial;
- `public`, `private` e `protected` quando necessários;
- `this`;
- membros de classe (`static`) e de instância;
- referências e `null`;
- `packages` e `imports` introduzidos progressivamente;
- fundamentos mínimos de compilação e execução;
- arrays e coleções de forma objetiva, considerando o repertório prévio de programação em Python e C;
- uso pragmático de `List` e `ArrayList`, sem transformar Generics em tópico;
- compreensão e tratamento básico de exceções;
- `toString` e `equals` quando pedagogicamente úteis;
- `hashCode` somente diante de uma necessidade concreta.

### Práticas transversais

- JUnit básico como ferramenta de verificação;
- depuração quando houver necessidade, sem unidade exclusiva;
- leitura e explicação de código;
- pequenas refatorações;
- comparação de soluções;
- análise de impacto de mudanças;
- avaliação de código produzido por LLM.

## Fora do escopo formal

- UML;
- Generics como tópico;
- Streams e lambdas;
- persistência e JDBC;
- GUI;
- concorrência e redes;
- frameworks;
- Maven ou Gradle como conteúdo;
- catálogo GoF de Design Patterns;
- recursos avançados de Java;
- aprofundamento de engenharia de testes.

Uma aplicação pode possuir infraestrutura ou interface fornecida pelo professor sem que isso transforme GUI ou frameworks em objeto de ensino.

## Arquitetura atualmente adotada

A disciplina está organizada em três unidades. Cada uma segue como referência:

**Parte 1 → Checkpoint → Parte 2 → Checkpoint → Parte 3 → Prova da Unidade**

Essa arquitetura não determina semanas nem quantidade de encontros. Os checkpoints não devem ficar imediatamente antes da prova. A Parte 3 deve reservar espaço real para consolidação, integração, transferência para novos problemas, leitura e análise antes da prova cumulativa da unidade.

### Unidade 1 — Objetos e Responsabilidades

**Pergunta central:** quem deve ser responsável por este estado e por este comportamento?

**Transformação esperada:** o estudante parte do repertório de programação estruturada e passa a decompor pequenos problemas em objetos com estado, comportamento e responsabilidades, implementando-os em Java.

**Focos:** transição procedural para OO; objeto; classe; estado; comportamento; referências; atributos; métodos; construtores; encapsulamento; invariantes simples; colaboração inicial; associação; composição; arrays e coleções como ferramenta; `static` versus instância; organização Java progressiva; introdução a JUnit; leitura e análise de código.

### Unidade 2 — Colaboração, Contratos e Polimorfismo

**Pergunta central:** como projetar objetos que colaboram e acomodam variações sem espalhar decisões pelo sistema?

**Transformação esperada:** o estudante passa de classes relativamente isoladas para um sistema em que objetos colaboram por responsabilidades, dependências e contratos bem definidos.

**Focos:** colaboração; composição; dependências; responsabilidades; coesão; acoplamento; contratos; interfaces; tipo da referência e tipo concreto; polimorfismo; despacho dinâmico; dependência de abstrações; herança; sobrescrita; classes abstratas; composição versus herança; JUnit na evolução; exceções básicas.

A sequência conceitual preferencial é: colaboração → dependências → variação → contrato/interface → polimorfismo → composição → herança quando fizer sentido. Herança não deve organizar a unidade.

### Unidade 3 — Evolução de Software Orientado a Objetos

**Pergunta central:** como compreender, avaliar e evoluir um software orientado a objetos que eu não escrevi do zero?

**Transformação esperada:** o estudante deixa de atuar apenas como autor de pequenos programas e passa a compreender, verificar, avaliar, modificar e refatorar software existente.

**Focos:** leitura e navegação de software; fluxo de chamadas; responsabilidades; dependências; análise de impacto; testes existentes; novos requisitos; refatoração; coesão; acoplamento; duplicação; revisão de decisões; composição versus herança; contratos; polimorfismo; código de terceiros ou sugerido por LLM; avaliação de alternativas.

Deve haver pouco conteúdo técnico novo. O foco é integrar e usar o repertório anterior.

Nas etapas de consolidação e nos checkpoints cumulativos, problemas mistos podem intercalar conceitos já estudados e exigir que o estudante decida qual ideia se aplica — composição, interface, herança ou mesmo nenhuma abstração adicional. O objetivo é praticar seleção e discriminação, não criar uma nova taxonomia de atividades.

## Práticas e projetos

Cada unidade possui um projeto. Práticas de laboratório e projeto não são trilhas independentes: cada prática é um incremento do projeto da unidade.

**Prática Lab 1 → evolução → Prática Lab 2 → evolução → demais incrementos → estado final do projeto**

A progressão de autonomia é:

1. **Projeto 1:** construção bastante guiada e evolutiva;
2. **Projeto 2:** novo domínio, com maior autonomia e necessidade de decisões;
3. **Projeto 3:** compreensão e evolução de uma aplicação existente, sem começar de uma pasta vazia.

Pequenos exercícios formativos podem ocorrer nas aulas teóricas sem constituir instrumentos formais de avaliação.

### Hipóteses atuais de domínio

- **Projeto 1:** sistema de pedidos, possivelmente evoluindo de `Produto` para `ItemPedido`, `Pedido`, vários itens, cálculos, fechamento e regras de estado.
- **Projeto 2:** sistema relacionado a entregas ou mobilidade, com requisitos sucessivos que provoquem variações, crescimento de condicionais, contratos, polimorfismo e comparação entre composição e herança.
- **Projeto 3:** aplicação interativa ou jogo simples, com infraestrutura ou interface fornecida pelo professor. O núcleo OO, e não a GUI, é o objeto de estudo.

Esses domínios são opções preferenciais, não decisões imutáveis. Requisitos específicos serão definidos progressivamente.

## Avaliação

Há quatro notas de mesmo peso:

- **N1:** prova individual da Unidade 1;
- **N2:** prova individual da Unidade 2;
- **N3:** prova individual da Unidade 3;
- **N4 — Projetos e Checkpoints**.

Assim, aproximadamente 75% da média provêm das provas individuais, 10% dos checkpoints e 15% dos projetos.

### Provas de unidade

As três provas são presenciais, individuais, em papel, sem consulta e têm duração aproximada de 1h30. Devem exigir pouco ou nenhum código extenso escrito à mão e priorizar:

- leitura e previsão de comportamento;
- explicação;
- identificação de responsabilidades;
- comparação de soluções;
- diagnóstico;
- análise de impacto;
- evolução diante de novo requisito;
- crítica de decisões;
- análise de código de terceiros ou produzido por LLM.

As provas são cumulativas no âmbito apropriado de cada unidade. POO é mais importante que precisão sintática de Java.

### N4 — Projetos e Checkpoints

- Três projetos de 20 pontos: **60 pontos**.
- Seis checkpoints individuais de 10 pontos; contam os quatro melhores: **40 pontos**.
- Total: **100 pontos**.

Os checkpoints são individuais, presenciais, em papel, têm duração padrão de 50 minutos, salvo indicação explícita em contrário, e ocorrem dois por unidade. Eles exercitam raciocínio semelhante ao das provas, são cumulativos na medida apropriada e fornecem feedback antes da avaliação da unidade.

As aulas seguintes a checkpoints e provas podem discutir soluções, erros frequentes, alternativas e raciocínio esperado. O feedback deve priorizar o modelo mental ou o raciocínio que levou ao erro, e não apenas apresentar a resposta correta — por exemplo, reconhecer quando variável e objeto foram tratados como a mesma coisa.

### Avaliação Substitutiva Cumulativa

Ao final do percurso regular haverá uma avaliação individual, em papel e sem consulta, abrangendo todo o conteúdo. Ela também será o instrumento de reposição para o estudante que deixou de realizar uma das provas N1, N2 ou N3.

Quem realizou as três provas poderá utilizá-la para substituir a menor nota entre N1, N2 e N3, somente se produzir resultado maior. Ela não substitui N4. A segunda chamada permanece uma situação distinta e segue o Regulamento Didático do IFPB.

### Práticas de laboratório

- Os projetos podem ser desenvolvidos em duplas.
- Cada estudante realiza sua própria entrega, mesmo quando o trabalho é feito em dupla.
- As práticas valorizam realização, evolução, participação e cumprimento de prazo.
- Não é necessário corrigir detalhadamente todas as soluções individualmente.
- O monitor pode apoiar a verificação de realização, entrega, requisitos mínimos, funcionamento básico e prazo.
- Testes automáticos simples com JUnit podem verificar comportamento.
- Qualidade de projeto — como responsabilidades, acoplamento e abstrações — não deve ser reduzida a correção automática; deve ser discutida pedagogicamente e avaliada principalmente nos instrumentos individuais.

## Uso de IA

Toda atividade relevante deve declarar explicitamente o nível máximo permitido:

- **Nível 0 — Sem IA:** sem auxílio de LLM.
- **Nível 1 — Tutor:** explicações, esclarecimento de conceitos e compreensão de erros.
- **Nível 2 — Revisor:** revisão de uma solução já construída e sugestões de melhoria.
- **Nível 3 — Colaborador:** pode gerar trechos ou soluções, sob responsabilidade do estudante.

Não há política única para todas as atividades. Independentemente do nível, o estudante deve explicar e modificar o código entregue. Especialmente na Unidade 3, o professor pode fornecer código gerado por IA como objeto de análise, crítica, comparação, correção e evolução.

## Critérios para evolução futura do planejamento

### Manter como princípios

- responsabilidade como eixo;
- compreensão antes de geração;
- POO acima da sintaxe de Java;
- protagonismo de colaboração e composição;
- herança sem protagonismo excessivo;
- software entendido como algo que evolui;
- leitura e avaliação de código como competências centrais;
- LLM como ferramenta que exige julgamento;
- domínio individual verificado presencialmente.

### Tratar como arquitetura atualmente adotada

- três unidades com perguntas e transformações centrais próprias;
- um projeto evolutivo por unidade;
- dois checkpoints por unidade;
- Parte 1 → checkpoint → Parte 2 → checkpoint → Parte 3 → prova;
- quatro notas de mesmo peso e composição definida para N4;
- Avaliação Substitutiva Cumulativa nos termos registrados acima.

Alterações nesses elementos são possíveis, mas exigem decisão pedagógica explícita do professor e atualização coordenada do plano, cronograma e atividades afetadas.

### Manter revisável

- domínio exato de cada projeto;
- posição precisa de JUnit e exceções;
- duração das unidades;
- distribuição dos tópicos entre as partes;
- sequência fina dos conteúdos;
- quantidade de encontros para cada conceito;
- requisitos específicos dos projetos.

Essas decisões devem responder ao ritmo da turma, às dificuldades observadas, aos resultados dos checkpoints, ao andamento dos projetos e à experiência do professor. Não inventar datas, calendário, quantidade exata de encontros ou distribuição semanal. Não tornar o cronograma excessivamente rígido.

## Orientação para novos conteúdos e atividades

Antes de criar ou reorganizar aulas, atividades ou avaliações:

1. consultar este documento, `estrutura-site.md` e `padrao-aula.md`; quando a atividade envolver laboratório, consultar também `padrao-laboratorio.md`;
2. verificar a unidade, a pergunta central e a transformação de aprendizagem atendidas;
3. privilegiar problemas, responsabilidades e colaboração, evitando sequências guiadas apenas por recursos da linguagem;
4. integrar escrita, leitura, explicação, previsão, verificação, crítica, modificação e refatoração de código;
5. informar o nível máximo de uso de IA em toda atividade relevante;
6. conectar práticas de laboratório à evolução do projeto da unidade;
7. preservar a Parte 3 como espaço real de consolidação antes da prova;
8. distinguir princípios estáveis de hipóteses revisáveis;
9. não antecipar conteúdos formais de componentes posteriores;
10. pedir decisão do professor quando uma escolha pedagógica importante ainda não estiver definida.
