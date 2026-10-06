# Desenho da Aula 13 — Como saber se ainda funciona?

## Intenção e fontes

O professor definiu a Aula 13 como primeira introdução a testes automatizados com JUnit, centrada em descrever e verificar comportamento. A pergunta nasce do fechamento da Aula 12: antes de mudar a colaboração de entrega que já funciona, como verificar as regras preservadas? A fonte pública é `docs/aulas/aula-13-como-saber-se-ainda-funciona.md`.

O professor aprovou a derivação dos slides após corrigir a forma de receber a entrega. Depois, definiu que o Laboratório 13 deve continuar o Projeto 2 no estado final do Laboratório 12. A aula mantém `Pedido` como exemplo teórico; a prática transfere os testes para `Lembrete`.

## Trajetória

1. Partir de `System.out.println` e de uma comparação explícita entre observado e esperado em código comum.
2. Mostrar o custo de repetir verificações manuais e introduzir somente `@Test` e `assertEquals` como estrutura mínima de JUnit.
3. Ler testes como histórias de comportamento: cenário, ação, expectativa e nome informativo, sem transformar Arrange–Act–Assert em ritual obrigatório.
4. Proteger regras da Versão 10 por operações públicas, inclusive chamadas que devem preservar o estado.
5. Proteger `EntregaNormal` antes da mudança da Aula 14; mostrar falha e correção propositalmente e delimitar o que um teste aprovado demonstra.

O encontro de 90 minutos reserva espaço para previsão, leitura, escrita curta e discussão dirigida à turma. Aprofundamentos elásticos comparam a força de diferentes cenários, sem introduzir mecanismos futuros.

## Código e continuidade

- Manter a API da Aula 12: `new Pedido()`, depois `fechar(new EntregaNormal())`; custo da entrega consultado separadamente após fechar.
- Usar preços `150.0` e `80.0`, custo normal `10.0`, identificação de linhas pela mesma referência de `Produto` e regras da Versão 10.
- O Laboratório 13 usa a solução final da Versão 1 do Projeto 2. `avisar()` para e-mail e `getQuantidadeAvisos()` são operações comuns; SMS e painel mantêm a API escolhida pelo estudante no Laboratório 12.
- O laboratório requer sete testes ao final: um fornecido, cinco regras especificadas e uma escolhida pelo estudante. Uma alteração temporária na contagem de avisos permite observar vermelho e verde, com restauração obrigatória.
- Os primeiros testes JUnit observam o contador público. Formato e ordem das linhas no console permanecem conferências manuais; não introduzir captura de saída ou novas abstrações de teste.

## Limites

Não ensinar `assertThrows`, `@BeforeEach`, testes parametrizados, mocks, cobertura, TDD formal, fixtures complexas, integração, Maven ou Gradle como conteúdo. Não introduzir interface nem antecipar a solução da Aula 14. A suíte oferece evidência relativa aos cenários e expectativas codificados; não prova ausência de defeitos.
