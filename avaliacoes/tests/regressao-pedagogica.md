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

## P18 — linguagem de autor, não de aluno

Um enunciado usa expressões como “versão encapsulada”, “adaptar o cliente” ou “preservar a propriedade”, embora a mesma ideia possa ser dita concretamente com o vocabulário da disciplina.

**Esperado:** reescrever do ponto de vista do estudante, descrevendo a situação e a ação a analisar sem metalinguagem do projeto da avaliação.

## P19 — efeito implícito em verbo abstrato

O enunciado diz “rejeita o registro `-2.0`”, mas a regra observável é que valores menores ou iguais a zero não alteram o total.

**Esperado:** descrever diretamente o efeito relevante, como “`-2.0` não deve ser somado ao total”.

## P20 — questão correta, mas sem conexão narrativa

Uma questão apresenta um problema e a seguinte resolve exatamente esse problema, mas começa como exercício independente.

**Esperado:** acrescentar uma transição curta que torne explícita a evolução conceitual, sem criar dependência da resposta anterior.

## P21 — comando excessivamente seco

Uma sequência de afirmações começa apenas com “Marque V ou F”.

**Esperado:** orientar naturalmente a ação, por exemplo pedindo que o estudante analise as afirmativas e assinale as verdadeiras e falsas. Não transformar comandos simples em parágrafos longos; a melhoria deve aumentar orientação, não verbosidade.

## P22 — contrato composto comprimido

Uma múltipla escolha pede, em uma única frase, a alternativa que mantém duas referências no mesmo objeto, respeita uma regra para valor inválido, preserva duas operações públicas e produz um total específico. Cada condição é clara isoladamente.

**Esperado:** não aceitar “determinado” como sinônimo de legível. Inventariar os critérios simultâneos, simular o percurso e reorganizar situação, mudança, condições e pedido para que possam ser escaneados sem releitura.

## P23 — distratores com atalhos heterogêneos

Em uma questão cujo foco pretendido é alteração controlada, um distrator não compila, outro cria um objeto diferente, outro viola a regra de domínio e outro erra apenas uma soma.

**Esperado:** identificar modos de eliminação heterogêneos. Preservá-los somente se a integração dessas dimensões for evidência deliberada e proporcional; caso contrário, tornar os distratores comparáveis e impedir acerto por atalhos incidentais.

## P24 — falsa economia

Uma versão curta remove títulos ou separações que distinguiam “o que mudou”, “o que continua válido” e “o que marcar”. O texto tem menos palavras, mas o estudante precisa relê-lo para descobrir como começar.

**Esperado:** rejeitar a compactação. Economia textual não prevalece sobre início imediato, escaneamento e redução da memória de trabalho.

## P25 — controle positivo: questão composta bem organizada

Uma questão profunda apresenta, em ordem visível, o estado inicial, a única mudança, três critérios curtos e o comando. As alternativas são blocos comparáveis, e o estudante sabe que deve rastrear cada candidato contra os critérios.

**Esperado:** preservar a questão. Vários critérios não constituem defeito quando a organização os torna manejáveis e todos pertencem à evidência integrada.

## P26 — carga incidental sem evidência

Uma auditoria classifica uma questão como “carga incidental baixa” e “compreensível de primeira”, mas não registra estados, regras, critérios simultâneos, percurso de resolução nem resultado de escaneamento.

**Esperado:** considerar a justificativa insuficiente. Exigir inventário observável e percurso mínimo antes de concluir sobre legibilidade.

## P27 — entidade do domínio sem relação estabelecida com o programa

O cenário contém equipamentos e contratos. Uma questão começa com “A oficina oferece esta operação”, mostra um método solto e pede uma mudança na oficina, sem apresentar como ela participa do programa.

**Esperado:** reconstruir separadamente o papel narrativo da oficina, a operação mostrada e o alvo da mudança. Registrar relações que tenham sido apenas inferidas. O código pode tornar a resposta calculável sem esclarecer a apresentação; não converter automaticamente esse custo em ambiguidade de resposta. Uma classe envolvente só deve ser exigida se tiver papel no entendimento do pedido.

## P28 — acréscimo sem destino definido

O programa permite declarar tipos, criar objetos e incluir itens em um inventário. O pedido diz “Acrescente um cristal ao sistema e adapte-o”, sem indicar se pede uma classe nova, uma instância na coleção ou uma alteração no objeto recebido por um método.

**Esperado:** apontar as intervenções diferentes sustentadas pela redação e pedir que o enunciado identifique a mudança e seu destino. A independência entre questões não resolve a referência indefinida dentro da questão. Não completar o pedido usando o blueprint.

