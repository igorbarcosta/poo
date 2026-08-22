---
name: revisar-material-didatico
description: Revisa materiais didáticos existentes deste repositório — Aula, Laboratório, Aula + Laboratório, deck isolado, Aula + deck ou Aula + Laboratório + deck — avaliando clareza, legibilidade, coerência pedagógica e prontidão para uso. Use quando o usuário pedir revisão, diagnóstico ou verificação de material já criado; por padrão, apenas analisar e relatar, editando somente quando houver pedido explícito para corrigir, aplicar, atualizar ou implementar ajustes.
---

# Revisar material didático

Identificar problemas reais e melhorias úteis sem promover reescrita infinita ou alterações por preferência estilística.

## Definir o modo

- Por padrão: analisar, relatar e não alterar arquivos.
- Editar somente quando o usuário pedir explicitamente para corrigir, aplicar, atualizar ou implementar ajustes.

## Consultar as fontes

1. Ler `AGENTS.md`.
2. Consultar, conforme o material revisado:
   - `specs/projeto-pedagogico.md`;
   - `specs/padrao-aula.md`;
   - `specs/padrao-laboratorio.md`;
   - `specs/padrao-slides.md`, sempre que houver slides no escopo;
   - `specs/estrutura-site.md`;
   - página anterior relacionada;
   - página seguinte relacionada, quando existir;
   - `docs/materiais/java-essencial.md`, quando houver Java envolvido.
3. Procurar em `retrospectivas/` observações relacionadas ao escopo e ler somente as entradas relevantes. Usá-las como evidência contextual, sem convertê-las automaticamente em regra ou alteração permanente.

Tratar o pedido específico como definição do escopo da revisão. Não converter decisões revisáveis observadas nos materiais em regras permanentes.

## Avaliar

### Correção conceitual e progressão

- Verificar conceitos, exemplos, simplificações excessivas e afirmações absolutas.
- Confirmar que o material depende apenas de conhecimentos já introduzidos e não antecipa conteúdo sem necessidade.
- Avaliar se o conceito nasce de um problema compreensível, se a Aula prepara o Laboratório e se o Laboratório sustenta o passo seguinte.

### Escopo e legibilidade

- Avaliar se falta aprofundamento ou se há conteúdo excessivo.
- Confirmar que Java apoia POO sem tomar o protagonismo.
- Verificar parágrafos, listas, títulos, perguntas, código e admonitions conforme as specs.
- Sinalizar paredes de texto, redundâncias e destaques sem função semântica.

Em aulas teóricas, verificar também:

- se atividades dependem desnecessariamente de discussão em dupla ou poderiam ser conduzidas coletivamente pelo professor;
- se existe tempo real de elaboração e coleta de hipóteses antes da resposta ou formalização;
- se as perguntas exigem raciocínio, em vez de apenas reproduzir o código recém-apresentado;
- se conceitos, mecanismos, dúvidas prováveis, apoios operacionais e sínteses recebem pausas didáticas somente quando sua função justifica a interrupção;
- se Peer Instruction ou trabalho em pares, quando presentes, possuem razão pedagógica explícita.

Não aplicar a restrição de dinâmica coletiva aos laboratórios: investigação conjunta, previsão compartilhada e comparação entre implementações podem ocorrer em dupla quando fizer sentido.

### Piloto de blocos didáticos nas Aulas 05–07

Ao revisar as Aulas 05, 06 ou 07 da oferta 2026.2, considerar também o piloto registrado em `specs/padrao-aula.md`:

- clareza e coerência interna dos blocos;
- duração estimada e compatibilidade do conjunto com 90 minutos;
- avanço identificável no modelo mental em cada bloco;
- continuidade causal entre os blocos e preservação do arco geral;
- presença de atividades curtas de processamento, recuperação ou aplicação;
- excesso de exposição, redundância entre blocos ou bloco sem avanço claro;
- fragmentação excessiva da página, do deck ou da narrativa;
- utilidade dos identificadores internos para manutenção e retrospectiva.

Tratar 20–30 minutos e aproximadamente três blocos como heurísticas, não critérios eliminatórios. Não reprovar automaticamente uma duração menor ou maior quando o arco conceitual for coerente. Não aplicar essa auditoria retroativamente às Aulas 01–04 nem converter o piloto em regra permanente antes da avaliação posterior à Aula 07.

