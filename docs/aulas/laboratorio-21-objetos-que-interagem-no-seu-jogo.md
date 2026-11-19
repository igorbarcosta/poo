# Laboratório 21 — Objetos que interagem no seu jogo

Seu jogo já possui uma regra própria e mostra seu resultado na tela. Agora,
o jogador vai encontrar outro participante: um inimigo, obstáculo, recurso,
porta ou elemento do cenário com o qual possa interagir.

O objetivo é fazer essa interação produzir uma consequência observável,
com as regras nos objetos do modelo e sua representação na tela. Continue
o projeto que você já está desenvolvendo.

!!! info "Uso de IA — Nível 3: Colaborador"

    A IA pode ajudar na implementação, nos testes e na investigação de erros.
    Antes de incorporar código, compreenda quem guarda o estado, quem aplica
    a regra e como verificar o resultado. Você deve conseguir explicar e
    modificar o que acrescentar ao seu jogo.

## Objetivos

- Representar outro participante do jogo por estado e comportamento próprios.
- Implementar uma colaboração que produza uma consequência visível.
- Verificar a interação e uma situação em que seu efeito não deve ocorrer.
- Integrar modelo, apresentação e reinício sem perder as regras já existentes.

## Partir do seu projeto atual

Abra a pasta completa do seu jogo e confira se ele executa e se os testes
existentes passam. O [Laboratório 19](laboratorio-19-iniciando-seu-jogo.md)
reúne as instruções de preparação da base. Preserve as alterações que você
já fez; não substitua o projeto por outra cópia do ZIP.

Os laboratórios da Unidade 03 acompanham a evolução do jogo, usando o
repertório acumulado da disciplina. Esta prática não exige acrescentar
exceções para reproduzir o assunto da Aula 21.

Delimite **um participante adicional e uma interação**. Por exemplo:

| Participante | Interação possível | Consequência observável |
| --- | --- | --- |
| Inimigo | Receber um ataque do jogador. | Perder vida, mudar de aparência ou desaparecer. |
| Obstáculo | Interceptar o movimento do jogador. | Impedir a passagem. |
| Recurso coletável | Ser recolhido ao contato. | Desaparecer e aumentar um saldo. |
| Porta | Receber uma ação do jogador próximo. | Abrir ou permitir a passagem. |
| Área do cenário | Ser alcançada pelo jogador. | Aplicar um efeito ou mudar o estado da partida. |

São alternativas. Escolha uma compatível com seu jogo e defina o estado
inicial, a condição para interagir e o efeito esperado. Um fundo decorativo
sozinho não representa a interação proposta aqui.

Se você já possui outros participantes visíveis, evolua uma interação com
eles: acrescente uma condição, uma consequência ou uma colaboração que ainda
não existe. Não é preciso duplicar elementos. A evolução deve produzir uma
mudança verificável em relação à versão com que você começou.

??? tip "Se precisar reduzir o recorte"

    Um recurso coletável pode permanecer parado. Ao ser alcançado, fornece
    uma unidade ao jogador e fica indisponível. Isso permite estudar posição,
    disponibilidade, saldo e colaboração sem criar projéteis ou física.

    Atirar em um inimigo é outra opção, mas um tiro que percorre a tela pode
    exigir um terceiro objeto e seu ciclo de vida. Escolha esse caminho se
    ele couber na evolução que você já começou.

## Incremento A — Acrescentar o participante ao modelo e à tela

Crie ou evolua o objeto que representa esse participante. Defina a posição,
as dimensões e o estado necessários à sua regra. Um recurso pode guardar
disponibilidade; uma porta, se está aberta; um inimigo, sua vida. Mantenha
esses dados privados e ofereça as operações e consultas de que o jogo precisa.

Guarde a referência ao participante no jogo ou no objeto que coordena a
partida. A mesma instância deve continuar existindo entre atualizações.
Não a recrie em cada quadro para voltar involuntariamente ao estado inicial.

Em `desenhar`, represente o estado desse objeto por uma forma simples,
distinguível do jogador. Escolha uma posição inicial alcançável. Se o
participante já está na cena, acrescente a representação do novo estado
necessário à interação escolhida.

