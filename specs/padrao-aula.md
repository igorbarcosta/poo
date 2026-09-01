# Padrão das páginas de aula

Este documento registra o padrão das aulas de POO, destinadas principalmente à fundamentação conceitual. Laboratórios possuem numeração e padrão próprios, registrados em `padrao-laboratorio.md`.

## Identificação

- O nome do arquivo deve seguir o padrão `aula-XX-assunto.md`.
- O título da página deve seguir o padrão `Aula XX — Título`.
- Não incluir data ou semestre no título da aula.
- Não definir `icon` no front matter das aulas. Conforme `estrutura-site.md`, o
  ícone Lucide pertence à categoria **Aulas**; os itens internos permanecem
  textuais no menu.

## Estrutura

Cada página deve começar com uma breve contextualização e conter objetivos e uma seção de materiais relacionados. A pergunta central, quando existir, e os objetivos podem aparecer em blocos estruturais próprios, próximos ao início da página:

- `lesson-question`: explicita o problema que orienta a trajetória;
- `lesson-objectives`: reúne, em bullets, poucas competências de maior nível.

Esses blocos usam identidade azul/neutra discreta. São elementos de orientação da aula, não pausas didáticas, e não ampliam a gramática das seis pausas.

Os macroblocos reais da narrativa podem aparecer diretamente como seções, de modo que o sumário também revele a trajetória da aula. O contêiner genérico **Conteúdo** é opcional, não uma exigência.

Quando forem pertinentes, podem ser incluídas as seguintes seções opcionais:

- **Exemplos**
- **Atividade**
- **Para revisar**
- **Referências**

## Construção pedagógica

O roteiro é a fonte pedagógica da aula e também um estudo autoguiado permanente para o estudante. Antes de produzir o deck, devem estar completos e validados os objetivos, as dependências, a trajetória narrativa, as pausas didáticas, a relação com o laboratório seguinte e o dimensionamento do encontro. Os slides são derivados dessa base; o deck anterior não deve substituir o trabalho de construir o roteiro.

O fluxo permanente de produção é:

**roteiro → revisão pedagógica → validação e aprovação do professor → slides → revisão visual dos slides**

Construir e revisar primeiro uma boa aula, sem comprimir o roteiro para fazê-lo caber em frames. Nunca gerar automaticamente os slides junto com a primeira construção do roteiro. A etapa de slides começa somente depois da aprovação pedagógica explícita e traduz visualmente uma narrativa já definida.

A página pública deve ser compreensível fora do encontro síncrono. Não incluir nela instruções de condução ao professor, coleta de respostas da turma, espera por uma discussão, adaptação ao ritmo da sala ou indicação de que uma resposta será formalizada oralmente. Essas decisões pertencem ao deck e às notas de apresentação. Comentários internos de autoria podem registrar estimativas, blocos e aprofundamentos, desde que não apareçam ao estudante nem sejam necessários para compreender o conteúdo.

Aula não é uma sequência de tópicos independentes. O storytelling didático estabelece causalidade: um problema produz uma observação, a observação cria uma pergunta, a pergunta exige investigação e a investigação permite formalizar uma ideia ou tomar uma decisão. Conceitos aparecem depois de existir uma necessidade compreensível para eles.

O encontro deve ser dimensionado internamente para 90 minutos, considerando explicação, leitura, previsão, espera, discussão, atividade, formalização e síntese. Esse dimensionamento orienta o projeto do material, mas não aparece como cronograma de minutos na página destinada aos estudantes.

Planejar o encontro com um **núcleo necessário** e possíveis **aprofundamentos elásticos**. O núcleo reúne o que precisa acontecer; os aprofundamentos entram conforme o ritmo da turma e devem ampliar recuperação, previsão, comparação, diagnóstico, explicação ou transferência, sem antecipar conteúdo futuro nem repetir exposição apenas para ocupar tempo.

