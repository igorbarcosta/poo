# Laboratório 19 — Iniciando seu jogo

Neste laboratório começa o **Projeto 3**. Cada aluno desenvolverá seu próprio
jogo ao longo da Unidade 03, partindo de uma base executável. A engine fornecida
cuida de janela, teclado e desenho; seu trabalho é construir e evoluir os
objetos, as regras e as colaborações do jogo.

O Megamania acompanha a base como exemplo e será usado nas aulas teóricas.
Você pode consultá-lo como inspiração, sem precisar criar um jogo de nave ou
copiar sua arquitetura.

!!! info "Uso de IA — Nível 3: Colaborador"

    A IA pode ajudar a gerar, revisar e compreender código. Antes de incorporar
    um trecho, compreenda o estado que ele altera, as regras que protege e os
    objetos com que colabora. Você deve conseguir verificar, explicar e
    modificar o código do seu projeto.

## Objetivos

- compreender a separação entre infraestrutura, apresentação e regras;
- implementar uma primeira regra própria com estado e comportamento observáveis;
- proteger esse estado e verificar a regra com JUnit; e
- conectar os comandos e o desenho ao modelo, preservando responsabilidades.

<!-- Dimensionamento interno de referência: preparação e execução 10 min;
leitura da base e escolha do recorte 15; incremento A, com testes, 35;
incremento B 20; verificação e síntese 10. Desafio opcional fora do núcleo.
Pré-requisitos: objetos, estado privado e guardas nas Aulas 03–05;
colaboração na Aula 06; JUnit na Aula 13; contratos na Aula 14;
composição na Aula 16; integração retomada na Aula 19.
Atualização por quadro, intervalo e desenho são infraestrutura fornecida,
explicada para leitura abaixo; não exigir sua implementação, colisões,
temporizadores, física ou novas APIs de linguagem nesta primeira prática.
Incrementos A e B produzem mudanças no código. A escolha e a execução inicial
são preparação, não incrementos autônomos. Não criar prazo ou nota. -->

## Baixar e executar a base

**[Baixar a base do Projeto 3 — ZIP](../materiais/projeto-03/base-jogo-poo.zip)**

O ZIP contém o jogo inicial, a engine, o Megamania, os testes e as instruções.
Você precisa do ambiente Java já usado na disciplina. Não é necessário instalar
Gradle ou configurar bibliotecas. A primeira importação precisa de internet
para baixar as dependências.

No VS Code no Windows:

1. Extraia o ZIP inteiro para uma pasta local do Windows.
2. Abra a pasta `meu-jogo`, que contém `README.md`, `build.gradle` e `.vscode`.
3. Aguarde a importação Java. As extensões recomendadas aparecem no projeto;
   use o suporte Java e o JDK preparados para a disciplina.
4. Em **Executar e Depurar**, selecione **Meu jogo** e pressione **F5**.

Você deve ver um quadrado ciano. Setas ou WASD movem; **R** reinicia a posição;
**Esc** fecha; **F11** alterna tela cheia. Confira esse comportamento antes de
alterar as regras.

??? tip "Se precisar executar pelo terminal"

    Abra o terminal do VS Code na pasta `meu-jogo` e execute:

    ```powershell
    .\gradlew.bat :run
    ```

    No Linux/macOS, use `./gradlew :run`. O `README.md` incluído no ZIP reúne
    as instruções de ambiente. Não é necessário editar `build.gradle`,
    `engine/` ou as configurações da janela para começar.

Para conferir uma alteração, **salve, encerre a execução anterior e execute de
novo**. R reinicia o estado da partida, mas não recompila o código.

## Localizar quem faz cada trabalho

Comece em `src/main/java/meujogo/`:

| Arquivo | Responsabilidade inicial |
| --- | --- |
| `Jogador.java` | Guarda a posição e protege os limites do movimento. |
| `MeuJogo.java` | Recebe os comandos, solicita movimento ao jogador e desenha seu estado. |
| `Iniciar.java` | Abre a janela com o jogo; já está pronto. |

