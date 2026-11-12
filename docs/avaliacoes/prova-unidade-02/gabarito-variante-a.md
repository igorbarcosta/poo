# Gabarito comentado — Prova da Unidade 02 — Variante A

[Consulte a prova (PDF)](prova-unidade-02-variante-a.pdf).

## Respostas

| Questão | Resposta |
| --- | --- |
| Q1 | a) `100`; b) `7` |
| Q2 | `Amuleto: 1/2` |
| Q3 | a) `Cajado: 2/3`; b) `Poção vazia` |
| Q4 | a) `false`; b) `28` |
| Q5 | `38` |
| Q6 | a) `47`; b) `56` |
| Q7 | `true` |
| Q8 | a) `true`; b) `0` |
| Q9 | a) `false`; b) `62` |
| Q10 | `48` |
| Q11 | a) `2`; b) `1` |
| Q12 | a) `96`; b) `96` |
| Q13 | B |
| Q14 | E |
| Q15 | D |
| Q16 | C |
| Q17 | B |
| Q18 | A |
| Q19 | B |
| Q20 | C |

Q1–Q12 reúnem vinte saídas de três pontos; Q13–Q20 valem cinco pontos cada. Total: 100 pontos. Cada questão é independente. As classes e alterações locais valem apenas na questão em que aparecem.

## Q1 — Limites e entradas ignoradas

### a)

`100`

### b)

`7`


A recuperação atinge 100; o dano negativo é ignorado. O dano seguinte leva a zero, a recuperação válida leva a 7 e a negativa é ignorada.

Acompanhe a vida após cada chamada, aplicando o limite naquele momento. Uma quantidade negativa é ignorada pela guarda; ela não inverte a operação. Recuperar vida depois de chegar a zero continua permitido pelo código apresentado.

## Q2 — Recarga, teto e consumo

`Amuleto: 1/2`

A recarga de cinco satura em duas; o uso consome uma, restando uma carga de duas.

A recarga primeiro soma e depois limita o saldo ao máximo. O uso seguinte consome uma carga. O texto impresso reúne o saldo atual e a capacidade máxima, que são informações diferentes.

## Q3 — A coleção conserva referências

### a)

`Cajado: 2/3`

### b)

`Poção vazia`


listar percorre a ordem de inclusão: o cajado conserva duas cargas; a poção foi consumida depois de guardada.

A lista guarda referências, não fotografias do estado dos itens. Quando um item é usado depois de ser adicionado, `listar()` consulta o estado atualizado desse mesmo objeto.

## Q4 — Compartilhamento de cargas

### a)

`false`

### b)

`28`


As duas posições referem-se ao mesmo cajado. O primeiro uso gasta sua carga; o segundo recusa. Vida: 40 − 12 = 28.

Adicionar duas vezes a mesma referência não duplica o equipamento. A primeira chamada altera o saldo compartilhado; a segunda encontra o resultado dessa alteração.

## Q5 — Variável local e campo são independentes

`38`

A reatribuição de escolha não troca o cajado armazenado. Vida: 50 − 12 = 38.

O campo do personagem recebeu a referência existente no momento de `equipar`. Atribuir outro objeto à variável local não executa uma nova chamada a `equipar` nem altera esse campo.

## Q6 — Cada chamada altera seu alvo

### a)

`47`

### b)

`56`


a recebe a cura: 32 + 15 = 47. b recebe o dano: 68 − 12 = 56.

Antes de calcular, identifique o objeto recebido como argumento de cada chamada. A referência do item e a referência do alvo têm funções distintas: o item executa a operação, e o alvo recebe a alteração de vida.

## Q7 — Casts preservam a identidade

`true`

Os casts preservam a referência ao mesmo objeto.

Um cast muda a forma de tratar uma referência, sem criar outro objeto. A comparação com `==` verifica se as referências alcançam a mesma instância.

## Q8 — Sucesso do uso e efeito na vida

### a)

`true`

### b)

`0`