Na condução síncrona registrada no deck, algumas aulas podem começar com uma recuperação curta, sem consulta e sem nota, combinando duas ou três questões sobre o encontro anterior e conteúdos mais antigos. Também pode ser útil empregar Peer Instruction quando houver modelos mentais concorrentes: resposta individual → discussão com colega → nova resposta → explicação coletiva, sem depender de clickers ou outra tecnologia. Nenhuma dessas estratégias é seção fixa ou ritual obrigatório da página autoguiada.

### Atividades no estudo autoguiado

As atividades da página falam diretamente ao estudante e devem ser respondíveis apenas com o contexto disponível no roteiro. Podem pedir previsão, comparação, explicação ou registro de uma hipótese antes da continuação. A página deve então oferecer elementos suficientes para conferir ou reformular o raciocínio, sem depender da fala do professor.

Não escrever na página “espere a discussão”, “o professor coleta”, “participe do levantamento coletivo”, “discuta com um colega” ou outras instruções dependentes de uma aula presencial. Trabalho em pares, Peer Instruction, coleta coletiva e formalização oral continuam disponíveis no deck quando houver razão pedagógica deliberada, mas não fazem parte do roteiro autoguiado.

Essa orientação não se aplica como restrição aos laboratórios. Neles, investigação conjunta, previsão compartilhada, ajuda entre pares e comparação entre implementações podem ocorrer naturalmente quando servirem ao objetivo prático.

## Piloto da oferta 2026.2 — granularidade por blocos didáticos

Esta seção registra uma hipótese experimental para as Aulas 05, 06 e 07 da oferta atual. Ela não altera retroativamente as Aulas 01–04 nem estabelece uma regra permanente da disciplina. Depois da Aula 07, uma retrospectiva específica deve avaliar a experiência antes de decidir se o padrão será mantido, ajustado ou abandonado.

Um **bloco didático** é uma unidade conceitualmente coerente da aula, organizada em torno de uma pergunta, tensão, problema ou avanço específico no modelo mental do estudante. O bloco é definido pela coerência do arco conceitual, não pelo relógio.

Como referência de planejamento para encontros de 90 minutos:

- considerar aproximadamente três blocos principais;
- usar 20 a 30 minutos como faixa típica por bloco;
- admitir dois blocos mais longos, quatro blocos quando algum for curto e durações fora da faixa sempre que o arco pedagógico justificar;
- evitar uma única exposição longa sem divisões conceituais claras.

Esses números são heurísticas, não obrigações nem limites cognitivos universais. O piloto se fundamenta em segmentação de conteúdo complexo, gerenciamento da carga cognitiva, alternância entre exposição e processamento, aprendizagem ativa, recuperação e aplicação frequentes e melhor granularidade de autoria, manutenção e retrospectiva. Não o justificar por uma suposta duração fixa da atenção dos estudantes.

### Engenharia interna dos blocos

Ao planejar cada bloco, conseguir responder internamente:

1. Qual pergunta ou tensão move o bloco?
2. O que o estudante entende ao final que ainda não entendia no início?
3. Qual mudança ocorre em seu modelo mental?
4. Que evidência rápida permite perceber se essa mudança ocorreu?
5. Como o resultado prepara o bloco seguinte?

Evitar blocos definidos apenas por categorias de sintaxe, como “Construtores”, “Métodos” ou “`this`”. Preservar a causalidade **problema → necessidade → mecanismo**: o recurso de Java aparece como resposta ao problema conceitual.

Como gramática de referência, um bloco pode articular **problema ou tensão → investigação ou previsão → construção do conceito → aplicação → síntese ou transição**. A sequência não é obrigatória. O bloco pode começar por código, comparação, previsão ou situação problemática, desde que produza um avanço identificável.

Sempre que apropriado, incluir dentro ou ao final do bloco uma atividade curta de processamento: prever saída, escolher entre alternativas, identificar uma responsabilidade, modificar código, fazer teste de mesa, comparar soluções, explicar uma decisão, detectar um problema ou transferir a ideia. Essas ações não precisam virar atividades formais nem entregáveis. Blocos não devem se tornar mini-exposições consecutivas.

