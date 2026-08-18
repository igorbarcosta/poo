# Padrão das páginas de aula

Este documento registra o padrão das aulas de POO, destinadas principalmente à fundamentação conceitual. Laboratórios possuem numeração e padrão próprios, registrados em `padrao-laboratorio.md`.

## Identificação

- O nome do arquivo deve seguir o padrão `aula-XX-assunto.md`.
- O título da página deve seguir o padrão `Aula XX — Título`.
- Não incluir data ou semestre no título da aula.
- Usar `material/school-outline` no campo `icon` do front matter.

## Estrutura

Cada página deve começar com uma breve contextualização e conter as seguintes seções obrigatórias:

- **Objetivos**
- **Conteúdo**
- **Material da aula**

Quando forem pertinentes, podem ser incluídas as seguintes seções opcionais:

- **Exemplos**
- **Atividade**
- **Para revisar**
- **Referências**

## Construção pedagógica

O roteiro é a fonte pedagógica da aula. Antes de produzir o deck, devem estar completos e validados os objetivos, as dependências, a trajetória narrativa, as pausas didáticas, a relação com o laboratório seguinte e o dimensionamento do encontro. Os slides são derivados dessa base; o deck anterior não deve substituir o trabalho de construir o roteiro.

Aula não é uma sequência de tópicos independentes. O storytelling didático estabelece causalidade: um problema produz uma observação, a observação cria uma pergunta, a pergunta exige investigação e a investigação permite formalizar uma ideia ou tomar uma decisão. Conceitos aparecem depois de existir uma necessidade compreensível para eles.

O encontro deve ser dimensionado internamente para 90 minutos, considerando explicação, leitura, previsão, espera, discussão, atividade, formalização e síntese. Esse dimensionamento orienta o projeto do material, mas não aparece como cronograma de minutos na página destinada aos estudantes.

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

Essas diretrizes apoiam a clareza sem impor uniformidade artificial.

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
