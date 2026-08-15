---
icon: material/school-outline
---

# Aula 01 — Apresentação da disciplina

Neste primeiro encontro, vamos conhecer a proposta da disciplina e compreender como as aulas de POO e os laboratórios se conectam. Também vamos localizar as fontes oficiais que você poderá consultar ao longo do semestre.

Programação Orientada a Objetos e Laboratório de POO serão trabalhados de forma articulada. O objetivo não é apenas escrever classes em Java, mas aprender a compreender, estruturar, avaliar e evoluir software orientado a objetos.

## Objetivos

Ao final deste encontro, você deverá ser capaz de:

- reconhecer a proposta geral da disciplina;
- compreender como cada aula de POO se relaciona com o laboratório seguinte;
- localizar o Plano de Ensino, o Cronograma, as aulas e os materiais de apoio;
- distinguir o papel do site e do Google Classroom;
- reconhecer e ler a estrutura Java mínima que será usada no Laboratório 01.

## Conteúdo

### A proposta da disciplina

A disciplina parte de problemas e evolui por meio de responsabilidades, estado, comportamento e colaboração entre objetos. Java será a linguagem usada para tornar essas ideias concretas, mas aprender seus recursos isoladamente não é o objetivo principal.

Ao longo do semestre, você vai escrever código e também ler, explicar, testar, criticar, modificar e comparar soluções.

!!! info "Princípio de domínio"

    Código que o aluno não consegue explicar não deve ser considerado código que ele domina.

### Como as aulas e os laboratórios se conectam

POO e Laboratório de POO são componentes diferentes, mas formam uma experiência integrada:

**Aula XX** — compreender e discutir os conceitos  
**Laboratório XX** — aplicar, experimentar e fazer o projeto evoluir

O que acontecer durante a prática também poderá ser retomado no encontro seguinte. Soluções, dificuldades e limitações percebidas no código servirão de ponto de partida para novos conceitos.

### Fontes oficiais da disciplina

Para evitar informações duplicadas ou desatualizadas, consulte cada assunto em sua fonte principal:

- o [Plano de Ensino](../plano-de-ensino.md) apresenta objetivos, metodologia, unidades, avaliação e regras gerais;
- o [Cronograma](../cronograma.md) registra a macroestrutura e os ajustes do planejamento;
- a seção de [Aulas](index.md) reúne aulas e laboratórios;
- a seção de [Materiais](../materiais/index.md) reúne referências e recursos de apoio;
- o Google Classroom concentra avisos, orientações operacionais, entregas, atividades, avaliações e notas.

### Conhecendo a turma

Também vamos conversar sobre:

- experiências anteriores com Python, C e Java;
- contato anterior com POO;
- IDEs e editores disponíveis;
- uso de ferramentas de IA para programação.

Esse diagnóstico ajudará a orientar o percurso da disciplina e não será uma avaliação.

### Preparando o primeiro laboratório

O próximo encontro pede uma solução pequena em Java. Antes de escrever e modificar esse programa, precisamos conseguir ler sua estrutura básica. Não vamos estudar toda a linguagem agora; vamos separar somente as partes necessárias para começar.

!!! tip "Dica — uma pasta para cada laboratório"

    Crie uma pasta para o laboratório, coloque os arquivos Java dentro dela e abra **a pasta** na IDE. Esse hábito já funciona com um único arquivo e continuará funcionando quando o projeto passar a ter várias classes.

    No VS Code, depois de entrar na pasta, você pode usar `code .`. Em outras IDEs, use a opção de abrir pasta ou projeto.

!!! java-focus "Java em foco — programa mínimo"

    ```java
    public class Laboratorio01 {

        public static void main(String[] args) {
            System.out.println("Ambiente configurado!");
        }
    }
    ```

    - `public class Laboratorio01` declara a classe pública; o arquivo se chama `Laboratorio01.java`;
    - `{` e `}` delimitam blocos;
    - `main` é o ponto de entrada que usaremos;
    - `System.out.println(...)` exibe um valor no console;
    - as instruções apresentadas terminam com `;`.

    A assinatura de `main` tem bastante coisa acontecendo de uma vez. Por enquanto, precisamos reconhecê-la e saber onde escrever as instruções. `public`, `static` e `String[] args` serão retomados quando suas funções forem necessárias.

O programa do laboratório também usa variáveis tipadas e um método auxiliar:

!!! java-focus "Java em foco — variáveis, parâmetros e retorno"

    ```java
    static double calcularSubtotal(double precoUnitario, int quantidade) {
        return precoUnitario * quantidade;
    }
    ```

    `double precoUnitario` e `int quantidade` são parâmetros: valores que entram no método. O primeiro `double` informa o tipo do resultado, e `return` devolve esse resultado. Uma chamada como `calcularSubtotal(150.0, 2)` fornece os dois valores na mesma ordem.

    No `main`, declarações como `String descricao = "Teclado";`, `double preco = 150.0;` e `int quantidade = 2;` associam tipo, nome e valor. Isso é o suficiente para ler e modificar a solução inicial do laboratório.

!!! synthesis "Síntese — da aula para o laboratório"

    Cada aula teórica prepara o laboratório imediatamente seguinte. No Laboratório 01, vamos abrir uma pasta de projeto, compilar e executar essa estrutura mínima e então fazê-la evoluir com o repertório de programação que a turma já possui.

## Material da aula

- [Plano de Ensino](../plano-de-ensino.md)
- [Cronograma](../cronograma.md)
- [Aulas](index.md)
- [Materiais](../materiais/index.md)
- [Referências e recursos](../materiais/referencias.md)
