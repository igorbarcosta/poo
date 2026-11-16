# Prova da Unidade 02 — primeira versão para revisão

Recorte confirmado: conteúdos até a Aula 18, sem tratamento de exceções.
Instrumento atual: treze questões de múltipla escolha e sete questões abertas de
saída de código, cada uma valendo 5 pontos, total de 100 pontos,
com duração de referência de 90 minutos. Esta versão aguarda avaliação do professor.

## Edição em andamento

Os arquivos de trabalho são `base.md` e `unidade_02.typ`, mantidos sincronizados,
com respostas em `gabarito.md`. Por orientação do professor, PDF, previews e pacote
da primeira revisão ficam na versão anterior até fecharmos a prova. A paginação
será conferida na renderização final.

## Arquivos para leitura

- `unidade_02.typ`: fonte Typst atual, com prints e linhas de resposta nos sete itens abertos; quadro de letras apenas para múltipla escolha.
- `unidade_02.pdf`: prévia compilada de sete páginas, sem o gabarito.
- `gabarito.md`: respostas comentadas, em arquivo exclusivo do professor.
- `java/`: nove classes e interfaces do cenário em arquivos Java compiláveis.
- `blueprint.md`: recorte, matriz de evidências, pesos e decisões de elaboração.
- `base.md`: conteúdo semântico atual da prova, em revisão.
- `base-review.md`: revisão do próprio autor, com o percurso de resolução dos itens.
- `workflow.yaml`: direcionamento registrado e estado de elaboração; sem aprovação de base.
- `preview/`: preview HTML da base e imagens das páginas para inspeção.

## Compilar

Na pasta deste arquivo:

```bash
typst compile unidade_02.typ unidade_02.pdf
javac -d out java/*.java
```

O Typst utiliza a fonte Ubuntu Mono para os códigos. A composição segue
`avaliacoes/provas/unidade_01.typ`: A4, cabeçalho institucional, campos Nome/Nota,
quadro de respostas, questões em duas colunas e caixas de código numeradas. O cenário fica
ao final; a paginação será validada após fechar o conteúdo.
O import `codepoint` do modelo anterior não foi copiado, pois nenhum de seus
componentes é utilizado nesta composição.

As classes Java representam o cenário; não incluem janela, framework ou `main`.
Os trechos independentes das questões fornecem as chamadas a analisar.

## Verificação da versão anteriormente renderizada

- Compilação do cenário com OpenJDK 21 em contêiner local sem rede.
- Sessenta verificações de execução para cenários, estados, delegação,
  capacidades, alternativas da Q12 e defeitos apresentados nas Q18 e Q20.
- Compilação isolada das quatro chamadas da Q5: I e III aceitas; II e IV rejeitadas.
- Contraexemplo para Q19: uma primeira chamada com outra partida e uma segunda
  com a partida esperada passam nos dois asserts, confirmando o limite do teste.
- Compilação Typst 0.15.1, conferência das sete páginas e inspeção visual.
- Preview HTML atualizado e workflow validado pelas ferramentas do Docemas.

Código e questões permanecem sujeitos à revisão pedagógica do professor.
O site e o protótipo do jogo não foram modificados. Não houve commit ou publicação.

## Ajustes após a primeira leitura do professor

- Cenário transferido para o final da prova.
- Removidas explicações do comportamento já expresso no código; preservadas as premissas externas.
- Uma primeira revisão clarificou o parâmetro de atualizar; a revisão atual substitui essa operação por disparar(), conforme o registro abaixo.
- Fonte Typst, base Markdown, Java e previews sincronizados; gabarito preservado.

## Sincronização das questões de saída no Typst

- Q2, Q3, Q6, Q8, Q9, Q10 e Q17 atualizadas conforme a base, com prints explícitos e sem alternativas.
- Linhas de resposta sob cada trecho; quadro de letras restrito às treze questões de múltipla escolha.
- Q16 usa a atribuição da consulta, conforme a base. Instruções gerais ajustadas aos dois formatos.
- Sem compilação, geração de PDF ou atualização dos previews nesta etapa.

## Revisão da abstração de Nave

- Removida a mecânica de tempo e recarga. Nave.disparar() verifica o fim e encaminha a partida ao Disparo recebido no construtor.
- Q1, Q3, Q4, Q7, Q8 e Q18 ajustadas; Q3 imprime 4 e 2, e Q18 detecta acionamento indevido após o fim da partida.
- Cenário Java, base Markdown, fonte Typst e gabarito sincronizados. PDF e previews continuam na versão anterior.

## Verificação da abstração atual

- Nove fontes Java compiladas com o JDK local.
- Sete trechos de saída extraídos da base executados e comparados às linhas do gabarito.
- Cinco alternativas da Q18 executadas no original e na versão sem a guarda: somente D passa no original e falha na versão defeituosa.
- Conferidos o encaminhamento da mesma partida e a ausência de chamadas ao colaborador depois do fim, usando DisparoRegistro.
- Conferida a correspondência dos trechos Java das vinte questões entre Markdown e Typst, e dos nove tipos entre cenário e arquivos Java.
- PDF e previews preservados; sem renderização nesta revisão.
