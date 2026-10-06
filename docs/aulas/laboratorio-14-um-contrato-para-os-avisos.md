# Laboratório 14 — Um contrato para os avisos

Na Aula 14, `Pedido` deixou de exigir uma entrega concreta e passou a depender
do papel `Entrega`. Agora você aplicará a mesma ideia ao **Projeto 2 — Sistema de
lembretes e notificações**. Seu ponto de partida é o código do Laboratório 12
com os testes acrescentados no Laboratório 13.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode esclarecer mensagens de compilação e ajudar você a comparar o
    código com os requisitos. Ela não deve escrever a interface, refatorar as
    classes ou adaptar os testes por você.

## Objetivos

- expressar como contrato a capacidade de enviar uma mensagem;
- fazer e-mail, SMS e painel cumprirem esse contrato;
- fazer `Lembrete` colaborar por `Notificador`, preservando mensagem e contagem;
- executar e adaptar os testes do Laboratório 13 sem perder suas expectativas; e
- acrescentar um canal sem modificar `Lembrete`.

## Ponto de partida e comportamento a preservar

Use **sua solução final do [Laboratório 13](laboratorio-13-protegendo-os-avisos-do-lembrete.md)**.
O Laboratório 12 permitiu APIs diferentes para SMS e painel; por isso, seu
`Lembrete` pode ter métodos, campos ou escolhas que não aparecem no projeto de
outro estudante. Todas essas soluções compartilham estes comportamentos:

- `new Lembrete("Revisar colaboração", new NotificadorEmail("Agenda"))`
  configura o canal inicial de e-mail;
- `avisar()` envia por esse canal inicial e soma um aviso;
- o mesmo lembrete também consegue avisar por SMS e painel, contando cada envio
  uma única vez; e
- `getQuantidadeAvisos()` permite observar o contador de cada lembrete.

Execute **todos os testes de `LembreteTest` antes de alterar a produção**.
Confirme também, no console, o cenário final do Laboratório 12: e-mail, SMS,
painel, e-mail, com contadores `1`, `2`, `3` e `4`. Guarde essa referência para
comparar com o resultado final. Os testes atuais verificam contadores; os
prefixos impressos ainda exigem conferência no console.

Se algum teste já falhar, descubra a causa antes de prosseguir. A atividade
parte de uma Versão 1 funcionando; a mudança deste laboratório é na forma de
colaborar, não nos resultados combinados.

## Incremento A — Dar nome à capacidade comum

Olhe para `NotificadorEmail`, `NotificadorSms` e `NotificadorPainel`. As três
classes oferecem `public void enviar(String mensagem)` e produzem formatos
diferentes. Complete a frase antes de escrever código: **“`Lembrete` precisa
de algo capaz de...”**

??? "Ver resposta"

    “...enviar a mensagem do lembrete.” O papel comum é o envio; `EMAIL
    [Agenda]`, `SMS` e `PAINEL` continuam sendo decisões de cada canal.

Crie `Notificador.java` com um contrato público que exija essa operação. Faça
as três classes concretas assumirem o contrato, mantendo a saída que cada uma
já produz. Neste incremento, **não altere `Lembrete`**. Compile e execute a
suíte do Laboratório 13 novamente.

??? tip "Dica — declaração mínima"

    Uma interface reúne a assinatura necessária: `void enviar(String
    mensagem);`. Em cada classe concreta, `implements Notificador` declara a
    promessa. O método que a cumpre precisa continuar `public`.

Antes de executar, preveja: a mudança de declaração, sozinha, fará o
construtor atual de `Lembrete` aceitar qualquer notificador? O que deve
acontecer com os testes neste ponto?

??? "Ver resultado e explicação"

    - Os testes devem continuar passando, com os mesmos contadores e saídas.
    - Declarar `implements Notificador` faz os objetos cumprirem o contrato,
      mas não muda automaticamente um parâmetro ou campo que ainda esteja
      declarado como `NotificadorEmail`.

## Incremento B — Fazer `Lembrete` depender do contrato

Agora reorganize `Lembrete` para que seus campos e assinaturas de colaboração
dependam de `Notificador`, sem citar `NotificadorEmail`, `NotificadorSms` ou
`NotificadorPainel`. Preserve o canal inicial recebido no construtor e a
operação `avisar()` para ele. Para escolher outro canal em um aviso, ofereça
também esta operação pública:

```java
public void avisarPor(Notificador notificador)
```

Ela deve solicitar um envio ao objeto recebido e aumentar o contador do mesmo
lembrete exatamente uma vez. `avisar()` deve continuar usando o colaborador
guardado na criação. Mantenha `getQuantidadeAvisos()`.

O exercício considera notificadores existentes e diferentes de `null`, como
no Laboratório 12. Não é necessário criar tratamento de falhas de envio.

??? tip "Dica — preserve uma única regra de contagem"

    Depois de implementar `avisarPor(...)`, `avisar()` pode solicitar o aviso
    pelo notificador guardado. Assim, a operação que envia e conta fica em um
    único lugar. Confira se nenhuma rota soma duas vezes.

