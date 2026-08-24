---
name: revisar-avaliacao
description: Revisa checkpoints e avaliações já produzidos desta disciplina, auditando qualidade pedagógica, objetividade, variantes, composição visual, paginação e integridade técnica. Use quando o usuário pedir revisão, diagnóstico ou validação de um instrumento pronto; por padrão, apenas analisar e relatar, editando somente quando houver pedido explícito para corrigir, aplicar, ajustar, atualizar ou implementar.
---

# Revisar avaliação

Auditar um instrumento já construído sem promover mudanças por preferência nem duplicar o processo de criação.

## Definir o modo

- Quando chamada por `criar-base-avaliacao`, operar em **modo de revisão integrada à criação**: auditar e corrigir achados necessários e recomendados que sejam objetivos e estejam dentro do blueprint aprovado. Essa chamada autoriza corrigir somente as fontes `base.md` e `auditoria-base.md` e regenerar `preview/base.html`; não autoriza decisões pedagógicas, variantes, gabarito ou renderização final.
- No modo integrado, fazer uma auditoria inicial e no máximo **dois ciclos de correção e nova auditoria**. Encerrar assim que não houver achados necessários ou recomendados corrigíveis autonomamente. Não corrigir itens opcionais apenas para prolongar o refinamento, não reiniciar a contagem após cada novo achado e não repetir uma correção que já falhou em resolver o mesmo problema.
- Se um problema persistir ao final do segundo ciclo, reaparecer depois de uma tentativa de correção ou exigir escolha pedagógica relevante, parar a autocorreção, preservar a melhor versão válida e relatá-lo como pendência para decisão humana. Nunca sacrificar escopo, conteúdo aprovado, legibilidade ou validade apenas para declarar convergência.
- Fora dessa chamada integrada, por padrão analisar, classificar achados e relatar sem alterar arquivos.
- Editar somente quando o usuário pedir explicitamente para corrigir, aplicar, ajustar, atualizar ou implementar.
- Tratar o pedido como limite do escopo. Não redesenhar conteúdo, regras ou composição fora dele.
- Identificar o estágio por `workflow.yaml` e validá-lo antes de editar. Enquanto a base não estiver aprovada, modificar somente `base.md` e `auditoria-base.md`; `preview/base.html` pode apenas ser regenerado pelo comando oficial. Não criar, atualizar nem sincronizar variantes, gabarito ou derivados finais.

## Consultar as fontes

1. Ler `AGENTS.md`, `specs/projeto-pedagogico.md`, `specs/padrao-avaliacoes.md` e `specs/contrato-artefatos-avaliacoes.md` integralmente.
2. Validar `workflow.yaml` e ler a skill responsável pelo estágio atual.
3. Ler integralmente as aulas e os laboratórios do escopo.
4. Consultar retrospectivas relevantes como evidência contextual, não como regra permanente.
5. Consultar materiais de Java quando necessário para confirmar o repertório efetivamente ensinado.
6. Ler somente os Markdown canônicos próprios do estágio. Fontes LaTeX e PDFs são derivados e só entram no escopo durante revisão de renderização.
7. Quando houver derivados, abrir os PDFs renderizados. Para checkpoint, confirmar também o padrão de 50 minutos e exatamente duas páginas A4 por exemplar do estudante.

## Auditar pedagogicamente em duas passagens

### Passagem 1 — revisão local

Para cada questão e unidade corrigível:

1. Formular em uma frase o pedido antes de resolvê-lo. Se isso for difícil, sinalizar problema no enunciado.
2. Resolver e registrar evidência, ganho marginal, demanda cognitiva, carga incidental, pontos, independência e relação com outras unidades.
3. Aplicar o teste de remoção e comparar questões conceituais com inferências já exigidas por saídas ou rastreamentos pontuados.
4. Verificar clareza imediata; economias textual, contextual e estrutural; necessidade de contexto distante; qualidade das alternativas; plausibilidade do Java; e adequação da representação escolhida à evidência.
5. Simular um estudante competente: identificar raciocínio pertencente ao conceito, esforço que não pertence e possível simplificação sem perda de evidência.
6. Quando houver evolução ou alternativas com estrutura comum, perguntar se mostrar somente o delta preserva a determinação e melhora a leitura. Não compactar quando a repetição for necessária para entender propostas independentes.

Uma questão pode ser determinada e ainda falhar pedagogicamente. Profundidade é demanda conceitual, não texto longo, condições espalhadas ou decodificação linguística.

### Passagem 2 — revisão global

Depois da revisão local:

