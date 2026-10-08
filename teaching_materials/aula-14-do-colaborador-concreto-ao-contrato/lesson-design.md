# Desenho da Aula 14 — Do colaborador concreto ao contrato

## Intenção e fonte

O professor definiu a Aula 14 como resposta ao limite deixado pela Aula 12, depois da introdução de testes na Aula 13. A fonte pública é `docs/aulas/aula-14-do-colaborador-concreto-ao-contrato.md`. O professor autorizou os ajustes narrativos da revisão e a geração dos slides em 8 de outubro de 2026. A derivação consome o registro de aprovação do estado ajustado pelo workflow Docemas.

## Continuidade e transformação

- Partir exatamente de `Pedido` com `private EntregaNormal entrega`, construtor sem entrega e `fechar(EntregaNormal)`. A escolha e a conservação da entrega acontecem no fechamento.
- `EntregaNormal`, `EntregaExpressa` e `RetiradaLocal` oferecem `calcularCusto(Pedido)`, com custos respectivos `10.0`, `25.0` e `0.0`; sua semelhança de método não as torna intercambiáveis na assinatura atual.
- Primeiro formular em linguagem natural o papel “algo capaz de calcular o custo da entrega”; só depois introduzir `interface Entrega` e `implements Entrega`.
- Trocar o tipo do campo e do parâmetro de `Pedido` para `Entrega`, preservando `fechar(...)`, sua guarda, `calcularCustoEntrega()` e as regras anteriores.
- Retomar variável, referência e objeto: `Entrega entrega = new EntregaExpressa()` cria um objeto concreto acessado por uma referência do tipo do contrato. Através dela, o código só solicita operações declaradas em `Entrega`.
- Usar os testes de `Pedido` apresentados na Aula 13 como verificações exemplares da mudança, sem afirmar que o Laboratório 13 produziu uma suíte de pedidos; esse laboratório continuou o Projeto 2.
- Acrescentar `EntregaAgendada` de custo `15.0` como experimento: `Pedido` não muda para aceitá-la.

## Trajetória e dimensionamento

Para 90 minutos: recuperar o impedimento de compilação e o papel estável; construir contrato e classes; trocar a dependência e retomar a mesma chamada expressa com saída `25.0`; verificar os testes conhecidos; experimentar nova implementação sem mudar `Pedido`; ler referência e objeto e fechar a pergunta seguinte. Perguntas dirigidas à turma permitem previsão, justificativa e síntese. Aprofundamentos elásticos: segunda tentativa de fechamento, método específico da classe concreta e necessidade de interfaces em outros pontos do sistema.

## Limites

Ensinar contrato, interface, `implements`, tipo da referência e tipo do objeto em nível de leitura e uso básico. Não formalizar polimorfismo, despacho dinâmico, sobrescrita, herança, classe abstrata, casting, `instanceof`, métodos `default`, SOLID, Strategy ou injeção de dependência. Encerrar com a pergunta de como Java escolhe a implementação, sem respondê-la; essa é a entrada da Aula 15 definida pelo professor.