Atualize `Main` para o cenário de **um lembrete** com mensagem `"Revisar
colaboração"` e e-mail de origem `"Agenda"`. Solicite, nesta ordem, e-mail
pelo canal inicial, SMS, painel e e-mail novamente pelo canal inicial. Mostre
o contador após cada aviso.

Os testes do Laboratório 13 descrevem comportamentos que continuam válidos.
Caso algum teste use um construtor ou uma operação específica de SMS ou painel
que você retirou, adapte a preparação e a chamada necessárias para usar
`avisarPor(...)`, conservando o nome, a sequência de canais e o valor esperado
do teste. As verificações de e-mail por `avisar()`
e de independência entre lembretes devem continuar com as mesmas expectativas.
Execute a classe `LembreteTest` inteira. Se falhar, investigue a diferença antes
de seguir.

Antes de executar `Main`, preveja as oito linhas. `Lembrete` ainda precisa
conhecer alguma classe concreta de canal? A mudança fez o contador pertencer
ao notificador?

??? "Ver resultado e explicação"

    ```text
    EMAIL [Agenda]: Revisar colaboração
    1
    SMS: Revisar colaboração
    2
    PAINEL: Revisar colaboração
    3
    EMAIL [Agenda]: Revisar colaboração
    4
    ```

    O contador continua em `Lembrete`. A classe solicita `enviar(mensagem)`
    pelo contrato `Notificador`, sem selecionar e-mail, SMS ou painel em seu
    próprio código. O teste pode precisar de uma nova chamada porque a API
    mudou; sua expectativa de contagem deve permanecer igual.

## Incremento C — Uma implementação que `Lembrete` ainda não conhece

Chegou um aviso para o aplicativo. Crie `NotificadorApp`, que cumpre o mesmo
contrato. Ao receber `"Revisar colaboração"`, ele deve imprimir:

```text
APP: Revisar colaboração
```

Antes de integrar, preveja quais arquivos de produção precisarão mudar para
criar e usar esse canal. Em `Main`, depois dos quatro avisos anteriores,
solicite mais um envio pelo aplicativo no **mesmo lembrete** e mostre o
contador. Acrescente a `LembreteTest` um teste com nome descritivo que faça um
lembrete novo avisar pelo aplicativo e verifique seu contador. Execute a suíte
inteira.

??? "Ver resultado e explicação"

    - A sequência anterior mantém suas oito linhas. As duas linhas novas são
      `APP: Revisar colaboração` e `5`.
    - No teste com um lembrete novo e um envio pelo aplicativo, o contador
      observado deve ser `1`.
    - O novo arquivo `NotificadorApp.java` e o código que cria ou testa esse
      objeto precisam mudar. `Lembrete.java` e `Notificador.java` não precisam
      ser modificados para aceitar essa quarta implementação.

## Verificação final

!!! success "Critérios de conclusão"

    - O projeto compila com `Notificador.java`, os quatro notificadores,
      `Lembrete.java`, `Main.java` e `LembreteTest.java`.
    - Os quatro notificadores cumprem `Notificador` e cada um conserva seu
      formato de saída.
    - `Lembrete` declara o colaborador pelo contrato; seu código não cita os
      nomes das classes concretas dos canais.
    - `avisar()` usa o canal inicial; `avisarPor(Notificador)` aceita qualquer
      um dos quatro canais; ambos contam um aviso por envio.
    - Os testes do Laboratório 13 continuam verificando os mesmos valores e
      passam junto com o novo teste do aplicativo.
    - `Main` produz a sequência de cinco avisos e contadores de `1` a `5`.
      A inclusão do aplicativo não exigiu alteração em `Lembrete`.

## Para pensar após a implementação

1. O que permaneceu igual quando as referências em `Lembrete` passaram a ser
   declaradas como `Notificador`?
2. `Lembrete` conhece o canal escolhido para cada aviso ou precisa conhecer a
   classe concreta desse canal?
3. Quando `enviar(mensagem)` é chamado por uma referência `Notificador`, como
   Java decide qual corpo do método executar?

??? "Ver uma análise possível"

    1. Mensagem, formatos, canal inicial, contagem e resultados observáveis
       permaneceram. Mudou o tipo de que `Lembrete` depende.
    2. O objeto recebido determina o canal usado, mas `Lembrete` precisa
       conhecer somente a operação prometida pelo contrato. A criação e a
       escolha concreta acontecem fora dele.
    3. O contrato garante que a chamada é possível; a explicação de como a
       implementação executada é escolhida será o problema da Aula 15.

As respostas servem para autoavaliação e não integram a entrega.

## Entrega

Entregue somente os arquivos `.java` do **Projeto 2** ao fim deste laboratório,
incluindo `LembreteTest.java`, conforme as orientações do
[Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).
Previsões, respostas de reflexão e prints não precisam ser enviados.

## Materiais relacionados

- [Aula 14 — Do colaborador concreto ao contrato](aula-14-do-colaborador-concreto-ao-contrato.md)
- [Laboratório 13 — Protegendo os avisos do lembrete](laboratorio-13-protegendo-os-avisos-do-lembrete.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
