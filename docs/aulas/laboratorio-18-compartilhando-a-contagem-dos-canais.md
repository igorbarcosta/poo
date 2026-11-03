# Laboratório 18 — Compartilhando a contagem dos canais

Na Aula 18, espada e escudo passaram a compartilhar regras sem mudar os
contratos usados pelos clientes. Agora você aplicará essa ideia ao **Projeto 2
— Sistema de lembretes e notificações**: cada objeto de canal permitirá
consultar quantos envios realizou, preservando os formatos e a composição
com prefixo.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode esclarecer conceitos, mensagens de compilação e falhas de teste.
    Ela não deve escrever a base, refatorar os canais ou produzir os testes
    por você.

## Objetivos

- concentrar estado e uma sequência comum de operações em uma classe abstrata;
- usar métodos herdados e implementar a operação que varia entre os canais;
- distinguir contagem por objeto de canal e contagem por lembrete; e
- verificar a integração da herança com a composição já existente.

## Ponto de partida

Continue sua solução final do
[Laboratório 16](laboratorio-16-acrescentando-informacao-antes-do-envio.md).
Mantenha a organização dos arquivos e a configuração de JUnit Jupiter. Ela
contém `Notificador`, os quatro canais, `NotificadorComPrefixo`, `Lembrete`,
`Main`, `NotificadorRegistro` e os testes anteriores.

Execute toda a suíte e confira o cenário de `Main` antes de alterar a produção.
O primeiro lembrete deve terminar com contador `15`; o segundo, com `1`.
As novas demonstrações deste laboratório serão acrescentadas depois desse
cenário, usando objetos novos.

O projeto continua simulando os envios no console. Não há rede, falhas de envio
ou tratamento de exceções nesta atividade. Mensagens, origens, prefixos e
notificadores recebidos são diferentes de `null`.

### O que passa a ser contado

- Cada objeto de canal começa com contador `0`.
- Cada chamada a `enviar(...)` imprime uma linha e soma exatamente `1` ao
  contador daquele objeto, inclusive se a mensagem for vazia ou repetida.
- Consultar o contador ou a identificação do canal não imprime nem conta.
- O contador acumula chamadas feitas diretamente, por lembretes ou por objetos
  com prefixo. Compartilhar o mesmo canal entre clientes não cria outro contador.
- Objetos diferentes têm contadores independentes, mesmo quando são da mesma
  classe.

O contador de `Lembrete` mantém o significado anterior: conta os avisos
solicitados por aquele lembrete. Um envio direto ao canal não altera nenhum
lembrete. Um aviso do lembrete aumenta seu contador e o do canal usado.

## Incremento A — Compartilhar o envio e o estado dos canais

Crie a classe abstrata `NotificadorConsole`, que cumpre `Notificador`.
Ela será a base dos canais que seguem a mesma regra de impressão e contagem.
Sua API deve oferecer:

```java
protected NotificadorConsole()
public void enviar(String mensagem)
public int getQuantidadeEnvios()
public abstract String descreverCanal()
```

Essas linhas indicam assinaturas, não uma classe pronta para copiar. O
construtor inicializa o contador privado com `0`; a consulta devolve seu valor
atual. A identificação fica a cargo de cada subclasse concreta.

O método de envio deve solicitar essa identificação, imprimir exatamente
`identificação + ": " + mensagem` e aumentar o contador uma única vez.
A saída não deve incluir o valor do contador automaticamente.

Faça `NotificadorSms`, `NotificadorPainel` e `NotificadorApp` estenderem essa
base. As identificações devolvidas por `descreverCanal()` são, respectivamente,
`"SMS"`, `"PAINEL"` e `"APP"`. Cada construtor chama `super()`; cada classe
implementa a identificação com `@Override` e herda o envio e sua consulta.
Não mantenha cópias do contador ou do corpo de `enviar(...)` nessas subclasses.

Nesta etapa, conserve o e-mail na versão anterior. `Lembrete`,
`NotificadorComPrefixo`, `NotificadorRegistro` e `Notificador` mantêm suas
implementações. O cliente continua solicitando envios pelo contrato,
independentemente de o objeto usar ou não a nova base.

??? tip "Dica — uma operação herdada pode usar outra sobrescrita"

    Retome a ponte para o laboratório na Aula 18. O método da base pode chamar
    `descreverCanal()` como uma operação do próprio objeto. O despacho chega
    à implementação concreta; não é necessário testar a classe do canal.
    O construtor apenas inicializa o contador, sem chamar essa operação.

### Demonstrar contadores independentes

Ao final de `Main`, acrescente o cenário abaixo, com objetos novos. Antes de
executar, preveja as linhas e explique se as variáveis `smsContagem` e
`referenciaContagem` alcançam objetos diferentes:

```java
NotificadorSms smsContagem = new NotificadorSms();
Notificador referenciaContagem = smsContagem;
NotificadorSms outroSmsContagem = new NotificadorSms();

referenciaContagem.enviar("Revisar colaboração");
smsContagem.enviar("Entregar atividade");
System.out.println(smsContagem.getQuantidadeEnvios());
System.out.println(outroSmsContagem.getQuantidadeEnvios());
```

