# Gabarito das variantes — Prova da Unidade 02

Material exclusivo do professor. Base aprovada; equivalência das variantes pendente de decisão humana. Vinte saídas de três pontos e oito objetivas de cinco pontos em cada versão: cem pontos. Corrigir cada subitem independentemente. Os títulos Variant A/B são identificadores do workflow.

## Variant A

### Q1

#### a)

`100`

#### b)

`7`


A recuperação atinge 100; o dano negativo é ignorado. O dano seguinte leva a zero, a recuperação válida leva a 7 e a negativa é ignorada.

### Q2

`Amuleto: 1/2`

A recarga de cinco satura em duas; o uso consome uma, restando uma carga de duas.

### Q3

#### a)

`Cajado: 2/3`

#### b)

`Poção vazia`


listar percorre a ordem de inclusão: o cajado conserva duas cargas; a poção foi consumida depois de guardada.

### Q4

#### a)

`false`

#### b)

`28`


As duas posições referem-se ao mesmo cajado. O primeiro uso gasta sua carga; o segundo recusa. Vida: 40 − 12 = 28.

### Q5

`38`

A reatribuição de escolha não troca o cajado armazenado. Vida: 50 − 12 = 38.

### Q6

#### a)

`47`

#### b)

`56`


a recebe a cura: 32 + 15 = 47. b recebe o dano: 68 − 12 = 56.

### Q7

`true`

Os casts preservam a referência ao mesmo objeto.

### Q8

#### a)

`true`

#### b)

`0`


A carga permite o uso e é consumida, mesmo com a vida já no máximo.

### Q9

#### a)

`false`

#### b)

`62`


Sem equipado, retorna false. Depois: 48 + 20 − 6 = 62; a recusa da segunda tentativa impede outro dano.

### Q10

`48`

CajadoLivre.usar substitui a sequência herdada e causa cinco de dano: 53 − 5 = 48.

### Q11

#### a)

`2`

#### b)

`1`


Somente os dois equipamentos oferecem Recarregavel; a recarga modifica o amuleto original de zero para um.

### Q12

#### a)

`96`

#### b)

`96`


Primeiro uso: 98 → 86 → 91 → 96. No segundo, a recusa do cajado se propaga e a vida permanece 96.

### Q13

Resposta: **B**.

- **A:** Métodos públicos herdados podem ser chamados; o problema é o tipo da referência.
- **B:** Usavel não oferece descrever, embora Amuleto possua a implementação herdada.
- **C:** Uma classe abstrata pode fornecer métodos concretos utilizáveis por suas subclasses.
- **D:** A atribuição de Amuleto a Usavel é válida; uma referência de interface pode guardar esse objeto.
- **E:** A disponibilidade do método é verificada em compilação, não adiada até o despacho.

### Q14

Resposta: **E**.

- **A:** Precisar dos métodos não basta para caracterizar o personagem como subtipo de inventário.
- **B:** Os métodos de Inventario continuam acessando seu próprio campo privado quando herdados.
- **C:** Composição permite delegar ao inventário, sem copiar seus métodos.
- **D:** Sobrescrever métodos não elimina a relação de subtipagem.
- **E:** A herança reutiliza, mas cria subtipagem; ter um inventário permite reutilizar por delegação.

### Q15

Resposta: **D**.

- **A:** O tipo do parâmetro afeta os argumentos aceitos, mesmo com corpo inalterado.
- **B:** Equipamento implementa Usavel; a atribuição ao campo continua válida.
- **C:** Ter a mesma assinatura não torna Pocao um subtipo de Equipamento.
- **D:** Pocao deixa de ser aceita, embora o contrato Usavel já ofereça usar.
- **E:** A restrição do parâmetro não elimina despacho dinâmico nem sobrescritas.

### Q16

Resposta: **C**.

