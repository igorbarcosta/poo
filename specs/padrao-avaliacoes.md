# Padrão de avaliações

Este documento registra os critérios duráveis de qualidade dos instrumentos individuais escritos da disciplina. Ele complementa `projeto-pedagogico.md`: o projeto define a arquitetura da disciplina; esta spec define o que caracteriza um bom checkpoint ou uma boa prova.

A estrutura dos artefatos e os gates estão em `contrato-artefatos-avaliacoes.md`. As skills definem o processo repetível e o tooling executa validações mecânicas. Este documento não substitui julgamento nem aprovação humana.

As avaliações são materiais internos. Suas fontes, distribuições e gabaritos ficam em `avaliacoes/`, fora de `docs/`, e não integram o site público.

## Instrumentos

### Checkpoint

Checkpoint é uma avaliação curta e focal, destinada a verificar a compreensão dos conceitos e mecanismos trabalhados nas aulas mais recentes antes de a disciplina avançar.

- duração padrão: 50 minutos;
- escala bruta de correção: 0–100 pontos;
- formato físico: A4;
- material do estudante com exatamente duas páginas, planejadas para impressão frente e verso;
- margens curtas e bom aproveitamento da área útil, sem desperdício visual;
- quantidade de questões definida pelas evidências necessárias, nunca por uma meta numérica;
- quantidade de subitens e pesos não fixos; distribuir os pontos conforme a importância da evidência e o esforço cognitivo esperado;
- prioridade para os assuntos das aulas mais recentes;
- consideração dos laboratórios e das retrospectivas para determinar o que realmente foi trabalhado;
- exclusão de conteúdo ainda não introduzido.

Usar preferencialmente um único cenário principal. O cenário deve ser novo o suficiente para exigir transferência: não basta renomear estruturas de aula ou laboratório, nem repetir a mesma estrutura cognitiva de um exercício anterior trocando apenas o domínio.

### Avaliação

Avaliação é acumulativa e integrativa. Seu objetivo é medir se o estudante consegue articular os conhecimentos construídos até aquele momento, e não apenas responder tópicos isolados.

- considerar todo o conteúdo efetivamente ensinado até a avaliação;
- dar prioridade aos conceitos estruturantes da disciplina;
- integrar vários conhecimentos em problemas comuns;
- evitar uma questão independente para cada tópico;
- buscar poucas evidências fortes de compreensão;
- exigir transferência para situações não treinadas literalmente;
- usar Java como meio para expressar conceitos de POO, não como checklist sintático;
- definir duração e quantidade de páginas em cada avaliação; a escala bruta de correção permanece 0–100.

## Escala de correção

Todo checkpoint e toda avaliação usa escala bruta de **0–100 pontos**. Essa é a escala interna de correção do instrumento e não altera os pesos acadêmicos definidos em `projeto-pedagogico.md`. Os itens e subitens devem totalizar exatamente 100 pontos; criação, gabarito e revisão devem conferir explicitamente essa soma.

## Natureza das questões

As questões devem ser predominantemente objetivas e determináveis. Podem assumir estruturas diferentes conforme a evidência necessária; não há fórmula fixa de quantidade, subitens ou pesos. Formatos adequados incluem:

- múltipla escolha;
- verdadeiro ou falso;
- teste de mesa;
- completar tabela;
- prever valores ou saída;
- localizar uma linha;
- selecionar uma implementação;
- escrever uma instrução específica;
- completar um pequeno trecho de código;
- modificar um pequeno trecho de código conforme requisitos determinados.

Evitar por padrão comandos abertos como “explique”, “justifique”, “discuta”, “descreva com suas palavras” e “o que você acha”. Quando a evidência exigir produção, formular requisitos observáveis e critérios determinados.

Quando houver evidência melhor disponível, preferir microproblemas que peçam interpretação, consequência, diagnóstico ou decisão em um código ou situação concreta a perguntas puramente definicionais. Variar as operações cognitivas ao longo do instrumento: dois formatos diferentes não justificam medir essencialmente a mesma compreensão.

