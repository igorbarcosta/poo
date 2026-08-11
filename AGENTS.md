# Site da disciplina de POO

Este repositório contém o site da disciplina de Programação Orientada a Objetos.

## Contexto

- O site é construído com Zensical.
- O conteúdo didático fica em `docs/` e deve ser escrito preferencialmente em Markdown.
- O site é publicado no GitHub Pages.
- O Google Classroom é o LMS oficial da turma.
- O Classroom é usado para avisos, entregas, atividades, avaliações e notas.
- Este site concentra o conteúdo didático permanente da disciplina.

## Estrutura

- `docs/`: conteúdo do site.
- `specs/`: decisões de estrutura e padrões pedagógicos; consulte-as antes de criar ou reorganizar conteúdo.
- Consulte `specs/padrao-aula.md` e `specs/padrao-laboratorio.md` antes de criar aulas ou laboratórios.
- Consulte `specs/projeto-pedagogico.md` antes de planejar aulas, atividades ou avaliações; o planejamento detalhado deve permanecer evolutivo.
- `zensical.toml`: configuração e navegação.
- `.github/workflows/`: publicação automática no GitHub Pages.
- `site/`: saída gerada pelo Zensical; não deve ser editada manualmente.

## Princípios

- Priorizar soluções simples e fáceis de manter.
- Usar Markdown para o conteúdo sempre que possível.
- Preferir recursos nativos do Zensical.
- Manter organização, nomenclatura e navegação consistentes.
- Evitar HTML, CSS e JavaScript customizados sem necessidade.
- Não adicionar dependências sem uma necessidade clara.
- Não inventar datas, avaliações, regras acadêmicas ou conteúdo não fornecido.
- Quando uma decisão pedagógica importante estiver indefinida, perguntar antes de implementá-la.

## Alterações

- Não excluir conteúdo existente sem necessidade ou autorização.
- Antes de mudanças estruturais importantes, apresentar brevemente um plano.
- Fazer alterações focadas somente no que foi solicitado.
- Não executar `git commit` ou `git push` sem solicitação explícita.

## Ambiente Python

Não presuma que a `.venv` esteja ativada na sessão do agente. Quando o repositório possuir `.venv/`, use diretamente seus executáveis para não depender do estado do shell que iniciou o Codex:

```bash
.venv/bin/python
.venv/bin/python -m pip
.venv/bin/zensical build
```

A ativação manual pode ser útil para uso humano, mas não é requisito do workflow dos agentes.

## Verificação

Após alterações relevantes no site:

1. Execute `.venv/bin/zensical build`.
2. Corrija erros de build antes de considerar a tarefa concluída.
3. Verifique `git diff` e `git status`.
4. Informe resumidamente os arquivos alterados.

## Regra principal

O agente pode implementar decisões pedagógicas já definidas, mas não deve tomar decisões pedagógicas importantes no lugar do professor.
