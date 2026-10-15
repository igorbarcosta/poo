# Gabarito comentado — Checkpoint 03

[Consulte a prova aplicada (PDF)](checkpoint-03.pdf).

## Respostas

| Questão | Resposta |
| --- | --- |
| Q1 | C |
| Q2 | E |
| Q3 | A |
| Q4 | B |
| Q5 | D |
| Q6 | 1) `20.0`; 2) `0.0`; 3) `45.0`; 4) `false`; 5) `25.0`; 6) `13` |
| Q7 | 1) `35.0`; 2) `28.0` |
| Q8 | Valor: `30.0`; teste: **FALHA** |

Cada questão parte do cenário base. A primeira hora gratuita da Q2, por
exemplo, não modifica os cálculos das questões seguintes.

## Q1 — O tipo do argumento e o tipo exigido pelo parâmetro

**Resposta: C.** Nesta questão, `encerrar` exige um argumento do tipo
`CobrancaPorHora`, mas a variável passada tem tipo declarado `Cobranca`:

```java
Cobranca c = new CobrancaPorHora();
e.encerrar(c);
```

O objeto criado é uma cobrança por hora. Porém, na compilação, o argumento é
verificado pelo tipo declarado da expressão `c`. Esse tipo é mais geral e não
garante a exigência específica do parâmetro. Portanto, a chamada não compila.

- **A:** confunde a classe do objeto com o tipo usado para verificar a chamada.
- **B:** o tipo do campo `cobranca` não muda a exigência da assinatura de `encerrar`.
- **D:** uma referência de interface pode, sim, apontar para um objeto de uma
  classe concreta que cumpre o contrato; a declaração de `c` é válida.
- **E:** campo e parâmetro não precisam ter o mesmo tipo. Um parâmetro
  `CobrancaPorHora` pode ser atribuído a um campo `Cobranca`; o problema está
  no argumento fornecido à chamada.

## Q2 — A regra de preço pertence à modalidade de cobrança

**Resposta: E.** A gratuidade pertence à cobrança por hora. `Estadia` deve
continuar registrando o tempo real, e a cobrança por diária deve conservar seu
valor de `40.0`.

Uma implementação possível em `CobrancaPorHora` é:

```java
public double calcularValor(Estadia e) {
    if (e.getHoras() <= 1) {
        return 0.0;
    }
    return (e.getHoras() - 1) * 5.0;
}
```

Com três horas registradas, por exemplo, a cobrança por hora passa a devolver
`10.0`, mas `getHoras()` continua devolvendo `3`.

- **A e C:** alteram o tempo registrado ou informado, contrariando o requisito.
- **B:** subtrair `5.0` de toda cobrança também reduziria a diária para `35.0`.
- **D:** acima de uma hora, conserva o cálculo antigo, sem descontar a primeira;
  além disso, aplica a gratuidade em `Estadia`, atingindo também a diária em
  estadias de até uma hora.

## Q3 — A referência concreta permite consultar o nome do evento

**Resposta: A.** O trecho correto é:

```java
System.out.println(ev.getNomeEvento());
e.encerrar(mod);
```

`ev` tem tipo declarado `CobrancaEvento`, que oferece `getNomeEvento()`. A
impressão é `Feira`. Já `mod` tem tipo declarado `Cobranca` e aponta para o
mesmo objeto; pode ser fornecida ao `encerrar(Cobranca)` do cenário base.

- **B:** `getNomeEvento()` não pertence ao contrato `Cobranca`.
- **C:** `Estadia` não oferece `getNomeEvento()`.
- **D:** `getNomeEvento()` devolve uma `String`; `encerrar` precisa receber uma
  `Cobranca`.
- **E:** `encerrar` é uma operação de `Estadia`, não de `Cobranca`.

O objeto não perde sua operação específica ao ser referenciado por `mod`.
O tipo dessa referência limita quais chamadas podem ser feitas por ela.

## Q4 — Um teste que passa pode não distinguir a alteração

**Resposta: B.** Com oito horas, os dois preços são iguais:

| Modalidade | Cálculo | Valor |
| --- | --- | ---: |
| Por hora | `8 * 5.0` | `40.0` |
| Por diária | valor fixo | `40.0` |

Tanto `40.0 < 40.0` quanto `40.0 > 40.0` são falsos. Nas duas versões,
`escolhida` permanece apontando para `hora`, e o teste observa `40.0`.

Esse resultado não identifica uma cobrança por diária nem demonstra que a
escolha funciona para qualquer tempo. `encerrar` apenas guarda a opção
recebida; não compara preços nem corrige a escolha.

Para distinguir as comparações, seria útil um cenário sem empate. Com nove
horas, por exemplo, a cobrança por hora custa `45.0` e a diária custa `40.0`:
a comparação original escolhe a diária; a comparação alterada conserva a
cobrança por hora. Uma expectativa de `40.0` passaria na primeira e falharia
na segunda.

## Q5 — Proteger a escolha do primeiro encerramento