Os testes ficam em `src/test/java/meujogo/JogadorTest.java`. A infraestrutura
fica em `engine/`; o exemplo completo, em `exemplo-megamania/`.

A engine recebe um objeto pelo contrato `Jogo`. Repetidamente, chama
`atualizar(segundos, entrada)` e depois `desenhar(tela)`. Esses métodos já
estão implementados em `MeuJogo`; você vai evoluir seus corpos.

- `Entrada` permite consultar comandos sem acessar a biblioteca gráfica.
- `Tela` permite solicitar formas e texto sem administrar a janela.
- `segundos` é o intervalo da atualização. O movimento já usa esse valor;
  não é necessário reescrever esse cálculo neste laboratório.

A tela lógica mede 960 × 720. A origem fica no canto inferior esquerdo;
`x` cresce para a direita e `y`, para cima. Redimensionar a janela não exige
trocar essas coordenadas. O arquivo `API.md` do ZIP apresenta as operações
disponíveis.

Leia `MeuJogo.atualizar` e `Jogador.mover`. Se o jogador alcançar uma borda,
quem impede que ele continue saindo? Desenhar o quadrado novamente muda sua
posição?

??? "Ver resposta"

    - `MeuJogo` traduz as teclas em direções e solicita `mover` ao jogador.
    - `Jogador.mover` altera a posição e a limita. A proteção pertence ao
      objeto responsável por esse estado.
    - `desenhar` consulta o estado e solicita um retângulo. Desenhar novamente
      não deve movimentar o jogador nem aplicar outra regra da partida.

## Escolher uma primeira regra do seu jogo

Escolha uma ideia que caiba na base: jogo 2D simples, controlado por teclado,
com formas geométricas e texto. Nesta primeira versão, a engine não fornece
imagens, som, mouse ou física pronta.

Dê um título ao jogo em `MeuJogo.getTitulo()`. Em seguida, delimite **uma regra
pequena** que altere um estado e tenha uma condição de aceitação ou um limite.
Não é preciso implementar o jogo inteiro, uma fase completa ou colisões agora.

Para delimitar o recorte, identifique o objeto responsável, seu estado inicial,
a operação e o resultado esperado. Por exemplo:

| Ideia de jogo | Primeira regra possível |
| --- | --- |
| Arena | Um equipamento possui cargas; usar consome uma enquanto houver saldo. |
| Exploração | Recuperar energia aumenta o saldo sem ultrapassar o máximo. |
| Sobrevivência | Receber dano reduz a vida sem permitir valor negativo. |

São opções, não requisitos cumulativos. Você pode escolher outra regra de
complexidade semelhante e aplicá-la ao seu próprio domínio. Não é necessário
criar interfaces ou superclasses adicionais para cumprir uma quantidade de
recursos de Java.

Como saber se o recorte está suficientemente definido para começar?

??? "Ver um exemplo de recorte verificável"

    Em um jogo de arena, um equipamento começa com duas cargas. Cada uso
    aceito consome uma e retorna `true`. Com saldo zero, outro uso retorna
    `false` e preserva o saldo. Consultar as cargas não as modifica.

    Esse recorte informa estado inicial, operação, limite e resultados. Ele
    permite implementar e testar a regra antes de desenhar projéteis ou criar
    inimigos. Seu jogo pode ter outra regra com resultados igualmente claros.

## Incremento A — Implementar a regra no modelo

Crie ou evolua uma classe do seu domínio para guardar o estado e realizar a
operação escolhida. Mantenha o estado privado e ofereça as consultas necessárias.
A classe deve poder ser usada sem janela, teclado ou operações de desenho.

Implemente a condição ou o limite no objeto responsável pelo estado. Uma
regra não deve depender de todos os clientes lembrarem de protegê-la.
O `Jogador` inicial pode continuar cuidando do movimento; não precisa
concentrar todas as responsabilidades do seu domínio.

Junto com a implementação, acrescente testes JUnit em
`src/test/java/meujogo/`. Use objetos novos em cada teste. Seus testes devem
observar:

