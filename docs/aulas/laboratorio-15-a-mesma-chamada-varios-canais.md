# Laboratório 15 — A mesma chamada, vários canais

Na Aula 15, a mesma chamada chegou a implementações diferentes conforme o
objeto alcançado pela referência. Agora você aplicará esse raciocínio ao
**Projeto 2 — Sistema de lembretes e notificações**: um lembrete poderá enviar
sua mensagem por uma sequência de canais, sem precisar identificar a classe de
cada notificador.

!!! info "Uso de IA — Nível 1: Tutor"

    A IA pode esclarecer conceitos, mensagens de compilação e falhas de teste.
    Ela não deve implementar a operação, montar o cenário ou escrever os testes
    por você.

## Objetivos

- percorrer uma lista de colaboradores declarados pelo contrato `Notificador`;
- solicitar a mesma operação a objetos de classes diferentes;
- preservar o canal inicial e contar cada envio uma única vez; e
- verificar sequências com testes e observação das saídas dos canais.

## Ponto de partida

Continue sua solução final do
[Laboratório 14](laboratorio-14-um-contrato-para-os-avisos.md). Ela deve conter:

- `Notificador` e suas implementações para e-mail, SMS, painel e aplicativo;
- `Lembrete`, com canal inicial recebido no construtor, `avisar()`,
  `avisarPor(Notificador)` e `getQuantidadeAvisos()`;
- `Main`, com os cinco avisos do laboratório anterior; e
- `LembreteTest`, com JUnit Jupiter já configurado.

Execute a suíte antes de mudar a produção. Confira também o cenário de `Main`:
mensagem `"Revisar colaboração"`, e-mail de origem `"Agenda"` e envios na ordem
e-mail, SMS, painel, e-mail, aplicativo. Os contadores devem ir de `1` a `5`.
Se houver diferenças, investigue-as antes de acrescentar a nova operação.

