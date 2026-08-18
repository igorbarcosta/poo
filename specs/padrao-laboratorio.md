# Padrão das páginas de laboratório

Este documento registra o padrão dos laboratórios de POO. Laboratórios são diferentes das aulas teóricas: são predominantemente práticos e aplicam o embasamento trabalhado anteriormente na aula de POO.

## Identificação

- Aulas e laboratórios possuem séries de numeração independentes.
- O nome do arquivo deve seguir o padrão `laboratorio-XX-assunto.md`.
- O título da página deve seguir o padrão `Laboratório XX — Título`.
- Não incluir data ou semestre no título do laboratório.
- Usar `material/flask-outline` no campo `icon` do front matter.

## Estrutura de referência

Cada página deve começar com uma contextualização curta. Conforme forem pertinentes, deve reunir:

- objetivos;
- indicação do nível máximo de uso de IA;
- indicação de laboratório acompanhado ou prática autônoma;
- conhecimentos ou instruções iniciais estritamente necessários;
- atividade;
- incrementos ou requisitos;
- critérios de conclusão;
- questões para reflexão;
- entrega;
- materiais relacionados.

Não criar seções vazias apenas para seguir o padrão.

## Legibilidade e roteiro público

Legibilidade é um requisito pedagógico. O roteiro público deve ajudar o estudante a compreender e executar a atividade, verificar a conclusão, aprofundar a aprendizagem e realizar a entrega.

- usar parágrafos curtos e linguagem direta;
- preferir bullets para requisitos e verificações independentes e listas numeradas para passos;
- usar títulos informativos e manter exemplos próximos das instruções relacionadas;
- preferir poucas perguntas de alta qualidade;
- apresentar critérios de conclusão objetivos e escaneáveis;
- reservar cada admonition para uma ideia principal, sem paredes de texto.

Detalhes internos de planejamento docente, como estimativas de duração de blocos e justificativas de dimensionamento, permanecem nas specs e não precisam aparecer no roteiro do estudante.

## Duração e dimensionamento

- Cada laboratório dura até 1h30.
- O núcleo obrigatório deve ser dimensionado para que um estudante típico consiga concluí-lo nesse período.
- Não aumentar artificialmente a atividade apenas para ocupar os 90 minutos.
- Desafios adicionais são oportunidades de aprofundamento para estudantes que terminarem antes. Devem ampliar ou explorar o problema sem antecipar conteúdo ainda não fundamentado.
- Desafios adicionais não integram os critérios obrigatórios de conclusão, salvo indicação explícita em outra atividade, e não devem ser usados para manter artificialmente o estudante ocupado.
- As questões finais podem preparar conceitos ou problemas que serão retomados em um encontro seguinte ou consolidar o bloco de aprendizagem que acabou de ser trabalhado.
- Em ambos os casos, devem ser poucas, relevantes e orientadas à compreensão. Não são requisitos de implementação nem precisam ser entregues, salvo indicação explícita.
- Quando funcionarem como ponte para um conteúdo seguinte, devem ser efetivamente retomadas posteriormente.

## Requisitos sem ambiguidade

O requisito deve deixar inequívoco **o que** o programa precisa fazer. Isso não significa dizer **como** o estudante deve implementar.

- **Requisito:** preciso, observável e verificável.
- **Implementação:** pode permanecer aberta quando não houver motivo pedagógico para prescrever uma estrutura específica.

Sempre que houver liberdade pedagógica de solução, essa liberdade deve ser preservada. Evitar comandos vagos como “registre um segundo item”. Preferir uma descrição que identifique os dados envolvidos e o resultado observável esperado, sem determinar desnecessariamente a organização do código.

Quando a atividade exigir um projeto configurado, o roteiro deve fornecer a preparação mínima necessária antes da implementação. Em ambientes heterogêneos, evitar dependência desnecessária de uma versão exata do Java, de uma única IDE ou da execução obrigatória pelo terminal, desde que o estudante consiga compilar e executar o projeto com uma versão compatível.

## Narrativa e pausas didáticas

O laboratório é organizado principalmente por incrementos. Não marcar cada incremento como `activity`: o próprio encontro já é uma atividade prática. No texto sequencial, perguntas, exemplos e explicações permanecem na narrativa normal.

Quando uma interrupção tiver valor real, usar a mesma gramática das aulas: `conceito-chave` (laranja), `java-focus` (azul), `activity` (verde), `tip` (amarelo), `trap` (vermelho) e `synthesis` (roxo). Cada admonition cumpre uma única função. Em laboratórios, `tip`, `java-focus` e `trap` tendem a ser especialmente úteis, mas nenhuma pausa é obrigatória.

As cores, os ícones Lucide e os requisitos de contraste nos temas claro e escuro seguem o mapeamento registrado em `padrao-aula.md`.

Informações administrativas, política de IA, acompanhamento e critérios de conclusão podem continuar usando admonitions nativas adequadas; elas não são pausas da narrativa conceitual.

## Princípios de uso

- O laboratório deve priorizar a prática e a evolução do projeto da unidade.
- Cada laboratório aplica e consolida o que foi preparado na aula teórica imediatamente anterior. Se o laboratório pedir que o estudante escreva uma construção Java, a aula anterior deve tê-la ensinado ao menos para reconhecer, ler, compreender sua função e usar no nível exigido.
- Instruções conceituais devem se limitar ao necessário para realizar a atividade.
- Critérios de conclusão devem permitir verificação objetiva sem prescrever arquitetura.
- Quando o objetivo envolver comportamento de código, o laboratório pode usar o ciclo **prever → executar → explicar**. Esse formato é especialmente útil para referências, fluxo, efeitos de alterações e leitura de código, mas não é obrigatório em todos os laboratórios.
- A página deve ser útil durante a realização e para consulta posterior.
