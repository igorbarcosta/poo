# Gabarito comentado — Checkpoint 04 — Variante A

[Consulte a prova aplicada (PDF)](checkpoint-04-variante-a.pdf).

## Respostas

| Questão | Resposta |
| --- | --- |
| Q1 | B |
| Q2 | C |
| Q3 | E |
| Q4 | B |
| Q5 | C |
| Q6 | D |
| Q7 | 1) `17.0`; 2) `1`; 3) `6.0`; 4) `40.0`; 5) `20.0`; 6) `2`; 7) `false`; 8) `false` |

Q1 a Q6 valem 10 pontos cada; cada saída de Q7 vale 5 pontos. Total: 100 pontos.
Cada questão parte do cenário base, e os cinco trechos de Q7 são independentes.

## Q1 — A mesma chamada alcança implementações diferentes

**Resposta: B.** A variável `c` tem tipo declarado `Cobranca` nas duas
passagens pelo laço. Esse contrato oferece `calcularValor(Estadia)`, portanto
permite a chamada `c.calcularValor(e)`.

O objeto alcançado pela referência muda a cada passagem:

| Passagem | Objeto referenciado por `c` | Implementação executada | Retorno |
| --- | --- | --- | --- |
| Primeira | `CobrancaPorHora` | Consulta as quatro horas de `e` e multiplica por `5.0`. | `20.0` |
| Segunda | `CobrancaPorDiaria` | Devolve o valor fixo da diária. | `40.0` |

Esse é o despacho dinâmico: o objeto determina a implementação executada.
O laço não imprime nem guarda esses retornos; apenas faz as chamadas.

- **A:** o compilador não altera o tipo declarado da variável a cada passagem.
- **C:** `e` fornece os dados da estadia; a chamada é feita ao objeto alcançado
  por `c`, que executa sua implementação.
- **D:** o tipo declarado permite a operação, mas não fixa uma implementação
  única. As duas classes apresentam corpos de método diferentes.
- **E:** as chamadas a `add` preenchem a lista. A escolha da implementação ocorre
  na execução, conforme o objeto alcançado em cada passagem.

A estadia ainda está aberta, mas a chamada vai diretamente à cobrança.
A guarda que devolveria `0.0` está em `Estadia.calcularValor()`, que não é
chamado nesse laço.

## Q2 — Contar as chamadas feitas ao colaborador

**Resposta: C.** `valor` termina com `16.0` e `base.getVezes()` devolve `2`.

A variável `c` referencia `Taxa`, cujo campo `base` alcança o mesmo objeto
`Fixa` criado no início. Cada execução de `Fixa.calcularValor` incrementa
`vezes`, mesmo quando recebe novamente a mesma estadia.

| Etapa em `Taxa.calcularValor` | Efeito em `Fixa` | Resultado |
| --- | --- | --- |
| `double valor = base.calcularValor(e)` | `vezes` passa de `0` para `1`. | A variável local recebe `12.0`. |
| `if (valor == 0.0)` | Não chama a base. | A condição é falsa. |
| `return base.calcularValor(e) + 4.0` | `vezes` passa de `1` para `2`. | Devolve `12.0 + 4.0 = 16.0`. |

Guardar o primeiro retorno em `valor` não impede uma segunda chamada.
A instrução final usa outra chamada ao método, em vez de usar `valor + 4.0`.
O adicional de `4.0` é somado uma única vez ao retorno da segunda chamada;
os dois retornos da base não são somados entre si.

As alternativas com contagem `1` ignoram essa segunda chamada. As demais
combinações numéricas não correspondem à expressão efetivamente devolvida.

## Q3 — O teste de capacidade vale para a referência examinada

**Resposta: E.** O trecho compila, imprime `OK` uma vez e falha no cast de
`segunda`.

1. `primeira` alcança um `Recibo`, que implementa `Comprovavel`. A condição
   `primeira instanceof Comprovavel` é verdadeira.
2. O cast de `primeira` é válido. `a` alcança o mesmo `Recibo`, e
   `a.emitir()` devolve `"OK"`.
