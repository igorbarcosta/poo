# Desenho da Aula 21 — Quando uma operação não pode continuar

Artifact identity: `lesson-design-poo-aula-21`.

O desenho está em `specs/planejamento-aula-21.md`. O roteiro canônico é
`docs/aulas/aula-21-quando-uma-operacao-nao-pode-continuar.md`, identidade
`lesson-poo-aula-21`; não é duplicado neste pacote.

## Intenção e trajetória

Após acompanhar as colaborações do Megamania na Aula 20, investigar como os
objetos comunicam chamadas inválidas e como diagnosticar falhas. A pergunta
central é: quando uma operação não pode acontecer, como o objeto comunica isso?

1. Comparar recusa de disparo durante recarga com argumento inválido.
2. Acompanhar lançamento, propagação, captura e continuação do fluxo.
3. Diagnosticar `NullPointerException`, `ClassCastException`,
   `IndexOutOfBoundsException` e `UnsupportedOperationException`, retomando
   `IllegalArgumentException` e a leitura do stack trace.
4. Verificar exceção e preservação do estado com JUnit.
5. Transferir o raciocínio para uma operação do próprio jogo.

## Contexto, limites e decisões abertas

Público: estudantes de POO com referências, contratos, cast, herança, listas
e JUnit básico já apresentados. Explicar a expressão diferida de `assertThrows`
somente para leitura e uso no teste. Referência de 90 minutos, conforme a spec.

Na autoria do roteiro, não criar hierarquia de exceções, conteúdo de arquivos,
nova mecânica, deck, instrumento avaliativo ou laboratório. O deck posterior
é uma projeção do roteiro aceito. Evitar captura genérica que esconda defeitos.
Distinguir experiências didáticas do código existente.

O professor acordou o desenho e os cinco tipos. Após a revisão do roteiro,
autorizou seguir para os slides e, depois da revisão integrada, solicitou
os ajustes de acesso e documentação. Aprovação, revisão e proveniência são
registradas em arquivos próprios no pacote; este desenho não substitui esses
registros. As versões anteriores permanecem como histórico.
O incremento do laboratório continua indefinido. IA Nível 3 nas atividades
de transferência para o Projeto 3, sem novas obrigações de entrega.