- **A:** Saldo inicial zero: somar um e substituir por um produzem o mesmo resultado.
- **B:** As duas versões terminam no máximo três; a saturação oculta o defeito.
- **C:** Uma carga mais uma resulta em duas no original; a proposta substitui o saldo por uma.
- **D:** As duas versões terminam no máximo três; a saturação oculta o defeito.
- **E:** Recarga zero retorna antes de modificar o saldo nas duas versões.

### Q17

Resposta: **B**.

- **A:** Impedir apenas a recuperação não controla retorno nem consumo do equipamento.
- **B:** A verificação em usar, antes de aplicarEm e do consumo, protege os dois caminhos de entrada.
- **C:** A validação ocorre depois do efeito; o alvo já pode ter sido alterado.
- **D:** Interromper somente aplicarEm deixa usar consumir a carga e devolver true.
- **E:** A proteção no coordenador não cobre a chamada direta ao equipamento.

### Q18

Resposta: **A**.

- **A:** Retorna true sem dano: I passa e II falha.
- **B:** Retorna false e causa o dano esperado: I falha e II passa.
- **C:** Retorna false sem dano: os dois testes falham.
- **D:** Retorna true e causa o dano esperado sem consumir: os dois testes passam, pois não observam cargas.
- **E:** Retorna false e causa dano excessivo: os dois testes falham.

### Q19

Resposta: **B**.

- **A:** Uma subclasse concreta pode ser instanciada mesmo que sua superclasse seja abstrata.
- **B:** Orbe herda a implementação concreta; Cajado e Amuleto mantêm suas sobrescritas.
- **C:** Métodos herdados podem satisfazer os contratos das interfaces.
- **D:** Os métodos da base usam o estado privado já existente no objeto; não se duplicam campos.
- **E:** O corpo concreto na base não substitui as sobrescritas de Cajado e Amuleto.

### Q20

Resposta: **C**.

- **A:** private restringe acesso direto ao campo, mas não torna imutável o objeto devolvido.
- **B:** Devolver a referência não cria uma cópia da lista.
- **C:** O cliente pode executar add na lista real sem chamar Inventario.adicionar.
- **D:** Reatribuir uma referência externa não substitui o campo privado do inventário.
- **E:** Acrescentar à lista devolvida não exige um setter para substituir o campo.

## Variant B

### Q1

#### a)

`100`

#### b)

`9`


A recuperação atinge 100; o dano negativo é ignorado. O dano seguinte leva a zero, a recuperação válida leva a 9 e a negativa é ignorada.

### Q2

`Amuleto: 1/2`

A recarga de quatro satura em duas; o uso consome uma, restando uma carga de duas.

### Q3

#### a)

`Cajado: 1/3`

#### b)

`Poção vazia`


listar percorre a ordem de inclusão: o cajado conserva uma carga; a poção foi consumida depois de guardada.

### Q4

#### a)

`false`

#### b)

`29`


As duas posições referem-se ao mesmo cajado. O primeiro uso gasta sua carga; o segundo recusa. Vida: 41 − 12 = 29.

### Q5

`48`

A reatribuição de escolha não troca o cajado armazenado. Vida: 60 − 12 = 48.

### Q6

#### a)

`49`

#### b)

`54`


a recebe a cura: 34 + 15 = 49. b recebe o dano: 66 − 12 = 54.

### Q7

`true`

Os casts preservam a referência ao mesmo objeto.

### Q8

#### a)

`true`

#### b)

`0`


A carga permite o uso e é consumida, mesmo com a vida já no máximo.

### Q9

#### a)

`false`

#### b)

`63`


Sem equipado, retorna false. Depois: 49 + 20 − 6 = 63; a recusa da segunda tentativa impede outro dano.

### Q10

`38`

CajadoLivre.usar substitui a sequência herdada e causa cinco de dano: 43 − 5 = 38.

### Q11

#### a)

`2`

#### b)

`1`


Somente os dois equipamentos oferecem Recarregavel; a recarga modifica o amuleto original de zero para um.

### Q12

#### a)

`95`

#### b)

`95`