??? "Ver resultado e explicação"

    ```text
    SMS: Revisar colaboração
    SMS: Entregar atividade
    2
    0
    ```

    - `smsContagem` e `referenciaContagem` alcançam o mesmo objeto; as duas
      chamadas acumulam nele.
    - `outroSmsContagem` alcança outro objeto, que ainda não recebeu envios.
    - `referenciaContagem.getQuantidadeEnvios()` não compilaria: essa consulta
      pertence à base dos canais, não à interface `Notificador`.

Compile, execute `Main` e rode a suíte anterior. Ao concluir, os três canais
devem herdar o envio, manter as saídas antigas e possuir contadores próprios.
O e-mail ainda deve funcionar pelo contrato, sem pertencer à base.

## Incremento B — Integrar o e-mail e preservar a composição

Faça também `NotificadorEmail` estender `NotificadorConsole`. Preserve seu
construtor público `NotificadorEmail(String origem)` e guarde a origem no
próprio e-mail. Chame `super()` no construtor e implemente a identificação
como `"EMAIL [" + origem + "]"`. A subclasse herda o envio e a contagem.

Antes de executar, preveja: criar `new NotificadorEmail("Agenda")` cria um
segundo objeto para guardar o contador? Que classe inicializa esse campo?

??? "Ver resposta"

    - É criado um único objeto de e-mail. A origem e o contador compõem seu
      estado, embora sejam declarados em classes diferentes.
    - O construtor de `NotificadorConsole`, chamado por `super()`, inicializa
      o contador privado; o de `NotificadorEmail` guarda a origem.

O objeto com prefixo e o registro de testes continuam cumprindo `Notificador`
diretamente. O primeiro acrescenta texto e delega a outro objeto; o segundo
registra dados sem imprimir. Eles não seguem o algoritmo de um canal de
console e não precisam dessa superclasse.

Depois da demonstração do incremento A, acrescente o cenário abaixo a `Main`.
Os objetos são novos e não reutilizam os contadores dos exemplos anteriores.
Use os imports de `List` e `ArrayList` já conhecidos.

```java
NotificadorEmail emailIntegracao = new NotificadorEmail("Agenda");
NotificadorSms smsIntegracao = new NotificadorSms();
NotificadorComPrefixo urgenteIntegracao =
    new NotificadorComPrefixo("[URGENTE] ", smsIntegracao);
Lembrete lembreteIntegracao =
    new Lembrete("Revisar colaboração", emailIntegracao);

lembreteIntegracao.avisarPor(urgenteIntegracao);
lembreteIntegracao.avisar();

List<Notificador> canaisIntegracao = new ArrayList<>();
canaisIntegracao.add(smsIntegracao);
canaisIntegracao.add(urgenteIntegracao);
canaisIntegracao.add(smsIntegracao);
lembreteIntegracao.avisarPorTodos(canaisIntegracao);

System.out.println(lembreteIntegracao.getQuantidadeAvisos());
System.out.println(smsIntegracao.getQuantidadeEnvios());
System.out.println(emailIntegracao.getQuantidadeEnvios());
```

Preveja as oito linhas acrescentadas. Quantos objetos SMS são usados? Os
dois contadores de envios precisam somar o contador do lembrete neste cenário?

??? "Ver resultado e explicação"

    ```text
    SMS: [URGENTE] Revisar colaboração
    EMAIL [Agenda]: Revisar colaboração
    SMS: Revisar colaboração
    SMS: [URGENTE] Revisar colaboração
    SMS: Revisar colaboração
    5
    4
    1
    ```

    - Existe um objeto SMS. O envio com prefixo e as três posições da lista
      chegam a esse mesmo destino, totalizando `4` chamadas.
    - O e-mail recebe `1` chamada pelo canal inicial. O lembrete conta `5`
      avisos. Neste cenário, todos os envios vêm desse único lembrete e usam
      esses dois canais, por isso `4 + 1 = 5`.
    - Essa igualdade não é uma regra geral: um canal pode receber chamadas
      diretas ou ser compartilhado por outros lembretes.

Execute `Main` e toda a suíte. Os cenários antigos devem manter as saídas e
contadores anteriores. Ao concluir, os quatro canais compartilham o algoritmo,
e o objeto com prefixo continua funcionando sem mudanças em sua implementação.

## Incremento C — Proteger os dois significados da contagem

Crie `NotificadorConsoleTest.java` e acrescente os seis testes abaixo, usando
JUnit Jupiter e `assertEquals`, como nos laboratórios anteriores. Preserve a
suíte existente. Cada teste usa objetos novos e não depende da ordem de execução.

