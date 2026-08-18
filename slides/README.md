# Slides da disciplina

Os slides são escritos em Marp Markdown e constituem o ambiente principal de condução das aulas teóricas. O site permanece como material completo de estudo e consulta; a IDE real é reservada às situações em que a interação com a ferramenta tenha valor pedagógico.

Frames sucessivos podem repetir e evoluir código, perguntas, resultados e diagramas para construir a narrativa sem depender de animações.

- fontes dos decks: `slides/*.md`;
- tema visual compartilhado: `slides/theme/poo.css`;
- distribuições oficiais versionadas: `slides/rendered/`;
- artefatos temporários: `.slides-build/`.

Os arquivos HTML e PDF em `slides/rendered/` são gerados automaticamente a partir do fonte Marp e do tema. Eles podem ser abertos diretamente pelo GitHub ou distribuídos sem Node, Marp ou Chrome e não devem ser editados manualmente.

## Comandos

```bash
npm run slides:preview
npm run slides:html
npm run slides:pdf
npm run slides:pptx
```

Os scripts básicos de exportação operam sobre o deck piloto da Aula 03.
As exportações para PDF e PPTX exigem um navegador compatível com o Marp, como Chrome, Edge ou Firefox, disponível no ambiente local.

Para gerar as distribuições oficiais da Aula 02:

```bash
npm run slides:aula02
npm run slides:aula02:html
npm run slides:aula02:pdf
```

O comando agregado gera HTML e PDF em `slides/rendered/`. PPTX não faz parte do fluxo oficial.

Para gerar as distribuições oficiais da Aula 03:

```bash
npm run slides:aula03
npm run slides:aula03:html
npm run slides:aula03:pdf
```

As páginas das aulas podem apontar para os HTML e PDF oficiais. `.slides-build/` permanece reservado a artefatos temporários; arquivos em `slides/rendered/` são sempre derivados dos fontes e nunca devem ser editados manualmente.

## Ambiente no WSL

O pipeline deve usar Node e npm instalados no Linux. Dentro do WSL, `which node` e `which npm` não devem apontar para caminhos iniciados por `/mnt/c/`. A versão de referência está registrada em `.nvmrc` e pode ser ativada com `nvm use`.
