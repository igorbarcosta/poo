# Validação da base de desenvolvimento

## Ampliação — quatro exemplos independentes

Foram acrescentados mapa/câmera, salas conectadas, chave/porta e patrulha,
sem alterar a engine ou as dependências. Esta verificação complementa o
histórico da base original, preservado nas seções seguintes.

| Verificação | Resultado |
| --- | --- |
| Compilação e JUnit, Linux/WSL, Temurin 25.0.5.1 | `verificar` passou: 47 testes, incluindo 21 dos novos exemplos, sem falhas ou erros. |
| Distribuições executáveis | `installDist` dos quatro módulos passou; inicializadores abrem cada demonstração separadamente. |
| Janela e comandos em Xvfb com renderização por software | Os quatro exemplos abriram, responderam aos comandos, reiniciaram por R e encerraram por Esc com código zero. |
| Mapa | Movimento além da área visível, acompanhamento da câmera, painel fixo e retorno ao início conferidos na janela; bordas verificadas nos testes. |
| Salas | Luz da sala 1 ligada, ida à sala 2 com luz independente, retorno à sala 1 com luz preservada e reinício conferidos. |
| Chave/porta | Coleta por contato, posse indicada no painel, abertura por Enter, consumo, travessia e reinício conferidos; recusa sem chave e bloqueios verificados por JUnit. |
| Patrulha | Movimento sem teclado, indicação da direção e reinício observados; inversão e preservação do deslocamento verificadas por JUnit. |
| Configurações VS Code | Seis configurações F5 com `projectName` e `mainClass` correspondentes aos fontes; JSONs válidos e sem caminhos locais de JDK. |
| Pacote | Quatro READMEs, catálogo `EXEMPLOS.md`, modelos, testes e configurações incluídos; sem caches ou classes compiladas e com permissão de execução no wrapper Unix. |
| ZIP extraído em pasta nova com espaços, Linux | `verificar` recompilou os seis projetos e executou os mesmos 47 testes sem falhas, usando apenas as dependências em cache. |

As capturas da página de exemplos foram feitas nas janelas reais sob Xvfb.
A execução usa a mesma engine da base anterior. As novas opções de F5 não
foram exercitadas dentro do VS Code da turma, nem as quatro novas janelas no
Windows/macOS. O teste Linux usa dependências em cache; uma primeira importação
sem cache continua precisando de rede.

## Escopo executado

A distribuição foi conferida em pastas novas, seguindo o roteiro do
Laboratório 19, incluindo uma implementação temporária da atividade do aluno.
Essa solução de teste não faz parte da base entregue à turma.

| Verificação | Resultado |
| --- | --- |
| Compilação e testes em Linux/WSL, JDK Temurin 25.0.5 | Passou: cinco testes do jogo inicial, sete da engine e 14 do Megamania; 26 testes sem falhas. |
| ZIP extraído para pasta nova com espaços, Linux | Compilação, testes e geração dos dois executáveis passaram sem depender do caminho original. |
| ZIP extraído para pasta local nova com espaços, Windows, JDK Oracle 24.0.2 | `gradlew.bat --offline --console=plain verificar :installDist :exemplo-megamania:installDist prepararDistribuicao` passou; os mesmos 26 testes passaram. |
| Simulação da atividade do aluno, Linux e Windows | Classe `Equipamento`, uso por comando, contador na tela e reinício implementados em cópia temporária; 33 testes passaram, incluindo sete testes adicionais da solução. |
| Jogo do aluno a partir do ZIP, Linux | Movimento, título alterado, sequência de cargas 2 → 1 → 0 → 0, comando mantido sem repetição, reinício por R e saída por Esc conferidos na janela. Contador em `y = 100` permaneceu legível com o jogador na parte superior. |
| Atalho `jogar.cmd`, Windows | Abriu somente o jogo do aluno, sobreviveu a minimizar/restaurar e terminou com código zero após Esc, sem abrir o Megamania em seguida. |
| Engine com contexto gráfico real, Linux e Windows | Janela ou framebuffer de tamanho zero suspenderam atualização e desenho; viewport de um pixel não causou falha da fonte; restauração retomou o desenho e o processo terminou normalmente. |
| Minimização nativa, Windows | Três ciclos reais de minimizar/restaurar passaram sem encerrar o jogo ou provocar erro de fonte. |
| Megamania a partir do ZIP, Linux | Início por Enter, pausa estável, retomada e saída por Esc conferidos; disparos e reinício também exercitados e inspecionados. |
| Conteúdo do pacote | Wrapper, configuração da IDE, código, testes, fonte, licença, `.gitignore` e `.gitattributes` presentes; sem caches, classes compiladas ou pastas geradas de IDE. |
| Geração repetida do pacote | Metadados incluídos sem alterar exclusões globais do Gradle/Ant; builds consecutivos passaram. |
| Permissões no ZIP | `gradlew` e `jogar.sh` têm permissão de execução Unix explícita, inclusive quando o ZIP for gerado no Windows. |
| Separação de dependências | Jogo inicial e Megamania não importam libGDX; ambos dependem da mesma engine. |
| Configuração do VS Code | JSONs de execução, testes, preferências e extensões conferidos; sem caminhos absolutos de JDK ou máquina do professor. |

Os testes foram executados com as dependências disponíveis em cache. Uma
máquina sem esse cache precisa de rede na primeira importação ou execução.
O ZIP não é uma distribuição completamente offline e não inclui JDK.

## Limites observados

- Na execução relatada pela turma no Windows, `glfw.dll` foi bloqueada com
  código 4551, tanto pelo VS Code quanto pelo Gradle. O evento 3077 identificou
  a política do Smart App Control. O professor confirmou que desativar esse
  recurso permitiu executar o jogo; na máquina dele, o recurso já estava
  desativado. Esse relato não valida a execução com a proteção ativa nem a
  reativação posterior. O README e o Laboratório 19 incluem essa limitação.
- F5 e os botões de testes não foram exercitados dentro do VS Code do Windows:
  a instalação disponível estava bloqueada por uma atualização em andamento.
  Conferir a importação e as duas configurações de execução na máquina da turma.
- A janela não foi exercitada no macOS nesta preparação.
- O cache Gradle pelo compartilhamento de rede WSL apresentou falha de locks
  no Windows; a validação passou com projeto e cache em pasta local do Windows.
  As instruções de início usam extração local.
- Nenhuma política do PowerShell foi alterada. O caminho de comandos da base
  usa o wrapper `.bat`, sem scripts PowerShell ou mudança de política de execução.

## Reproduzir

Use `gradlew.bat verificar prepararDistribuicao` no Windows ou
`./gradlew verificar prepararDistribuicao` no Linux/macOS. Extraia o ZIP para
uma pasta nova e siga os passos de [Preparação docente](PREPARACAO-DOCENTE.md).
Os cinco testes iniciais estão disponíveis para a evolução do projeto do aluno;
os sete testes da engine verificam sua infraestrutura e os 14 adicionais
pertencem ao exemplo Megamania.
