# Regressão pedagógica de avaliações

Esta suíte documental exercita julgamentos semânticos de `criar-base-avaliacao` e `revisar-avaliacao`. Não é um teste determinístico: o agente deve classificar cada caso conforme o resultado esperado e justificar pela evidência. Os exemplos são sintéticos e não definem formatos obrigatórios para instrumentos reais.

## Protocolo

Para cada caso, aplicar a revisão local, a passagem global quando indicada e a postura adversarial. O comportamento passa quando identifica a classe de defeito ou preserva o controle positivo pela razão esperada; correspondência literal de palavras não é necessária.

## P01 — saída redundante

```java
Conta a = new Conta();
Conta b = a;
System.out.println(a == b); // S1
System.out.println(b == a); // S2
```

Duas unidades pontuam S1 e S2 separadamente.

**Esperado:** detectar ganho marginal baixo ou ausente em S2 e falha no teste de remoção, pois a segunda saída é integralmente determinada pela primeira.

## P02 — verbalização do rastreamento

Uma unidade pontua a saída de `System.out.println(x == y)`. Outra afirmação V/F pergunta se `x` e `y` apontam para o mesmo objeto, sem acrescentar contexto ou operação.

**Esperado:** detectar sobreposição relevante e dupla pontuação da mesma inferência, apesar do formato diferente.

## P03 — vazamento retroativo

Q01 pede o total após uma sequência. Q04 começa com: “Sabendo que o total obtido em Q01 é `18.0`...”.

**Esperado:** rejeitar entrega retroativa; o estudante pode ler Q04 antes de resolver Q01.

## P04 — determinação com redação confusa

Afirmação: “A permanência do argumento na entidade não se consolida como atributo após a cessação operacional do método.”

**Esperado:** identificar carga incidental de leitura e reescrever em termos diretos, mesmo que a proposição possa ser determinada após interpretação cuidadosa.

## P05 — operação abstrata em alternativa

Alternativa: “Providenciar externamente a atualização subsequente do indicador após cada ocorrência relevante.” O conceito pretendido poderia ser mostrado por `contador = contador + 1;`.

**Esperado:** apontar baixa concretude e preferir Java plausível quando o código comunicar diretamente a decisão.

## P06 — profundidade escondida por contexto distante

Uma questão pede avaliar encapsulamento, mas exige recuperar três valores de questões anteriores, lembrar duas mudanças de referência e reinterpretar uma regra apresentada no início da prova.

**Esperado:** preservar o objetivo profundo e rejeitar a recuperação distante; fornecer regra e estado mínimos junto à questão.

## P07 — regra implícita

Cinco métodos candidatos tratam valores negativos de formas diferentes, mas o enunciado pergunta apenas “qual implementação é melhor?” sem declarar quais valores são válidos.

**Esperado:** considerar a resposta indeterminada ou pedagogicamente inadequada e exigir regra de negócio explícita antes dos candidatos.

## P08 — prova sem progressão

Questões individualmente válidas aparecem nesta ordem: detalhes de acesso, sintaxe local, projeto de API, definição básica, rastreamento de referências. Cada uma introduz contexto próprio.

**Esperado:** na passagem global, detectar arco ausente, troca de contexto e aparência de coleção de exercícios; propor reorganização coerente sem inventar história.

## P09 — storytelling ornamental

O enunciado apresenta empresa, gerente, cidade, prazo e nomes de funcionários, mas a resposta depende somente de duas linhas de uma classe `Sensor`.

**Esperado:** identificar decoração narrativa e remover atores e detalhes sem função diagnóstica.

## P10 — controle positivo: questão profunda e clara

Regra: “O saldo só pode diminuir quando há valor suficiente.” São apresentados dois métodos Java curtos e plausíveis: um verifica a condição antes de alterar o campo; outro altera sem verificar. A pergunta pede qual preserva a regra e por quê em alternativa objetiva.

**Esperado:** não penalizar a questão pela demanda conceitual. Reconhecer regra explícita, código comparável, pedido imediato e baixa carga incidental.

## P11 — reapresentação desnecessária em evolução

Uma classe protegida e sua regra já foram estabelecidas. A questão seguinte reapresenta a “versão 1” completa e depois uma “versão 2” igualmente completa, embora a única mudança seja a inclusão de um método público.

**Esperado:** reconhecer dependência legítima do contexto, recomendar mostrar somente o novo método e preservar todas as novas premissas necessárias. Não exigir que o estudante tenha acertado a questão anterior.

## P12 — repetição estrutural em alternativas

Cinco alternativas repetem a mesma assinatura de método e suas chaves; apenas duas ou três linhas do corpo variam.

**Esperado:** fatorar assinatura e estrutura comuns e comparar somente os corpos, desde que cada alternativa continue determinada e legível.

## P13 — premissa apresentada tarde

Um trecho Java usa acesso de pacote. Somente depois do código aparece a premissa de que todos os arquivos pertencem ao mesmo projeto e não declaram `package`.

**Esperado:** mover a premissa para antes do primeiro código que depende dela e não repeti-la nas questões.

## P14 — representação visual inadequada

Cinco alternativas descrevem em prosa corrida diferentes implementações Java curtas e comparáveis.

**Esperado:** recomendar blocos de código visualmente separados; a correção conceitual não compensa uma representação que obriga o estudante a traduzir prosa para Java.

## P15 — controle positivo: repetição necessária

Cinco alternativas apresentam classes pequenas, mas independentes: cada uma varia assinatura, campos e fluxo de controle, e omitir qualquer parte tornaria ambíguo o comportamento analisado.

**Esperado:** preservar as implementações completas. Economia estrutural não autoriza compactar informação necessária à compreensão independente das alternativas.

## P16 — distrator fora do repertório

Uma alternativa incorreta usa um mecanismo ou uma sintaxe Java ainda não trabalhada no recorte curricular. A resposta correta pode ser reconhecida sem dominar esse recurso.

**Esperado:** rejeitar ou reescrever a alternativa. Distratores também devem pertencer ao repertório disponível e ser julgáveis pelos conceitos avaliados, não pelo desconhecimento de conteúdo futuro.

## P17 — cenário fragmentado por explicações

Premissas e comentários narrativos aparecem entre artefatos de código que poderiam ser lidos continuamente.

**Esperado:** concentrar as premissas antes do primeiro trecho de código e remover interrupções desnecessárias entre os artefatos.
