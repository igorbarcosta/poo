# Produção de avaliações

Instrumentos novos seguem `specs/contrato-artefatos-avaliacoes.md`. Checkpoints históricos permanecem válidos em sua organização original até que uma migração seja solicitada explicitamente.

## Preparar o ambiente

O projeto usa a versão de Python registrada em `.python-version` e as dependências pinadas em `requirements.txt`. Em um clone novo:

```bash
python3.12 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
```

`PyYAML` é dependência direta do validador de workflow, não uma dependência implícita do Zensical.

## Iniciar um instrumento

Crie `avaliacoes/checkpoints/<identificador>/` ou `avaliacoes/provas/<identificador>/` e copie inicialmente somente `workflow.yaml` e `blueprint.md` de `avaliacoes/templates/instrumento/`. Os demais esqueletos são copiados quando o estágio correspondente for autorizado; sua existência não antecipa um gate.

O comando comum é:

```bash
npm run avaliacoes:workflow -- validate avaliacoes/<tipo>/<identificador>
```

Ele valida schema, estados, hashes e os artefatos exigidos pelos gates já aprovados.

A suíte automatizada do harness é executada com:

```bash
npm run avaliacoes:test
```

## Registrar um gate

O comando abaixo só pode ser executado depois de uma decisão humana explícita:

```bash
npm run avaliacoes:workflow -- approve avaliacoes/<tipo>/<identificador> \
  --gate blueprint_aprovado \
  --decision "Blueprint aprovado explicitamente pelo professor."
```

Os demais nomes são `base_aprovada`, `variantes_aprovadas` e `liberada_para_impressao`. O comando calcula o hash dos artefatos declarados, registra a decisão e invalida registros posteriores quando um gate anterior é refeito.

Se um artefato congelado for alterado sem novo gate, `validate` falha. Essa falha torna o gate e todos os posteriores efetivamente inválidos; o tooling não tenta inferir uma nova aprovação.

## Limites atuais

O tooling não julga dificuldade, validade pedagógica, distratores, equivalência cognitiva nem prontidão visual. Também não implementa ainda o renderer comum Markdown → LaTeX/PDF. O diretório `rendered/` só pode ser congelado no gate de impressão depois que os derivados tiverem sido gerados e revisados visualmente por um fluxo posterior.
