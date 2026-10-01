# Laboratório 12 — Quando uma segunda solução aparece

Na Aula 12, uma colaboração adequada passou a ter um limite quando outra classe
pôde realizar o mesmo trabalho. Agora você investigará essa situação em um
pequeno sistema de lembretes. O objetivo é fazer as alternativas funcionarem com
o repertório atual e perceber onde o código precisa mudar.

!!! info "Prática autônoma — em casa"

    Este laboratório é realizado em casa. O código inicial e os resultados de
    verificação estão nesta página. A prática é uma transferência independente
    do Projeto 1; não exige adaptar pedidos nem define o Projeto 2.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode ajudar a interpretar erros, esclarecer chamadas e fazer perguntas
    sobre responsabilidades e referências. Ela não deve gerar a solução,
    decidir sua organização nem introduzir recursos ainda não estudados.

## Objetivos

- compreender uma colaboração entre um lembrete e seu canal de aviso;
- modificar a regra do canal sem deslocá-la para o lembrete;
- incorporar alternativas concretas usando recursos conhecidos;
- identificar quais classes passaram a conhecer as alternativas; e
- distinguir a responsabilidade estável das formas que podem realizá-la.

## Ponto de partida — um lembrete que já funciona

Um `Lembrete` mantém sua mensagem e conta quantos avisos foram realizados.
Inicialmente, o canal disponível é `NotificadorEmail`, recebido na criação.
Cada chamada a `avisar()` solicita um envio e aumenta o contador uma vez.

Todos os canais desta prática **simulam** envio escrevendo no console. Não há
rede, conta de e-mail, telefone, biblioteca externa nem possibilidade de falha
de envio neste recorte. As mensagens e os colaboradores fornecidos existem e
não são `null`.

Crie um projeto Java pequeno e coloque as três classes abaixo na mesma pasta de
código-fonte, cada uma em seu arquivo. Use a IDE ou, na pasta dos arquivos,
`javac Main.java Lembrete.java NotificadorEmail.java` e `java Main`.

**NotificadorEmail.java**

```java
public class NotificadorEmail {
    public void enviar(String mensagem) {
        System.out.println("EMAIL: " + mensagem);
    }
}
```

**Lembrete.java**

```java
public class Lembrete {
    private String mensagem;
    private NotificadorEmail notificador;
    private int quantidadeAvisos;

    public Lembrete(String mensagem, NotificadorEmail notificador) {
        this.mensagem = mensagem;
        this.notificador = notificador;
        quantidadeAvisos = 0;
    }

    public void avisar() {
        notificador.enviar(mensagem);
        quantidadeAvisos++;
    }

    public int getQuantidadeAvisos() {
        return quantidadeAvisos;
    }
}
```

**Main.java**

```java
public class Main {
    public static void main(String[] args) {
        NotificadorEmail email = new NotificadorEmail();
        Lembrete lembrete =
            new Lembrete("Revisar colaboração", email);

        lembrete.avisar();
        System.out.println(lembrete.getQuantidadeAvisos());
    }
}
```

Antes de executar, preveja a saída. Quem conhece o formato do aviso? Que
responsabilidade fica em `Lembrete`?

??? "Ver resposta"

    ```text
    EMAIL: Revisar colaboração
    1
    ```

    `NotificadorEmail` conhece o formato do envio. `Lembrete` mantém a mensagem,
    solicita o envio e conta avisos. A colaboração é adequada ao requisito
    inicial, que possui apenas esse canal.

Preserve esse ponto de partida em uma cópia. Em cada incremento, preveja,
modifique, execute e confira o resultado. As anotações ajudam a investigar;
a entrega será somente código.

## Incremento A — Evoluir o canal que já existe

Agora o aviso por e-mail deve mostrar também a origem. Faça `NotificadorEmail`
receber essa informação no construtor e mantê-la em um campo privado. A saída
de cada envio deve seguir este formato, com a origem recebida:

```text
EMAIL [Agenda]: Revisar colaboração
```

Em `Main`, crie o canal com origem `"Agenda"` e faça o mesmo lembrete avisar
**duas vezes**, mostrando o contador depois de cada aviso. Preserve a mensagem,
o comportamento de `avisar()` e as responsabilidades de `Lembrete`.