| Cenário | O que verificar |
| --- | --- |
| Operação permitida | O estado inicial, a alteração exata e o retorno, quando houver. |
| Limite ou recusa | O estado no limite e o resultado da tentativa seguinte, conforme sua regra. |
| Dois objetos independentes | Alterar um objeto preserva o estado do outro. |

??? tip "Apoio para começar os testes"

    `JogadorTest.java` já contém exemplos de `@Test`, construção de objetos
    e `assertEquals`. Use a mesma configuração e adapte os dados e as
    expectativas ao seu domínio. Não chame `Iniciar` ou `Janela.abrir` no teste
    da regra; crie diretamente o objeto que você quer verificar.

Execute **Terminal → Executar Tarefa → Verificar meu jogo** no VS Code.
Alternativamente, use `./gradlew test` no Linux/macOS ou, no PowerShell:

```powershell
.\gradlew.bat test
```

Confira os resultados antes de ligar a regra ao teclado. O que os testes do
exemplo de cargas deveriam observar após três tentativas de uso?

??? "Ver resultado e critérios de verificação"

    - No exemplo com duas cargas: primeira tentativa `true`, saldo `1`;
      segunda `true`, saldo `0`; terceira `false`, saldo `0`.
    - Um segundo equipamento novo permanece com duas cargas enquanto o
      primeiro é usado. Não há contador compartilhado entre instâncias.
    - Na sua regra, os testes devem usar os dados que você definiu e verificar
      seus resultados exatos. A janela não precisa abrir.
    - Os testes iniciais devem continuar passando se as regras de movimento
      forem preservadas. Se você mudar deliberadamente uma regra do movimento,
      atualize sua expectativa com base no novo requisito, não apenas para
      ocultar uma falha. Os testes do Megamania pertencem ao exemplo.

Ao concluir este incremento, deve existir uma regra própria implementada e
verificada, além do movimento fornecido na base.

## Incremento B — Conectar comando, regra e resultado visível

Guarde em `MeuJogo` a referência ao objeto criado no incremento A ou ao objeto
que o coordena. A mesma instância deve continuar existindo entre as atualizações
da partida. Não recrie o objeto em cada chamada apenas para consultar ou usar.

Em `atualizar`, conecte um comando à operação do modelo. Para uma primeira
ação executada uma vez a cada pressionamento, você pode usar **Enter**:
`entrada.confirmou()` fica `true` na atualização do pressionamento.

??? tip "Apoio para ligar o comando"

    Use no método `atualizar` já existente uma condição como:

    ```java
    if (entrada.confirmou()) {
        // Solicite a operação ao objeto que guarda o estado da sua regra.
    }
    ```

    A condição consulta a entrada; a chamada dentro dela deve delegar a regra
    ao modelo. O espaço, consultado por `entrada.acao()`, permanece `true`
    enquanto estiver pressionado e pode solicitar a operação várias vezes.
    Escolha o comando entendendo essa diferença.

Em `desenhar`, mostre uma consulta do estado atual, por texto ou outra
representação simples. Use a **mesma instância** que recebeu o comando.
Desenhar não deve consumir cargas, recuperar energia ou causar dano.

??? tip "Apoio para mostrar o estado"

    `MeuJogo.desenhar` já usa `tela.texto(...)`. Você pode acrescentar uma
    linha em `y = 100`, usando `x = 40`, escala `1` e `Cor.BRANCO`, por exemplo.
    Essa faixa fica abaixo da área de movimento do jogador e acima dos controles.
    Monte o texto com a consulta do seu objeto. `API.md` explica os parâmetros;
    não é preciso importar a biblioteca gráfica.

Faça R reiniciar também o estado que você acrescentou. A base já trata
`entrada.reiniciou()` recriando o jogador; inclua ali a reinicialização da sua
parte da partida. Preserve o movimento e a saída por Esc, salvo adaptação
deliberada do seu jogo.

Salve e execute de novo. Observe o estado inicial, acione a regra até a condição
de limite e reinicie. O comportamento na janela deve corresponder ao que os
testes verificam.

