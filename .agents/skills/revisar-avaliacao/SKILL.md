---
name: revisar-avaliacao
description: Revisa checkpoints e avaliações já produzidos desta disciplina, auditando qualidade pedagógica, objetividade, variantes, composição visual, paginação e integridade técnica. Use quando o usuário pedir revisão, diagnóstico ou validação de um instrumento pronto; por padrão, apenas analisar e relatar, editando somente quando houver pedido explícito para corrigir, aplicar, ajustar, atualizar ou implementar.
---

# Revisar avaliação

Auditar um instrumento já construído sem promover mudanças por preferência nem duplicar o processo de criação.

## Definir o modo

- Por padrão, analisar, classificar achados e relatar sem alterar arquivos.
- Editar somente quando o usuário pedir explicitamente para corrigir, aplicar, ajustar, atualizar ou implementar.
- Tratar o pedido como limite do escopo. Não redesenhar conteúdo, regras ou composição fora dele.

## Consultar as fontes

1. Ler `AGENTS.md`, `specs/projeto-pedagogico.md` e `specs/padrao-avaliacoes.md` integralmente.
2. Identificar se o instrumento é checkpoint ou avaliação e ler a skill de criação correspondente.
3. Ler integralmente as aulas e os laboratórios do escopo.
4. Consultar retrospectivas relevantes como evidência contextual, não como regra permanente.
5. Consultar materiais de Java quando necessário para confirmar o repertório efetivamente ensinado.
6. Ler a matriz de evidências, o gabarito, os fontes `.tex` e todas as variantes disponíveis.
7. Abrir os PDFs renderizados. Para checkpoint, confirmar também o padrão de 50 minutos e a restrição de exatamente duas páginas A4 por variante do estudante.

## Auditar pedagogicamente

- Mapear cada questão ou item à informação nova que fornece sobre a aprendizagem.
- Verificar cobertura, redundância, entrega involuntária de respostas e cascata de erro.
- Confirmar transferência, adequação ao conteúdo efetivamente ensinado e ausência de sintaxe, API, mecanismo, convenção ou conceito ainda não introduzido.
- Comparar importância, esforço cognitivo, dificuldade e pontuação.
- Não sugerir alterações apenas porque outra redação ou organização também seria possível.

## Auditar objetividade

- Confirmar que toda resposta é determinada pelos dados e regras fornecidos.
- Exigir afirmações V/F inequivocamente verdadeiras ou falsas.
- Em múltipla escolha, confirmar exatamente cinco alternativas A–E e exatamente uma correta, salvo regra explícita diferente.
- Avaliar se os quatro distratores são plausíveis, se não há pegadinha linguística e se tamanho, detalhe ou redação não revelam a resposta.
- Detectar regras de domínio necessárias que tenham ficado implícitas.

## Comparar variantes

- Resolver e conferir todas as variantes com o gabarito.
- Comparar competências, pontos, dificuldade, quantidade de texto, número de linhas, densidade, tempo esperado e posição das respostas corretas.
- Detectar pistas ou vantagens acidentais e confirmar que o material do estudante não revela a variante.

## Inspecionar visualmente

Não considerar a inspeção completa com apenas log de compilação, contagem de páginas ou texto extraído. Renderizar **cada página de cada PDF do estudante como imagem e abri-la para inspeção visual**.

Para cada página, verificar:

- equilíbrio, densidade e áreas vazias sem função;
- margens, alinhamento, grid e consistência dos espaçamentos;
- hierarquia, tamanho das fontes, hifenização e quebras de linha;
- legibilidade, contraste, backgrounds e syntax highlighting;
- código inline e painéis de código, inclusive gutter, números de linha e alinhamento entre cabeçalho e corpo;
- separação entre questões e facilidade de escanear alternativas;
- clareza e usabilidade do quadro de respostas;
- elementos cortados ou próximos demais das margens;
- consistência visual entre variantes.

## Verificar tecnicamente

1. Compilar variantes e gabarito pelo fluxo do repositório.
2. Confirmar A4 e o número esperado de páginas; checkpoint do estudante deve ter exatamente duas.
3. Procurar overflow e caixas overfull ou underfull relevantes.
4. Verificar fontes, imagens, assets, links e recursos aplicáveis.
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
9. equivalência entre variantes;
10. conclusão: precisa de nova rodada, pronto após ajustes pontuais ou pronto para uso.

## Aplicar ajustes quando solicitado

Modificar apenas achados dentro do escopo autorizado, preservar alterações preexistentes e repetir as auditorias afetadas. Recompilar, renderizar novamente todas as páginas alteradas, reinspecioná-las visualmente e executar as verificações técnicas finais. Não fazer commit ou push sem solicitação explícita.