A aula continua sendo uma narrativa única. Cada bloco deve deixar uma consequência, tensão ou necessidade que cause o próximo; evitar transições meramente catalográficas. A página e o deck podem refletir a segmentação internamente, mas não precisam mostrar “Bloco 1”, “Bloco 2” ou slides separadores. Manter um arquivo Markdown por aula e headings narrativos naturais.

### Identificação e retrospectiva

Identificar os blocos internamente pelo número da aula e uma sequência curta: `5.1`, `5.2`, `5.3`; `6.1`, `6.2`, `6.3`; e assim por diante. No fonte Markdown, usar quando útil um comentário leve antes da seção correspondente, por exemplo:

```markdown
<!-- bloco-didatico: 5.1 -->
```

O identificador pode aparecer em comentários, notas internas e retrospectivas, sem precisar ficar visível ao estudante. Nos slides, preservar a mesma fronteira apenas na organização interna ou em transições narrativas naturais, sem criar lâminas cuja única função seja anunciar um novo bloco.

A partir da Aula 05, as retrospectivas podem registrar evidências por identificador de bloco. Cada achado pode ter um dos destinos já praticados:

1. **ajuste pontual:** melhorar o material da aula já dada sem mudar o conteúdo apresentado;
2. **propagação:** aplicar a aprendizagem às próximas aulas da mesma oferta;
3. **futura oferta:** registrar uma mudança estrutural para a próxima versão do curso.

Depois da Aula 07, criar na retrospectiva da oferta uma síntese intitulada **Granularidade por blocos didáticos**. Avaliar se o piloto melhorou preparação, ritmo, alternância entre exposição e processamento, utilidade das retrospectivas e identificação de redundâncias; verificar também se gerou fragmentação ou burocracia excessiva e se a faixa de 20–30 minutos e a referência de três blocos foram úteis.

### Hipótese inicial para a Aula 05

A arquitetura abaixo orienta o planejamento posterior; não constitui ainda a página completa da aula.

| ID | Pergunta que move o bloco | Avanço esperado e processamento | Continuidade |
| --- | --- | --- | --- |
| **5.1 — O problema do objeto nascer incompleto** | Se um objeto precisa de certas informações para fazer sentido, por que permitimos criá-lo sem elas? | Partir dos objetos vazios e configurados depois da criação; identificar estados incompletos possíveis e prever suas consequências. | A insuficiência da configuração posterior cria a necessidade de melhorar a criação. |
| **5.2 — Como garantir um estado inicial adequado?** | Como fazer o objeto receber aquilo de que precisa no momento em que nasce? | Construir o construtor como resposta; introduzir parâmetros e `this` somente conforme a necessidade do código; comparar criação vazia e criação inicializada. | Inicializar os campos não garante, por si só, que os valores recebidos façam sentido. |
| **5.3 — Quem garante que o objeto nasce válido?** | Receber os dados no construtor já garante que o objeto é válido? | Trabalhar validação inicial e responsabilidade pelo próprio estado com invariantes simples; realizar uma transferência curta para `Reserva`, domínio ainda não usado nas aulas anteriores. | Preparar a consolidação prática no Laboratório 05 sem transformar os blocos teóricos em incrementos. |

O Laboratório 05 deve consolidar esses avanços e continuar obedecendo a `padrao-laboratorio.md`: cada incremento obrigatório modifica concretamente o código. A segmentação da aula teórica não deve ser copiada mecanicamente como estrutura do laboratório.

## Legibilidade

Legibilidade é um requisito pedagógico. A página deve permitir que o estudante compreenda a explicação, localize informações rapidamente, diferencie conceitos, exemplos, dicas e atividades e retome o conteúdo sem reler grandes blocos.

Como orientação editorial:

- usar parágrafos curtos para desenvolver ideias;
- preferir bullets para três ou mais informações independentes e listas numeradas para sequências;
- manter exemplos próximos do conceito que ilustram;
- usar títulos informativos e linguagem direta, orientada ao estudante;
- preferir poucas perguntas de alta qualidade;
- evitar repetir em prosa o que já está claro em código, tabela ou lista;
- quando uma informação normativa ou estrutural já possuir uma fonte oficial no site, referenciá-la em vez de duplicá-la extensamente na página da aula;
- reservar cada admonition para uma ideia principal e evitar paredes de texto dentro dela.