3. `segunda` alcança uma `CobrancaPorHora`, que não implementa `Comprovavel`.
   Seu cast lança `ClassCastException`; o segundo `println` não é executado.

O `if` verificou apenas o objeto alcançado por `primeira`. Entrar nesse bloco
não garante a capacidade de outro objeto alcançado por `segunda`.

- **A:** a condição é verdadeira para o `Recibo`.
- **B:** o segundo cast não é válido na execução.
- **C:** `emitir()` é chamado por referências do tipo `Comprovavel`, que declara
  esse método. Não é necessário declará-lo em `Cobranca` para essas chamadas.
- **D:** o primeiro cast é válido e a primeira impressão acontece.

O cast entre essas referências de interface é aceito na compilação. Sua validade
na execução depende do objeto alcançado, caso a instrução seja executada.
Um cast não cria outro objeto nem acrescenta uma interface à classe dele.

## Q4 — Verificar cada chamada pelo tipo declarado

**Resposta: B. Apenas I e IV compilam.** `c`, `x` e `evento` alcançam o
mesmo objeto, mas suas declarações permitem usos diferentes.

| Chamada | Compila? | Motivo |
| --- | --- | --- |
| I — `x.cancelar()` | Sim | `x` tem tipo declarado `Cancelavel`, que oferece `cancelar()`. |
| II — `x.calcularValor(e)` | Não | `Cancelavel` não declara `calcularValor(Estadia)`. |
| III — `e.encerrar(x)` | Não | O parâmetro exige `Cobranca`; o tipo declarado `Cancelavel` não garante esse contrato. |
| IV — `e.encerrar(c)` | Sim | `c` tem tipo declarado `Cobranca`, compatível com o parâmetro. |

O fato de o objeto concreto ser um `Evento` não faz a referência `x` oferecer
automaticamente todas as operações dessa classe. A questão pede chamadas sem
acrescentar casts.

As alternativas A e E incluem II, que não compila; D inclui III, que não
compila; C deixa de incluir IV, que compila.

Cada chamada é analisada separadamente após as declarações, como pede o
enunciado. Não se trata de executar as quatro em sequência nem de calcular
um preço depois do cancelamento.

## Q5 — Preservar a identidade da estadia na colaboração

**Resposta: C. O teste falha.** `e.encerrar(new Servico(registro))` guarda
o serviço e encerra a estadia. Ao calcular, o caminho é:

```text
e.calcularValor()
  → Servico.calcularValor(e)
      → cria outra = new Estadia()
      → Registro.calcularValor(outra)
          → alvo = outra
```

O cálculo chega a `Registro`, mas com outra instância de `Estadia`. No final,
`registro.getAlvo() == e` é `false`, e `assertTrue` falha. O retorno numérico
seria `12.0 + 3.0 = 15.0`; essa igualdade numérica não é o que o teste verifica.

- **A:** o serviço usa `registro`, mas substitui a estadia passada ao colaborador.
- **B:** `==` compara a identidade das referências; estados iguais não tornam
  duas instâncias o mesmo objeto.
- **D:** zero horas não bloqueia o cálculo. A estadia foi encerrada, e `Registro`
  devolve um valor fixo.
- **E:** atribuir uma referência não copia o objeto. O novo objeto foi criado
  por `new Estadia()` em `Servico`.

## Q6 — Reatribuir uma variável não troca o colaborador guardado

**Resposta: D. O valor é `22.0`.** O construtor de `Seguro` guarda a referência
recebida em seu campo `base`. No momento da construção, essa referência
alcança uma `CobrancaPorHora`.

Depois da reatribuição da variável local `base`, as referências ficam assim:

```text
base → CobrancaPorDiaria
segurada → Seguro → CobrancaPorHora
e → Estadia → o mesmo Seguro, após encerrar(segurada)
```

O cálculo solicitado à estadia passa por `Seguro` e chega à cobrança por hora:
`3 × 5.0 + 7.0 = 22.0`.

Reatribuir a variável local `base` não executa uma atribuição no campo `base`
do seguro. O nome é igual, mas são locais de armazenamento diferentes.
A estadia está encerrada, portanto a guarda de `Estadia.calcularValor()` não
devolve zero. Os resultados sem os `7.0` ignoram o seguro; usar a diária
confunde a variável reatribuída com o colaborador que o seguro conservou.