Uma questão de programação pode admitir múltiplas implementações corretas. A correção considera a semântica e o atendimento aos requisitos, não a correspondência literal com o código do gabarito. O gabarito deve registrar implementações equivalentes aceitáveis ou critérios de correção quando necessário.

### Múltipla escolha

Toda questão de múltipla escolha possui exatamente cinco alternativas, identificadas como **A**, **B**, **C**, **D** e **E**. Por padrão, existe exatamente uma alternativa correta.

- construir quatro distratores conceitualmente plausíveis, associados a erros reais de compreensão;
- fazer os distratores representarem interpretações, consequências ou decisões plausíveis, e não apenas código obviamente inválido ou afirmações absurdas;
- evitar alternativas absurdas, “todas as anteriores”, “nenhuma das anteriores” e pegadinhas linguísticas;
- manter estrutura gramatical, extensão e detalhamento comparáveis entre as alternativas;
- impedir que tamanho, precisão ou estilo revelem a resposta correta;
- distribuir as respostas corretas entre A–E sem padrão previsível ao longo do instrumento.

A dificuldade deve estar no conceito avaliado, não em interpretação maliciosa do enunciado.

## Legibilidade dos enunciados e do código

- usar bloco de código quando sua estrutura for relevante para compreender a questão, em vez de reconstruí-la em prosa;
- preferir enunciados concretos e operacionais, nomeando diretamente objetos, campos, métodos e ações quando isso evitar abstração ou decodificação desnecessária;
- redigir em tom direto e didático: depois de uma leitura, o estudante deve reconhecer a situação apresentada, a ação ou condição relevante e exatamente o que precisa marcar, calcular ou identificar;
- evitar comandos genéricos como “qual é a melhor solução?” ou “qual diagnóstico está correto?” quando o critério de decisão ou o resultado observável puder ser declarado diretamente;
- não comprimir nem igualar artificialmente blocos de código de tamanhos diferentes;
- preservar linhas em branco e espaçamentos que tornem visíveis os agrupamentos lógicos;
- garantir separação visual suficiente entre alternativas e entre os limites das questões, permitindo que sejam reconhecidos antes da leitura integral.

## Repertório já ensinado

Antes de finalizar o instrumento, verificar o conteúdo efetivamente ensinado nas aulas, nos laboratórios, nos materiais de Java e, quando pertinente, nas retrospectivas da oferta.

A avaliação não pode introduzir nova sintaxe, API, mecanismo de linguagem, convenção ou conceito. Preferir exatamente as formas usadas nos materiais anteriores. Se `!portaAberta` ainda não foi ensinado, usar `portaAberta == false`. Se a forma ensinada foi `andarAtual = andarAtual + 1;`, não introduzir uma abreviação somente na avaliação.

## Determinação das respostas

Toda questão deve possuir resposta determinada pelos dados e pelas regras fornecidas. Regras de domínio necessárias à solução devem ser explicitadas suficientemente; a resposta não pode depender de uma decisão de domínio omitida pelo enunciado.

Cada item deve isolar o conhecimento pretendido. Um erro incidental de identificador, membro, sintaxe, premissa ou redação não pode tornar uma alternativa correta ou uma afirmação falsa por uma razão diferente daquela que o item pretende diagnosticar.

Uma questão pode admitir diferentes implementações, desde que os requisitos e os critérios para reconhecer uma solução correta estejam claros e determinados.

## Matriz de evidências

Antes da versão final, produzir internamente uma matriz **questão → evidência de aprendizagem**. Para cada questão, responder: **que conhecimento novo esta questão permite verificar?** A matriz é artefato de planejamento do professor e não integra necessariamente a versão do estudante.

Cada questão deve ter uma evidência diagnóstica principal distinta. Conceitos podem se relacionar e um item pode mobilizar conhecimentos auxiliares, mas seu acerto ou erro deve acrescentar uma inferência própria sobre a aprendizagem.

Auditar obrigatoriamente:

