# Ambiente de Desenvolvimento

Nesta disciplina, usaremos o **Java 25** como versão de referência. As demonstrações serão feitas principalmente no **IntelliJ IDEA**, mas você pode trabalhar com a ferramenta em que se sentir mais confortável.

VS Code, Eclipse, NetBeans, terminal e outras ferramentas são alternativas válidas. O importante é que você consiga compilar, executar e explicar o próprio código.

## Instalação do Java

Recomendamos o **Eclipse Temurin JDK 25**, uma distribuição do OpenJDK mantida pelo projeto Eclipse Adoptium. Baixe a versão adequada ao seu sistema operacional na [página oficial do Temurin](https://adoptium.net/temurin/releases/?version=25).

Durante a instalação, mantenha habilitadas as opções que adicionam o Java ao `PATH`, quando elas forem oferecidas.

### JDK e JRE

- **JRE** (*Java Runtime Environment*): reúne o necessário para executar programas Java;
- **JDK** (*Java Development Kit*): inclui o ambiente de execução e ferramentas de desenvolvimento, como o compilador `javac`.

Para desenvolver, precisamos do **JDK**.

## Verificando a instalação

Abra um terminal e execute:

```bash
java --version
javac --version
```

Os dois comandos devem indicar a versão 25. Se `java` funcionar, mas `javac` não estiver disponível, verifique se você instalou o JDK e se seu diretório `bin` está no `PATH`.

## Primeiro programa

Crie uma pasta para o programa e, dentro dela, um arquivo chamado `Main.java`:

```java
public class Main {

    public static void main(String[] args) {
        System.out.println("Olá, POO!");
    }
}
```

No terminal, dentro da pasta que contém o arquivo, compile e execute:

```bash
javac Main.java
java Main
```

O primeiro comando gera `Main.class`. O segundo executa a classe `Main` e deve exibir no console:

```text
Olá, POO!
```

## Projeto simples no IntelliJ IDEA

As demonstrações da disciplina usarão o IntelliJ IDEA como IDE de referência. Para criar um projeto Java simples:

1. abra o IntelliJ IDEA e selecione **New Project**;
2. escolha **Java**;
3. informe um nome e uma pasta para o projeto;
4. em **Build system**, selecione **IntelliJ**;
5. em **JDK**, selecione o Temurin 25 instalado;
6. se ele não aparecer, use **Add JDK from Disk** e indique a pasta do JDK 25;
7. crie o projeto e adicione `Main.java` à pasta de código-fonte.

Os nomes exatos de algumas opções podem variar um pouco entre versões da IDE. O ponto essencial é que o projeto esteja configurado para usar o **JDK 25**.

!!! info "Começaremos com o ambiente mínimo"

    Inicialmente, não usaremos:

    - Maven ou Gradle;
    - Docker ou WSL;
    - frameworks;
    - banco de dados.

    Esses recursos serão introduzidos somente quando houver uma necessidade pedagógica.

## Projetos independentes da IDE

O código do projeto não deve depender de uma IDE específica. Os arquivos `.java` devem continuar compreensíveis e executáveis em outro editor ou pelo terminal.

Uma IDE facilita tarefas como editar, navegar, compilar e executar, mas não muda os fundamentos do programa. Sempre que necessário, você deve conseguir reconhecer o fluxo básico:

**código-fonte → compilação → execução**

## Recursos automáticos e IA

IDEs podem completar código, organizar importações, gerar trechos e sugerir correções. Algumas também oferecem recursos de IA. Use esses apoios de acordo com as orientações de cada atividade, sem transferir a eles a responsabilidade de compreender a solução.

!!! warning "Princípio de domínio"

    **Código que você não consegue explicar não é código que você domina.**

    Antes de aceitar uma sugestão automática, procure compreender o que ela faz, por que funciona e como se relaciona com o problema.

## Checklist do ambiente

Antes do primeiro laboratório, verifique se:

- [ ] o Eclipse Temurin JDK 25 está instalado;
- [ ] `java --version` indica a versão 25;
- [ ] `javac --version` indica a versão 25;
- [ ] você consegue compilar `Main.java` com `javac Main.java`;
- [ ] você consegue executar o programa com `java Main`;
- [ ] sua IDE ou editor está configurado para usar o JDK 25;
- [ ] o projeto pode ser compreendido e executado sem depender de recursos exclusivos da IDE.
