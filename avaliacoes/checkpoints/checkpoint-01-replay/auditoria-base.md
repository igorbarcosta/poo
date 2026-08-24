# Auditoria objetiva da base — Checkpoint 01 Replay

## Registro da versão final

A versão atual de `base.md` é a fonte semântica final refinada manualmente pelo professor. O motor de avaliações foi usado como apoio para estrutura, diagnóstico e auditoria. A redação final e a legibilidade foram validadas humanamente pelo professor e não foram reabertas nesta etapa.

Não permanecem bloqueios objetivos conhecidos para a aprovação da base.

## Estrutura e pontuação

| Questão | Formato | Unidades corrigíveis | Pontos |
|---|---|---:|---:|
| Q01 | saídas S1–S7 | 7 | 35 |
| Q02 | V/F, itens a–e | 5 | 25 |
| Q03 | múltipla escolha A–E | 1 | 10 |
| Q04 | múltipla escolha A–E | 1 | 10 |
| Q05 | múltipla escolha A–E | 1 | 10 |
| Q06 | múltipla escolha A–E | 1 | 10 |
| **Total** | **6 questões** | **16** | **100** |

A distribuição por questão é `35/25/10/10/10/10`.

## Resolução determinada

| Questão | Resposta |
|---|---|
| Q01 | S1 `true`; S2 `false`; S3 `true`; S4 `10.0`; S5 `8.0`; S6 `12.0`; S7 `1.0` |
| Q02 | a) V; b) V; c) V; d) V; e) F |
| Q03 | B |
| Q04 | A |
| Q05 | A |
| Q06 | B |

Q03–Q06 possuem exatamente cinco alternativas A–E e uma única resposta correta. As cinco afirmações de Q02 são inequivocamente verdadeiras ou falsas nas condições apresentadas.

## Cobertura curricular

| Eixo | Unidades | Pontos |
|---|---|---:|
| Estrutura e responsabilidade | Q02a–Q02c; Q02e; Q03 | 30 |
| Referências e identidade | Q01a–Q01f | 30 |
| Encapsulamento e evolução controlada | Q01g; Q02d; Q04; Q05; Q06 | 40 |
| **Total** | **16 unidades** | **100** |

O código e as alternativas usam somente o repertório previsto até o Laboratório 04: classes, objetos, referências, `new`, campos, métodos, parâmetros, retorno, `void`, tipos básicos, `if`, comparações simples, acesso com `.`, `public`, `private`, acesso de pacote e `System.out.println`. Não foi identificado conteúdo posterior ao recorte curricular.

## Integridade objetiva

- O blueprint aprovado permanece íntegro e é o contrato da base.
- A estrutura da base corresponde ao blueprint: 6 questões, 16 unidades corrigíveis, 100 pontos e distribuição `35/25/10/10/10/10`.
- A cobertura consolidada permanece `30/30/40`.
- S1–S7, os cinco itens V/F e Q03–Q06 foram resolvidos e conferidos.
- Os trechos apresentados como Java usam tokens e sintaxe literal válidos no contexto. Em Q05C, o acesso ao campo `private` é sintaticamente Java, mas é recusado pelo controle de acesso, como parte da alternativa incorreta.
- `preview/base.html` foi regenerado pelo comando oficial e corresponde à versão final de `base.md`.
- Os testes determinísticos do motor e `git diff --check` foram executados nesta etapa.

## Decisão

**APROVÁVEL para registro humano de `base_aprovada`.** A validação desta etapa foi exclusivamente objetiva. A redação e a legibilidade pertencem à decisão final já tomada pelo professor.
