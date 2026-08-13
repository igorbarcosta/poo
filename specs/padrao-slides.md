# Padrão dos slides

Este documento registra o padrão inicial dos decks usados nas aulas presenciais. O padrão deve evoluir a partir da experiência real com os pilotos.

## Papel dos slides

O deck é o ambiente principal de condução da aula teórica. Ele deve permitir percorrer toda a narrativa planejada sem depender do site ou de uma IDE externa para completar a explicação.

O site permanece como material completo e permanente para estudo e consulta. O quadro apoia livremente raciocínios, desenhos e explicações espontâneas, mas o deck não deve depender de um desenho obrigatório para completar a narrativa. Slides não substituem o laboratório nem a explicação do professor, e não devem resultar de uma conversão mecânica das seções da página da aula.

Ao partir de um roteiro, reconstruir a experiência da aula — problema, pergunta, previsão, comparação, descoberta, explicação, aplicação e síntese. Não usar como regra “uma seção da página = um slide”: uma seção curta pode exigir vários frames sucessivos, enquanto seções de referência podem não gerar nenhum. Cada slide deve possuir uma função clara na condução da aula.

## Densidade, narrativa e progressão

- Trabalhar uma ideia principal por slide, com pouco texto e sem listas extensas.
- Preservar a pergunta central, a progressão conceitual, os problemas que motivam os conceitos e as atividades de previsão ou discussão relevantes.
- Não reproduzir todos os objetivos, explicações, exemplos e sínteses da página da aula.
- Não estabelecer meta fixa de quantidade. Em uma aula de 90 minutos, dezenas de slides simples são aceitáveis quando representam estados sucessivos da narrativa.
- Preferir vários frames simples e progressivos a concentrar pergunta, resposta, código e explicação em uma tela carregada.
- Em previsões e atividades, apresentar primeiro a pergunta sem resposta e revelar resultado, explicação e diagrama em slides posteriores.
- Construir progressões por slides sucessivos em vez de depender de animações.

## Gramática visual

O estudante deve reconhecer a função de um frame em poucos segundos. O sistema possui três níveis distintos:

1. **Navegação narrativa:** `chapter` indica discretamente o macrobloco da investigação nos frames normais. Pode ser omitido na capa, em `section` e em `takeaway` quando a etapa já estiver óbvia.
2. **Função pedagógica:** cada frame possui exatamente uma função semântica principal.
3. **Forma de apresentação:** classes utilitárias e componentes internos organizam o conteúdo sem alterar sua função pedagógica.

As funções semânticas de frame são:

- `section`: transição entre macroblocos da narrativa;
- `question`: pergunta, previsão ou pausa de investigação, sem resposta no mesmo frame;
- `concept`: definição curta ou consolidação de uma ideia que deve ser guardada;
- `example`: código, comparação, estado de objeto ou execução simulada;
- `activity`: instrução para ação do estudante, individual ou colaborativa;
- `takeaway`: conclusão importante ou síntese de alto impacto, usada com parcimônia.

Cada frame possui exatamente uma dessas classes. A classificação responde primeiro à pergunta **“o que o aluno deve fazer neste frame?”**: pensar ou responder (`question`), compreender (`concept`), observar uma solução (`example`), executar ou discutir (`activity`), perceber uma mudança de bloco (`section`) ou fixar uma conclusão (`takeaway`). O conteúdo presente — inclusive código — não muda essa função.

Classes utilitárias descrevem somente a forma de apresentação, como `code-focus`, `compact-code` e `definition`. `definition` marca a consolidação formal de um conceito que já nasceu da investigação, sem criar uma nova função pedagógica. Estruturas como `columns`, `cards` e `sequence` organizam o conteúdo interno. Portanto, combinações como `question code-focus`, `concept definition` e `activity compact-code` são válidas; combinações como `question example`, `activity example` e `concept takeaway` não são.

Componentes internos não reutilizam nomes de tipos de frame. `key-point` é uma conclusão curta dentro de outro frame; `statement` é uma afirmação em destaque; `concept-card` agrupa uma pequena unidade conceitual. Em particular, `takeaway` identifica somente frames completos.

A Aula 03 ainda depende temporariamente dos aliases legados `central-question`, `takeaway` interno e `concept-pair`; eles permanecem no tema apenas para compatibilidade e não devem ser usados em decks novos ou revisados.

Os macroblocos devem fornecer orientação narrativa suficiente para que o estudante reconheça rapidamente em que parte da investigação está. `chapter` usa rótulos breves e estáveis, não mensagens genéricas como “Nova etapa”.

Slides da disciplina compartilham uma grade visual estável. Perguntas, conceitos, exemplos, atividades, transições e conclusões se diferenciam principalmente por sinais semânticos controlados — cor, marcador, acento e fundo — e não por mudanças arbitrárias de alinhamento, tamanho de título ou posição dos elementos.

A região superior segue a mesma ordem: marcador reservado, `chapter`, título e barra estrutural. O conteúdo começa abaixo dessa região em posição previsível. Labels adicionais aparecem somente quando agregam orientação pedagógica: “Pense antes de avançar”, “Atividade” e “Conceito-chave”.

Diferenças de composição correspondem a diferenças de função sem romper essa geometria:

- `question` usa fundo amarelo muito claro, acento lateral e marcador discreto;
- `concept` mantém título previsível, acento lateral e conteúdo curto, podendo conter um pequeno exemplo;
- `example` ancora código e estruturas à esquerda e usa o bloco escuro consistente do tema;
- `activity` usa identidade própria, marcador discreto e instruções à esquerda; tempo ou forma de trabalho aparecem somente quando pertinentes;
- `takeaway` usa fundo de destaque e é reservado para conclusões de alto valor narrativo, não para toda resposta ou recapitulação;
- `section` usa fundo forte e composição de transição, com pouco conteúdo, dentro da mesma grade.

A capa usa `section lead`: `section` fornece sua função narrativa e `lead` somente a composição de capa.

Perguntas, conceitos e atividades não dependem somente de cor: composição, marcador e acento estrutural também os distinguem. Labels são automáticos e discretos apenas em perguntas e atividades; não rotular todos os frames.

## Alinhamento e títulos

- Alinhar à esquerda títulos, listas, enumerações, instruções, código, campos, valores e comparações estruturadas.
- Usar a mesma posição, o mesmo tamanho e o mesmo peso de `h2` em todos os slides de conteúdo.
- Manter uma barra horizontal de mesma espessura, largura, posição e espaçamento abaixo de todo `h2`; apenas sua cor semântica pode variar.
- A centralização não faz parte da gramática regular. A capa é a única exceção natural quando sua composição exigir.
- Não alterar a geometria para comunicar que uma pergunta ou conclusão é mais importante.

## Paleta funcional

A paleta é inspirada, sem reproduzir identidade oficial, nas cores Google: azul `#4285F4`, vermelho `#EA4335`, amarelo `#FBBC05` e verde `#34A853`. Os fundos suaves usam azul `#E8F0FE`, vermelho `#FCE8E6`, amarelo `#FFF8E1` e verde `#E6F4EA` para preservar sobriedade, contraste e legibilidade.

- azul → compreender e consolidar conceitos; também sustenta a estrutura do deck;
- amarelo → pensar e responder perguntas, sempre com texto escuro;
- verde → fazer, executar ou discutir em atividade;
- vermelho → atenção, erro, limitação ou contraponto pontual; não constitui categoria semântica.

Exemplos usam fundo neutro e barra discreta. `section` usa azul forte; `takeaway`, azul escuro harmonizado e reservado a conclusões fortes. Cor reforça marcadores, texto e estrutura, mas nunca é o único sinal semântico.

## Código e perguntas

- Projetar código em tamanho legível e mostrar somente o trecho necessário à discussão.
- Manter o código próximo da pergunta ou do conceito correspondente.
- Em atividades de previsão, mostrar o código antes da resposta.
- Usar slides como pausas para perguntas relevantes e não responder visualmente quando a intenção for discussão.
- Quando o roteiro trouxer uma resposta ou um comentário recolhível, preservar primeiro o momento de reflexão no deck. Se for pedagogicamente útil exibir a resolução, a conclusão ou o comentário, fazê-lo em um slide posterior; algumas respostas podem permanecer apenas na discussão oral.
- Quando a pergunta depender da leitura de código, tratar o código como elemento visual principal, usando fonte significativamente grande e a área disponível.
- Dividir o código entre slides se for necessário reduzir a fonte para fazê-lo caber.
- Alinhar sempre código à esquerda, com margens consistentes e sem deixá-lo flutuar sem título ou contexto.

## Execução simulada e IDE real

Os slides podem simular fielmente arquivo ou classe, trecho e linha relevante, saída no console, resultado de expressão, mudança no estado e mensagem curta de compilação. A representação deve mostrar apenas elementos úteis à aprendizagem, sem copiar menus, tabs, ícones ou a aparência de uma IDE específica.

Reservar a IDE real para situações em que a interação com a própria ferramenta tenha valor pedagógico, como debugger, navegação relevante entre arquivos, refactoring, autocomplete em discussão, testes, execução de aplicação real ou comportamento cuja demonstração ao vivo seja parte do objetivo. Não abrir a IDE apenas para mostrar algo que o deck pode representar com clareza e fidelidade.

## Diagramas e legibilidade

- Preferir diagramas simples quando relações espaciais comunicarem melhor que o texto, especialmente entre variável, referência e objeto.
- Evitar diagramas decorativos.
- Priorizar tipografia grande, alto contraste, espaço em branco e código legível a distância.
- Dividir um slide quando for necessário reduzir demais a fonte para fazer o conteúdo caber.
- Em código, priorizar legibilidade a distância acima da sofisticação do realce de sintaxe. Identificadores, operadores, literais, palavras-chave, strings e comentários devem manter contraste adequado para projeção.

## Notas do professor

Quando suportadas de forma estável pelo formato, as notas podem registrar perguntas, respostas esperadas, cuidados conceituais e momentos de usar a IDE ou o quadro. Devem permanecer discretas, não aparecer para os estudantes e não se transformar em roteiro palavra por palavra.

## Efeitos

Priorizar slides estáticos. Animações, transições e outros efeitos só devem ser adotados posteriormente diante de uma necessidade pedagógica concreta.
