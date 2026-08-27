# Avaliações de POO

Este diretório contém instrumentos concretos, retrospectivas e artefatos finais da disciplina. A infraestrutura genérica pertence ao domínio de avaliações do Docemas.

## Integração local de desenvolvimento

Por padrão, POO procura o checkout irmão em:

```text
~/workspace/docemas
~/workspace/poo
```

Outro caminho pode ser informado com `DOCEMAS_ROOT`. Esta integração é temporária; distribuição e versionamento ainda serão decididos.

Os comandos locais permanecem estáveis por wrappers finos:

```bash
npm run avaliacoes:workflow -- validate avaliacoes/<colecao>/<identificador>
npm run avaliacoes:preview -- generate avaliacoes/<colecao>/<identificador>
npm run avaliacoes:test
```

## Criar um instrumento

Copie do Docemas somente os artefatos necessários à fase:

```text
../docemas/assessments/templates/instrument/
```

As specs genéricas estão em `../docemas/specs/assessments/`. As decisões curriculares e institucionais de POO permanecem em `specs/projeto-pedagogico.md` e `specs/padrao-avaliacoes.md`.

`base.md` contém o instrumento apresentado ao estudante; `blueprint.md` contém o projeto pedagógico. O gate `base_aprovada` congela ambos. Não registrar aprovação sem decisão humana explícita.

## Histórico

Checkpoint 01, replay, variantes, gabaritos e PDFs continuam pertencendo a POO. Manifests schema v1 são validados pelo suporte histórico do Docemas sem migração automática.

As skills locais em `.agents/skills/` são interfaces de descoberta e extensão disciplinar. O processo genérico autoritativo está em `../docemas/.agents/skills/`.
