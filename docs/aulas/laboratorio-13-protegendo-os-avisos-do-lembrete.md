# Laboratório 13 — Protegendo os avisos do lembrete

Na Aula 13, transformamos uma expectativa em uma verificação executável. Agora você fará isso no **Projeto 2 — Sistema de lembretes e notificações**, a partir da **Versão 1 concluída no Laboratório 12**. Antes de reorganizar a colaboração com os notificadores, queremos verificar automaticamente comportamentos que já funcionam.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode ajudar a interpretar uma falha, esclarecer `@Test` e `assertEquals` e fazer perguntas sobre o cenário. Ela não deve escrever os testes por você nem decidir quais expectativas são corretas.

## Objetivos

- escrever testes JUnit para o comportamento público de `Lembrete`;
- montar cenários independentes com resultados determinados;
- verificar o contador após avisos por e-mail, SMS e painel;
- conferir que lembretes diferentes mantêm contadores independentes; e
- interpretar o que uma falha detecta e o que os testes ainda não verificam.

## Ponto de partida — Projeto 2 após o Laboratório 12

Use **sua solução final do [Laboratório 12](laboratorio-12-quando-uma-segunda-solucao-aparece.md)**. Ela já contém `Main`, `Lembrete`, `NotificadorEmail`, `NotificadorSms` e `NotificadorPainel`. O e-mail recebe a origem `"Agenda"`; o lembrete usa a mensagem `"Revisar colaboração"`. Um mesmo lembrete consegue avisar pelos três canais e seu contador aumenta exatamente uma vez a cada aviso.

O Laboratório 12 permitiu mais de uma forma de integrar SMS e painel: operações específicas, parâmetros ou seleção por código. **Mantenha a API da sua solução.** Nos cenários abaixo, “avisar por SMS” e “avisar pelo painel” significam chamar as operações que você já implementou para esses canais. Não crie uma interface nem reorganize `Lembrete` neste laboratório.

Vamos observar `getQuantidadeAvisos()`, que já é público. Os formatos `EMAIL [Agenda]: ...`, `SMS: ...` e `PAINEL: ...` continuam visíveis no console, mas não serão capturados por estes primeiros testes JUnit. Isso delimita o que a suíte verifica.

Crie uma pasta de testes no seu projeto e configure **JUnit Jupiter** na IDE. No IntelliJ IDEA, marque essa pasta como pasta de testes e use a opção de adicionar suporte a JUnit se `@Test` aparecer como não resolvido. Em outra ferramenta, configure a mesma biblioteca e execute a classe de testes por ela. Maven e Gradle não são conteúdo desta prática.

Crie `LembreteTest.java` com este primeiro teste. Ele usa apenas operações presentes no ponto de partida do Laboratório 12:

```java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class LembreteTest {
    @Test
    void avisoPorEmailAumentaContadorUmaVez() {
        NotificadorEmail email = new NotificadorEmail("Agenda");
        Lembrete lembrete =
            new Lembrete("Revisar colaboração", email);

        lembrete.avisar();

        assertEquals(1, lembrete.getQuantidadeAvisos());
    }
}
```

Execute `LembreteTest`. O teste deve passar e o envio simulado deve imprimir `EMAIL [Agenda]: Revisar colaboração`. Se não compilar, confira a biblioteca JUnit e a organização das pastas antes de investigar o código do lembrete.

Em cada incremento, **acrescente testes à mesma classe**, execute a classe inteira e confira os resultados. Crie novos objetos dentro de cada método para que um teste não dependa do estado deixado por outro. As classes do projeto já implementam as regras: a evolução deste laboratório está nos testes.

## Incremento A — O contador nasce e evolui

O primeiro teste mostra o efeito de um aviso por e-mail. Acrescente **dois testes**:

1. `lembreteNovoComecaSemAvisos`: crie um `Lembrete` novo com mensagem `"Revisar colaboração"` e um `NotificadorEmail` de origem `"Agenda"`. Sem chamar `avisar()`, verifique seu contador.
2. `doisAvisosPorEmailSaoContados`: em outro lembrete novo, chame `avisar()` duas vezes e verifique o contador final.

Preveja os dois resultados antes de executar. Por que os testes não devem compartilhar o mesmo `Lembrete`?

??? "Ver resultado e explicação"

    1. Um lembrete novo começa com `0` avisos.
    2. Duas chamadas a `avisar()` produzem contador `2`.

    Cada teste cria seu próprio cenário. Se compartilhassem um lembrete, o resultado dependeria da ordem de execução dos métodos de teste, e a expectativa deixaria de descrever apenas aquele cenário.

## Incremento B — O mesmo lembrete usa outros canais

Agora acrescente **dois testes** usando as operações de SMS e painel da sua solução final do Laboratório 12:

1. `emailESmsCompartilhamContador`: crie um lembrete, faça um aviso por e-mail e depois um por SMS. Verifique o contador do mesmo objeto após as duas chamadas.
2. `emailSmsPainelEEmailSaoContados`: em outro lembrete novo, avise nesta ordem: e-mail, SMS, painel e e-mail novamente. Verifique o contador final.

Em ambos, use a mensagem `"Revisar colaboração"` e origem de e-mail `"Agenda"`. Forneça ou alcance os outros notificadores da mesma forma que sua implementação do Laboratório 12 já faz. Antes de executar, preveja os contadores e as linhas de envio exibidas pelo segundo cenário.