- **redundância:** se acertar uma questão praticamente responde outra, redesenhar ou remover uma delas; não medir o mesmo conhecimento repetidamente apenas com formatos diferentes;
- **cobertura:** confirmar evidência suficiente para os aprendizados prioritários do escopo; cobertura não exige avaliar todo fato ensinado, mas priorizar conceitos estruturantes e variar as operações cognitivas;
- **independência:** evitar que um erro torne várias questões subsequentes impossíveis;
- **entrega de respostas:** verificar se cenário, enunciado, alternativa ou outra questão revela inadvertidamente uma resposta.

## Variantes

Todo checkpoint concluído para aplicação e toda avaliação possuem, por padrão, Variante A e Variante B. Essa distribuição só é produzida depois da aprovação humana de uma versão-base única. As variantes devem preservar:

- as mesmas competências e a mesma distribuição de pontos;
- dificuldade aproximada equivalente;
- volumes de leitura e escrita comparáveis;
- a mesma estrutura geral e o mesmo tempo esperado de resolução;
- ausência de pistas adicionais em qualquer variante.

Não produzir variantes apenas por substituição superficial de nomes ou números quando isso não altera adequadamente o problema. O gabarito deve identificar claramente as respostas de cada variante. A equivalência deve ser verificada depois de ambas serem resolvidas integralmente.

As variantes são identificação interna. O material entregue ao estudante não pode exibir “Variante A”, “Variante B”, código equivalente ou qualquer outra pista no cabeçalho, rodapé ou nome visível do instrumento. Os nomes internos dos arquivos podem preservar a variante, e o gabarito do professor deve identificá-la claramente.

## Fonte semântica e aprovação

O conteúdo de instrumentos novos é estabilizado em Markdown antes da diagramação. O blueprint precede as questões; a base aprovada é o contrato semântico das variantes; e cada transição que congela conteúdo exige decisão humana explícita. Pedidos de correção, continuidade ou melhoria não constituem aprovação.

Alterações em artefatos aprovados invalidam os gates posteriores conforme `contrato-artefatos-avaliacoes.md`. Artefatos históricos anteriores ao contrato não recebem aprovação retroativa por inferência.

## Composição do checkpoint

Em instrumentos predominantemente objetivos, preferir a macroestrutura:

**CABEÇALHO → RESPOSTAS → CENÁRIO → QUESTÕES**

Outra ordem pode ser adotada quando houver razão pedagógica ou de composição explícita. O quadro de respostas deve refletir exatamente a numeração e a subnumeração das questões e permitir correção rápida. Alternativas, verdadeiro ou falso, números, valores e resultados devem ser registrados preferencialmente nele. Quando for mais legível, código curto pode ser escrito junto à questão.

O cenário concentra o contexto e o código principal. Deve parecer visualmente uma área de referência, com arquivos e trechos claramente identificados. As questões vêm depois, com hierarquia tipográfica clara.

No checkpoint entregue ao estudante, não exibir duração nem valor máximo do instrumento. A pontuação de cada questão pode permanecer visível. O cabeçalho preferencial é tipográfico, compacto e formado por duas linhas institucionais: **IFPB - CAMPUS CAMPINA GRANDE** e **PROGRAMAÇÃO ORIENTADA A OBJETOS - [INSTRUMENTO]**, seguida pelos campos de nome e nota. Por exemplo: **PROGRAMAÇÃO ORIENTADA A OBJETOS - CHECKPOINT 1** ou **PROGRAMAÇÃO ORIENTADA A OBJETOS - AVALIAÇÃO 1**. Não incluir matrícula nem revelar variante. Se houver rodapé, usar somente paginação discreta.

A macroseção **RESPOSTAS** deve ser especialmente fácil de localizar, ler e preencher e evitar aparência de formulário administrativo. Nos instrumentos objetivos, posicioná-la por padrão logo após o cabeçalho, em um único painel de fundo cinza muito claro, com delimitação discreta, campos uniformes e agrupamento por alinhamento, espaço e tipografia. Não usar linhas verticais, bolhas ou caixas de seleção. Priorizar campos simples nos quais o estudante escreva diretamente números, valores, V/F ou letras; não exigir coluna de correção nem área adicional de nota. Essa ordem é preferencial, não absoluta: outro formato pedagógico pode exigir composição diferente.