??? tip "Apoio para desenhar outro participante"

    O `MeuJogo.desenhar` inicial já usa `tela.retangulo(...)`. Use as consultas
    do seu objeto para fornecer posição e tamanho. Os argumentos são:

    ```java
    tela.retangulo(x, y, largura, altura, Cor.LARANJA);
    ```

    Nesse recorte, `x` e `y` indicam o canto inferior esquerdo e `largura` e
    `altura`, as dimensões. Adapte os valores às consultas de seu objeto.
    A tela lógica mede 960 × 720; o jogador inicial se move entre `y = 110`
    e `y = 600`, considerando também seu tamanho. A engine não impõe essas
    faixas: confira os limites atuais do seu modelo.

Salve, encerre a execução anterior e execute novamente. Observe o novo
participante antes de implementar a interação.

??? "Conferir o incremento A"

    - Jogador e participante podem ser identificados na cena.
    - A representação consulta o estado do modelo; não mantém uma segunda
      posição independente apenas para o desenho.
    - O participante permanece entre atualizações e pode ser alcançado ou
      acionado conforme a interação escolhida.
    - A regra própria que você já havia implementado continua disponível.

## Incremento B — Implementar e testar a interação

Implemente no modelo a operação entre os participantes. Separe a condição
que permite a interação do efeito produzido. Os objetos responsáveis devem
proteger as regras de seu próprio estado; o código de desenho não aplica
dano, coleta recursos nem abre portas.

Defina também o resultado de repetir a tentativa ou manter o contato.
Um recurso indisponível não deve continuar acrescentando saldo. Em uma
barreira, o bloqueio pode continuar enquanto houver tentativa de passagem.
O comportamento depende da regra que você escolheu.

??? tip "Apoio se sua interação depende de sobreposição"

    Para dois retângulos alinhados aos eixos, é possível comparar seus
    intervalos em `x` e em `y`. No recorte abaixo, `xA`, `yA`, `larguraA` e
    `alturaA` descrevem o primeiro retângulo; os nomes terminados em `B`
    descrevem o segundo:

    ```java
    boolean sobrepostos = xA < xB + larguraB
            && xA + larguraA > xB
            && yA < yB + alturaB
            && yA + alturaA > yB;
    ```

    Essa condição considera sobreposição com área positiva: apenas encostar
    as bordas não basta. No Megamania, consulte `Corpo.colideCom` e o uso em
    `Projetil.tentarAtingir`. Adapte a condição ao seu modelo; não é necessário
    herdar de `Corpo` nem copiar a arquitetura do exemplo.

    Detectar sobreposição não decide o efeito. Para um obstáculo, verifique
    a posição proposta antes de aceitar o movimento ou restaure a última
    posição permitida. Não basta detectar o encontro depois de deixar o
    jogador atravessar. Um movimento muito grande pode saltar um obstáculo;
    mantenha o recorte simples, com a atualização já fornecida pela base.

Junto com a implementação, acrescente testes JUnit em `src/test/java/meujogo/`.
Crie os objetos diretamente, sem abrir a janela, e verifique:

| Cenário | O que observar |
| --- | --- |
| Condição satisfeita | Estado inicial, operação e consequência exata nos participantes. |
| Condição ausente ou limite atingido | A tentativa não produz o efeito que sua regra proíbe. |

Inclua nas verificações o resultado da tentativa seguinte ou da continuidade
do contato, conforme a regra definida. Use objetos novos em cada teste.
Os exemplos de `@Test` e `assertEquals` já estão em `JogadorTest.java`.

Para conferir um recorte: um jogador começa com saldo `0`; um recurso
disponível fornece uma unidade uma única vez. Ambos estão sobrepostos.
Após duas tentativas de coleta, qual deve ser o saldo e a disponibilidade?
O que aconteceria se estivessem separados desde o início?

??? "Ver resultado e critérios para seus testes"

    - Na primeira tentativa, o saldo passa a `1` e o recurso fica indisponível.
    - Na segunda, o saldo continua `1` e o recurso permanece indisponível.
    - Em outro cenário, com objetos novos e separados, a tentativa mantém
      o saldo `0` e o recurso disponível.
    - Para outro domínio, defina expectativas igualmente determinadas:
      posição bloqueada, quantidade de vida, estado da porta ou outro efeito.
      O teste deve consultar o resultado, não apenas chamar um método.