Dentro de blocos destacados, uma única ideia curta pode permanecer em uma frase. Duas ou mais informações independentes devem preferir bullets; sequências, procedimentos ou conjuntos de perguntas devem preferir enumeração. Não transformar todo conteúdo em lista, mas evitar parágrafos longos dentro de admonitions.

Essas diretrizes apoiam a clareza sem impor uniformidade artificial.

### Diagramas de referências e objetos

Quando um diagrama representar o estado de execução de um programa orientado a
objetos, usar uma notação pequena e consistente:

- representar cada objeto como um contêiner identificado por sua classe;
- mostrar dentro do contêiner somente os campos relevantes para o raciocínio;
- representar variáveis e campos que guardam referências como caixas vermelhas,
  sempre acompanhadas dos rótulos `variável`, `campo` e `referência`, para que a
  distinção não dependa apenas da cor;
- fazer cada seta partir da variável ou do campo que guarda a referência e apontar
  para o objeto acessado; nesse tipo de diagrama, a seta significa somente
  **aponta para**;
- comunicar que um campo pertence a um objeto por contenção, nunca por uma seta;
- mostrar valores primitivos como campos neutros dentro do objeto;
- omitir detalhes de memória, JVM e estado que não contribuam para a pergunta em
  discussão.

Uma visão simplificada pode omitir os campos e ligar objetos diretamente apenas
quando o grafo de objetos for o único foco. Não usá-la quando a aprendizagem
depender de distinguir variável, campo, referência e objeto.

## Narrativa e pausas didáticas

A narrativa é o estado normal da aula. Perguntas, exemplos, comparações, código e explicações pertencem ao fluxo e não recebem destaque apenas por serem perguntas ou exemplos. Sempre que fizer sentido, o texto explicita não apenas o que é verdadeiro, mas por que esse assunto se tornou necessário naquele ponto.

Uma **pausa didática** interrompe deliberadamente esse fluxo para concentrar a atenção em uma única função. A gramática oficial possui seis pausas:

| Pausa | Função | Quando usar | Quando não usar | Admonition | Cor | Ícone Lucide |
| --- | --- | --- | --- | --- | --- | --- |
| Conceito-chave | formalizar uma ideia importante à qual a narrativa chegou | depois de problema, exploração ou discussão | para abrir uma explicação ou destacar toda definição | `conceito-chave` | laranja `#F29900`, fundo `#FFF3E0` | `book-open` |
| Java em foco | explicar o mecanismo mínimo de Java necessário agora | quando a leitura ou a próxima prática depende da construção | como catálogo de sintaxe ou antecipação de linguagem | `java-focus` | azul `#4285F4`, fundo `#E8F0FE` | `code-2` |
| Atividade | suspender a próxima resposta e solicitar produção do estudante | quando haverá tempo real para prever, discutir, explicar ou construir | para toda pergunta narrativa ou seção de exercícios | `activity` | verde `#34A853`, fundo `#E6F4EA` | `pencil` |
| Dica | reduzir atrito prático sem ocupar o centro conceitual | para IDE, organização, execução e procedimentos úteis | para conteúdo conceitual indispensável | `tip` | amarelo `#FBBC05`, fundo `#FFF8E1` | `lightbulb` |
| Armadilha | explicitar um caminho plausível, seu problema e o princípio a preservar | diante de erro conceitual ou técnico recorrente | para alertas genéricos ou dificuldades improváveis | `trap` | vermelho `#EA4335`, fundo `#FCE8E6` | `triangle-alert` |
| Síntese | fechar deliberadamente uma etapa importante | ao fim de macrobloco, discussão longa ou aula | como repetição integral do conteúdo | `synthesis` | roxo `#7E57C2`, fundo `#F3E5F5` | `list-checks` |

