# Fronteira de avaliações: POO e Docemas

O contrato genérico de instrumentos avaliativos pertence ao domínio de avaliações do projeto Docemas, no checkout local irmão:

`../docemas/specs/assessments/`

Docemas é a autoridade para:

- blueprint vivo e estado semântico `base.md + blueprint.md`;
- Markdown estruturado, IDs internos estáveis e rótulos visuais;
- workflow schema v2 e compatibilidade de leitura com schema v1;
- estados de trabalho até `base_aprovada`;
- hashes e invalidação do gate;
- templates, tooling e skills genéricos.

Este repositório fornece o contexto curricular, as políticas específicas registradas em `padrao-avaliacoes.md`, os instrumentos concretos e os derivados da disciplina.

## Integração local

Durante o desenvolvimento, `avaliacoes/scripts/` contém wrappers finos que procuram Docemas em `../docemas` ou no caminho definido por `DOCEMAS_ROOT`. Novos instrumentos copiam templates de `../docemas/assessments/templates/instrument/`.

Essa integração é temporária de desenvolvimento. Empacotamento, versionamento e distribuição das skills ainda não foram decididos. Não copiar de volta specs ou tooling genéricos para este repositório.

Os artefatos históricos, inclusive o Checkpoint 01 e manifests schema v1, permanecem em POO e não são migrados automaticamente.
