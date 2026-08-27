# Gabarito comentado — Checkpoint 01 — Variante B

[Consulte a prova aplicada (PDF)](checkpoint-01-variante-b.pdf).

## Respostas

| Questão | Resposta |
| --- | --- |
| Q1 | A) `false`; B) `true`; C) `false`; D) `6.0`; E) `9.0`; F) `11.0`; G) `2.0` |
| Q2 | A) F; B) F; C) F; D) F; E) V |
| Q3 | E |
| Q4 | B |
| Q5 | D |
| Q6 | C |

## Q1 — Acompanhando objetos e referências

Logo após as linhas 3 a 8, existem **dois objetos** `MedidorChuva`:

- `principal` e `apoio` apontam para o primeiro objeto, cujo total é `6.0`;
- `outro` aponta para um segundo objeto, também com total `6.0`.

Os totais iguais não tornam os objetos iguais por identidade. O operador `==`, quando usado entre referências, verifica se elas apontam para o mesmo objeto.

- **A) Linha 10 — `false`:** `principal` e `outro` apontam para objetos diferentes.
- **B) Linha 11 — `true`:** `principal` e `apoio` apontam para o mesmo objeto.
- **C) Linha 14 — `false`:** depois de `apoio = outro`, `apoio` aponta para o segundo objeto, enquanto `principal` continua apontando para o primeiro.
- **D) Linha 17 — `6.0`:** a chuva de `3.0` foi registrada no segundo objeto por meio de `apoio`; o objeto apontado por `principal` não foi alterado.
- **E) Linha 18 — `9.0`:** `outro` aponta para o mesmo objeto alterado por `apoio`, cujo total passou de `6.0` para `9.0`.
- **F) Linha 22 — `11.0`:** após `apoio = principal`, a chamada feita por `apoio` altera o primeiro objeto: `6.0 + 5.0 = 11.0`.
- **G) Linha 26 — `2.0`:** `apoio.totalMilimetros = -4.0` substitui o total do objeto compartilhado. Em seguida, `principal.registrarChuva(6.0)` produz `-4.0 + 6.0 = 2.0`.

!!! warning "Erro comum"

    Uma atribuição como `apoio = outro` muda a referência guardada em `apoio`; ela não copia o objeto nem altera a referência guardada em `principal`. Já uma alteração como `apoio.totalMilimetros = ...` modifica o objeto alcançado pela referência naquele momento.

## Q2 — Estado, comportamento, parâmetros e retorno

- **A) Falsa.** A afirmativa inverte os conceitos: os atributos guardam o estado, enquanto os métodos representam comportamentos.
- **B) Falsa.** O parâmetro `milimetros` existe durante a execução do método. Ele não se transforma em atributo; o que permanece é a alteração realizada em `totalMilimetros`.
- **C) Falsa.** `void` significa que o método não devolve um valor ao chamador. Um método `void` ainda pode alterar o estado do objeto.
- **D) Falsa.** `consultarTotal()` devolve um `double`, e a variável recebe uma cópia desse valor. Alterar a variável não modifica o atributo.
- **E) Verdadeira.** Um método de instância pode acessar diretamente os atributos do próprio objeto, sem recebê-los como parâmetros.

## Q3 — Responsabilidade do próprio objeto

**Resposta: E.** O método `atingiuAlerta(double limite)` recebe apenas a informação externa necessária — o limite — e compara esse valor com `totalMilimetros`, que já pertence ao estado do objeto.

As demais propostas ou não realizam a verificação, ou deslocam a responsabilidade para `Main`, ou expõem/duplicam desnecessariamente um dado que o próprio medidor já conhece.

## Q4 — Acesso sem modificador

**Resposta: B.** Um membro declarado sem modificador possui acesso de pacote. Como `Main` e `MedidorChuva` estão no mesmo pacote, `Main` consegue acessar `totalMilimetros` diretamente.

Isso não acontece por causa do tipo `double`, do uso de `new`, da existência de uma referência ou de uma permissão especial de `main`.

## Q5 — Mesma identidade e estado válido

**Resposta: D.** `principal` e `apoio` começam apontando para o mesmo objeto. Nenhuma das três linhas troca qualquer referência. A sequência aceita `7.0`, ignora `-3.0` e aceita `5.0`, chegando a `12.0`.

- A alternativa A cria um novo objeto e separa as referências.
- B tenta acessar diretamente um atributo `private` e não compila.
- C termina em `15.0`.
- E termina em `7.0`, pois consultar não altera o total e o valor negativo é ignorado.

## Q6 — Encapsulamento e controle das alterações

**Resposta: C.** Tornar o atributo `private` impede a alteração direta por outras classes, mas o controle depende também dos métodos públicos oferecidos. `definirTotal` atribui qualquer valor sem aplicar a regra de `registrarChuva`, criando um caminho que contorna a validação.

Encapsular não é apenas esconder o atributo: é garantir que todas as operações disponíveis preservem as regras do objeto.