- descrever o arco da prova em uma frase e verificar se a progressão cognitiva é compreensível;
- detectar questões que caem de paraquedas, trocas de contexto desnecessárias e recuperação distante;
- distinguir storytelling funcional, que reduz carga cognitiva, de decoração narrativa sem função diagnóstica;
- percorrer a prova fora da ordem e procurar vazamentos nos dois sentidos, redundância e cascata de erro;
- verificar se o cenário é reutilizado com função, se a prova parece um instrumento único e se a dificuldade varia intencionalmente;
- confirmar que as questões mais profundas continuam fáceis de compreender;
- confirmar que premissas aparecem antes do primeiro artefato a que se aplicam; em cenários baseados em código, verificar que elas foram concentradas antes do primeiro trecho e que artefatos consecutivos não são fragmentados por explicações narrativas dispensáveis;
- confirmar que a continuidade decorre principalmente da organização e que questões próximas de implementação usam representações visualmente coerentes quando apropriado;
- distinguir dependência permitida do contexto estabelecido de dependência proibida da resposta anterior; em evoluções, verificar se apenas a mudança e as novas premissas necessárias foram reapresentadas;
- conferir cobertura, repertório ensinado, distribuição de pontos e tempo global.

Storytelling não exige história. Quando questões compartilham cenário, conceitos ou evolução de projeto, usar apenas transições mínimas que tornem clara a continuidade.

### Revisão adversarial

Não tentar confirmar que a prova está boa. Procurar a menor unidade cuja remoção, reescrita ou reorganização aumentaria materialmente clareza ou qualidade diagnóstica, sem inventar defeitos por preferência. Usar `avaliacoes/tests/regressao-pedagogica.md` como suíte comportamental e verificar se a auditoria reconheceria as classes de falha ali documentadas.

Em ambas as passagens, distinguir questão temática, evidência e subitem; confirmar transferência, conteúdo ensinado, soma de 100 pontos e ausência de sintaxe ou conceito futuro.

## Auditar objetividade

- Confirmar que toda resposta é determinada pelos dados e regras fornecidos.
- Resolver cada item pela razão pretendida e procurar erros incidentais de identificador, membro, sintaxe, premissa ou redação que possam produzir acerto ou erro por outro motivo.
- Exigir afirmações V/F inequivocamente verdadeiras ou falsas.
- Em múltipla escolha, confirmar exatamente cinco alternativas A–E e exatamente uma correta, salvo regra explícita diferente.
- Avaliar se os quatro distratores representam interpretações ou decisões plausíveis, se não dependem apenas de invalidade óbvia, se não há pegadinha linguística e se tamanho, detalhe ou redação não revelam a resposta.
- Inventariar as construções Java usadas no cenário, nos enunciados, nas alternativas corretas e em cada distrator; comparar todas com o repertório efetivamente trabalhado no recorte. Não aceitar mecanismo futuro em alternativa incorreta: o erro deve ser julgável pelos conceitos avaliados, não pelo desconhecimento de sintaxe ou recurso ainda não ensinado.
- Quando um trecho for apresentado como Java, confirmar sintaxe literal válida, inclusive operadores, aspas e caracteres visualmente semelhantes, e preferir código concreto a descrição verbal. Código impossível só é distrator aceitável quando compilação é a evidência deliberada e pertence ao repertório disponível.
- Rejeitar distrator que dependa de uma primeira parte verdadeira combinada a conclusão falsa quando isso obscurecer a concepção diagnosticada; a razão do erro deve ser clara, não traiçoeira.
- Detectar regras de domínio necessárias que tenham ficado implícitas.
- Ler cada enunciado como um estudante: confirmar que uma primeira leitura revela a situação, a ação ou condição relevante e o tipo exato de resposta esperado. Sinalizar comandos genéricos, redação burocrática ou termos abstratos cujo critério concreto só aparece nas alternativas.
- Aplicar clareza local também a cada V/F e alternativa: um estudante que domina o conteúdo deve compreender imediatamente a decisão ou afirmação. Uma frase tecnicamente determinável ainda falha se precisar ser decifrada antes do raciocínio conceitual. Exigir ações concretas, referências definidas e distratores claros e plausíveis.
- Aplicar economia em três níveis: textual, removendo palavras sem função; contextual, evitando reapresentar cenário, estado ou código ainda válidos; e estrutural, fatorando assinaturas, versões e blocos comuns quando só o delta interessa. Perguntar se remover a estrutura repetida mantém a questão determinada e mais legível; não fatorar quando a repetição sustenta a compreensão independente das alternativas.

