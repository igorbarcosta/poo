# Planejamento da Unidade 03 — Evolução de jogos orientados a objetos

## Decisões do professor

O Projeto 3 começa no Laboratório 19. Cada aluno desenvolve seu próprio jogo
ao longo dos laboratórios da Unidade 03, usando uma engine comum fornecida
pelo professor. A infraestrutura deve facilitar o desenvolvimento e evitar
que configuração de ferramentas e interface bloqueiem a aprendizagem de POO.

O Megamania será a base comum das aulas teóricas. Seu código também ficará
disponível aos alunos como referência e inspiração. Os jogos individuais
podem ter outros domínios, objetos e mecânicas compatíveis com a infraestrutura.

O professor aprovou o desenho de liberdade com escopo viável, evolução a
partir de uma base executável e desafios comuns de aprendizagem aplicados a
jogos diferentes. A unidade integra o repertório já estudado; complementos
entram quando necessários e pedagogicamente definidos.

IA Nível 3 — Colaborador: pode auxiliar na geração e revisão de código, desde
que o aluno compreenda o que incorpora. Explicar uma execução, localizar quem
altera um estado, justificar uma decisão, verificar o comportamento e fazer
uma pequena mudança são formas de observar essa compreensão. Não se cria
por este registro uma nova entrega, prova oral ou regra de pontuação.

Este documento orienta a preparação posterior da base e dos roteiros. Não é
um laboratório público nem certifica que o protótipo já esteja pronto para
distribuição aos alunos. Não estabelece datas ou uma quantidade de encontros.

## Articulação entre teoria e laboratório

| Aulas teóricas | Laboratórios |
| --- | --- |
| Compreender e evoluir o Megamania como aplicação comum. | Compreender a base recebida e evoluir o próprio jogo. |
| Acompanhar chamadas, estado, responsabilidades e dependências. | Localizar as responsabilidades correspondentes no próprio domínio. |
| Examinar requisitos, alternativas, testes e refatorações no exemplo. | Aplicar o desafio de aprendizagem às necessidades do jogo escolhido. |
| Comparar soluções e justificar decisões. | Verificar a mudança e explicar as escolhas de implementação. |

O requisito comum de aprendizagem não exige mecânicas idênticas. Um desafio
de acomodar variações pode produzir movimentos, efeitos ou interações
diferentes conforme o jogo. Não exigir uma interface, uma hierarquia ou um
padrão apenas para compor um checklist de recursos de Java.

O ponto de partida preserva o foco da Unidade 03 em leitura e evolução de
software existente: todos recebem uma aplicação mínima executável, estudam
seu contrato e a modificam. O exemplo completo ajuda a investigar uma solução
maior sem obrigar todos a transformar o Megamania no próprio projeto.

## Fronteira da infraestrutura fornecida

| Parte | Responsabilidade |
| --- | --- |
| Engine e inicialização fornecidas | Janela, ciclo de execução, leitura de entrada, desenho, adaptação à biblioteca gráfica e configuração de execução. |
| Integração do jogo do aluno | Usar o contrato e o ponto de entrada já preparados para traduzir entrada e representar o estado. |
| Modelo do jogo do aluno | Objetos, estado, regras, responsabilidades, colaborações e verificação independente da janela. |

A abstração de interface reduz a infraestrutura que o aluno precisa conhecer.
O uso mínimo de entrada e desenho deve ser apresentado com exemplos pequenos;
não deve se converter em estudo da biblioteca gráfica ou do processo de build.
A engine não deve absorver as regras de domínio que são o objeto do projeto.

## Requisitos para preparar a distribuição

Antes de entregar a base à turma:

- fornecer um projeto mínimo que já abre, executa um comportamento e pode ser
  alterado, com dependências e configuração de testes prontas;
- oferecer um caminho principal curto para abrir e executar, usando as
  ferramentas disponíveis à turma; configurações alternativas ficam como apoio;
- preparar o ponto de entrada do jogo sem exigir edição do inicializador
  gráfico, de dependências, de flags da JVM ou de arquivos de build;
- deixar claro onde o aluno começa a trabalhar, com nomes e arquivos fáceis
  de localizar, sem exigir renomear toda a árvore de pacotes;
- oferecer execução dos testes das regras sem abrir a janela;
- documentar o comportamento de salvar, recompilar e reiniciar, evitando
  confundir reinício de partida com carregamento de alterações no código;
- verificar a primeira execução nos ambientes efetivamente usados pela turma,
  inclusive a necessidade de rede para baixar dependências;
- disponibilizar o Megamania com instruções próprias de consulta e execução,
  preservando a simplicidade do projeto inicial do aluno.