??? "Ver resultado e explicação"

    1. E-mail seguido de SMS deixa o contador em `2`.
    2. A sequência de quatro avisos deixa o contador em `4` e exibe, nesta ordem:

        ```text
        EMAIL [Agenda]: Revisar colaboração
        SMS: Revisar colaboração
        PAINEL: Revisar colaboração
        EMAIL [Agenda]: Revisar colaboração
        ```

    O teste JUnit verifica o **contador**. As quatro linhas são uma conferência manual da execução; `assertEquals(4, ...)` não verifica sozinho o texto impresso nem a ordem das mensagens.

??? tip "Dica — preserve sua API"

    Se sua solução usa operações específicas, chame as operações de SMS e painel que você já escreveu. Se usa seleção por parâmetro, forneça os valores definidos no seu próprio código. O teste descreve a sequência e o resultado, sem exigir que todos tenham a mesma assinatura.

## Incremento C — Dois lembretes não compartilham contador

Acrescente `lembretesMantemContadoresIndependentes`: crie **dois** objetos `Lembrete`, com mensagens `"Revisar colaboração"` e `"Revisar testes"`, cada um com seu próprio `NotificadorEmail`. Use `"Agenda"` como origem do primeiro e `"Monitoria"` como origem do segundo. Faça o primeiro avisar duas vezes por e-mail e o segundo avisar uma vez por e-mail. Verifique **ambos** os contadores no mesmo teste.

Quais valores devem aparecer nas duas verificações? Esse teste precisaria ler o campo privado `quantidadeAvisos`?

??? "Ver resultado e explicação"

    O primeiro contador deve ser `2` e o segundo, `1`. O teste não acessa o campo privado: `getQuantidadeAvisos()` permite observar o comportamento público de cada objeto. As origens diferentes ajudam a identificar os envios no console; as expectativas JUnit são os contadores independentes.

Escolha ainda **uma regra de contagem** do estado atual do projeto e escreva um teste com nome descritivo. Você pode, por exemplo, fazer dois avisos seguidos pelo painel e esperar `2`, ou SMS, e-mail, SMS e esperar `3`. Use as operações existentes na sua solução. O cenário deve deixar claro qual erro a expectativa detectaria.

??? "Ver critérios para sua escolha"

    - Um lembrete novo que avisa duas vezes pelo painel deve terminar com `2`.
    - Um lembrete novo que avisa por SMS, e-mail e SMS deve terminar com `3`.
    - Em qualquer alternativa, o nome deve descrever a regra, o cenário deve começar com um lembrete novo e a verificação deve observar `getQuantidadeAvisos()`.

Com a suíte verde, faça uma experiência **temporária**: altere `Lembrete.avisar()` para que um aviso por e-mail deixe de aumentar o contador. Execute todos os testes, observe quais falham, restaure a contagem original e execute novamente. Se a contagem estiver concentrada em uma operação compartilhada, faça a alteração no ponto que afeta `avisar()` e confira também seu efeito nos outros canais.

??? "Ver resultado esperado"

    O teste `avisoPorEmailAumentaContadorUmaVez()` deve falhar: espera `1` e observa `0`. Testes que incluem e-mail também podem falhar; o conjunto exato depende de onde sua solução concentra a contagem. `lembreteNovoComecaSemAvisos()` continua esperando `0`. Depois da restauração, todos os testes devem voltar a passar. A falha mostra que a suíte detecta essa alteração, sem provar que cobre todos os defeitos possíveis.

## Verificação final

!!! success "Critérios de conclusão"

    - O projeto continua com `Main`, `Lembrete` e os três notificadores da Versão 1 do Projeto 2.
    - `LembreteTest` contém o teste inicial e seis testes novos: dois do Incremento A, dois do B, independência entre lembretes e uma regra escolhida.
    - Cada teste usa um cenário próprio, verifica comportamento público e tem nome que comunica a regra.
    - A classe de testes inteira passa após restaurar a alteração temporária.
    - A colaboração com os notificadores e a API da solução do Laboratório 12 permanecem funcionais.

## Antes de reorganizar a colaboração

Qual desses testes você mais gostaria de executar antes de mudar como `Lembrete` se relaciona com os notificadores? Que comportamento importante ainda depende da conferência do console?

??? "Ver uma análise possível"

    O teste da sequência e-mail → SMS → painel → e-mail protege a coexistência das três alternativas e a contagem de um mesmo lembrete. O teste de independência protege o estado de cada objeto. Os formatos e a ordem das mensagens impressas ainda não estão cobertos pelas verificações JUnit deste laboratório; a suíte oferece evidência somente sobre os cenários e resultados que ela observa.

A próxima pergunta permanece: como expressar em Java que `Lembrete` precisa de **algo capaz de enviar a mensagem**, sem conhecer cada classe concreta?

## Entrega

Entregue somente os arquivos `.java` do **Projeto 2**, incluindo `LembreteTest.java`, conforme as orientações do [Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5). Previsões, respostas de reflexão, prints e mensagens de falha não compõem a entrega.

## Materiais relacionados

- [Aula 13 — Como saber se ainda funciona?](aula-13-como-saber-se-ainda-funciona.md)
- [Laboratório 12 — Quando uma segunda solução aparece](laboratorio-12-quando-uma-segunda-solucao-aparece.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
