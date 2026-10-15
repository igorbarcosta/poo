# Desenho da Aula 15 — Polimorfismo: a mesma mensagem, comportamentos diferentes

Artifact identity: `lesson-design-poo-aula-15`.

## Fontes e autorização

O desenho pedagógico é o registrado em `specs/planejamento-aula-15.md`. A fonte
permanente é `docs/aulas/aula-15-polimorfismo-a-mesma-mensagem-comportamentos-diferentes.md`.
Depois da revisão do par, o professor autorizou o ajuste pontual no Laboratório
15 e a geração dos slides: “faca o ajuste pontual e pode em seguida gerar os
slides”. O ajuste acrescenta a verificação das referências nas posições
originais da lista. A geração consome a aprovação registrada pelo workflow
Docemas para os bytes atuais deste desenho e da aula.

## Intenção e continuidade

Turma de POO com o repertório das Aulas 01–14. A Aula 14 estabeleceu interfaces
e a possibilidade de classes diferentes ocuparem um mesmo papel. A pergunta
agora é como Java escolhe a implementação executada. Preservar `Pedido`,
`EntregaNormal` com custo `10.0` e `EntregaExpressa` com custo `25.0`.

O estudante deve prever compilação, localizar o receptor, identificar a
implementação e acompanhar valores e mudanças de estado. Distinguir tipo
declarado, classe do objeto, reatribuição local e campo guardado.

## Trajetória

1. Prever duas chamadas pela mesma variável; mudar o objeto, conservando o tipo.
2. Investigar referências compartilhadas e posterior reatribuição; representar
   o estado antes e depois com os componentes visuais existentes.
3. Formalizar polimorfismo e despacho dinâmico após as observações.
4. Investigar o método específico `priorizarNaFila()`: a interface limita a
   chamada na compilação; o objeto determina a implementação da chamada válida.
5. Retomar `Pedido`, que guarda a entrega no primeiro fechamento válido;
   reatribuir a variável local e tentar outro fechamento. Mostrar um teste JUnit.
6. Comparar colaboração e seleção de modalidades; incorporar `EntregaAgendada`
   de custo `15.0` sem modificar o pedido.
7. Retomar `List`, `ArrayList`, `add` e percurso pelo contrato, sem alterar a
   regra de uma entrega por pedido. Explicar lista vazia e referência repetida.
8. Transferir para personagem com vida inicial `50`, poção de `20` e armadilha
   de `10`: prever `70` e `60`, acompanhar as chamadas e diagnosticar seleção
   desnecessária de classes. Incorporar `FonteDeCura` de `5`, chegando a `65`.
9. Sintetizar as quatro perguntas de análise e fazer a ponte para o Laboratório
   15, que acrescenta `avisarPorTodos(List<Notificador>)` ao Projeto 2.

## Restrições de projeção

Manter todas as situações e a transferência. O professor controla o tempo;
não fixar divisão de minutos nem marcar situações como opcionais por duração.
Uma atividade recebe resposta completa e visível no frame imediatamente
seguinte. Preservar os exemplos e explicitar mudanças de cenário. Usar Marp e
o perfil `slides/presentation-profile.md`, sem alterar o tema compartilhado.

Não introduzir herança, sobrecarga, casts, inspeção de tipos ou novas regras
para vida, falha de envio ou fechamento. O jogo é transferência conceitual;
não define o domínio do Projeto 3. O laboratório mantém IA Nível 1 e entrega
somente de arquivos Java.