## Q7 — Composição, referências compartilhadas e capacidades

### Trecho I — Os adicionais se acumulam

**Saída 1: `17.0`.** O caminho é:

```text
Estadia → Adicional de 4.0 → Adicional de 3.0 → CobrancaPorHora
```

A cobrança por hora devolve `2 × 5.0 = 10.0`. Na volta das chamadas,
o primeiro adicional soma `3.0`, e o seguinte soma `4.0`:
`10.0 + 3.0 + 4.0 = 17.0`. Cada objeto acrescenta seu próprio valor
ao retorno do colaborador.

### Trecho II — Duas posições na lista alcançam o mesmo objeto

**Saída 2: `1`.** As duas chamadas a `opcoes.add(f)` guardam referências
ao mesmo `Flexivel`; não criam duas cobranças.

| Momento | Tarifa de `f` | Saldo de `f` |
| --- | --- | --- |
| Antes do laço | `5.0` | `3` |
| Após a primeira chamada | `6.0` | `2` |
| Após a segunda chamada | `6.0` | `1` |

A segunda chamada também consome saldo. O método verifica se a tarifa é
positiva e se há saldo; não rejeita uma tarifa só por ser igual à atual.

### Trecho III — A ordem das camadas muda o resultado

**Saída 3: `6.0`.** As duas cadeias usam a mesma cobrança por diária,
cujo retorno é `40.0`, mas aplicam adicional e teto em ordens diferentes.

| Cobrança | Primeiro cálculo | Próxima camada | Resultado |
| --- | --- | --- | --- |
| `a` — teto envolvendo adicional | `40.0 + 6.0 = 46.0` | O teto reduz para `35.0`. | `35.0` |
| `b` — adicional envolvendo teto | O teto reduz `40.0` para `35.0`. | Soma `6.0` depois do teto. | `41.0` |

A expressão pede **`b - a`**, portanto o resultado é
`41.0 - 35.0 = 6.0`. Em `b`, o adicional é aplicado depois do
teto; por isso o resultado final pode ultrapassar `35.0`.

### Trecho IV — A capacidade examinada e o objeto substituído

**Saída 4: `40.0`.** Inicialmente, `opcao` alcança uma `CobrancaPorHora`.
Ela não implementa `Ajustavel`; o `instanceof` devolve `false`, e a negação
faz o bloco executar. `opcao` passa a alcançar `CobrancaPorDiaria`, que devolve
`40.0` independentemente das horas.

**Saída 5: `20.0`.** Em seguida, a referência é substituída por um objeto
`Teto` que envolve uma nova cobrança por hora. O cálculo por hora é
`7 × 5.0 = 35.0`.
Como `35.0` supera o limite de `20.0`, o teto devolve `20.0`.

Essas chamadas vão diretamente a `opcao.calcularValor(e)`. A estadia não foi
encerrada nesse trecho, mas sua guarda de cálculo não participa desse caminho.

### Trecho V — Capacidade, saldo e resultado da tentativa

**Saída 6: `2`.** `f.alterarTarifa(-2.0)` encontra uma tarifa inválida
e devolve `false` antes de alterar os campos. O saldo de `f` permanece em `2`.

**Saída 7: `false`.** `g` começa com saldo `1`. A chamada
`g.alterarTarifa(4.0)` é válida e deixa saldo `0`.
A tentativa seguinte encontra saldo zero, devolve `false` e conserva a tarifa `4.0`.

**Saída 8: `false`.** `c` alcança um objeto `Adicional`, que implementa
`Cobranca`, mas não `Ajustavel`. Seu campo `base` alcança `g`, um `Flexivel`;
isso não transfere as interfaces de `g` para o objeto que o envolve.

Ter a capacidade `Ajustavel` e conseguir realizar uma alteração são questões
diferentes. Um `Flexivel` continua implementando `Ajustavel` quando seu saldo
acaba, embora o método passe a recusar novas alterações. Já `Adicional` não
implementa essa interface, seja qual for o saldo do objeto envolvido.