**Resposta: D.** A alteração retira a condição `!encerrada`. Com isso, uma
segunda chamada com argumento válido passa a substituir a cobrança guardada.

O teste D primeiro encerra uma estadia de três horas com cobrança por hora e
depois tenta encerrá-la com cobrança por diária:

| Implementação de `encerrar` | Cobrança conservada | Valor observado | Expectativa de `15.0` |
| --- | --- | ---: | --- |
| Cenário base | por hora | `15.0` | passa |
| Alterada | por diária | `40.0` | falha |

Os outros testes não satisfazem a combinação pedida:

- **A:** há apenas um encerramento; passa nas duas versões.
- **B:** a segunda cobrança também é por hora. A substituição muda o objeto,
  mas conserva o resultado `15.0`; passa nas duas versões.
- **C:** a estadia permanece encerrada nas duas versões. Verificar somente
  esse estado não detecta a troca da cobrança.
- **E:** a expectativa de `40.0` falha no cenário base e passa na versão
  alterada, que é o sentido inverso do solicitado.

## Q6 — Estado, caminho da chamada e reatribuição

### Impressões 1 a 3 — Consultar a estadia ou chamar a cobrança diretamente

| Impressão | Resultado | Raciocínio |
| --- | --- | --- |
| 1 | `20.0` | `a` está encerrada e usa a cobrança por hora: `4 * 5.0`. |
| 2 | `0.0` | `b` tem nove horas, mas ainda está aberta. `Estadia.calcularValor()` devolve zero antes de solicitar a cobrança. |
| 3 | `45.0` | A chamada vai diretamente a `c`, com `b` como argumento. `CobrancaPorHora` consulta as nove horas e calcula `9 * 5.0`; não verifica se a estadia está encerrada. |

A regra que impede o cálculo pela estadia aberta está em
`Estadia.calcularValor()`. Ela não é executada quando o cliente chama
`c.calcularValor(b)` diretamente.

### Impressões 4 e 5 — Uma tentativa com null não encerra

- **4 — `false`:** `e.encerrar(null)` não passa pela guarda `opcao != null`.
  A estadia continua aberta, com três horas.
- O `if` entra no `else` e acrescenta duas horas, chegando a cinco.
- **5 — `25.0`:** o encerramento com uma cobrança por hora é válido;
  o cálculo usa `5 * 5.0`.

### Impressão 6 — Duas referências compartilhadas, depois dois objetos

Inicialmente, `principal` e `apoio` alcançam a mesma estadia. As primeiras
adições se acumulam nela: `6 + 4 = 10` horas.

Depois de `apoio = new Estadia()`, somente `apoio` passa a alcançar uma nova
estadia. Essa nova estadia recebe `principal.getHoras() - 7`, isto é,
`10 - 7 = 3` horas. Por fim, `principal` recebe essas três horas adicionais.

**6 — `13`:** a primeira estadia termina com `10 + 3 = 13` horas. Reatribuir
`apoio` não zerou nem substituiu o objeto alcançado por `principal`.

## Q7 — Guardar o resultado não guarda uma consulta futura

**Respostas: 1) `35.0`; 2) `28.0`.**

`ajuste`, `modalidade` e o campo de cobrança da estadia alcançam o mesmo objeto
`CobrancaAjustavel`. Antes da alteração, a tarifa é `5.0`, e o cálculo devolve
`7 * 5.0 = 35.0`.

```java
double valorRegistrado = e.calcularValor();
```

Essa atribuição guarda o valor primitivo `35.0`. A variável não fica ligada ao
método nem recalcula seu conteúdo quando outro objeto muda.

Já `ajuste.alterarTarifa(4.0)` modifica a tarifa no objeto compartilhado.
Ao consultar novamente `e.calcularValor()`, a estadia usa essa mesma cobrança
com seu estado atual: `7 * 4.0 = 28.0`.

Conservar a referência escolhida no encerramento não torna o estado do
colaborador imutável nem congela o resultado de cálculos futuros.

## Q8 — O cálculo fixo deixa de respeitar a cobrança escolhida

**Valor exibido: `30.0`. O teste FALHA.**

A primeira verificação, `assertFalse(e.isEncerrada())`, passa: a estadia ainda
está aberta. Em seguida, `encerrar(mod)` guarda a cobrança por diária e marca
a estadia como encerrada.

Porém, o método alterado ignora o colaborador guardado e calcula diretamente
`horas * 5.0`. Com seis horas, o `println` exibe `30.0`.

Na última verificação:

```java
assertEquals(mod.calcularValor(e), e.calcularValor());
```

- O valor esperado, primeiro argumento, é `40.0`, devolvido pela cobrança por diária.
- O valor observado, segundo argumento, é `30.0`, devolvido pelo método alterado.

Como os valores diferem, a expectativa falha. O teste evidencia que repetir
uma fórmula dentro de `Estadia` quebra a colaboração: ela deveria solicitar
o cálculo à cobrança escolhida.
