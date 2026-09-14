# Gabarito comentado — Checkpoint 02 — Variante B

[Consulte a prova aplicada (PDF)](checkpoint-02-variante-b.pdf).

## Respostas

| Questão | Resposta |
| --- | --- |
| Q1 | A) `200.0`; B) `220.0`; C) `440.0`; D) `330.0`; E) `360.0`; F) `270.0`; G) `450.0` |
| Q2 | A) F; B) V; C) F; D) V; E) V |
| Q3 | B |
| Q4 | C |
| Q5 | E |
| Q6 | C |

## Q1 — Acompanhando referências e estado

`principal` e `apoio` apontam para a mesma `Locacao`, que aponta para `hatch`. `segunda` é outra locação, mas também consulta o mesmo carro.

- **A) `200.0`:** `100.0 × 2`.
- **B) `220.0`:** a diária compartilhada passou a `110.0`; `110.0 × 2`.
- **C) `440.0`:** `apoio` é um alias de `principal`; aumentar dois dias leva a 4, então `110.0 × 4`.
- **D) `330.0`:** a segunda locação tem 3 dias e consulta a diária atual de `110.0`.
- **E) `360.0`:** `referencia` aponta para o mesmo carro e altera a diária para `90.0`; `90.0 × 4`.
- **F) `270.0`:** a segunda locação também usa esse carro; `90.0 × 3`.
- **G) `450.0`:** a locação compartilhada chega a 5 dias; `90.0 × 5`.

A variante preserva a mesma relação conceitual: aliases compartilham o estado do carro e da locação, enquanto a quantidade de dias pertence a cada objeto `Locacao`.

## Q2 — Construtores, parâmetros e encapsulamento

- **A) Falsa.** Declarar um construtor com parâmetros impede a geração automática de um construtor sem argumentos.
- **B) Verdadeira.** `this.valorDiaria` identifica o campo e `valorDiaria` identifica o parâmetro.
- **C) Falsa.** A regra precisa estar no construtor ou nos métodos da classe; outro código não fica protegido por uma verificação localizada apenas em `Main`.
- **D) Verdadeira.** O valor negativo é rejeitado e o campo `double` permanece com seu valor padrão `0.0`.
- **E) Verdadeira.** `"Argo"` e `120.0` seriam argumentos; os identificadores na declaração do construtor seriam parâmetros.

## Q3 — Identidade

**Resposta: B.** As duas chamadas a `new Carro` e as duas chamadas a `new Locacao` produzem objetos distintos, ainda que seus estados coincidam.

## Q4 — Distribuição de responsabilidades

**Resposta: C.** Cada `Locacao` calcula seu próprio valor; `Fatura` apenas percorre as locações e acumula os resultados.

## Q5 — Coleção e aliasing

**Resposta: E.** A mesma referência `popular` pode aparecer duas vezes na lista. Com `popular` em `150.0` e `sedan` em `140.0`, as três entradas satisfazem o limite.

## Q6 — Controle da coleção

**Resposta: C.** O getter expõe a própria lista, permitindo inserções e remoções externas sem passar pelas operações de `Fatura`.