A carga permite o uso e é consumida, mesmo com a vida já no máximo.

O método verifica a disponibilidade de carga, aplica o efeito e consome a carga. Ele não exige que a vida tenha mudado para devolver `true`; o limite de vida é aplicado pelo personagem.

## Q9 — O retorno controla a continuação

### a)

`false`

### b)

`62`


Sem equipado, retorna false. Depois: 48 + 20 − 6 = 62; a recusa da segunda tentativa impede outro dano.

A primeira tentativa não tem item equipado. Depois, a poção só permite um uso: o primeiro `if` aplica a cura e executa seu corpo; no segundo, a recusa impede tanto a cura quanto o dano escrito no corpo do `if`.

## Q10 — A sobrescrita define o caminho executado

`48`

CajadoLivre.usar substitui a sequência herdada e causa cinco de dano: 53 − 5 = 48.

O tipo declarado `Equipamento` permite chamar `usar`, mas o objeto é um `CajadoLivre`. Sua sobrescrita executa o corpo completo apresentado na questão; o corpo herdado não é chamado automaticamente. Por isso, começar com zero cargas não bloqueia esse uso.

## Q11 — Interfaces expressam capacidades

### a)

`2`

### b)

`1`


Somente os dois equipamentos oferecem Recarregavel; a recarga modifica o amuleto original de zero para um.

O `instanceof` verifica cada objeto da lista. A poção não oferece recarga; amuleto e cajado oferecem. O cast permite chamar o contrato identificado, e a recarga modifica o próprio objeto que também é alcançado pela variável `amuleto`.

## Q12 — Composição e propagação da recusa

### a)

`96`

### b)

`96`


Primeiro uso: 98 → 86 → 91 → 96. No segundo, a recusa do cajado se propaga e a vida permanece 96.

Cada camada chama sua base antes de curar. No primeiro uso, o cajado causa dano e, na volta das chamadas, cada camada acrescenta sua cura. Na tentativa seguinte, `false` percorre as camadas e faz cada uma retornar antes da cura.

## Q13 — Tipo declarado e operações disponíveis

Resposta: **B**.

- **A:** Métodos públicos herdados podem ser chamados; o problema é o tipo da referência.
- **B:** Usavel não oferece descrever, embora Amuleto possua a implementação herdada.
- **C:** Uma classe abstrata pode fornecer métodos concretos utilizáveis por suas subclasses.
- **D:** A atribuição de Amuleto a Usavel é válida; uma referência de interface pode guardar esse objeto.
- **E:** A disponibilidade do método é verificada em compilação, não adiada até o despacho.

A análise tem duas etapas: a atribuição é válida porque o objeto implementa `Usavel`; a chamada é rejeitada porque esse tipo declarado não oferece `descrever`. O despacho dinâmico só escolhe uma implementação depois que a chamada é aceita pelo compilador.

## Q14 — Herança e composição

Resposta: **E**.

- **A:** Precisar dos métodos não basta para caracterizar o personagem como subtipo de inventário.
- **B:** Os métodos de Inventario continuam acessando seu próprio campo privado quando herdados.
- **C:** Composição permite delegar ao inventário, sem copiar seus métodos.
- **D:** Sobrescrever métodos não elimina a relação de subtipagem.
- **E:** A herança reutiliza, mas cria subtipagem; ter um inventário permite reutilizar por delegação.

Reutilizar operações e estabelecer uma relação de subtipagem são decisões diferentes. Com um campo `Inventario`, o personagem pode delegar tarefas ao colaborador sem passar a ser utilizável como um inventário.

## Q15 — O parâmetro define os argumentos aceitos

Resposta: **D**.

- **A:** O tipo do parâmetro afeta os argumentos aceitos, mesmo com corpo inalterado.
- **B:** Equipamento implementa Usavel; a atribuição ao campo continua válida.
- **C:** Ter a mesma assinatura não torna Pocao um subtipo de Equipamento.
- **D:** Pocao deixa de ser aceita, embora o contrato Usavel já ofereça usar.
- **E:** A restrição do parâmetro não elimina despacho dinâmico nem sobrescritas.

