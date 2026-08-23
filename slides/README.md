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
bash slides/render.sh aula-04-protegendo-o-estado-dos-objetos
```

Esse é o entrypoint oficial e também pode ser chamado, quando `npm` já estiver corretamente configurado no Linux, por:

```bash
npm run slides:render -- aula-04-protegendo-o-estado-dos-objetos
```

O comando executa um preflight curto, localiza uma instalação Linux de Node compatível com `.nvmrc`, usa o Marp versionado pelo projeto e um browser Linux compatível para gerar `slides/rendered/<slug>.html` e `slides/rendered/<slug>.pdf`. Ele não instala dependências nem altera a configuração global.

A exportação PDF ocorre inteiramente no Linux. O script procura, no `PATH`, Chrome, Chromium ou Firefox compatível e informa explicitamente ao Marp o tipo e o caminho encontrados. Um browser instalado fora do `PATH` pode ser indicado por `SLIDES_BROWSER_PATH`. A ausência de browser Linux ou qualquer falha de exportação interrompe o processo; não há fallback para executáveis Windows.

Os processos externos têm limite normal de 120 segundos e usam um grupo de processos Linux próprio. Ao exceder o limite, o script envia `SIGTERM`, aguarda 3 segundos, aplica `SIGKILL` ao grupo se necessário e espera pelo encerramento antes de limpar um artefato parcial. Se o encerramento não puder ser confirmado, o diretório de staging é preservado para evitar limpeza concorrente, seu caminho é informado no erro e o workflow falha explicitamente. `TMPDIR`, `TEMP` e `TMP` são definidos para `.slides-build/tmp/`, impedindo que variáveis herdadas do Windows desviem temporários do Marp para fora do ambiente Linux.

HTML e PDF são gerados em uma área temporária no mesmo filesystem de `slides/rendered/`. O script exige ali a mesma quantidade de slides no fonte, de seções no HTML e de páginas no PDF. Somente depois da validação integral os dois arquivos substituem a distribuição oficial por renames locais; se a promoção falhar, os artefatos anteriores são restaurados. Qualquer falha com término confirmado descarta apenas a tentativa temporária e mantém intacta a distribuição oficial existente; sem confirmação de término, o staging é preservado conforme descrito acima.

As páginas das aulas podem apontar para os HTML e PDF oficiais. `.slides-build/` permanece reservado a experimentos temporários; arquivos em `slides/rendered/` são sempre derivados dos fontes e nunca devem ser editados manualmente.

## Ambiente no WSL

O pipeline deve usar Node e browser instalados no Linux. O entrypoint rejeita um `node` Windows encontrado no `PATH` e tenta reutilizar a versão indicada por `.nvmrc` quando ela já estiver instalada pelo NVM. O renderer aceita Google Chrome, Chromium ou Firefox suportado pelo Marp. Se o runtime ou o browser adequado não estiver disponível, o preflight encerra sem instalar nem reconfigurar o ambiente.

Mensagens de erro descrevem o comportamento observado. A versão do WSL, a configuração ou a causa ambiental só devem ser afirmadas depois de verificação explícita.
