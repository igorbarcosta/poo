# Padrão dos slides

Este documento registra o padrão inicial dos decks usados nas aulas presenciais. O padrão deve evoluir a partir da experiência real com os pilotos.

## Papel dos slides

O deck é o ambiente principal de condução da aula teórica. Ele deve permitir percorrer toda a narrativa planejada sem depender do site ou de uma IDE externa para completar a explicação.

O site permanece como material completo e permanente para estudo e consulta. O quadro apoia livremente raciocínios, desenhos e explicações espontâneas, mas o deck não deve depender de um desenho obrigatório para completar a narrativa. Slides não substituem o laboratório nem a explicação do professor, e não devem resultar de uma conversão mecânica das seções da página da aula.

## Densidade, narrativa e progressão

- Trabalhar uma ideia principal por slide, com pouco texto e sem listas extensas.
- Preservar a pergunta central, a progressão conceitual, os problemas que motivam os conceitos e as atividades de previsão ou discussão relevantes.
- Não reproduzir todos os objetivos, explicações, exemplos e sínteses da página da aula.
- Não estabelecer meta fixa de quantidade. Em uma aula de 90 minutos, dezenas de slides simples são aceitáveis quando representam estados sucessivos da narrativa.
- Preferir vários frames simples e progressivos a concentrar pergunta, resposta, código e explicação em uma tela carregada.
- Em previsões e atividades, apresentar primeiro a pergunta sem resposta e revelar resultado, explicação e diagrama em slides posteriores.
- Construir progressões por slides sucessivos em vez de depender de animações.

## Código e perguntas

- Projetar código em tamanho legível e mostrar somente o trecho necessário à discussão.
- Manter o código próximo da pergunta ou do conceito correspondente.
- Em atividades de previsão, mostrar o código antes da resposta.
- Usar slides como pausas para perguntas relevantes e não responder visualmente quando a intenção for discussão.
- Quando a pergunta depender da leitura de código, tratar o código como elemento visual principal, usando fonte significativamente grande e a área disponível.
- Dividir o código entre slides se for necessário reduzir a fonte para fazê-lo caber.

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