A compatibilidade do argumento é verificada pelo tipo declarado e pelo contrato do parâmetro. Restringir o parâmetro a `Equipamento` exclui outros implementadores de `Usavel`, mesmo que ofereçam a operação necessária ao corpo do método.

## Q16 — Um teste precisa revelar o defeito

Resposta: **C**.

- **A:** Saldo inicial zero: somar um e substituir por um produzem o mesmo resultado.
- **B:** As duas versões terminam no máximo três; a saturação oculta o defeito.
- **C:** Uma carga mais uma resulta em duas no original; a proposta substitui o saldo por uma.
- **D:** As duas versões terminam no máximo três; a saturação oculta o defeito.
- **E:** Recarga zero retorna antes de modificar o saldo nas duas versões.

Compare a execução original e a alterada com os mesmos dados. Um teste só detecta essa alteração quando seus resultados observados diferem. Saldo zero e saturação no máximo podem fazer as duas implementações coincidir.

## Q17 — A guarda deve proteger todos os caminhos

Resposta: **B**.

- **A:** Impedir apenas a recuperação não controla retorno nem consumo do equipamento.
- **B:** A verificação em usar, antes de aplicarEm e do consumo, protege os dois caminhos de entrada.
- **C:** A validação ocorre depois do efeito; o alvo já pode ter sido alterado.
- **D:** Interromper somente aplicarEm deixa usar consumir a carga e devolver true.
- **E:** A proteção no coordenador não cobre a chamada direta ao equipamento.

Liste os dois caminhos de entrada: chamada direta ao equipamento e chamada pelo personagem. A condição precisa ser verificada antes do efeito e do consumo, em um ponto comum aos dois caminhos.

## Q18 — Cada teste observa uma propriedade

Resposta: **A**.

- **A:** Retorna true sem dano: I passa e II falha.
- **B:** Retorna false e causa o dano esperado: I falha e II passa.
- **C:** Retorna false sem dano: os dois testes falham.
- **D:** Retorna true e causa o dano esperado sem consumir: os dois testes passam, pois não observam cargas.
- **E:** Retorna false e causa dano excessivo: os dois testes falham.

Analise separadamente o retorno booleano e a vida final. Um teste que observa apenas uma dessas propriedades pode passar com a outra incorreta. Os dois testes também não verificam o saldo de cargas; passar neles não demonstra que todo o comportamento está correto.

## Q19 — Implementação herdada e sobrescritas

Resposta: **B**.

- **A:** Uma subclasse concreta pode ser instanciada mesmo que sua superclasse seja abstrata.
- **B:** Orbe herda a implementação concreta; Cajado e Amuleto mantêm suas sobrescritas.
- **C:** Métodos herdados podem satisfazer os contratos das interfaces.
- **D:** Os métodos da base usam o estado privado já existente no objeto; não se duplicam campos.
- **E:** O corpo concreto na base não substitui as sobrescritas de Cajado e Amuleto.

Uma subclasse concreta pode aproveitar a implementação concreta herdada para cumprir um contrato. Quando outra subclasse já sobrescreve o método, essa implementação própria continua sendo escolhida para seus objetos.

## Q20 — Encapsulamento de uma coleção mutável

Resposta: **C**.

- **A:** private restringe acesso direto ao campo, mas não torna imutável o objeto devolvido.
- **B:** Devolver a referência não cria uma cópia da lista.
- **C:** O cliente pode executar add na lista real sem chamar Inventario.adicionar.
- **D:** Reatribuir uma referência externa não substitui o campo privado do inventário.
- **E:** Acrescentar à lista devolvida não exige um setter para substituir o campo.

O modificador `private` protege o acesso direto ao campo. Se um método devolve a própria lista mutável, o cliente ganha uma referência capaz de alterar seu conteúdo e pode contornar as verificações de `adicionar`.
