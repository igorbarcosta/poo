# Gabarito comentado — Checkpoint 01 — Variante A

[Consulte a prova aplicada (PDF)](checkpoint-01-variante-a.pdf).

## Respostas

| Questão | Resposta |
| --- | --- |
| Q1 | A) `true`; B) `false`; C) `true`; D) `10.0`; E) `8.0`; F) `12.0`; G) `1.0` |
| Q2 | A) V; B) V; C) V; D) V; E) F |
| Q3 | B |
| Q4 | D |
| Q5 | C |
| Q6 | A |

## Q1 — Acompanhando objetos e referências

Logo após as linhas 3 a 8, existem **dois objetos** `MedidorChuva`:

- `principal` e `apoio` apontam para o primeiro objeto, cujo total é `8.0`;
- `outro` aponta para um segundo objeto, também com total `8.0`.

Os totais iguais não tornam os objetos iguais por identidade. O operador `==`, quando usado entre referências, verifica se elas apontam para o mesmo objeto.

- **A) Linha 10 — `true`:** `principal` e `apoio` apontam para o mesmo objeto.
- **B) Linha 11 — `false`:** `principal` e `outro` apontam para objetos diferentes, embora ambos armazenem `8.0`.
- **C) Linha 14 — `true`:** depois de `apoio = outro`, as duas variáveis apontam para o segundo objeto.
- **D) Linha 17 — `10.0`:** a chamada feita por `apoio` soma `2.0` ao segundo objeto. Como `outro` aponta para esse mesmo objeto, ele observa o total atualizado.
- **E) Linha 18 — `8.0`:** o primeiro objeto não foi alterado; `principal` continuou apontando para ele.
- **F) Linha 22 — `12.0`:** após `apoio = principal`, a chamada feita por `apoio` altera o primeiro objeto: `8.0 + 4.0 = 12.0`.
- **G) Linha 26 — `1.0`:** `apoio.totalMilimetros = -2.0` substitui o total do objeto compartilhado. Em seguida, `principal.registrarChuva(3.0)` produz `-2.0 + 3.0 = 1.0`.

!!! warning "Erro comum"

    Uma atribuição como `apoio = outro` muda a referência guardada em `apoio`; ela não copia o objeto nem altera a referência guardada em `principal`. Já uma alteração como `apoio.totalMilimetros = ...` modifica o objeto alcançado pela referência naquele momento.

## Q2 — Estado, comportamento, parâmetros e retorno

- **A) Verdadeira.** `local` e `totalMilimetros` guardam dados do objeto e formam seu estado. Os métodos representam operações que o objeto pode realizar.
- **B) Verdadeira.** O parâmetro `milimetros` é uma variável local à execução de `registrarChuva`. O que permanece depois da chamada é a alteração feita em `totalMilimetros`.
- **C) Verdadeira.** `void` significa que o método não devolve um valor ao chamador. Isso não impede que ele altere o estado do objeto.
- **D) Verdadeira.** `consultarTotal()` devolve um valor do tipo primitivo `double`. A variável que recebe esse resultado guarda uma cópia do valor, não uma ligação com o atributo.
- **E) Falsa.** Um método de instância pode acessar diretamente os atributos do próprio objeto. Por isso `registrarChuva` usa `totalMilimetros` sem recebê-lo como parâmetro.

## Q3 — Responsabilidade do próprio objeto

**Resposta: B.** O método `atingiuAlerta(double limite)` recebe apenas a informação externa necessária — o limite — e compara esse valor com `totalMilimetros`, que já pertence ao estado do objeto.

As demais propostas ou não realizam a verificação, ou deslocam a responsabilidade para `Main`, ou expõem/duplicam desnecessariamente um dado que o próprio medidor já conhece.

## Q4 — Acesso sem modificador

**Resposta: D.** Um membro declarado sem modificador possui acesso de pacote. Como `Main` e `MedidorChuva` estão no mesmo pacote, `Main` consegue acessar `totalMilimetros` diretamente.

Isso não acontece por causa do tipo `double`, do uso de `new`, da existência de uma referência ou de uma permissão especial de `main`.

## Q5 — Mesma identidade e estado válido

**Resposta: C.** `principal` e `apoio` começam apontando para o mesmo objeto. Nenhuma das três linhas troca qualquer referência. A sequência aceita `6.0`, ignora `-2.0` e aceita `4.0`, chegando a `10.0`.

- A alternativa A cria um novo objeto e separa as referências.
- B termina em `6.0`, pois consultar não altera o total e o valor negativo é ignorado.
- D termina em `12.0`.
- E tenta acessar diretamente um atributo `private` e não compila.

## Q6 — Encapsulamento e controle das alterações

**Resposta: A.** Tornar o atributo `private` impede a alteração direta por outras classes, mas o controle depende também dos métodos públicos oferecidos. `definirTotal` atribui qualquer valor sem aplicar a regra de `registrarChuva`, criando um caminho que contorna a validação.

Encapsular não é apenas esconder o atributo: é garantir que todas as operações disponíveis preservem as regras do objeto.