No roteiro e no laboratório, cada admonition preserva uma única função. Elas devem permanecer raras o suficiente para terem peso; o texto sequencial continua sendo a estrutura principal.

No site, cada pausa possui a combinação fixa de nome, função, cor e ícone registrada acima. A identidade deve permanecer reconhecível nos temas claro e escuro, com contraste adequado de título, conteúdo, ícone, links e código.

### Java em foco

Java deve ser ensinado de maneira incremental e transversal. Características da linguagem, convenções e boas práticas devem ser explicadas quando surgirem naturalmente no conteúdo de POO, sem criar blocos extensos de revisão para conceitos de programação que os estudantes já possuem.

Usar `java-focus` com o título **Java em foco — assunto** para explicações curtas de linguagem, sintaxe ou convenção. Cada bloco deve tratar de um mecanismo coeso. A trilha principal continua sendo POO; “Java em foco” explica como expressar corretamente esses conceitos na linguagem.

Se o laboratório exigir que o estudante escreva uma construção Java, a aula anterior deve ter apresentado o mecanismo necessário ao menos para leitura, compreensão de sua função e uso básico. Isso não exige antecipar todo o conteúdo da linguagem.

Quando uma informação de “Java em foco” for necessária para ler o código projetado durante a aula, o deck também deve oferecer esse apoio, em versão mínima. O roteiro pode preservar a explicação mais completa. O quadro continua livre para respostas, desenhos e aprofundamentos espontâneos, mas não deve ser o único lugar de uma explicação de linguagem cuja necessidade já é conhecida.

### Conceitos-chave

Um conceito-chave não deve surgir isoladamente como definição antecipada. A narrativa cria primeiro sua necessidade por meio do problema, da discussão e da observação; quando a definição aparece, deve funcionar como fechamento reconhecível e fácil de recuperar depois.

No roteiro, usar a admonition `conceito-chave` com o título **Conceito-chave — nome** para essa formalização. Sua identidade é laranja e distinta do vermelho reservado a armadilhas. Manter o recurso raro: estado, comportamento ou outros termos não precisam receber o mesmo destaque apenas porque são importantes.

Como heurística de construção do material:

- **narrativa ou problema** → cria a necessidade;
- **Java em foco** → fornece o mecanismo mínimo da linguagem;
- **conceito-chave** → formaliza o que a turma acabou de compreender.

Essa sequência não impõe três fases rígidas a toda aula. O princípio é criar uma razão antes de apresentar o mecanismo ou a definição.

### Tom de conversa técnica

O texto deve ser rigoroso, claro, natural e próximo: uma conversa entre pessoas tentando compreender um problema juntas. A leveza nasce de transições naturais, perguntas genuínas, reconhecimento de dificuldades reais, explicações progressivas e adiamento consciente da complexidade que ainda não é necessária.

Evitar humor forçado, sarcasmo, ironia como objetivo editorial, regionalismos, gírias, memes, infantilização, tom de influencer e tentativas de parecer jovem. Não basta registrar o que é verdade: sempre que ajudar a aprendizagem, explicitar por que estamos falando disso agora.

## Princípios de uso

- A aula oferece o embasamento conceitual que será aplicado no laboratório relacionado.
- Tudo que for obrigatório no laboratório imediatamente seguinte deve ter sido preparado em uma aula anterior, inclusive mecanismos pequenos de leitura, escrita, execução e organização necessários à prática.
- Uma aula de 1h30 não precisa maximizar a quantidade de conceitos novos. Observar, comparar, prever, explicar, discutir, aplicar e transferir também conferem densidade ao encontro.
- Preferir aprofundar conceitos importantes antes de antecipar conteúdos futuros.
- A página deve ser útil tanto antes quanto depois da aula.
- O padrão deve orientar a organização do conteúdo, sem criar seções vazias apenas para cumprir o template.
- Admonitions devem destacar apenas informações semanticamente especiais, conforme o padrão visual do projeto; o conteúdo principal permanece em Markdown normal.
