# Ajustes aplicados — Aula 21

A solicitação do professor “faça os 3 pontos” foi atendida.

1. **Validador e revisão formal:** em `../docemas/teaching_materials/contracts.py`,
   a resolução legada foi substituída pelo registro local de recursos do JSON
   Schema. O teste de regressão em `test_correction_contracts.py` verifica tanto
   a aceitação do snapshot quanto a rejeição de hash inválido após a referência
   externa de proveniência. Nenhuma dependência foi instalada. A revisão antes
   bloqueada foi emitida em `projection-recovered-2026-11-18.json`.
2. **Acesso aos slides:** links HTML/PDF adicionados à abertura do roteiro,
   seguindo a convenção da Aula 20; destinos locais conferidos.
3. **Estado documental:** planejamento e LessonDesign atualizados para distinguir
   autoria, revisão e projeção concluídas da situação histórica anterior.

## Registros atuais e histórico

A aprovação 01 foi preservada e passou a `VALID_STALE` por causa dos ajustes de
links e documentação. O registro 02 documenta esses ajustes explicitamente
autorizados, sem alterar a narrativa ou os exemplos da aula. A aprovação 02 e
a proveniência 02 foram classificadas `VALID_CURRENT`.

Registros atuais:

- `../approvals/lesson-approval-poo-aula-21-02.json`.
- `../slides/aula-21-quando-uma-operacao-nao-pode-continuar-02.provenance.json`.
- `pedagogical-after-adjustments-2026-11-18.json`: ReviewRun canônico válido.
- `projection-after-adjustments-2026-11-18.json`: ReviewRun de projeção válido.

As tentativas malsucedidas e os relatórios anteriores permanecem como histórico;
a pendência neles descrita foi resolvida pelos registros acima.

## Verificação

- Build Zensical concluído sem erros.
- `npm test` do Docemas passou, incluindo a suíte de 124 testes de materiais.
- `git diff --check` passou nos dois repositórios.
- Fonte, HTML e PDF dos slides preservados; hashes coincidem com a inspeção
  visual registrada, com 39 slides/páginas. Não foi necessária nova renderização.
- A suíte de integração do POO executou 11 testes: nove passaram e dois falharam
  nas referências históricas da Aula 05 (hash esperado e proveniência histórica).
  As mesmas duas falhas foram reproduzidas em um processo isolado usando os bytes
  exatos de contracts.py anteriores à correção. Não são regressões deste ajuste;
  os materiais da Aula 05 e seus testes foram preservados.

Sem commit, push ou publicação. Nenhum conteúdo pedagógico dos slides foi alterado.