As macroseções **RESPOSTAS**, **CENÁRIO** e **QUESTÕES** devem compartilhar uma única hierarquia tipográfica e ser imediatamente reconhecíveis ao escanear a página. Quando o cenário tiver nome, apresentá-lo preferencialmente em uma única linha, como **CENÁRIO: ELEVADOR**. Apenas a área funcional de respostas recebe painel; cenário e questões são marcados por tipografia e espaçamento. Uma única linha horizontal discreta pode separar o fim do cenário do início das questões.

As questões não exigem subtítulo temático. Preferir a forma direta **Questão X — enunciado**, com pontuação discreta. Código dentro de enunciados e alternativas deve receber tratamento visual próprio, com fonte monoespaçada, fundo neutro claro e padding suficiente para distingui-lo do texto.

## Padrão de diagramação

Usar os componentes de `avaliacoes/templates/` na geração dos derivados de impressão. LaTeX pode ser usado como formato intermediário de renderização, mas não é a fonte semântica principal dos instrumentos novos.

- papel A4;
- margens curtas, calibradas para impressão comum e bom uso da área A4;
- fonte confortável para impressão, aproximadamente 10,5 a 11 pt;
- código legível e bom aproveitamento horizontal;
- cabeçalho compacto;
- visual limpo, acadêmico e profissional;
- ausência de grandes caixas decorativas e espaços vazios desnecessários;
- espaços de resposta proporcionais ao tamanho esperado;
- legibilidade integral em impressão preto e branco ou escala de cinza.

Não usar grandes caixas decorativas nem tabelas pesadas. Destacar cenário, nomes de arquivos, questões e quadro de respostas por hierarquia, espaçamento e contraste discreto. Números de linha de código devem permanecer legíveis, mas subordinados ao código.

O código pode usar syntax highlighting discreto e funcional. Manter fundos brancos ou cinza muito claros; usar cores suaves para palavras-chave, tipos, literais e comentários somente quando preservarem contraste e significado em escala de cinza.

Adotar uma escala curta e consistente de espaçamentos para relações próximas, conteúdo interno, transições locais, separação de blocos e mudanças de macroseção. Os componentes do template devem controlar o próprio espaço anterior e posterior; evitar ajustes ad hoc espalhados pelos arquivos de cada instrumento. Todo painel de código deve reservar espaço suficiente antes e depois, sem ficar colado ao texto introdutório nem ao primeiro item subsequente.

Para checkpoints, o PDF do estudante deve ter exatamente duas páginas. Não reduzir agressivamente a fonte para forçar o conteúdo. Se o conteúdo não couber:

1. remover redundância;
2. reduzir texto desnecessário;
3. melhorar a composição;
4. ajustar espaçamentos;
5. somente por último realizar pequena redução tipográfica.

Excesso de páginas pode indicar excesso de conteúdo para 50 minutos.

## Gabarito do professor

Gerar um gabarito separado com:

- a mesma identificação do instrumento;
- respostas das variantes A e B claramente separadas;
- pontuação por item;
- critérios para respostas em código;
- implementações equivalentes aceitáveis, quando relevante;
- quadro de respostas preenchido;
- total de 100 pontos.

O gabarito pode ultrapassar duas páginas. A restrição de duas páginas aplica-se apenas a cada variante entregue ao estudante.

## Organização dos arquivos

- `avaliacoes/templates/`: estilo reutilizável, esqueletos e documentos fictícios de validação;
- `avaliacoes/checkpoints/`: fontes, PDFs e gabaritos dos checkpoints reais;
- `avaliacoes/provas/`: fontes, PDFs e gabaritos das avaliações reais.

Cada instrumento real deve ter diretório próprio e seguir `contrato-artefatos-avaliacoes.md`. Não adicionar esses arquivos a `docs/`, à navegação do Zensical ou ao fluxo de cópia de artefatos do site.
