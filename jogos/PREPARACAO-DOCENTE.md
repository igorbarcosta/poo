# Preparação e distribuição — Projeto 3

O ambiente prioritário definido pelo professor é **VS Code no Windows**.
O aluno recebe a pasta inteira, abre sua raiz e usa a configuração **Meu jogo**.
Não deve editar o inicializador gráfico ou os arquivos de dependências.

## Organização mantida pelo professor

- O projeto raiz é o jogo do aluno, com um exemplo mínimo e testes.
- `engine` é a única implementação da infraestrutura usada pelos dois jogos.
- `exemplo-megamania` é uma aplicação independente que depende dessa mesma engine.
- `.vscode` configura as duas execuções e uma tarefa de testes, sem caminhos
  absolutos para a máquina do professor.
- `gradlew` e `gradlew.bat` fixam a ferramenta de build. Não há instalação
  global de Gradle como requisito.

O código foi extraído do protótipo em `prototipos/megamania-poo`, preservado
como histórico de exploração. Na distribuição, a inicialização da janela fica
em `Janela.abrir(Jogo)`. `Entrada.acao()` nomeia o espaço sem pressupor um jogo
de tiro; o exemplo Megamania traduz essa ação para disparos.

## Preparar o pacote

Na pasta `jogos`, com o JDK disponível:

```powershell
.\gradlew.bat prepararDistribuicao
```

Linux/macOS: `./gradlew prepararDistribuicao`.

A tarefa compila e testa os projetos e gera
`build/distribuicoes/base-jogo-poo.zip`. O ZIP contém a pasta `meu-jogo` com
fontes, testes, wrapper, configuração do VS Code, recursos licenciados, engine
e exemplo. Não contém caches, classes compiladas, caminhos de JDK ou metadados
de IDE gerados pela máquina do professor.

No repositório da disciplina, o download publicado é a cópia desse ZIP em
`docs/materiais/projeto-03/base-jogo-poo.zip`. Ao atualizar a base, regenere o
pacote e atualize essa cópia junto com os fontes; o build do site não executa
o Gradle nem refaz o ZIP.

Esse é um pacote de **desenvolvimento**, não apenas um executável para jogar.
Os laboratórios posteriores evoluem a cópia de cada aluno; não se substitui
sua pasta inteira por uma nova base a cada encontro.

Para executar toda a verificação sem janela:

```powershell
.\gradlew.bat verificar
```

`installDist` cria também uma distribuição executável do jogo do aluno;
`:exemplo-megamania:installDist` cria a do exemplo. Ambas ainda precisam de Java.

## Conferir na máquina da turma antes do encontro

1. Confirmar o JDK usado na disciplina e as extensões recomendadas pelo projeto.
2. Extrair o ZIP para uma pasta nova, inclusive com espaços no caminho.
3. Abrir a pasta `meu-jogo` no VS Code e aguardar a importação Java.
4. Executar **Meu jogo** por F5; conferir movimento, reinício e saída.
5. Alterar o título, salvar, parar e executar novamente; conferir a nova versão.
6. Executar **Verificar meu jogo** e confirmar que os testes não abrem janela.
7. Executar **Exemplo Megamania**; conferir início e controles.

Preparar o cache de dependências nas máquinas antes da aula quando a rede do
laboratório puder limitar downloads. A base não inclui JDK ou extensões do
VS Code e não instala programas automaticamente.

## Limites de compatibilidade e validação

A ferramenta de build e o código são compatíveis com JDK 17 ou superior;
a referência já usada no protótipo é Java 25. O suporte Java do VS Code tem
requisitos próprios de runtime: preparar a instalação já adotada na turma,
sem pedir ao aluno para ajustar versões durante o laboratório.

As versões de libGDX, LWJGL, JUnit e Gradle foram mantidas iguais às do
protótipo. Nenhuma biblioteca gráfica nova foi adicionada.

A execução por F5 deve ser conferida no VS Code da turma antes do encontro.
Build e testes por `gradlew.bat` foram executados no Windows, mas isso não
equivale a verificar a integração da IDE ou a janela nesse sistema.
Resultados e limitações estão em [Validação da base](VALIDACAO.md).