## Comparar variantes

Executar esta seção somente depois de `base_aprovada`, durante `finalizar-avaliacao`. A ausência de variantes ou gabarito antes desse gate não é um problema.

- Resolver e conferir todas as variantes com o gabarito.
- Comparar competências, pontos, dificuldade, quantidade de texto, número de linhas, densidade, tempo esperado e posição das respostas corretas.
- Detectar pistas ou vantagens acidentais e confirmar que o material do estudante não revela a variante.

## Inspecionar visualmente

Executar esta seção somente no estágio de renderização. Não considerar a inspeção completa com apenas log de compilação, contagem de páginas ou texto extraído. Renderizar **cada página de cada PDF do estudante como imagem e abri-la para inspeção visual**.

Para cada página, verificar:

- equilíbrio, densidade e áreas vazias sem função;
- margens, alinhamento, grid e consistência dos espaçamentos;
- hierarquia, tamanho das fontes, hifenização e quebras de linha;
- legibilidade, contraste, backgrounds e syntax highlighting;
- código inline e painéis de código, inclusive gutter, números de linha e alinhamento entre cabeçalho e corpo;
- separação entre questões e facilidade de escanear alternativas;
- enunciados concretos, sem decodificação desnecessária antes de compreender a tarefa;
- uso de bloco quando a estrutura do código for relevante, evitando código descrito em prosa;
- preservação de linhas em branco e agrupamentos lógicos, sem igualar artificialmente blocos de tamanhos diferentes;
- densidade das alternativas e reconhecimento imediato de cada alternativa e dos limites entre questões, sem exigir leitura integral;
- clareza e usabilidade do quadro de respostas;
- elementos cortados ou próximos demais das margens;
- consistência visual entre variantes.

## Verificar tecnicamente

1. Executar `.venv/bin/python avaliacoes/scripts/workflow.py validate <diretório-do-instrumento>`.
2. Antes da renderização final, limitar a revisão semântica aos Markdown canônicos. Na fase da base, verificar também que `preview/base.html` corresponde à fonte, apresenta texto e código legíveis e preserva visualmente os tokens Java literais; não avaliar nele paginação A4 ou composição de aplicação.
3. Depois da renderização, confirmar A4 e o número esperado de páginas; checkpoint do estudante deve ter exatamente duas.
4. Procurar erros do renderer, overflow e recursos ausentes quando aplicável.
5. Executar `git diff --check` e verificar `git diff` e `git status`.

## Classificar e relatar

Classificar cada achado relevante:

- **NECESSÁRIO:** erro, ambiguidade, resposta indeterminada, inequivalência, quebra visual ou falha técnica que compromete o uso;
- **RECOMENDADO:** melhoria clara de validade, clareza, legibilidade ou operação;
- **OPCIONAL:** benefício pequeno e não necessário;
- **NÃO ALTERAR:** aspecto adequado que deve ser preservado.

Uma base pode ser não aprovável mesmo quando respostas, soma e estrutura estejam mecanicamente corretas. Redundância diagnóstica relevante, dupla pontuação, baixo ganho marginal, entrega de respostas, alternativas pouco claras ou complexidade incidental que obscureça o conceito são achados **NECESSÁRIOS** ou **RECOMENDADOS** conforme o impacto; não os relegar automaticamente a opcionais.

Produzir relatório conciso com:

1. avaliação geral;
2. passagem local por questão, incluindo pedido em uma frase, evidência, ganho, demanda e carga incidental;
3. passagem global, incluindo arco, coerência narrativa, contexto, vazamentos, redundâncias, dificuldade e tempo;
4. resultado da revisão adversarial;
5. problemas necessários e melhorias recomendadas;
6. opcionais somente quando úteis e aspectos que devem permanecer;
7. diagnóstico visual e técnico;
8. equivalência entre variantes, quando a revisão ocorrer na fase final;
9. conclusão: precisa de nova rodada, pronto após ajustes pontuais ou pronto para uso.

## Aplicar ajustes quando solicitado

Modificar apenas achados dentro do escopo autorizado, preservar alterações preexistentes e repetir as auditorias afetadas. Antes de `base_aprovada`, a autorização editorial alcança somente `base.md` e `auditoria-base.md`; regenerar e reinspecionar o preview depois de mudanças na base. Recompilar derivados finais somente no estágio de renderização. No modo integrado, respeitar o limite de ciclos definido em **Definir o modo**. Não registrar gate, fazer commit ou push sem autorização explícita.
