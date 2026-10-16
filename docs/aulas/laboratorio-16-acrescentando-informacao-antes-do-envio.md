# Laboratório 16 — Acrescentando informação antes do envio

Na Aula 16, uma entrega com seguro aproveitou o cálculo de outro objeto e
acrescentou seu próprio comportamento. Agora você aplicará composição e
delegação ao **Projeto 2 — Sistema de lembretes e notificações**: acrescentar
um prefixo à mensagem antes de encaminhá-la ao canal escolhido.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode esclarecer conceitos, mensagens de compilação e falhas de teste.
    Ela não deve implementar a nova classe, montar os cenários ou escrever os
    testes por você.

## Objetivos

- compor um notificador usando outro objeto do contrato `Notificador`;
- acrescentar um prefixo sem modificar as classes dos canais ou `Lembrete`;
- preservar a mensagem original, o canal inicial e a contagem dos avisos; e
- verificar o texto encaminhado e a quantidade de envios com JUnit.

## Ponto de partida

Continue sua solução final do
[Laboratório 15](laboratorio-15-a-mesma-chamada-varios-canais.md). Ela contém
`Notificador`, os canais e-mail, SMS, painel e aplicativo, `Lembrete`, `Main`
e `LembreteTest`, com JUnit Jupiter configurado.

Execute toda a suíte antes de alterar o código. Confira também o cenário de
`Main`: os cinco avisos individuais, os três pela lista e o aviso final pelo
canal inicial devem chegar ao contador `9`. A mensagem é
`"Revisar colaboração"` e a origem do e-mail é `"Agenda"`.

As operações existentes de `Lembrete` já recebem colaboradores pelo contrato.
Neste laboratório, **mantenha sua implementação, a interface `Notificador` e
os quatro canais existentes**. Acrescente a nova classe e use-a por meio
dessas operações. Mantenha os testes e os nove envios anteriores.

## Incremento A — Acrescentar o prefixo e delegar o envio

Crie `NotificadorComPrefixo.java`. O novo objeto deve cumprir `Notificador` e
receber na criação o texto do prefixo e o notificador que realizará o envio:

```java
public NotificadorComPrefixo(String prefixo, Notificador destino)
```

Sua operação `public void enviar(String mensagem)` deve:

- construir o texto como `prefixo + mensagem`, nessa ordem;
- solicitar **um único envio** desse texto ao destino recebido na criação;
- conservar o prefixo e o destino para as chamadas seguintes; e
- produzir a saída somente pelo destino, sem imprimir uma segunda mensagem.

Use o prefixo exatamente como recebido, incluindo seus espaços. Um prefixo
vazio encaminha a mensagem sem acréscimo. Considere prefixos, mensagens e
notificadores diferentes de `null`, sem introduzir regras de falhas de envio.

??? tip "Dica — duas responsabilidades diferentes"

    A nova classe precisa cumprir o contrato e guardar um colaborador desse
    contrato. Retome a distinção entre `implements Entrega` e o campo
    `Entrega entregaBase` na Aula 16. O destino é recebido, não escolhido
    dentro de `enviar(...)`.

### Usar a combinação com o lembrete existente

Depois dos nove envios anteriores de `Main`, no **mesmo lembrete**:

1. Crie um notificador com prefixo `"[URGENTE] "` e destino SMS.
2. Solicite `avisarPor(...)` usando esse objeto e mostre o contador.
3. Solicite `avisar()` e mostre o contador novamente.

Antes de executar, preveja as quatro linhas novas: que texto vai ao SMS,
que texto vai ao e-mail e quais contadores aparecem?

??? "Ver resultado e explicação"

    ```text
    SMS: [URGENTE] Revisar colaboração
    10
    EMAIL [Agenda]: Revisar colaboração
    11
    ```

    - O novo objeto acrescenta o prefixo e solicita um envio ao SMS.
    - `Lembrete` conta esse envio uma vez. O notificador não controla esse contador.
    - `avisar()` continua usando o e-mail inicial com a mensagem original.
      O envio anterior não reconfigura o lembrete.

Compile, execute `Main` e rode todos os testes existentes. Ao concluir este
incremento, a nova classe funciona com o SMS e o cenário anterior permanece
preservado, sem alterações em `Lembrete` ou nos canais.

## Incremento B — Combinar usos e proteger a delegação

O objeto com prefixo pode ocupar os mesmos pontos de colaboração que qualquer
outro notificador. Vamos usá-lo em uma sequência e como canal inicial, além
de verificar o que ele solicita ao destino.

### Ampliar o cenário de execução

Depois do contador `11`, no mesmo lembrete de `Main`:

1. Monte uma nova `List<Notificador>` com três elementos, nesta ordem:
   o SMS com prefixo `"[URGENTE] "` criado no incremento A, um painel com
   prefixo `"[TURMA] "` e um aplicativo sem prefixo.
2. Solicite `avisarPorTodos(...)` com essa lista e mostre o contador.
3. Solicite `avisar()` e mostre o contador novamente.