Execute a tarefa **Verificar meu jogo** do VS Code ou os testes pela IDE.
No terminal da pasta do projeto, as alternativas são `./gradlew test` no
Linux/macOS e `.\gradlew.bat test` no PowerShell.

Ao concluir este incremento, a interação deve funcionar no modelo e possuir
verificações executáveis, mesmo antes de ser acionada na janela.

## Incremento C — Conectar a interação e completar o reinício

Em `atualizar`, conecte a operação do modelo ao encontro dos participantes
ou ao comando escolhido. Ela deve usar os mesmos objetos que são desenhados.
Um objeto coordenador pode encaminhar a operação se seu jogo já precisar
dele; não é obrigatório criar uma classe `Partida`.

Se a interação exige uma ação do teclado, confira a frequência do comando:
`entrada.confirmou()` identifica o pressionamento de Enter;
`entrada.acao()` continua verdadeiro enquanto o espaço estiver pressionado.
Essa diferença precisa ser compatível com sua regra.

Atualize a apresentação para mostrar a consequência: o recurso some quando
fica indisponível, a porta muda de aparência ao abrir ou uma consulta mostra
o estado resultante. Um bloqueio pode ser observado pela posição do jogador.
Não mantenha uma interação que só altera um campo sem consequência perceptível.

Complete o tratamento de `entrada.reiniciou()` para restaurar o participante
e o estado afetado pela interação, além do reinício que já existia. Se a
coleta altera saldo, reinicie saldo e disponibilidade; se a interação altera
vida, restaure o estado inicial correspondente.

Salve, execute de novo, provoque a interação e teste seu limite. Depois,
pressione R e tente novamente.

??? "Conferir o incremento C"

    - A interação na janela produz a consequência prevista nos testes.
    - Uma condição ausente ou recusa preserva o estado exigido pela regra.
    - Manter contato ou repetir o comando não produz efeitos indevidos.
    - Apenas desenhar a cena novamente não aplica a regra outra vez.
    - R restaura os estados iniciais, e a interação pode ocorrer novamente.
    - As regras anteriores e os controles preservados continuam funcionando.

## Verificação final

!!! success "Critérios de conclusão"

    - O projeto foi evoluído a partir da versão anterior.
    - Há jogador e outro participante visível com função na regra do jogo.
    - Uma interação produz consequência observável, com estado e regras no modelo.
    - Os testes verificam o efeito aceito e uma condição em que ele não ocorre.
    - Repetição ou contato persistente respeitam o comportamento definido.
    - Atualização, apresentação e reinício usam estados coerentes entre si.
    - A engine e a configuração fornecidas foram preservadas.

Se o participante e sua interação já existiam, os critérios se aplicam à
evolução que você acrescentou nesta prática.

## Continuidade e entrega

Guarde a pasta completa do projeto com as alterações e os testes: o jogo
continuará evoluindo. As escolhas, previsões e anotações de investigação são
apoio ao trabalho; não é necessário produzir um relatório.

Consulte as orientações de entrega no
[Google Classroom](https://classroom.google.com/c/ODcwOTgzNDMyMjc5).

## Materiais relacionados

- [Laboratório 19 — Iniciando seu jogo](laboratorio-19-iniciando-seu-jogo.md): base, execução e primeira regra própria.
- [Aula 20 — Entendendo a estrutura de um jogo orientado a objetos](aula-20-entendendo-a-estrutura-de-um-jogo.md): referência para consultar colaborações no Megamania.
- [Aula 06 — Colaboração entre objetos](aula-06-colaboracao-entre-objetos.md).
- [Aula 13 — Como saber se ainda funciona?](aula-13-como-saber-se-ainda-funciona.md): testes do modelo.
- [Base do Projeto 3 — ZIP](../materiais/projeto-03/base-jogo-poo.zip): contém `API.md`, engine e Megamania para consulta; mantenha seu projeto atual.