## P29 — jargão de implementação como atalho editorial

Uma questão pede selecionar um teste e começa com “Um defeito remove apenas a guarda de recarregar”. A expressão “guarda” não foi trabalhada com a turma. O trecho removido poderia ser mostrado diretamente:

```java
if (quantidade <= 0) {
    return;
}
```

**Esperado:** descrever a ação concreta sobre o método, informar que o restante permanece igual e mostrar o trecho. Preservar a tarefa de descobrir o teste discriminante, sem explicar antecipadamente qual entrada revela o efeito da remoção.

## P30 — reparo narrativo que não resolve a dúvida registrada

A revisão registra que falta saber que parte do programa deve mudar. A correção apenas acrescenta “A oficina é um local do jogo onde se recarregam itens”. O registro passa a declarar que a dúvida foi resolvida.

**Esperado:** conferir a correção contra a dúvida original. Definir um lugar do jogo não identifica por si só uma classe, método, parâmetro ou coleção a alterar. Exigir o trecho revisado que apresenta a relação pertinente, sem demandar que todo lugar ou objeto do domínio tenha uma classe própria. Preservar divergências de leitura e não afirmar validação independente quando um leitor apenas recuperou a intenção por inferência.

## P31 — controle positivo: extensão local explicitamente apresentada

Somente nesta questão, uma nova versão do programa terá a classe `Oficina`, responsável por recarregar objetos. O método apresentado pertence a essa classe e inicialmente recebe `Equipamento`. A mesma versão terá a classe `Cristal`, com estado próprio e operações de recarga, fora da hierarquia de `Equipamento`. A pergunta pede quais declarações permitem ao método receber as duas famílias.

**Esperado:** reconhecer que a relação com o programa, a introdução local dos tipos e o alvo da mudança estão apresentados. Não exigir que as duas classes já existam no cenário comum, nem descrever antecipadamente qual interface e qual parâmetro resolvem o problema.

## P32 — controle positivo: comparação de versões com enunciado curto

O cenário fornece `Equipamento.recarregar`. A questão informa que o trecho mostrado foi apagado desse método, que o restante não mudou e que cada alternativa começa com `new Cajado(2)`. Pergunta qual teste passa na versão original e falha após a remoção.

**Esperado:** preservar a concisão: método afetado, mudança, estado inicial e resposta solicitada estão determinados. Não acrescentar personagem narrativo, uma explicação do efeito sobre valores negativos ou uma história de depuração. O raciocínio para selecionar o teste é a dificuldade pretendida.

## P33 — pergunta determinada, mas pouco direta

Uma questão apresenta `Personagem extends Inventario` para reutilizar métodos e pergunta “Qual avaliação considera a relação entre os objetos e o reaproveitamento dessas operações?”. Duas alternativas incorretas repetem a ideia de que a composição exige duplicação, uma da lista e outra das regras; a correta é visivelmente mais completa e construtiva.

**Esperado:** avaliar a orientação ao estudante e o ganho marginal dos distratores, mesmo que o pedido possa ser reconstruído e haja resposta única. Identificar o trecho abstrato, a possível proximidade entre alternativas e a diferença de apresentação; avaliar se as razões realmente se distinguem antes de propor uma mudança. Uma reformulação deve indicar concretamente que compreensão melhora e preservar a decisão pedagógica.

## P34 — controle positivo: paráfrase sem ganho demonstrado

Uma questão informa que um trecho de `Equipamento.recarregar` foi removido, que o restante permanece igual e que cada teste começa com um cajado novo. Ela pede o teste que passa antes e falha depois. Uma revisão propõe trocar “Durante uma alteração...” por “Uma alteração foi feita...”, alegando que agora a comparação ficou contextualizada.

**Esperado:** reconhecer que a situação e a comparação já foram apresentadas. Não afirmar melhoria de contexto sem mostrar informação nova ou redução concreta de dificuldade; preservar o original se a diferença for apenas preferência estilística. Uma sugestão opcional de estilo deve ser identificada como tal, sem ser registrada como defeito ou correção necessária.

## P35 — mudança sem ponto de partida para o leitor

O cenário mostra um personagem que equipa um item, mas ainda não possui inventário. Uma questão começa com “Cada personagem terá um inventário” e pede avaliar uma proposta de herança para reutilizar métodos. A resposta pode ser determinada, porém a abertura não orienta o leitor sobre a passagem do código atual para a necessidade nova.

**Esperado:** considerar uma transição breve que recupere o que o personagem já faz, apresente a necessidade de guardar itens e só então situe a proposta a avaliar. Não exigir história adicional em questões cujo código e pedido já situem a tarefa; não antecipar a escolha entre herança e composição.