| Cenário | Preparação e ações | Verificações |
| --- | --- | --- |
| Reutilização do canal | Crie um SMS; consulte o contador; envie `"Texto"` duas vezes e depois `""`. | Contadores `0`, `1`, `2` e `3`, conferidos após cada ação. |
| Objetos independentes | Crie dois SMS; envie `"Texto"` só pelo primeiro. | Primeiro com `1`; segundo com `0`. |
| Identificações e canais diferentes | Crie SMS, painel, aplicativo e e-mail de origem `"Agenda"`; consulte suas identificações; envie `"Texto"` só pelo painel. | Identificações `"SMS"`, `"PAINEL"`, `"APP"` e `"EMAIL [Agenda]"`; todos começam em `0`; depois só o painel tem `1`. Consultas não alteram contadores. |
| Origem por objeto | Crie e-mails de origens `"Agenda"` e `"Curso"`; envie `"Texto"` só pelo primeiro. | Identificações `"EMAIL [Agenda]"` e `"EMAIL [Curso]"`; contadores `1` e `0`. |
| Prefixo, lista e canal inicial | Reproduza o cenário novo do incremento B. | Após o prefixo: lembrete `1`, SMS `1`, e-mail `0`. Após `avisar()`: `2`, `1`, `1`. Após a lista: `5`, `4`, `1`; lista com tamanho `3` e as mesmas referências nas posições originais. |
| Canal compartilhado | Crie um SMS e dois lembretes distintos com mensagens `"A"` e `"B"`, usando esse SMS como canal inicial. Solicite um aviso pelo primeiro, um pelo segundo e um envio direto de `"C"` ao SMS. | Após os dois avisos, cada lembrete tem `1` e o SMS tem `2`. Após o envio direto, os lembretes continuam em `1` e o SMS passa a `3`. |

??? tip "Dica — observar cada responsável"

    Consulte `getQuantidadeAvisos()` no lembrete e `getQuantidadeEnvios()`
    no objeto de canal guardado antes da montagem. Não crie outro canal para
    conferir o resultado. Reutilize os imports de `@Test` e `assertEquals`
    presentes em seus testes; não é necessária uma nova API de testes.

Execute toda a suíte. Que defeitos os novos cenários revelam se o contador
for `static`, for zerado a cada envio ou for incrementado também na subclasse?

??? "Ver critérios de verificação"

    - Os seis novos testes e todos os anteriores devem passar.
    - Objetos independentes revelam um contador compartilhado por `static`.
    - Envios repetidos e mensagem vazia revelam reinicialização ou contagem
      condicionada ao conteúdo do texto.
    - As contagens exatas revelam duplicação de incrementos entre base e
      subclasse. O cenário com prefixo verifica quantas chamadas chegaram ao
      destino e o compartilhamento preserva os contadores de cada lembrete.
    - Identificações verificam também a origem de cada e-mail. Esses testes
      não capturam a impressão: confira em `Main` o formato e a ordem das
      linhas, incluindo a ausência de uma impressão extra pelo prefixo.

## Verificação final

!!! success "Critérios de conclusão"

    - `NotificadorConsole` é abstrata, cumpre `Notificador` e concentra o
      contador privado, sua consulta e a sequência de imprimir e contar.
    - Os quatro canais estendem a base e implementam `descreverCanal()`;
      o e-mail conserva a origem recebida. Não há cópias do envio ou contador
      nessas subclasses.
    - Cada objeto de canal começa em `0` e acumula um envio por chamada,
      independentemente do cliente que a realizou.
    - `Lembrete`, `Notificador`, `NotificadorComPrefixo` e `NotificadorRegistro`
      mantêm suas implementações. As contagens dos lembretes são preservadas.
    - `Main` mantém os cenários anteriores e acrescenta as duas demonstrações
      com objetos novos, produzindo as saídas previstas.
    - Os seis novos testes e a suíte anterior passam.

## Para pensar após a implementação

1. Por que a nova base é útil aos quatro canais, mas `Lembrete` e o objeto
   com prefixo continuam dependendo de `Notificador`?
2. Na chamada a `enviar(...)` sobre um e-mail, onde estão os corpos do envio
   e da identificação? A chamada à identificação cria outro objeto?

??? "Ver uma análise possível"

    1. Os canais seguem a mesma regra de impressão e contagem. Os clientes
       só precisam solicitar o envio, inclusive a objetos como o registro de
       testes, que não seguem essa regra. O prefixo combina seu trabalho com
       outro objeto; não se torna um canal de console por fazer isso.
    2. O envio está em `NotificadorConsole`; a identificação está em
       `NotificadorEmail`. Ambos executam sobre o mesmo objeto de e-mail.
       Chamar um método sobrescrito não cria outro objeto.

## Entrega

Entregue somente os arquivos `.java` do **Projeto 2**, incluindo a nova base,
os canais alterados, `Main` e os testes, conforme as orientações do
[Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).
Previsões, respostas conceituais, diagramas e prints não precisam ser enviados.

## Materiais relacionados

- [Aula 18 — Compartilhando regras sem perder os contratos](aula-18-compartilhando-regras-sem-perder-os-contratos.md)
- [Laboratório 16 — Acrescentando informação antes do envio](laboratorio-16-acrescentando-informacao-antes-do-envio.md)
- [Aula 13 — Como saber se ainda funciona?](aula-13-como-saber-se-ainda-funciona.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