??? tip "Dica"

    Um construtor como `public NotificadorEmail(String origem)` pode guardar
    `this.origem = origem;`. A expressão de saída pode combinar textos e esse
    campo com `+`, como o código inicial já faz com `mensagem`.

Preveja as quatro linhas e localize quais arquivos precisam mudar. O lembrete
deve precisar aprender a montar o novo formato?

??? "Ver resultado e análise"

    ```text
    EMAIL [Agenda]: Revisar colaboração
    1
    EMAIL [Agenda]: Revisar colaboração
    2
    ```

    Muda `NotificadorEmail`, que mantém a origem e compõe a saída, e muda sua
    criação em `Main`. `Lembrete` pode continuar exatamente igual: o tipo do
    colaborador e o comportamento que ele solicita permanecem os mesmos.

## Incremento B — Um segundo canal precisa coexistir

Chegou outro requisito: também devemos avisar por SMS. Crie `NotificadorSms`
com uma operação `public void enviar(String mensagem)` que produza:

```text
SMS: Revisar colaboração
```

Antes de integrar o canal, experimente temporariamente em `Main`:

```java
NotificadorSms sms = new NotificadorSms();
Lembrete lembrete = new Lembrete("Revisar colaboração", sms);
```

O construtor atual deve aceitar o novo argumento? Preveja antes de compilar.

??? "Ver resposta"

    Não. O parâmetro de `Lembrete` pede `NotificadorEmail`; `sms` referencia
    um objeto de outra classe. As duas classes terem `enviar(String)` não faz
    o compilador aceitar essa substituição no código apresentado.

Confira a mensagem de compilação e retire a tentativa para retomar um estado
compilável. Agora evolua a solução com campos, métodos, parâmetros e condições
que você já conhece. Você pode acrescentar operações específicas ou uma escolha
por código numérico; justifique para si o que sua proposta faz o lembrete conhecer.

O programa deve permitir ao **mesmo objeto `Lembrete`**:

- continuar usando `avisar()` para o canal de e-mail original;
- realizar um aviso por SMS quando solicitado explicitamente;
- manter a mesma mensagem nos dois canais;
- aumentar o mesmo contador exatamente uma vez por envio; e
- deixar a formatação de cada canal em seu respectivo notificador.

Não basta substituir todo e-mail por SMS. As duas alternativas devem coexistir.
Você não precisa trocar um campo único entre as duas classes. Caso crie uma
operação específica para SMS, ela pode receber ou alcançar seu colaborador
concreto e efetuar a solicitação; o canal selecionado deve estar disponível
antes da chamada.

??? tip "Dica"

    Campos concretos separados são uma possibilidade com o repertório atual.
    Outra é uma operação que receba `NotificadorSms` para esse aviso.
    Ambas precisam manter em `Lembrete` a coordenação da mensagem e do contador.
    Observe o conhecimento adicional que cada uma exige.

Em `Main`, substitua o cenário anterior por um lembrete novo: avise por e-mail,
exiba o contador, avise por SMS e exiba o contador novamente. Antes de executar,
preveja o resultado e identifique quais arquivos você alterou para integrar SMS.

??? "Ver resultado e critérios"

    ```text
    EMAIL [Agenda]: Revisar colaboração
    1
    SMS: Revisar colaboração
    2
    ```

    Além da nova classe, a integração muda `Main` e, nas propostas acima,
    `Lembrete`: ele passa a conhecer o canal SMS em um campo, parâmetro ou
    operação específica. A tarefa “solicitar um envio e contá-lo” continua a mesma.

## Incremento C — Uma terceira alternativa aparece

O sistema também será usado em uma tela local. Crie `NotificadorPainel` com
`public void enviar(String mensagem)` e esta saída:

```text
PAINEL: Revisar colaboração
```

Antes de integrar, preveja se criar apenas essa classe fará o lembrete conseguir
usá-la. Depois estenda sua solução para aceitar a solicitação explícita de aviso
no painel, mantendo e-mail e SMS disponíveis e cada formatação em sua classe.
O contador do lembrete deve aumentar uma vez para qualquer envio.