Em seguida, crie **outro lembrete**, com mensagem `"Entregar atividade"` e
canal inicial formado por prefixo `"[POO] "` e destino aplicativo. Solicite
`avisar()` nesse novo lembrete e mostre o contador dele.

Preveja as oito linhas acrescentadas por essas ações. O uso de um objeto com
prefixo exige que `avisarPorTodos(...)` identifique sua classe? Os dois
lembretes compartilham um contador?

??? "Ver resultado e explicação"

    ```text
    SMS: [URGENTE] Revisar colaboração
    PAINEL: [TURMA] Revisar colaboração
    APP: Revisar colaboração
    14
    EMAIL [Agenda]: Revisar colaboração
    15
    APP: [POO] Entregar atividade
    1
    ```

    - Cada elemento da lista provoca um envio. O primeiro lembrete passa de
      `11` para `14`, e seu aviso inicial seguinte leva o contador a `15`.
    - O percurso solicita `enviar(...)` pelo contrato. O objeto com prefixo
      recebe a chamada e delega o envio ao próprio destino.
    - O outro lembrete usa o objeto com prefixo como canal inicial. Seu contador
      é independente e começa em `0`, chegando a `1` após seu primeiro aviso.

### Observar o texto sem depender do console

Os testes anteriores verificavam contadores e referências. Para conferir
também o texto encaminhado, acrescente o apoio abaixo em
`NotificadorRegistro.java`, na mesma área das classes auxiliares dos testes
do seu projeto. Se o projeto usa uma única pasta de fontes, coloque-o junto
dos demais arquivos. O código é fornecido para uso nos testes:

```java
public class NotificadorRegistro implements Notificador {
    private String ultimaMensagem;
    private int quantidadeEnvios;

    public void enviar(String mensagem) {
        ultimaMensagem = mensagem;
        quantidadeEnvios++;
    }

    public String getUltimaMensagem() {
        return ultimaMensagem;
    }

    public int getQuantidadeEnvios() {
        return quantidadeEnvios;
    }
}
```

Esse notificador não imprime. Ele registra a última mensagem recebida e conta
as solicitações, como `EntregaRegistrada` na Aula 16. Cada instância começa
com contador `0`. Crie instâncias novas em cada teste, sem depender da ordem
de execução dos testes.

Use-o como destino de `NotificadorComPrefixo` para observar a mensagem recebida.
Por exemplo, depois de um envio, `registro.getUltimaMensagem()` fornece o texto
e `registro.getQuantidadeEnvios()` fornece a quantidade. Compare os resultados
com `assertEquals`, usando os imports JUnit já conhecidos.

### Acrescentar verificações à suíte

Preserve os testes anteriores de `LembreteTest` e acrescente os sete cenários
abaixo nela ou em `NotificadorComPrefixoTest`. Os nomes são sugestões.

| Teste | Preparação e ações | Verificações |
| --- | --- | --- |
| `acrescentaPrefixoEDelegaUmaVez` | Crie um registro e um objeto com prefixo `"[URGENTE] "` que o use como destino. Solicite diretamente `enviar("Revisar colaboração")` ao objeto com prefixo. | O registro recebeu `"[URGENTE] Revisar colaboração"` e conta `1` envio. |
| `prefixoVazioPreservaMensagem` | Crie um registro e um objeto com prefixo `""` que o use como destino. Solicite `enviar("Texto")` ao objeto com prefixo. | O registro recebeu exatamente `"Texto"` e conta `1` envio. |
| `prefixoSemEspacoNaoAcrescentaSeparador` | Crie um registro e um objeto com prefixo `"Aviso:"` que o use como destino. Solicite `enviar("Texto")` ao objeto com prefixo. | O registro recebeu exatamente `"Aviso:Texto"` e conta `1` envio. |
| `reutilizacaoNaoAcumulaPrefixo` | Com um registro e um objeto com prefixo novos de `"[URGENTE] "`, envie `"Revisar colaboração"` e depois `"Entregar atividade"` pela mesma combinação. | Após a primeira chamada, a mensagem é `"[URGENTE] Revisar colaboração"` e o contador é `1`; após a segunda, a mensagem é `"[URGENTE] Entregar atividade"` e o contador é `2`. |
| `avisoAlternativoPreservaMensagemECanalInicial` | Crie dois registros: um para o canal inicial e outro como destino de um objeto com prefixo `"[URGENTE] "`. Crie um lembrete com mensagem `"Revisar colaboração"` e o primeiro registro como canal inicial. Solicite `avisarPor(...)` com o objeto com prefixo; depois solicite `avisar()`. | Confira os resultados intermediários e finais detalhados abaixo. |
| `prefixoPodeSerCanalInicial` | Crie um registro e uma combinação com prefixo `"[POO] "`. Use a combinação como canal inicial de um novo lembrete com mensagem `"Entregar atividade"`. Solicite `avisar()` duas vezes. | Após cada chamada, o registro recebeu `"[POO] Entregar atividade"`; o contador do lembrete e o do registro passam por `1` e `2`. |
| `listaCombinaObjetosComESemPrefixo` | Crie três registros e uma lista com: prefixo `"[URGENTE] "` para o primeiro, prefixo `"[TURMA] "` para o segundo e o terceiro diretamente. Use a lista em um novo lembrete com mensagem `"Revisar colaboração"` e um quarto registro como canal inicial. Depois solicite `avisar()`. | Confira os resultados intermediários e finais detalhados abaixo. |

