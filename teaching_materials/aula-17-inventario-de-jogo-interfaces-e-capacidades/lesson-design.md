# Desenho da Aula 17 — Inventário de jogo: interfaces e capacidades

Artifact identity: `lesson-design-poo-aula-17`.

## Contexto e intenção

Unidade 02, depois das Aulas 14–16. Público: estudantes de POO em Java com
repertório de interfaces, tipo declarado e classe concreta, despacho dinâmico,
referências, listas, composição, delegação, encapsulamento e JUnit básico.

A referência docente é `specs/planejamento-aula-17.md`. O professor definiu a
transferência para um inventário inspirado em Minecraft, a consolidação de
interfaces, cast e `instanceof`, a ausência de laboratório e a posição antes
do Checkpoint 04. As regras numéricas e assinaturas propostas naquele desenho
são usadas neste rascunho para tornar as situações determinadas; permanecem
sujeitas à revisão docente, sem registro de aprovação por inferência.

A fonte canônica do papel `lesson.md` é
`docs/aulas/aula-17-inventario-de-jogo-interfaces-e-capacidades.md`, identidade
`lesson-poo-aula-17`. Não duplicar o roteiro público neste diretório.

## Aprendizagem e trajetória

Pergunta: como um inventário guarda itens diferentes e permite operações
específicas sem exigir que todos ofereçam as mesmas capacidades?

O estudante deve distinguir contrato de apresentação e capacidade de reparo;
decidir sobre compilação, compatibilidade e despacho; explicar identidade e
estado após um cast; delegar pelo contrato necessário; e verificar consumo,
limites e impacto de mudança.

1. Partir da seleção de espada, escudo e maçã. Recuperar a listagem por `Item`
   e o despacho de `descrever()`, antes de investigar o reparo.
2. Contrastar a chamada recusada por `Item` com o cast para `Espada`. Acompanhar
   o mesmo objeto no inventário, a durabilidade `40 → 65` e o ferro `2 → 1`.
3. Selecionar a maçã em cenário independente. Separar aceitação do cast na
   compilação e falha em execução; introduzir `instanceof` antes do cast.
4. Comparar reparo em todo `Item`, ramos por classe e contrato `Reparavel`.
   Construir a bigorna por verificação de capacidade e delegação. Distinguir
   ter a capacidade de satisfazer material, saldo e durabilidade.
5. Prever três verificações prioritárias: sucesso, material incompatível e
   limite. Relacionar consumo e estado; reconhecer limites da cobertura.
   Transferir para `Picareta` e realizar quatro decisões individuais curtas.

## Escopo, apoio e condução

Incluídos: interfaces independentes no mesmo objeto, cast de referências,
`instanceof` tradicional, reconhecimento localizado de `ClassCastException`,
polimorfismo, identidade, responsabilidades, invariantes, testes e evolução.

Excluídos: `extends`, classes abstratas, tratamento de exceções, pattern
matching, combate, consumo de alimentos, encantamentos, experiência, GUI e
reprodução da implementação do Minecraft. A maçã cumpre somente `Item`.

Usar os limites e acréscimos didáticos do planejamento: espada `100`/`25` com
ferro; escudo `80`/`20` com madeira. Um sucesso consome uma unidade inclusive
no reparo parcial até o máximo. Uma recusa preserva equipamento e pilha.
Construtores protegem intervalos por condicionais já conhecidos; entradas
inválidas não são uma investigação adicional. Pilhas são diferentes de `null`;
os índices são válidos e os itens do inventário não são nulos.

`Inventario` e `PilhaMaterial` são fornecidos como apoio expansível. A leitura
do núcleo usa o laço de listagem e as operações da pilha, sem reconstruir essas
classes. O roteiro mostra recortes de reparo e contratos antes das versões
completas de consulta. A comparação de textos em `PilhaMaterial` recebe uma
explicação local mínima; não se abre uma unidade sobre igualdade.

Referência: 90 minutos, incluindo formulação e discussão das respostas.
Distribuição interna: inventário e recuperação, cerca de 10 minutos; cast,
identidade e falha, 20; capacidade e delegação, 25; verificações e evolução,
15; aplicação individual e discussão, 20. São estimativas de autoria.

As perguntas dirigem-se à turma toda, com elaboração individual antes da
discussão. O roteiro autoguiado oferece contexto local e respostas imediatas
expansíveis. A atividade final começa individualmente, sem consulta e sem
nota. IA Nível 1 — Tutor: a ajuda vem depois da previsão e justificativa.
Classes completas e casos complementares são consulta; reatribuição local é
aprofundamento opcional. Preservar a aplicação final se o ritmo exigir escolhas.

## Relações e decisões em aberto

Sem Laboratório 17, entrega ou incremento do Projeto 2. O cenário não define
o Projeto 3. Não encerrar a Unidade 02 nem decidir a sequência posterior.
O planejamento do Checkpoint 04 permanece uma tarefa separada; a aula não
determina o repertório que será cobrado nele.

O roteiro está preparado para apreciação docente. A preparação não constitui
aprovação semântica. Regras, assinaturas e redação permanecem revisáveis;
slides dependem de solicitação posterior e aprovação pedagógica explícita.