Para a lista, use os recursos retomados na
[Aula 15](aula-15-polimorfismo-a-mesma-mensagem-comportamentos-diferentes.md#a-mesma-operacao-em-um-percurso-de-objetos-diferentes):
`List<Notificador>`, `ArrayList`, `add` e percurso por elementos. Os imports
necessários nos arquivos que usarem esses tipos são:

```java
import java.util.ArrayList;
import java.util.List;
```

Mantenha os arquivos e a configuração de execução do projeto existente.

## Incremento A — Enviar a mensagem por uma sequência de canais

Até agora, o cliente precisava solicitar separadamente cada aviso. Acrescente
a `Lembrete` uma operação que receba uma lista e envie a mensagem do próprio
lembrete por todos os notificadores presentes nela:

```java
public void avisarPorTodos(List<Notificador> notificadores)
```

A operação deve satisfazer estes comportamentos:

- percorrer a lista na ordem fornecida e solicitar um envio por posição;
- aumentar o contador do lembrete uma vez para cada envio;
- conservar o canal inicial, a mensagem e os comportamentos de `avisar()` e
  `avisarPor(Notificador)`;
- deixar a lista recebida com os mesmos elementos e na mesma ordem;
- com uma lista vazia, não enviar mensagens nem alterar o contador; e
- se a mesma referência aparecer em duas posições, realizar dois envios.

Considere listas e notificadores diferentes de `null`, como nos cenários
anteriores. O exercício não acrescenta regras de falhas de envio.

`Lembrete` deve continuar dependendo de `Notificador`. Ele não precisa citar
`NotificadorEmail`, `NotificadorSms`, `NotificadorPainel` ou `NotificadorApp`
para selecionar um comportamento durante o percurso.

??? tip "Dica — aproveite a operação de um envio"

    `avisarPor(...)` já solicita o envio e atualiza o contador. Considere como
    reutilizar esse comportamento para cada elemento do percurso. Somar ao
    contador também no método externo pode contar o mesmo envio duas vezes.

### Integrar ao cenário de execução

Preserve os cinco avisos existentes em `Main`. Depois deles, no **mesmo
lembrete**:

1. Crie uma `List<Notificador>` e inclua, nesta ordem, um notificador SMS,
   um painel e um aplicativo.
2. Solicite o envio pela lista usando a nova operação e mostre o contador
   depois que ela terminar.
3. Solicite `avisar()` e mostre o contador novamente.

Antes de executar, preveja as novas linhas de saída. O envio pela lista muda
o canal inicial? O contador deve aumentar uma vez pela operação inteira ou
uma vez por envio?

??? "Ver resultado e explicação"

    Depois das dez linhas do cenário anterior, devem aparecer estas seis:

    ```text
    SMS: Revisar colaboração
    PAINEL: Revisar colaboração
    APP: Revisar colaboração
    8
    EMAIL [Agenda]: Revisar colaboração
    9
    ```

    - A lista produz três envios; o contador passa de `5` para `8`.
    - O canal inicial continua sendo o e-mail. A chamada a `avisar()` produz
      o nono envio.
    - A operação pelo contrato chega a cada implementação conforme o objeto
      atual. O corpo do percurso não precisa identificar sua classe.

Compile, execute `Main` e compare a ordem, os formatos e os contadores. Execute
também a suíte inteira. Corrija diferenças antes de seguir.

Ao concluir este incremento, `Lembrete` deve oferecer a nova operação e `Main`
deve demonstrar os nove envios, preservando os cinco anteriores.

## Incremento B — Proteger o comportamento das sequências

Uma lista com três elementos verifica o caso mais visível. Agora amplie
`LembreteTest` para proteger situações em que contar chamadas ou percorrer
referências incorretamente pode passar despercebido.

Acrescente os quatro testes abaixo, preservando os testes existentes. Cada
teste cria seu próprio lembrete com mensagem `"Revisar colaboração"` e canal
inicial de e-mail com origem `"Agenda"`. Use nomes descritivos; os nomes da
tabela são sugestões.

| Teste | Preparação e ações | Verificações com `assertEquals` |
| --- | --- | --- |
| `sequenciaContaCadaEnvioEAcumulaAvisoSeguinte` | Monte a lista SMS, painel e aplicativo; envie pela lista; depois solicite `avisar()`. | Contador `3` logo após a lista e `4` depois de `avisar()`. |
| `listaVaziaPreservaContadorExistente` | Faça um aviso inicial, confira o contador e depois envie por uma lista vazia. | Contador `1` antes e `1` depois da lista. |
| `mesmaReferenciaEmDuasPosicoesEnviaDuasVezes` | Crie um único objeto SMS, inclua sua referência duas vezes na lista e solicite o envio pela lista. | Contador `2`. |
| `mesmaListaPodeSerUsadaNovamente` | Monte a lista SMS, painel e aplicativo e use a mesma lista em duas chamadas consecutivas. | Contador `3` após a primeira chamada e `6` após a segunda; após cada chamada, lista com tamanho `3` e as mesmas referências nas posições originais. |

No teste de reutilização, guarde em variáveis os três notificadores antes de
incluí-los na lista. Depois de **cada** chamada a `avisarPorTodos(...)`, confira
o tamanho e compare cada elemento com a variável original: SMS na posição `0`,
painel na `1` e aplicativo na `2`. Assim, o teste detecta também substituições
ou mudanças de ordem que apenas conferir o tamanho não revelaria.

??? tip "Dica — confira os elementos por posição"

    `get(indice)` fornece a referência daquela posição, contando a partir de
    zero. Se a variável original do SMS se chama `sms`, uma das verificações é
    `assertEquals(true, notificadores.get(0) == sms)`: `==` confere se as duas
    referências alcançam o mesmo objeto. Faça o equivalente para os outros dois
    objetos, além de conferir `size()`.

Preveja também quais canais devem aparecer no console em cada teste. No teste
com duas posições, foram criados dois objetos SMS? Isso muda o número de envios?

??? "Ver saídas esperadas e explicação"

    1. **Sequência e canal inicial:** SMS, painel, aplicativo e depois e-mail
       com origem `Agenda`, todos com a mesma mensagem.
    2. **Lista vazia:** somente o e-mail do aviso anterior. A chamada com a lista
       vazia não acrescenta saída nem zera o contador.
    3. **Referência repetida:** duas linhas `SMS: Revisar colaboração`. Existe
       apenas um objeto SMS, que recebe duas chamadas por ocupar duas posições.
    4. **Lista reutilizada:** SMS, painel, aplicativo, SMS, painel, aplicativo.
       Cada chamada percorre a sequência completa. A lista mantém três posições.

    O número de envios depende das posições percorridas, não da quantidade de
    objetos distintos. Copiar uma referência para outra posição não cria um
    novo notificador e não elimina aquela passagem do laço.

??? tip "Dica — referências repetidas e lista vazia"

    Para repetir o mesmo objeto, crie-o uma vez e forneça a mesma variável a
    duas chamadas de `add`. Para o caso vazio, crie uma `ArrayList` e não inclua
    elementos. Cada teste continua marcado com `@Test`, usando os imports JUnit
    já presentes em `LembreteTest`.

Execute `LembreteTest` inteira. O executor pode executar os testes em outra
ordem: compare a saída de cada teste com seu próprio cenário, sem depender
da ordem global dos métodos.

Os `assertEquals` solicitados verificam os contadores, o tamanho da lista e a
preservação dos notificadores nas posições originais.
**Eles não verificam os prefixos nem a ordem dos canais automaticamente.**
Confira esses comportamentos no console de `Main` e de cada teste. Um programa
que conte corretamente, mas use o canal errado, ainda precisa ser corrigido.

Ao concluir este incremento, os quatro novos testes e os anteriores devem
passar, com as saídas coerentes com os cenários.

## Verificação final

!!! success "Critérios de conclusão"

    - O projeto compila com os arquivos anteriores e a nova operação
      `avisarPorTodos(List<Notificador>)`.
    - A sequência respeita a ordem, conta um envio por posição e funciona
      com referências de classes diferentes pelo contrato.
    - Lista vazia não envia nem altera o contador; referência repetida provoca
      um envio por ocorrência; a lista recebida não é alterada.
    - `avisar()` continua usando o canal inicial, e `avisarPor(...)` continua
      realizando um envio pelo argumento recebido.
    - `Lembrete` conserva a mensagem e depende do contrato, sem selecionar
      classes concretas durante o percurso.
    - `Main` preserva os cinco avisos anteriores, acrescenta os três pela lista
      e termina com e-mail pelo canal inicial, chegando ao contador `9`.
    - A suíte preserva os testes existentes e contém os quatro novos cenários,
      todos passando.

## Para pensar após a implementação

1. A variável do laço continua tendo tipo `Notificador`. O que determina qual
   implementação de `enviar(...)` executa a cada passagem?
2. Por que enviar pela sequência não substitui o canal inicial? Que alteração
   seria necessária para substituí-lo?

??? "Ver uma análise possível"

    1. O objeto alcançado pela referência na posição atual determina a
       implementação executada por despacho dinâmico. O contrato permite a
       chamada e cada objeto realiza seu envio.
    2. O percurso usa os objetos da lista sem atribuí-los ao campo do canal
       inicial. Substituir esse colaborador exigiria uma atribuição ao campo
       dentro de `Lembrete`, comportamento que esta operação não solicita.

As respostas e previsões servem para compreender e conferir o programa; não
integram a entrega.

## Entrega

Entregue somente os arquivos `.java` do **Projeto 2** ao fim deste laboratório,
incluindo `LembreteTest.java`, conforme as orientações do
[Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).
Previsões, diagramas, respostas de reflexão e prints não precisam ser enviados.

## Materiais relacionados

- [Aula 15 — Polimorfismo: a mesma mensagem, comportamentos diferentes](aula-15-polimorfismo-a-mesma-mensagem-comportamentos-diferentes.md)
- [Laboratório 14 — Um contrato para os avisos](laboratorio-14-um-contrato-para-os-avisos.md)
- [Laboratório 13 — Protegendo os avisos do lembrete](laboratorio-13-protegendo-os-avisos-do-lembrete.md)
- [Java essencial para quem já sabe programar](../materiais/java-essencial.md)