Esses são requisitos de preparação docente, não tarefas de implementação
avaliadas dos alunos. A base deve ser validada antes do encontro; o Laboratório
19 não deve depender de uma sessão coletiva de ajustes de infraestrutura.

## Situação do protótipo atual

O protótipo está em `prototipos/megamania-poo/`. Seu README e os contratos
`base/Jogo.java`, `base/Entrada.java` e `base/Tela.java` documentam uma
separação inicial entre aplicação, entrada, desenho e regras. Há wrapper
Gradle, configuração de JUnit, o exemplo Megamania e um exemplo mínimo
`meujogo/MeuJogo`.

Na composição atual, `desktop/Principal.java` escolhe o exemplo e configura
libGDX. O README orienta editar esse inicializador para selecionar outro jogo.
Esse procedimento precisa ser simplificado na distribuição estudantil: o
aluno não deve precisar alterar o código de configuração da janela para começar.

O README registra verificação em Linux e necessidade de verificação em
Windows e macOS. Isso não comprova compatibilidade com os computadores da turma.
As dependências são baixadas na primeira execução; a preparação deve considerar
essa condição. Este planejamento não altera versões ou dependências.

## Direção para o Laboratório 19

### Base de desenvolvimento preparada

A implementação inicial está em [`jogos/`](../jogos/README.md). O projeto raiz
é o jogo do aluno; `engine` fornece a infraestrutura comum e
`exemplo-megamania` fornece a referência executável. O protótipo anterior foi
preservado. A API usa `Entrada.acao()` para o espaço, sem pressupor disparos
em todos os jogos.

O ambiente prioritário foi definido pelo professor como VS Code no Windows.
A pasta inclui configurações de F5 para o jogo próprio e para o Megamania,
tarefa de testes, wrapper, atalhos Windows e instruções de início.
`prepararDistribuicao` gera o pacote de desenvolvimento dos alunos em
`jogos/build/distribuicoes/base-jogo-poo.zip`.

Compilação e 19 testes passaram em Linux e Windows; os dois jogos foram
executados em tela virtual Linux, também a partir do ZIP extraído. A integração
por F5 no VS Code da turma e a janela no Windows ainda precisam de conferência
no ambiente real. Ver [Validação da base](../jogos/VALIDACAO.md).

### Primeiro incremento a detalhar

O primeiro resultado é executar e compreender a base e produzir uma evolução
pequena do jogo próprio, com uma regra de estado e comportamento observável.
A escolha de escopo acompanha essa evolução; escolher uma ideia ou apenas
executar o exemplo não constitui, sozinho, um incremento de código.

Antes da autoria do laboratório, selecionar o menor contrato que permita essa
primeira regra e mapear seus pré-requisitos. Em particular, atualização por
quadro, passagem de tempo e coordenadas não devem surgir como exigências
implícitas: fornecer o apoio necessário sem deslocar o foco para programação
gráfica. A Aula 19 é correção da prova e não deve ser presumida como uma aula
de introdução a esses mecanismos.

O roteiro deve permitir que o estudante avance, verifique resultados e confira
seu raciocínio sem depender de liberação oral. Seguir o padrão de laboratório,
com núcleo viável em 90 minutos e apoio progressivo para evitar bloqueios.
O detalhamento dos incrementos, critérios de conclusão e entrega fica para
a autoria específica do Laboratório 19.

O [roteiro do Laboratório 19](../docs/aulas/laboratorio-19-iniciando-seu-jogo.md)
concretiza a abertura em dois incrementos: implementar uma regra própria no
modelo com verificação de operação, limite/recusa e independência de objetos;
depois conectar comando, consulta visual e reinício. A escolha da regra e do
domínio permanece com o aluno. O download inclui a engine e o Megamania.
Prazos e orientações de entrega continuam no Classroom.

## Planejamento que permanece evolutivo

- Capacidades e limites da primeira distribuição da engine, após verificar
  quais jogos ela realmente permite desenvolver com simplicidade.
- Forma de distribuição e caminhos de execução, conforme o ambiente da turma.
- Requisitos de cada laboratório e adaptações observáveis para jogos diferentes.
- Complementos conceituais necessários, com fundamentação anterior ao uso exigido.
- Critérios específicos dos artefatos e acompanhamento da compreensão, sem
  alterar automaticamente as notas e os instrumentos da disciplina.

## Referências locais

- [Projeto pedagógico](projeto-pedagogico.md).
- [Padrão de laboratório](padrao-laboratorio.md).
- [Padrão de aula](padrao-aula.md).
- [Protótipo Megamania e base comum](../prototipos/megamania-poo/README.md).
- [Aula 19 — Correção da prova da Unidade 02](../docs/aulas/aula-19-correcao-da-prova-da-unidade-02.md).
