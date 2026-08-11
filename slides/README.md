# Slides da disciplina

Os slides são escritos em Marp Markdown e constituem o ambiente principal de condução das aulas teóricas. O site permanece como material completo de estudo e consulta; a IDE real é reservada às situações em que a interação com a ferramenta tenha valor pedagógico.

Frames sucessivos podem repetir e evoluir código, perguntas, resultados e diagramas para construir a narrativa sem depender de animações.

- fontes dos decks: `slides/`;
- tema: `slides/theme/poo.css`;
- saídas locais: `.slides-build/`;
- HTML, PDF e PPTX gerados não são versionados nesta etapa.

## Comandos

```bash
npm run slides:preview
npm run slides:html
npm run slides:pdf
npm run slides:pptx
```

Os scripts de exportação atuais operam sobre o deck piloto da Aula 03.
As exportações para PDF e PPTX exigem um navegador compatível com o Marp, como Chrome, Edge ou Firefox, disponível no ambiente local.