No teste `avisoAlternativoPreservaMensagemECanalInicial`, confira:

1. Depois de `avisarPor(...)`: contador do lembrete `1`; registro alternativo
   com `1` envio e texto `"[URGENTE] Revisar colaboração"`; registro inicial
   com `0` envios.
2. Depois de `avisar()`: contador do lembrete `2`; registro inicial com `1`
   envio e texto `"Revisar colaboração"`; registro alternativo ainda com `1`
   envio e o mesmo texto prefixado.

No teste `listaCombinaObjetosComESemPrefixo`, confira:

1. Depois da lista: contador do lembrete `3`; cada um dos três destinos com
   `1` envio e, respectivamente, as mensagens `"[URGENTE] Revisar colaboração"`,
   `"[TURMA] Revisar colaboração"` e `"Revisar colaboração"`; canal inicial
   com `0` envios. A lista mantém tamanho `3` e as mesmas referências nas
   posições originais, como no Laboratório 15.
2. Depois de `avisar()`: contador do lembrete `4`; canal inicial com `1`
   envio e mensagem `"Revisar colaboração"`; os três destinos da lista
   continuam com `1` envio cada.

??? tip "Dica — observar o destino certo"

    Guarde o `NotificadorRegistro` em uma variável antes de fornecê-lo ao
    objeto com prefixo. Depois da ação, consulte esse mesmo registro. O
    lembrete usa a combinação; o teste observa o destino que ela recebeu.

Execute a suíte inteira e confira o console de `Main`. Quais defeitos os
novos testes detectariam: omitir o prefixo, ignorar o destino recebido,
enviar duas vezes ou acumular o prefixo entre chamadas?

??? "Ver critérios de verificação"

    - Todos os testes novos e antigos devem passar.
    - O texto esperado detecta prefixo ausente ou repetido.
    - Os casos com prefixo vazio e sem espaço final detectam separadores
      acrescentados indevidamente. O texto deve ser exatamente `prefixo + mensagem`.
    - O contador e a mensagem do registro fornecido detectam destino ignorado
      e envios duplicados.
    - Os testes de integração verificam mensagem original, canal inicial e
      contagem do lembrete, inclusive quando o notificador com prefixo participa
      de uma lista.
    - Os registros não verificam o formato de impressão dos canais reais.
      Confira em `Main` a ordem das linhas e os prefixos `SMS`, `PAINEL`,
      `EMAIL [Agenda]` e `APP`.

## Verificação final

!!! success "Critérios de conclusão"

    - `NotificadorComPrefixo` cumpre o contrato, conserva o prefixo e o destino
      recebidos e solicita um envio por chamada com o texto correto.
    - `Lembrete`, `Notificador` e os quatro canais mantêm suas implementações.
    - O objeto com prefixo funciona em `avisarPor(...)`, em uma lista e como
      canal inicial, preservando mensagem e contagem de cada lembrete.
    - `Main` preserva os nove envios anteriores, leva o primeiro lembrete ao
      contador `15` e demonstra o segundo lembrete com contador `1`.
    - `NotificadorRegistro` e os sete novos testes verificam os cenários
      solicitados; os testes anteriores continuam passando.

## Para pensar após a implementação

1. Por que `NotificadorComPrefixo` precisa tanto de `implements Notificador`
   quanto de um campo do tipo `Notificador`?
2. Que código precisa mudar para enviar uma mensagem com o mesmo prefixo por
   e-mail, em vez de SMS?

??? "Ver uma análise possível"

    1. `implements` permite usar o objeto nos pontos que esperam o contrato.
       O campo permite conservar o outro objeto ao qual ele delega o envio.
    2. O código de montagem fornece um `NotificadorEmail` ao criar a combinação.
       A implementação da classe com prefixo e a de `Lembrete` permanecem iguais.

## Entrega

Entregue somente os arquivos `.java` do **Projeto 2**, incluindo a nova classe,
`NotificadorRegistro.java` e os testes, conforme as orientações do
[Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).
Previsões, respostas conceituais, diagramas e prints não precisam ser enviados.

## Materiais relacionados

- [Aula 16 — Combinando comportamentos por composição](aula-16-combinando-comportamentos-por-composicao.md)
- [Laboratório 15 — A mesma chamada, vários canais](laboratorio-15-a-mesma-chamada-varios-canais.md)
- [Aula 13 — Como saber se ainda funciona?](aula-13-como-saber-se-ainda-funciona.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
