---
name: criar-base-avaliacao
description: Cria e refina a prova-base em Markdown de um checkpoint ou prova com blueprint aprovado, sem gerar variantes nem iniciar diagramação final.
---

# Criar base de avaliação

Transformar um blueprint aprovado em uma fonte semântica completa e auditada.

## Confirmar o gate

1. Ler `AGENTS.md`, as duas specs de avaliações e o diretório do instrumento.
2. Executar `workflow.py validate` e confirmar que `blueprint_aprovado` está íntegro.
3. Recusar a etapa se o hash divergir ou se a aprovação humana não estiver registrada.

## Planejar antes de redigir

Registrar o planejamento em `auditoria-base.md` ou em rascunho interno descartável. Não começar preenchendo os formatos ou a quantidade de questões do blueprint.

### A. Mapa de evidências

1. Listar evidências ainda necessárias, eixo, demanda cognitiva e pontos.
2. Marcar evidências já obtidas por outras unidades, sobreposições possíveis e lacunas.
3. Perguntar **o que ainda precisamos descobrir sobre a compreensão do estudante?** Somente depois escolher onde e como coletar cada evidência.

### B. Plano narrativo

Descrever em uma frase o arco da avaliação e registrar, para cada questão, papel na progressão, contribuição nova, relação com o que vem antes e depois, contexto reutilizado e necessidade real de transição. Storytelling pedagógico é continuidade que reduz troca de contexto; não adicionar atores, histórias ou texto ornamental. Ordenar premissas semanticamente necessárias antes do primeiro código ou artefato a que se aplicam. Em cenários baseados em código, concentrar essas premissas antes do primeiro trecho e preservar a leitura contínua dos artefatos, sem explicações narrativas intercaladas quando não forem semanticamente necessárias.

Distinguir **dependência de contexto**, permitida quando reaproveita informação estabelecida e reduz repetição, de **dependência de resposta**, proibida quando o acerto anterior é necessário. Em evoluções de código ou API, aplicar o princípio do delta: apresentar somente a mudança proposta e as novas informações necessárias, sem reconstruir a solução anterior.

### C. Contrato local da questão

Antes do enunciado final, definir: evidência, papel narrativo, ação esperada do estudante, forma mais simples de obter a evidência, demanda conceitual, carga incidental desejada, dependências, sobreposição e justificativa do formato. Escolher explicitamente a representação mais legível — prosa, expressão Java, bloco curto, comparação de corpos de método ou regra com alternativas — e buscar coerência visual entre questões próximas quando os objetivos permitirem. Quando houver regra de negócio e decisão de implementação, preferir **regra explícita → código candidato → decisão**.

Não declarar a carga incidental apenas como baixa, média ou alta. Registrar um pequeno orçamento de coordenação: estados, referências, mudanças, regras, critérios simultâneos e recuperações distantes que o estudante precisa manter ativos. Não há limite numérico universal; o inventário serve para revelar congestionamento que uma classificação intuitiva esconderia.

Esboçar o percurso mínimo de resolução: primeira ação, informações consultadas, decisões intermediárias e resposta. Se o primeiro passo não for evidente após uma leitura, ou se vários critérios independentes estiverem comprimidos no comando, reorganizar o enunciado em blocos funcionais. Preservar concisão, mas não remover orientação útil.

Escrever para o estudante que realizará a avaliação, não para quem projeta ou audita o instrumento. Usar o vocabulário trabalhado nas aulas e descrever mudanças de estado e efeitos de forma concreta. Evitar metalinguagem como “adaptar o cliente”, “versão encapsulada” ou “preservar a propriedade” quando a consequência observável puder ser dita diretamente. Se o estudante precisar traduzir uma expressão antes de começar o raciocínio, reescrevê-la sem entregar a resposta.

### D. Autocrítica local

Antes de aceitar cada questão, responder:

1. O que exatamente o estudante precisa fazer?
2. O que a resposta permite inferir?
3. O pedido é entendido na primeira leitura por quem conhece o conteúdo?
4. A dificuldade está no conceito ou na redação?
5. Existe formulação mais curta e concreta?
6. A unidade repete evidência já coletada?
7. Entrega ou recebe resposta de outra questão?
8. Código comunicaria melhor que prosa?
9. A regra necessária aparece antes das alternativas?
10. A questão se conecta naturalmente à progressão?
11. Cenário, estado ou código já estabelecidos estão sendo reapresentados sem necessidade?
12. Se a estrutura repetida for removida e apenas a diferença for mostrada, a questão continua determinada e mais fácil de compreender?
13. O texto soa como orientação natural de professor ou como documentação do instrumento?
14. Quando a questão continua uma evolução, ficam claros o ponto atual, a mudança e o que deve ser analisado?
15. Qual é o primeiro passo de resolução e ele é evidente sem reler o comando?
16. Quantas condições ou estados precisam ser coordenados simultaneamente, e a organização visual torna isso manejável?
17. Os distratores exigem o mesmo tipo principal de julgamento ou permitem atalhos por erros incidentais heterogêneos?

## Produzir e conferir a base

1. Criar `base.md` segundo o contrato e manter identificadores `QXX`. Pedidos corrigíveis independentes usam subitens; a fonte contém somente informação semântica.
2. Completar em `auditoria-base.md` a matriz por unidade, o plano narrativo, os contratos locais e a resolução interna.
3. Reaplicar a matriz e o teste de remoção. Comparar unidades verbais com rastreamentos já pontuados e percorrer a prova fora da ordem para detectar entrega retroativa.
4. Aplicar três níveis de economia: **textual**, removendo palavras sem função; **contextual**, não reapresentando cenário, estado ou código ainda válidos; e **estrutural**, fatorando cabeçalhos, versões e blocos idênticos quando somente a diferença é avaliativa. Separar demanda conceitual de carga incidental. Em alternativas de implementação, usar blocos Java curtos, comparáveis e plausíveis; preservar repetição somente quando ela for necessária para que cada alternativa seja entendida de forma independente.
5. Inventariar cada construção Java do cenário, dos enunciados e de todas as alternativas. Exigir sintaxe Java literal válida e repertório já trabalhado em alternativas corretas e distratores; uma alternativa errada deve ser julgável pelo conceito avaliado, não pelo desconhecimento de mecanismo futuro.
6. Gerar `preview/base.html` com `npm run avaliacoes:preview -- generate <diretório>` e abri-lo para inspeção editorial. Além de confirmar operadores e tokens, verificar por questão se situação, mudança, pedido e critérios são reconhecíveis por escaneamento antes da leitura integral das alternativas. O preview é derivado e não simula páginas finais.
7. Não produzir variantes, gabarito, LaTeX, PDF ou elementos finais de aplicação.
8. Usar `revisar-avaliacao` no modo integrado: auditoria inicial e no máximo dois ciclos de correção objetiva. Depois de cada correção, regenerar o preview.
9. Executar `npm run avaliacoes:preview -- check <diretório>`, `workflow.py validate` e as verificações de diff.

Ao criar ou revisar questões, usar os casos sintéticos de `avaliacoes/tests/regressao-pedagogica.md` como regressão comportamental. Eles não substituem julgamento humano nem são validações determinísticas.

Encerrar com a base aguardando aprovação humana. Registrar `base_aprovada` somente depois de decisão explícita. A aprovação congela `base.md` e `auditoria-base.md`; qualquer mudança posterior invalida esse gate e os seguintes.
