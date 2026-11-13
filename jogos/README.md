# Meu jogo — Projeto 3 de POO

Esta pasta é seu projeto de desenvolvimento. Ela já contém um jogo mínimo que
abre uma janela, desenha um quadrado e permite movê-lo. Você vai evoluí-lo com
os objetos e as regras do seu jogo ao longo dos laboratórios.

O Megamania está incluído como exemplo para consultar e executar. Os dois
jogos usam a mesma engine.

## Começar no VS Code no Windows

1. Extraia o ZIP inteiro para uma pasta local do Windows. Não trabalhe dentro do ZIP.
2. No VS Code, use **Arquivo → Abrir Pasta** e escolha `meu-jogo`, a pasta
   que contém este README, `build.gradle` e `.vscode`.
3. Aguarde a importação do projeto Java. Use o JDK adotado na disciplina e as
   extensões Java do VS Code. A pasta já recomenda as extensões necessárias.
4. Na área **Executar e Depurar**, selecione **Meu jogo** e pressione **F5**.

Você também pode abrir `src/main/java/meujogo/Iniciar.java` e clicar em
**Run** acima do método `main`, com a pasta inteira aberta e a importação
Java concluída.

Você deve ver um quadrado ciano. Setas ou WASD movem; **R** reinicia;
**Esc** fecha; **F11** alterna tela cheia.

Não é necessário instalar Gradle, adicionar bibliotecas ou editar arquivos de
configuração. A primeira importação precisa de internet para baixar as
dependências. Depois de preparadas, as bibliotecas ficam no cache da máquina.

Se a escola fornecer uma máquina já preparada, comece diretamente pelo passo 2.
Se o Java ainda não estiver disponível no computador, prepare esse ambiente
antes do laboratório com o apoio da disciplina.

## Onde desenvolver

Comece em `src/main/java/meujogo/`:

| Arquivo | Papel no exemplo inicial |
| --- | --- |
| `MeuJogo.java` | Título, tradução dos controles em comandos e desenho do estado. |
| `Jogador.java` | Posição e regra de movimento do quadrado. |
| `Iniciar.java` | Entrada já preparada; não precisa mudar para começar. |

Os testes iniciais ficam em `src/test/java/meujogo/JogadorTest.java`.

Primeiro, mude o título devolvido por `getTitulo()` em `MeuJogo`, salve, pare
a execução anterior e pressione F5 de novo. A janela deve abrir com o novo
título. Depois, desenvolva os objetos e comportamentos pedidos no laboratório.

Os nomes e a organização iniciais são um ponto de partida. Você pode criar
outras classes no pacote `meujogo`. Não precisa renomear a pasta, os pacotes
ou o projeto Gradle para dar identidade ao seu jogo.

## Verificar suas regras

No VS Code, use **Terminal → Executar Tarefa → Verificar meu jogo**.
Os testes executam sem abrir a janela. O resultado deve terminar com
`BUILD SUCCESSFUL`; um teste que falha indica qual expectativa não foi atendida.

Você também pode executar os testes pelos botões exibidos em `JogadorTest.java`
ou pela área **Testes** do suporte Java.

Para executar pelo PowerShell, na pasta deste README:

```powershell
.\gradlew.bat test
.\gradlew.bat :run
```

`:run` abre apenas seu jogo. Para abrir o exemplo, use a configuração
**Exemplo Megamania** ou o comando indicado na próxima seção.

`test` também verifica os testes do exemplo incluído. O relatório dos testes
do seu jogo fica em `build/reports/tests/test/index.html`.

Como atalho fora do VS Code, `jogar.cmd` abre seu jogo e `testar.cmd` executa
os testes. Os atalhos usam o Java disponível no terminal ou em `JAVA_HOME`.

## Consultar o Megamania

Selecione **Exemplo Megamania** em **Executar e Depurar** e use F5. **Enter**
inicia; setas ou A/D movem; espaço dispara; P pausa; R reinicia; Esc sai.

Seu código fica em
`exemplo-megamania/src/main/java/br/edu/ifpb/jogos/megamania/`.
Comece por `JogoMegamania` e acompanhe as chamadas para `modelo/Partida`.
Os testes do modelo estão em `exemplo-megamania/src/test/java/`.

Alternativa pelo PowerShell:

```powershell
.\gradlew.bat megamania
```