Em `Main`, use um único lembrete novo com mensagem `"Revisar colaboração"` e
origem de e-mail `"Agenda"`. Execute, nesta ordem: e-mail, SMS, painel e e-mail
novamente. Exiba o contador depois de cada aviso.

??? "Ver resultado e análise"

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

    Criar a terceira classe não integra automaticamente o canal. Na solução
    concreta construída, precisam mudar também os lugares que recebem,
    alcançam ou selecionam cada alternativa. O último envio confere que
    acrescentar painel não retirou o comportamento de e-mail.

Sua solução pode funcionar e ainda exigir outra alteração no coordenador a
cada novo canal. Esse limite é o resultado da investigação. Não é necessário
resolvê-lo com um recurso novo para concluir o laboratório.

## Verificação final

!!! success "Critérios de conclusão"

    - O projeto compila e executa com os cinco arquivos: `Main`, `Lembrete` e os três notificadores.
    - `NotificadorEmail` mantém a origem privada e mostra o formato especificado.
    - `Lembrete` mantém mensagem e contador privados e preserva `avisar()` para e-mail.
    - Um mesmo lembrete consegue solicitar os três canais e conta cada envio uma vez.
    - Cada notificador formata sua própria saída, sem colocar os prefixos em `Lembrete`.
    - `Main` executa a sequência final e produz as oito linhas previstas.
    - A solução usa apenas os mecanismos já trabalhados; não introduz novos recursos de modelagem.

## Questões para reflexão

1. Por que mudar o formato do e-mail foi diferente de acrescentar SMS?
2. O que permanece estável e o que varia entre os três canais?
3. Se aparecer um quarto canal, onde sua solução precisará mudar? O problema é simplesmente ter um `if`?
4. Que frase descreve de que colaborador o lembrete realmente precisa?
5. Quais comportamentos você verificaria antes de reorganizar essa colaboração?

??? "Ver uma análise possível"

    1. A primeira mudança preservou a classe do colaborador e sua operação.
       SMS trouxe outra classe que não cabia no parâmetro inicial.
    2. Estável: solicitar envio da mensagem e contar o aviso. Variável: quem
       realiza o envio e como representa a saída.
    3. Confira campos, parâmetros, operações, seleção e criação na sua própria
       solução. O problema é quanto conhecimento dos canais o coordenador precisa
       manter; condições podem ser adequadas às responsabilidades que expressam.
    4. “Preciso de algo capaz de enviar esta mensagem.” Não é necessário citar
       e-mail, SMS ou painel para descrever a necessidade.
    5. Mensagem preservada, formato de cada canal, e-mail ainda disponível,
       contador começando em zero e aumentando uma vez por envio, além da
       independência entre lembretes.

As reflexões são para autoavaliação e não precisam ser entregues. A representação
em Java dessa necessidade comum permanece como problema para a sequência da unidade.

## Desafio adicional — objetos diferentes da mesma classe

Crie outro canal `NotificadorEmail` com origem `"Monitoria"` e outro lembrete com
a mesma mensagem. Avise uma vez por cada lembrete e confira a origem e os
contadores. Criar o segundo objeto exige nova classe ou nova seleção de canal?

??? "Ver resultado esperado"

    - Cada e-mail mostra sua origem: `Agenda` ou `Monitoria`.
    - Se os dois lembretes começam novos, cada contador passa de `0` para `1`.
    - Ambos os canais são `NotificadorEmail`; suas instâncias têm estados
      diferentes. Isso não exige ensinar outra classe ao campo inicial.

O desafio é opcional e não integra os critérios de conclusão.

## Entrega

Entregue somente o código-fonte final do Laboratório 12, conforme as orientações
do [Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).
Previsões, respostas, diagramas, prints e mensagens de compilação não compõem a entrega.

## Materiais relacionados

- [Aula 12 — Quando um colaborador começa a variar](aula-12-quando-um-colaborador-comeca-a-variar.md)
- [Aula 11 — Revisão da Unidade 01](aula-11-revisao-da-unidade-01.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
