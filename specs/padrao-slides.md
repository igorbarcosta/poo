# Padrão dos slides

Este documento registra o padrão dos decks usados nas aulas presenciais.

## Papel dos slides

O deck é o ambiente principal de condução da aula teórica. Ele deve permitir percorrer a narrativa sem depender do site ou de uma IDE externa para completar explicações previsíveis. O site permanece como material completo e permanente; quadro e IDE apoiam situações em que sua interação tem valor pedagógico.

Quando um mecanismo de Java for necessário para compreender o código projetado ou realizar o laboratório seguinte, o deck deve oferecer o apoio mínimo de leitura e uso. “Java em foco” permanece subordinado ao problema de POO e não se transforma em catálogo de sintaxe.

Ao partir de um roteiro, reconstruir a experiência da aula — problema, pergunta, previsão, comparação, descoberta, explicação, aplicação e síntese. Não converter mecanicamente seções da página em slides.

## Fonte e distribuição

Os arquivos `slides/*.md` são a fonte da verdade. HTML e PDF em `slides/rendered/` são distribuições oficiais derivadas e versionadas; não devem ser editados manualmente. As páginas das aulas podem apontar para esses artefatos oficiais. `.slides-build/` permanece reservado a renderizações temporárias.

## Narrativa: o estado normal

O slide normal sustenta a conversa técnica. Pode conter texto, pergunta, exemplo, código, comparação, diagrama ou resposta sem receber um tipo semântico. Pergunta e exemplo fazem parte da narrativa, não são categorias visuais.

O slide normal:

- mantém alinhamento à esquerda, título padronizado e barra estrutural azul;
- usa fundo claro e estrutura discreta;
- usa `chapter` quando a orientação pelo macrobloco for útil;
- desenvolve uma ideia principal por frame;
- não recebe label semântico.

Perguntas que fazem parte da exposição permanecem neutras. Somente quando a aula realmente suspende a resposta e espera produção do estudante o frame se torna uma pausa `activity`.

## Pausas didáticas

Uma pausa didática interrompe deliberadamente a narrativa e concentra toda a atenção em uma função. Cada pausa ocupa um frame inteiro. Um frame possui no máximo uma pausa: não misturar funções, labels ou caixas de outra pausa no mesmo slide.

| Classe | Função | Quando usar | Quando não usar | Identidade |
| --- | --- | --- | --- | --- |
| `concept-key` | formalizar uma ideia importante à qual a narrativa chegou | depois de problema, exploração ou discussão | para iniciar explicação ou reunir exemplos | laranja `#F29900`, fundo `#FFF3E0`, texto `#8A4B00` |
| `java-focus` | compreender o mecanismo mínimo de Java necessário agora | quando leitura ou prática depende da construção | como catálogo ou antecipação de linguagem | azul `#4285F4`, fundo `#E8F0FE`, texto `#174EA6` |
| `activity` | pedir que o estudante produza algo antes de receber a próxima resposta | em previsão, discussão, explicação, modelagem ou código com tempo real de trabalho | para toda pergunta narrativa | verde `#34A853`, fundo `#E6F4EA`, texto `#137333` |
| `tip` | oferecer conhecimento prático complementar | para IDE, organização, compilação, execução ou procedimento | para conteúdo conceitual central | amarelo `#FBBC05`, fundo `#FFF8E1`, texto `#7A5B00` |
| `trap` | mostrar caminho tentador, problema e princípio a preservar | para erro conceitual ou técnico provável e relevante | para advertência genérica | vermelho `#EA4335`, fundo `#FCE8E6`, texto `#B3261E` |
| `synthesis` | fechar deliberadamente uma etapa importante | depois de macrobloco, discussão longa ou no encerramento | para repetir toda explicação | roxo `#7E57C2`, fundo `#F3E5F5`; `#5E35B1` em composição forte |

As pausas são mudanças de marcha e devem ser raras o suficiente para conservar peso. Depois de uma pausa, a aula volta à narrativa. Uma pausa não precisa aparecer em toda aula.

Nos roteiros e laboratórios, as representações equivalentes são as admonitions `conceito-chave`, `java-focus`, `activity`, `tip`, `trap` e `synthesis`.

## Navegação e composição

`chapter` e macroblocos respondem “onde estamos?” e não são pausas didáticas. Uma transição pode usar `section`, mas não criar um slide de seção quando o `chapter` já orientar adequadamente.

Pausas preservam a geometria básica dos slides normais: alinhamento à esquerda, posição e tamanho de título, barra horizontal, código legível e uma ideia principal. Elas mudam principalmente cor, label e intensidade.

Classes como `code-focus`, `compact-code` e `method-structure` são utilitárias e podem organizar qualquer frame sem criar uma segunda função semântica. Componentes como `columns`, `cards`, `sequence`, `statement` e `concept-card` também não definem tipo de frame.

Os aliases legados `question`, `concept`, `example`, `takeaway`, `definition`, `central-question`, `final-question` e `concept-pair` permanecem no tema apenas para compatibilidade com decks fora do escopo. Não devem ser usados em decks novos ou revisados. `section` continua disponível como navegação, não como pausa.

## Densidade e progressão

- Trabalhar uma ideia principal por slide, com pouco texto e sem listas extensas.
- Preferir frames sucessivos simples a concentrar pergunta, resposta, código e explicação.
- Em previsões e atividades, apresentar primeiro a solicitação; revelar resultado e explicação em frames narrativos posteriores.
- Não estabelecer meta fixa de quantidade. Dezenas de slides simples podem servir a uma aula de 90 minutos.
- Manter muitos slides neutros entre as pausas; as miniaturas não devem parecer um festival de cores.

## Código, diagramas e legibilidade

- Projetar somente o trecho necessário, em tamanho legível a distância.
- Dividir código entre slides se for preciso reduzir demais a fonte.
- Alinhar código à esquerda e manter o fundo escuro atual.
- Simular arquivo, trecho, console ou mensagem de compilação sem copiar a interface de uma IDE.
- Preferir diagramas simples quando relações espaciais comunicarem melhor que prosa, especialmente entre variável, referência e objeto.
- Verificar contraste, espaço em branco, geometria estável e ausência de overflow em todas as miniaturas.

## Tom

O deck acompanha o tom de conversa técnica dos roteiros: rigoroso, claro, natural e próximo. Perguntas genuínas, transições e reconhecimento de dificuldades tornam a exposição leve. Evitar humor forçado, sarcasmo, regionalismos, gírias, memes, infantilização e tom de influencer. Sempre que fizer sentido, explicitar por que o assunto aparece naquele momento.

## Notas e efeitos

Notas do professor podem registrar respostas esperadas e cuidados conceituais, sem se tornar roteiro palavra por palavra. Priorizar slides estáticos; animações ou transições só entram diante de necessidade pedagógica concreta.
