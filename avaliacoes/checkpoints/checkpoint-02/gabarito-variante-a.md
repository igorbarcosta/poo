# Gabarito comentado — Checkpoint 02 — Variante A

[Consulte a prova aplicada (PDF)](checkpoint-02-variante-a.pdf).

## Respostas

| Questão | Resposta |
| --- | --- |
| Q1 | A) `360.0`; B) `420.0`; C) `560.0`; D) `280.0`; E) `600.0`; F) `300.0`; G) `750.0` |
| Q2 | A) V; B) F; C) V; D) V; E) F |
| Q3 | C |
| Q4 | B |
| Q5 | D |
| Q6 | A |

## Q1 — Acompanhando referências e estado

`principal` e `apoio` apontam para a mesma `Locacao`, que por sua vez aponta para `compacto`. `segunda` é outra locação, mas usa o mesmo carro.

- **A) `360.0`:** `120.0 × 3`.
- **B) `420.0`:** a diária do mesmo `Carro` passou a `140.0`; `140.0 × 3`.
- **C) `560.0`:** `apoio` é um alias de `principal`; aumentar os dias leva a 4, então `140.0 × 4`.
- **D) `280.0`:** a segunda locação tem 2 dias e usa a diária atual de `140.0`.
- **E) `600.0`:** `apoioCarro` aponta para `compacto`, portanto a diária compartilhada passa a `150.0`; `150.0 × 4`.
- **F) `300.0`:** a segunda locação também consulta o mesmo carro; `150.0 × 2`.
- **G) `750.0`:** a locação compartilhada chega a 5 dias; `150.0 × 5`.

Alterar uma referência do tipo `Carro` modifica o objeto compartilhado. Criar uma nova `Locacao`, por outro lado, cria uma nova locação com quantidade de dias independente.

## Q2 — Construtores, parâmetros e encapsulamento

- **A) Verdadeira.** O campo `double` recebe seu valor padrão `0.0` quando a condição do construtor rejeita o valor negativo.
- **B) Falsa.** Ao declarar um construtor com parâmetros, a classe não recebe automaticamente um construtor sem argumentos.
- **C) Verdadeira.** Os valores passados em `new` são argumentos; os nomes da assinatura do construtor são parâmetros.
- **D) Verdadeira.** `this.valorDiaria` é o campo do objeto atual e `valorDiaria` é o parâmetro.
- **E) Falsa.** A regra deve ser preservada pelo próprio construtor e pelos métodos públicos, não apenas por `Main`.

## Q3 — Identidade

**Resposta: C.** Cada expressão `new` cria um objeto com identidade própria. Estados iguais não fazem `primeiro` e `segundo`, nem as duas locações, apontarem para o mesmo objeto.

## Q4 — Distribuição de responsabilidades

**Resposta: B.** `Fatura` coordena suas locações e pede a cada `Locacao` o valor que ela sabe calcular. Assim, não duplica a regra interna da locação.

## Q5 — Coleção e aliasing

**Resposta: D.** A lista contém três referências: `popular`, `sedan` e novamente `popular`. Após a alteração, as três diárias são pelo menos `130.0`, portanto o resultado é `3`.

## Q6 — Controle da coleção

**Resposta: A.** Retornar a lista interna permite que código externo a altere diretamente, contornando as operações de `Fatura`.