??? "Ver critérios de verificação"

    - O jogo abre com seu título e o estado inicial da regra visível.
    - O comando chega ao objeto do modelo e produz a alteração esperada.
    - O estado persiste entre atualizações. No exemplo das cargas, não volta
      a duas a cada quadro.
    - O limite ou a recusa continua sendo respeitado pela chamada da interface.
    - Manter o jogo aberto sem acionar a regra não produz consumo ou outro
      efeito apenas por desenhar.
    - R restaura o estado inicial da sua regra, além do estado que já era
      reiniciado na base.

## Consultar o Megamania com uma pergunta concreta

Se precisar de referência, selecione **Exemplo Megamania** em **Executar e
Depurar**. Enter inicia; A/D ou setas movem; espaço dispara; P pausa; R reinicia.
Pelo PowerShell, a alternativa é `.\gradlew.bat megamania`.

No código em `exemplo-megamania/src/main/java/br/edu/ifpb/jogos/megamania/`,
acompanhe `JogoMegamania.atualizar` até `modelo/Partida` e `modelo/Nave`.
Procure distinguir quem consulta a entrada e quem decide se um disparo pode
acontecer. Você precisa copiar toda essa estrutura para sua primeira regra?

??? "Ver uma análise possível"

    - `JogoMegamania` traduz a entrada em comandos e delega à partida.
    - A partida coordena os objetos; a nave decide se pode produzir um disparo,
      considerando vidas e recarga.
    - A separação de responsabilidades é a referência. Não é preciso copiar
      todos os objetos, seus nomes ou suas relações para outro domínio.

## Verificação final

!!! success "Critérios de conclusão"

    - Seu projeto parte da base fornecida e abre com o título escolhido.
    - Existe uma regra própria com estado inicial, operação e limite ou condição
      definidos; a regra funciona no modelo sem abrir janela.
    - Os testes verificam a operação, o limite ou a recusa e a independência
      entre objetos.
    - Um comando da entrada solicita a operação; a apresentação mostra o estado
      do mesmo objeto, sem executar a regra durante o desenho.
    - O estado persiste entre atualizações e R o reinicia.
    - A implementação usa a engine fornecida, com a configuração preservada.

## Se quiser aprofundar

Acrescente um segundo cliente que use o mesmo objeto do modelo, em um teste
sem janela. Compare com o cenário de dois objetos independentes. O que muda
quando os dois clientes compartilham a referência?

??? "Ver uma forma de conferir"

    Os clientes que compartilham uma referência alteram e consultam o mesmo
    estado. Com objetos distintos, cada estado evolui separadamente. No exemplo
    das cargas, duas referências ao mesmo equipamento não duplicam o saldo.
    Esse aprofundamento é opcional e não integra os critérios obrigatórios.

## Continuidade e entrega

Guarde a pasta completa do seu projeto: ela será evoluída nos próximos
laboratórios. Evite substituí-la por uma cópia nova da base e perder suas
alterações. As anotações usadas para escolher a regra ou prever resultados
são apoio de estudo; não é necessário produzir um relatório para seguir este
roteiro.

Consulte as orientações de entrega no
[Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).

## Materiais relacionados

- [Base de desenvolvimento — ZIP](../materiais/projeto-03/base-jogo-poo.zip): inclui `README.md`, `API.md`, testes e o exemplo Megamania.
- [Aula 19 — Correção da Prova da Unidade 02](aula-19-correcao-da-prova-da-unidade-02.md): retomada do repertório de estado, referências, contratos e testes.
- [Aula 13 — Como saber se ainda funciona?](aula-13-como-saber-se-ainda-funciona.md): verificação com JUnit.
- [Aula 14 — Do colaborador concreto ao contrato](aula-14-do-colaborador-concreto-ao-contrato.md): colaboração por interfaces.
- [Aula 16 — Combinando comportamentos por composição](aula-16-combinando-comportamentos-por-composicao.md): objetos que colaboram sem concentrar todas as regras no cliente.