Você pode consultar as decisões desse exemplo e escolher soluções diferentes
para seu jogo. Não é necessário ter nave, inimigos, tiros ou herdar das classes
do Megamania.

## O que já vem pronto

`engine/` cuida da janela, do teclado, do desenho e do ciclo de execução.
Seu código usa os contratos `Jogo`, `Entrada` e `Tela`; não precisa importar
libGDX, cuidar da janela ou adicionar dependências.

A base oferece jogos 2D com teclado, formas geométricas e texto. A lista dos
controles e as operações de desenho estão em [API da engine](API.md).
Imagens, áudio, mouse e física pronta não integram esta primeira versão.
Combine o escopo do seu jogo com as capacidades fornecidas.

## Salvar e executar de novo

Salvar o código não muda automaticamente uma janela que já está aberta.
Para conferir uma alteração, salve, encerre a execução e execute de novo.
A tecla R reinicia o estado da partida; não recompila o programa.

Se houver erro de compilação, corrija o erro mostrado antes de executar.
Evite manter várias janelas abertas, para não observar uma versão anterior.

## Uso de IA — Nível 3: Colaborador

A IA pode ajudar a gerar, revisar e compreender código. Antes de incorporar
um trecho, compreenda os objetos envolvidos, as mudanças de estado e as
colaborações. Você deve conseguir explicar, verificar e modificar o código.
O objetivo é desenvolver seu jogo e seu domínio de POO.

## Linux e macOS

Abra a mesma pasta no VS Code. Pelo terminal, use `./gradlew :run`,
`./gradlew test` e `./gradlew megamania`. Não é necessário instalar Gradle.
Se a extração perder a permissão de execução, use `chmod +x gradlew jogar.sh`.

## Ajuda de ambiente

| Situação | O que conferir |
| --- | --- |
| F5 não encontra a configuração | Abra a pasta inteira que contém `.vscode`, não apenas um arquivo Java. |
| O projeto ainda mostra imports ausentes | Aguarde o fim da importação Java e do download das dependências. |
| `java` não foi encontrado ao usar os atalhos | Use o JDK adotado na disciplina no terminal ou peça apoio para preparar o ambiente. |
| Primeira importação não termina | Confira a conexão e a mensagem de erro do download; não altere bibliotecas ao acaso. |
| Alteração não aparece | Salve, feche a execução anterior e execute de novo. |

### Windows 11: erro glfw.dll com código 4551

Se aparecer `Failed to load library: ... glfw.dll (error code = 4551)`,
o Windows bloqueou a biblioteca gráfica por uma política de segurança.
Esse bloqueio foi observado com o **Controle Inteligente de Aplicativos
(Smart App Control)**. Trocar Run por F5 ou pelo terminal não resolve
esse bloqueio.

Em computador pessoal, a desativação é uma opção: afeta todo o computador
e reduz a proteção contra outros aplicativos não confiáveis. Antes de
decidir, confira as condições de reativação na
[orientação da Microsoft](https://support.microsoft.com/en-gb/windows/security/threat-malware-protection/smart-app-control-frequently-asked-questions).
Atualizações recentes permitem reativar o recurso, mas essa possibilidade
depende do Windows instalado. Se não puder garantir a reativação ou
preferir manter a proteção, peça apoio ao professor para usar outra máquina.

Se optar pela mudança:

1. Abra **Segurança do Windows → Controle de aplicativos e navegador →
   Configurações do Controle Inteligente de Aplicativos**.
2. Anote o estado atual. Se estiver **Ativado**, selecione **Desativado**
   e execute o jogo novamente.
3. Ao terminar as atividades, volte à mesma tela e **reative a proteção
   se ela estava ativada antes**, quando disponível. Se a opção não
   aparecer, peça apoio; não altere o Registro do Windows.

Mantenha o Microsoft Defender e o antivírus ativos. Em computador
institucional, solicite apoio à TI antes de mudar configurações.
Se o recurso já estiver desativado ou o erro for outro, envie a mensagem
completa ao professor. Reativar a proteção pode voltar a bloquear o jogo.

Referências de configuração da infraestrutura:
[projetos Java no VS Code](https://code.visualstudio.com/docs/java/java-project),
[execução e depuração](https://code.visualstudio.com/docs/java/java-debugging),
[wrapper Gradle](https://docs.gradle.org/9.1.0/userguide/gradle_wrapper.html).