Primeiro uso: 97 → 85 → 90 → 95. No segundo, a recusa do cajado se propaga e a vida permanece 95.

### Q13

Resposta: **D**.

- **A:** A atribuição de Amuleto a Usavel é válida; uma referência de interface pode guardar esse objeto.
- **B:** A disponibilidade do método é verificada em compilação, não adiada até o despacho.
- **C:** Métodos públicos herdados podem ser chamados; o problema é o tipo da referência.
- **D:** Usavel não oferece descrever, embora Amuleto possua a implementação herdada.
- **E:** Uma classe abstrata pode fornecer métodos concretos utilizáveis por suas subclasses.

### Q14

Resposta: **C**.

- **A:** Os métodos de Inventario continuam acessando seu próprio campo privado quando herdados.
- **B:** Sobrescrever métodos não elimina a relação de subtipagem.
- **C:** A herança reutiliza, mas cria subtipagem; ter um inventário permite reutilizar por delegação.
- **D:** Precisar dos métodos não basta para caracterizar o personagem como subtipo de inventário.
- **E:** Composição permite delegar ao inventário, sem copiar seus métodos.

### Q15

Resposta: **E**.

- **A:** Ter a mesma assinatura não torna Pocao um subtipo de Equipamento.
- **B:** O tipo do parâmetro afeta os argumentos aceitos, mesmo com corpo inalterado.
- **C:** A restrição do parâmetro não elimina despacho dinâmico nem sobrescritas.
- **D:** Equipamento implementa Usavel; a atribuição ao campo continua válida.
- **E:** Pocao deixa de ser aceita, embora o contrato Usavel já ofereça usar.

### Q16

Resposta: **D**.

- **A:** As duas versões terminam no máximo três; a saturação oculta o defeito.
- **B:** Recarga zero retorna antes de modificar o saldo nas duas versões.
- **C:** Saldo inicial zero: somar um e substituir por um produzem o mesmo resultado.
- **D:** Uma carga mais uma resulta em duas no original; a proposta substitui o saldo por uma.
- **E:** As duas versões terminam no máximo três; a saturação oculta o defeito.

### Q17

Resposta: **A**.

- **A:** A verificação em usar, antes de aplicarEm e do consumo, protege os dois caminhos de entrada.
- **B:** A proteção no coordenador não cobre a chamada direta ao equipamento.
- **C:** Impedir apenas a recuperação não controla retorno nem consumo do equipamento.
- **D:** Interromper somente aplicarEm deixa usar consumir a carga e devolver true.
- **E:** A validação ocorre depois do efeito; o alvo já pode ter sido alterado.

### Q18

Resposta: **E**.

- **A:** Retorna true e causa o dano esperado sem consumir: os dois testes passam, pois não observam cargas.
- **B:** Retorna false e causa o dano esperado: I falha e II passa.
- **C:** Retorna false e causa dano excessivo: os dois testes falham.
- **D:** Retorna false sem dano: os dois testes falham.
- **E:** Retorna true sem dano: I passa e II falha.

### Q19

Resposta: **D**.

- **A:** O corpo concreto na base não substitui as sobrescritas de Cajado e Amuleto.
- **B:** Métodos herdados podem satisfazer os contratos das interfaces.
- **C:** Uma subclasse concreta pode ser instanciada mesmo que sua superclasse seja abstrata.
- **D:** Orbe herda a implementação concreta; Cajado e Amuleto mantêm suas sobrescritas.
- **E:** Os métodos da base usam o estado privado já existente no objeto; não se duplicam campos.

### Q20

Resposta: **A**.

- **A:** O cliente pode executar add na lista real sem chamar Inventario.adicionar.
- **B:** Acrescentar à lista devolvida não exige um setter para substituir o campo.
- **C:** Reatribuir uma referência externa não substitui o campo privado do inventário.
- **D:** Devolver a referência não cria uma cópia da lista.
- **E:** private restringe acesso direto ao campo, mas não torna imutável o objeto devolvido.