### Requisitos e experimentos

Em laboratórios, conferir especialmente:

- clareza sobre o que deve acontecer;
- dados e estados iniciais definidos;
- resultados observáveis;
- informações suficientes para execução;
- valores de previsão determinados;
- critérios de conclusão alinhados à atividade;
- roteiro autossuficiente sem prescrição desnecessária da implementação.

Verificar também a estrutura dos incrementos obrigatórios:

- cada incremento representa evolução concreta e pedagogicamente significativa do programa;
- previsão, observação e análise estão integradas ao bloco prático que modifica o código;
- não há alteração artificial ou código descartável criado apenas para cumprir o formato;
- o fluxo causal entre incrementos permanece claro;
- cada incremento possui resultado observável quando isso fizer sentido.

Classificar como problema um incremento isolado que não modifica o código, não evolui a solução e apenas pede leitura, observação ou resposta quando poderia ser incorporado naturalmente a um incremento vizinho. Admitir exceção somente quando houver razão pedagógica explícita; não recomendar uma modificação artificial como correção.

Quando houver experimento, verificar se a previsão é possível e determinada, a operação está especificada e o resultado permite comparação e evidencia o conceito pretendido. Não aceitar como observável um valor que apenas é retornado, mas nunca armazenado ou apresentado.

### Java, material público e Zensical

- Verificar se somente recursos Java necessários foram introduzidos e se “Java em foco” permanece curto e contextualizado.
- Conferir coerência temporal com `java-essencial.md`, inclusive referências ao que seria ensinado futuramente.
- Identificar detalhes de planejamento interno sem utilidade para compreender, executar, verificar, aprofundar ou entregar.
- Conferir front matter, Markdown, admonitions, listas, código, links relativos e ausência de customizações desnecessárias.

### Slides no escopo

- Confirmar que o deck preserva a narrativa e a causalidade do roteiro, sem converter mecanicamente suas seções em frames.
- Verificar legibilidade a distância, densidade, tamanho e recorte do código projetado, alinhamento, contraste e composição.
- Conferir se as pausas didáticas têm função real, ocupam frames próprios e seguem `specs/padrao-slides.md`.
- Comparar o deck com o roteiro para identificar lacunas, antecipações, redundâncias ou mudanças de ênfase.
- Procurar especificamente redundância expositiva, distinguindo repetição que muda a operação cognitiva de mera reformulação da mesma explicação.
- Inspecionar os renderizados ou miniaturas disponíveis em busca de overflow, elementos cortados e geometria instável.

Não prolongar a revisão em busca de uma versão ideal. Encerrar quando não houver achados necessários ou recomendados que prejudiquem o uso real.

## Classificar os achados

Classificar cada achado relevante:

- **NECESSÁRIO:** erro conceitual, ambiguidade real, requisito inexequível, inconsistência ou problema relevante;
- **RECOMENDADO:** melhoria clara de aprendizagem, clareza ou legibilidade;
- **OPCIONAL:** preferência editorial com benefício pequeno;
- **NÃO ALTERAR:** trecho avaliado e considerado adequado.

Priorizar itens necessários e recomendados. Evitar listas extensas de opcionais. Não propor mudança apenas porque outra redação também seria possível. Quando o material estiver bom, afirmá-lo claramente.

## Relatar

Apresentar relatório conciso com:

1. avaliação geral;
2. problemas necessários;
3. melhorias recomendadas;
4. opcionais somente quando realmente úteis;
5. aspectos que devem permanecer como estão;
6. conclusão: precisa de nova rodada, pronto após ajustes pontuais ou pronto para uso.

Ao revisar Aula e Laboratório juntos, incluir coerência entre ambos, continuidade com o par anterior e ponte para o próximo passo.

## Aplicar ajustes quando solicitado

1. Modificar somente os pontos solicitados ou aprovados.
2. Evitar reestruturações não pedidas e preservar alterações preexistentes do usuário.
3. Executar `.venv/bin/zensical build` e corrigir erros.
4. Quando houver slides alterados, renderizar o deck pelo fluxo oficial e inspecionar o resultado.
5. Verificar `git diff` e `git status`.
6. Relatar arquivos alterados e resultado das validações.

Não fazer commit ou push sem solicitação explícita.
