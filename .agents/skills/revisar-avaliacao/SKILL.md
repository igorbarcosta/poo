---
name: revisar-avaliacao
description: Revisa checkpoints e avaliações já produzidos desta disciplina, auditando qualidade pedagógica, objetividade, variantes, composição visual, paginação e integridade técnica. Use quando o usuário pedir revisão, diagnóstico ou validação de um instrumento pronto; por padrão, apenas analisar e relatar, editando somente quando houver pedido explícito para corrigir, aplicar, ajustar, atualizar ou implementar.
---

# Revisar avaliação

Auditar um instrumento já construído sem promover mudanças por preferência nem duplicar o processo de criação.

## Definir o modo

- Quando chamada por `criar-base-avaliacao`, operar em **modo de revisão integrada à criação**: auditar e corrigir achados necessários e recomendados que sejam objetivos e estejam dentro do blueprint aprovado. Essa chamada autoriza corrigir somente `base.md` e `auditoria-base.md`; não autoriza decisões pedagógicas, variantes, gabarito ou renderização.
- No modo integrado, fazer uma auditoria inicial e no máximo **dois ciclos de correção e nova auditoria**. Encerrar assim que não houver achados necessários ou recomendados corrigíveis autonomamente. Não corrigir itens opcionais apenas para prolongar o refinamento, não reiniciar a contagem após cada novo achado e não repetir uma correção que já falhou em resolver o mesmo problema.
- Se um problema persistir ao final do segundo ciclo, reaparecer depois de uma tentativa de correção ou exigir escolha pedagógica relevante, parar a autocorreção, preservar a melhor versão válida e relatá-lo como pendência para decisão humana. Nunca sacrificar escopo, conteúdo aprovado, legibilidade ou validade apenas para declarar convergência.
- Fora dessa chamada integrada, por padrão analisar, classificar achados e relatar sem alterar arquivos.
- Editar somente quando o usuário pedir explicitamente para corrigir, aplicar, ajustar, atualizar ou implementar.
- Tratar o pedido como limite do escopo. Não redesenhar conteúdo, regras ou composição fora dele.
- Identificar o estágio por `workflow.yaml` e validá-lo antes de editar. Enquanto a base não estiver aprovada, modificar somente `base.md` e `auditoria-base.md`. Não criar, atualizar nem sincronizar variantes, gabarito ou derivados.

## Consultar as fontes

1. Ler `AGENTS.md`, `specs/projeto-pedagogico.md`, `specs/padrao-avaliacoes.md` e `specs/contrato-artefatos-avaliacoes.md` integralmente.
2. Validar `workflow.yaml` e ler a skill responsável pelo estágio atual.
3. Ler integralmente as aulas e os laboratórios do escopo.
4. Consultar retrospectivas relevantes como evidência contextual, não como regra permanente.
5. Consultar materiais de Java quando necessário para confirmar o repertório efetivamente ensinado.
6. Ler somente os Markdown canônicos próprios do estágio. Fontes LaTeX e PDFs são derivados e só entram no escopo durante revisão de renderização.
7. Quando houver derivados, abrir os PDFs renderizados. Para checkpoint, confirmar também o padrão de 50 minutos e exatamente duas páginas A4 por exemplar do estudante.

## Auditar pedagogicamente

- Mapear cada questão ou item à informação nova que fornece sobre a aprendizagem.
- Confirmar uma evidência diagnóstica principal distinta por questão: registrar que inferência exclusiva um erro permite fazer e sinalizar questões cuja inferência principal apenas repete outra.
- Verificar cobertura, redundância, entrega involuntária de respostas e cascata de erro.
- Tratar cobertura como priorização dos conceitos estruturantes, não como obrigação de cobrar todo fato ensinado, e verificar variedade de operações cognitivas.
- Preferir, quando houver ganho de evidência, interpretação, consequência, diagnóstico ou decisão em situação concreta a recuperação puramente definicional.
- Confirmar transferência, adequação ao conteúdo efetivamente ensinado e ausência de sintaxe, API, mecanismo, convenção ou conceito ainda não introduzido.
- Comparar importância, esforço cognitivo, dificuldade e pontuação.
- Confirmar que itens e subitens totalizam exatamente 100 pontos; tratar essa escala como correção bruta, sem reinterpretar os pesos acadêmicos do projeto pedagógico.
- Não sugerir alterações apenas porque outra redação ou organização também seria possível.

## Auditar objetividade

- Confirmar que toda resposta é determinada pelos dados e regras fornecidos.
- Resolver cada item pela razão pretendida e procurar erros incidentais de identificador, membro, sintaxe, premissa ou redação que possam produzir acerto ou erro por outro motivo.
- Exigir afirmações V/F inequivocamente verdadeiras ou falsas.
- Em múltipla escolha, confirmar exatamente cinco alternativas A–E e exatamente uma correta, salvo regra explícita diferente.
- Avaliar se os quatro distratores representam interpretações ou decisões plausíveis, se não dependem apenas de invalidade óbvia, se não há pegadinha linguística e se tamanho, detalhe ou redação não revelam a resposta.
- Detectar regras de domínio necessárias que tenham ficado implícitas.
- Ler cada enunciado como um estudante: confirmar que uma primeira leitura revela a situação, a ação ou condição relevante e o tipo exato de resposta esperado. Sinalizar comandos genéricos, redação burocrática ou termos abstratos cujo critério concreto só aparece nas alternativas.

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
2. Antes da renderização, limitar a revisão aos Markdown canônicos e às validações estruturais.
3. Depois da renderização, confirmar A4 e o número esperado de páginas; checkpoint do estudante deve ter exatamente duas.
4. Procurar erros do renderer, overflow e recursos ausentes quando aplicável.
5. Executar `git diff --check` e verificar `git diff` e `git status`.

## Classificar e relatar

Classificar cada achado relevante:

- **NECESSÁRIO:** erro, ambiguidade, resposta indeterminada, inequivalência, quebra visual ou falha técnica que compromete o uso;
- **RECOMENDADO:** melhoria clara de validade, clareza, legibilidade ou operação;
- **OPCIONAL:** benefício pequeno e não necessário;
- **NÃO ALTERAR:** aspecto adequado que deve ser preservado.

Produzir relatório conciso com:

1. avaliação geral;
2. problemas necessários;
3. melhorias recomendadas;
4. opcionais somente quando úteis;
5. aspectos que devem permanecer;
6. diagnóstico pedagógico;
7. diagnóstico visual;
8. diagnóstico técnico;
9. equivalência entre variantes, quando a revisão ocorrer na fase final;
10. conclusão: precisa de nova rodada, pronto após ajustes pontuais ou pronto para uso.

## Aplicar ajustes quando solicitado

Modificar apenas achados dentro do escopo autorizado, preservar alterações preexistentes e repetir as auditorias afetadas. Antes de `base_aprovada`, a autorização para ajustar alcança somente `base.md` e `auditoria-base.md`. Recompilar e reinspecionar somente quando o estágio já possuir derivados. No modo integrado, respeitar o limite de ciclos definido em **Definir o modo**. Não registrar gate, fazer commit ou push sem autorização explícita.
