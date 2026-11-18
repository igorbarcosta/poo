# Planejamento da Aula 21 — Quando uma operação não pode continuar

## Desenho acordado e contexto

O professor definiu o foco em exceções a partir do Megamania e aprovou a
inclusão de `IllegalArgumentException`, `NullPointerException`,
`ClassCastException`, `IndexOutOfBoundsException` e
`UnsupportedOperationException`. O repertório deve ligar mensagem, causa e
correção, distinguindo proteção de contratos de diagnóstico de defeitos.

A Aula 20 preparou os percursos de movimento, disparo e impacto. As Aulas
17 e 18 fornecem a base de interfaces, cast e herança. A Aula 13 fornece
JUnit básico. O roteiro não presume tratamento prévio de exceções nem domínio
de lambdas; a notação mínima de `assertThrows` será explicada localmente.

## Pergunta e intenção

**Quando uma operação não pode acontecer, como o objeto comunica isso?**

O aluno deve distinguir recusa prevista de chamada inválida, acompanhar a
interrupção e propagação de uma exceção, diagnosticar falhas por tipo e
percurso de chamadas e verificar a proteção de estado.

## Trajetória de referência — 90 minutos

| Etapa | Tempo | Evidência de compreensão |
| --- | --- | --- |
| Comparar recarga e argumento inválido | 15 min | Justificar retorno normal e exceção pelos contratos. |
| Seguir `throw`, propagação e `try/catch` | 20 min | Prever instruções executadas e ponto de continuação. |
| Diagnosticar falhas comuns | 30 min | Localizar referência, cast, índice ou operação incorreta. |
| Verificar contrato e estado com JUnit | 15 min | Distinguir exceção esperada de teste interrompido por falha. |
| Transferir e sintetizar | 10 min | Delimitar uma operação e justificar sua comunicação. |

Núcleo necessário: os cinco tipos, fluxo básico, leitura do stack trace,
verificação e transferência. Como aprofundamento elástico, investigar a
posição da validação em `Partida.atualizar` e distinguir lista não modificável
de objetos imutáveis. Evitar exposição repetida para preencher tempo.

## Recortes e limites

- Usar código real de `jogos/exemplo-megamania`; identificar experiências
  defeituosas e programas de diagnóstico como construções didáticas.
- Explorar `Partida(null)`, direção inválida, validação em `Corpo`, disparo
  durante recarga, cast entre participantes e consulta das listas.
- Mostrar que `catch` não retoma a instrução que falhou nem desfaz alterações.
- Não recomendar capturar falhas de programação em cada quadro do jogo.
- Apresentar os cinco tipos como subclasses de `RuntimeException`, sem
  hierarquia extensa. Não introduzir exceções próprias, `finally`, arquivos,
  recursos, checked exceptions ou `throws` como novo eixo de conteúdo.
- Nenhuma mudança de mecânica ou código distribuído é necessária.

## Relação com outros artefatos

O roteiro público é `docs/aulas/aula-21-quando-uma-operacao-nao-pode-continuar.md`.
O pacote em `teaching_materials/` referencia essa fonte sem duplicá-la.
O roteiro passou pela revisão pedagógica e foi aceito pelo professor para
prosseguir aos slides. O pacote registra a aprovação e a proveniência da
projeção; os registros anteriores são preservados como histórico. O deck possui
39 slides, com distribuições HTML/PDF e inspeção visual registradas. A revisão
da projeção foi validada após a correção da resolução de schemas no Docemas.

O incremento do laboratório permanece em aberto. Esta aula prepara a análise
de contratos dos jogos individuais, sem exigir exceções artificiais, definir
entrega, nota ou uma nova arquitetura. Nas atividades ligadas ao Projeto 3,
vale IA Nível 3 — Colaborador, conforme o projeto pedagógico.

## Referências

- [Projeto pedagógico](projeto-pedagogico.md).
- [Unidade 03](planejamento-unidade-03.md).
- [Aula 20](planejamento-aula-20.md).
- [Padrão de aula](padrao-aula.md).
