# Slides da disciplina

Os slides são escritos em Marp Markdown e constituem o ambiente principal de condução das aulas teóricas. O site permanece como material completo de estudo e consulta; a IDE real é reservada às situações em que a interação com a ferramenta tenha valor pedagógico.

Frames sucessivos podem repetir e evoluir código, perguntas, resultados e diagramas para construir a narrativa sem depender de animações.

- fontes dos decks: `slides/*.md`;
- tema visual compartilhado: `slides/theme/poo.css`;
- distribuições oficiais versionadas: `slides/rendered/`;
- artefatos temporários: `.slides-build/`.

Os arquivos HTML e PDF em `slides/rendered/` são gerados automaticamente a partir do fonte Marp e do tema. Eles podem ser abertos diretamente pelo GitHub ou distribuídos sem Node, Marp ou Chrome e não devem ser editados manualmente.

## Comandos

Para visualizar os decks durante a edição:

```bash
npm run slides:preview
```

Para gerar HTML e PDF oficiais de uma aula, informe o nome do arquivo sem `slides/` e sem a extensão `.md`:

```bash
npm run slides:render -- aula-04-protegendo-o-estado-dos-objetos
```

O comando localiza `slides/<slug>.md` e gera `slides/rendered/<slug>.html` e `slides/rendered/<slug>.pdf`. A exportação para PDF exige um navegador compatível com o Marp, como Chrome, Edge ou Firefox, disponível no ambiente local.

As páginas das aulas podem apontar para os HTML e PDF oficiais. `.slides-build/` permanece reservado a experimentos temporários; arquivos em `slides/rendered/` são sempre derivados dos fontes e nunca devem ser editados manualmente.

## Ambiente no WSL

O pipeline deve usar Node e npm instalados no Linux. Dentro do WSL, `which node` e `which npm` não devem apontar para caminhos iniciados por `/mnt/c/`. A versão de referência está registrada em `.nvmrc` e pode ser ativada com `nvm use`.
