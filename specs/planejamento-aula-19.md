# Planejamento da Aula 19 — Correção da Prova da Unidade 02

## Decisão do professor e estatuto

O professor definiu a Aula 19 como correção da Prova da Unidade 02, questão
por questão, avaliando didaticamente o resultado e explicitando a habilidade
medida e retomada. A variante A orienta a resolução; a B é apresentada
brevemente a partir da diferença. O encontro deve servir ao nivelamento do
curso até este ponto.

Este documento registra essa decisão e propõe sua condução. Não é ainda o
roteiro público nem um deck. Substitui o recorte da Aula 19 no
[planejamento anterior do fechamento](planejamento-fechamento-unidade-02.md),
que previa exceções e consolidação antes da prova. Não realoca exceções para
outro encontro nem acrescenta conteúdo técnico novo.

## Pergunta orientadora e aprendizagem esperada

**Como justificar o resultado de um programa e avaliar suas decisões de
projeto usando o repertório de POO construído até aqui?**

Ao final, o estudante deve conseguir:

- rastrear referências, objetos e alterações de estado sem confundir
  reatribuição, compartilhamento e cópia;
- separar o que o tipo declarado permite chamar da implementação escolhida
  pelo objeto concreto;
- explicar como contratos, delegação, composição e herança afetam uma solução;
- localizar a responsabilidade por uma regra e avaliar o alcance de um teste;
- reconhecer qual raciocínio precisa retomar, além de conferir o próprio
  resultado com o gabarito.

O nivelamento recupera fundamentos da Unidade 01 dentro dos problemas da
Unidade 02. Uma resposta correta isolada não comprova domínio da habilidade;
a justificativa precisa tornar o raciocínio observável.

## Fontes para preparar a correção

- [Prova A publicada](../docs/avaliacoes/prova-unidade-02/prova-unidade-02-variante-a.pdf)
  e [gabarito comentado A](../docs/avaliacoes/prova-unidade-02/gabarito-variante-a.md).
- [Prova B publicada](../docs/avaliacoes/prova-unidade-02/prova-unidade-02-variante-b.pdf)
  e [gabarito comentado B](../docs/avaliacoes/prova-unidade-02/gabarito-variante-b.md).
- [Registro de composição dos PDFs](../avaliacoes/provas/unidade-02/README.md)
  e [gabarito das duas variantes](../avaliacoes/provas/unidade-02/answer-key.md).
- [Projeto pedagógico](projeto-pedagogico.md),
  [padrão de aula](padrao-aula.md) e [estrutura do site](estrutura-site.md).

**Atenção à versão:** a página 2, com Q9–Q13, foi trocada entre os PDFs A e B
por solicitação do professor. Os gabaritos já refletem a troca; os Markdown
em `avaliacoes/provas/unidade-02/variants/` conservam a composição anterior.
Preparar recortes a partir dos PDFs e das fontes Typst correspondentes em
`rendered/`, conferindo-os com os gabaritos publicados. Não deduzir a letra
de Q13 nem os dados de Q9, Q10 e Q12 pelo nome do Markdown da variante.

## Dinâmica por questão

Manter Q1 → Q20 como sequência principal. Os agrupamentos abaixo ajudam a
regular o ritmo, sem substituir a correção de cada questão.

1. **Retomar o problema da A.** Localizar o trecho relevante e seu estado
   inicial. Cada questão reinicia seu cenário; alterações locais não passam
   para a próxima.
2. **Recuperar uma previsão ou justificativa.** Pedir uma resposta curta antes
   de revelar a solução. Para objetivas, recuperar a afirmação, não só a letra.
3. **Construir a resolução.** Acompanhar as chamadas e o estado ou comparar
   as alternativas com o requisito. Tornar explícito o passo que decide o
   resultado. Nas objetivas, explicar também por que as alternativas restantes
   não atendem ao enunciado, sem repetir uma exposição completa por alternativa.
4. **Interpretar o raciocínio.** Contrastar a solução com um erro plausível e
   explicar o modelo mental envolvido. Só chamar um erro de frequente se houver
   evidência nas respostas da turma.
5. **Nomear a habilidade.** Fechar com uma frase concreta: “Esta questão
   avaliou sua capacidade de…”, usando a ação correspondente na matriz abaixo.
6. **Conferir a B pela diferença.** Mostrar o dado ou a posição da alternativa
   que mudou e o resultado correspondente. Quando a saída coincide, explicar
   por que a mudança não alterou o resultado. Reabrir a resolução apenas se
   a comparação revelar uma dúvida conceitual.

O acerto e o erro são oportunidades de explicação. Evitar presumir que quem
acertou soube justificar ou que um erro numérico identifica sozinho uma
incompreensão de POO. A correção não redefine critérios de nota.

## Matriz de correção e habilidades

As respostas abaixo seguem os PDFs atuais. Nas objetivas, a letra serve só
para conferência; a habilidade e o argumento orientam a discussão.

| Questão | Habilidade medida e retomada | Passo decisivo e raciocínio a verificar | Resultado A → resultado B |
| --- | --- | --- | --- |
| Q1 | Rastrear estado respeitando guardas e limites a cada chamada. | Negativos são ignorados; aplicar cada limite no momento da operação. Chegar a zero não impede recuperação no código dado. | `100; 7` → `100; 9` |
| Q2 | Combinar recarga, saturação e consumo em um mesmo objeto. | A recarga para no máximo dois; o uso consome uma carga. Diferenciar saldo de capacidade. | `Amuleto: 1/2` → igual; cinco ou quatro unidades saturam no mesmo teto. |
| Q3 | Explicar que uma coleção guarda referências e consulta o estado atual. | A poção usada depois da inclusão é a mesma listada; preservar a ordem de inclusão. | `Cajado: 2/3; Poção vazia` → `Cajado: 1/3; Poção vazia` |
| Q4 | Reconhecer compartilhamento de identidade e estado entre posições. | Duas posições apontam para um cajado; o primeiro uso esgota a carga do segundo acesso. | `false; 28` → `false; 29` |
| Q5 | Distinguir reatribuição de variável local e referência guardada em campo. | Trocar `escolha` não troca o equipamento já guardado pelo personagem. | `38` → `48` |
| Q6 | Seguir a colaboração identificando qual objeto recebe cada efeito. | Separar usuário, item e alvo: o cajado afeta `b`; o amuleto afeta `a`. | `47; 56` → `49; 54` |
| Q7 | Explicar identidade de objeto através de casts. | O cast não cria objeto; `==` compara as referências à mesma instância. | `true` → igual. |
| Q8 | Distinguir aceitação da operação, efeito observado e consumo. | Vida no máximo não faz o uso retornar `false`; a carga é consumida mesmo sem aumento de vida. | `true; 0` → igual. |
| Q9 | Rastrear delegação, retorno booleano e fluxo condicional. | Sem equipado há recusa; depois, a segunda recusa da poção impede também o corpo do segundo `if`. | `false; 62` → `false; 63` |
| Q10 | Prever despacho dinâmico quando uma subclasse substitui o método completo. | `CajadoLivre.usar` executa sua própria sequência; o corpo herdado não roda automaticamente. | `48` → `38` |
| Q11 | Reconhecer capacidades por interface e rastrear efeitos via outra referência. | Só os equipamentos são recarregáveis; a recarga atinge o mesmo amuleto da variável original. | `2; 1` → igual. |
| Q12 | Acompanhar composição em camadas e propagação de sucesso ou recusa. | A base age primeiro; as curas vêm na volta. A recusa seguinte atravessa as duas camadas antes de qualquer cura. | `96; 96` → `95; 95` |
| Q13 | Separar verificação de chamadas em compilação e despacho em execução. | A atribuição é válida, mas `Usavel` não oferece `descrever`; não se chega ao despacho dessa chamada. | B → D |
| Q14 | Comparar herança e composição pelo significado da relação. | Herdar de inventário cria subtipagem; ter um inventário permite delegar sem copiar métodos. | E → C |
| Q15 | Analisar o impacto de restringir o contrato de um parâmetro. | `Equipamento` exclui poções e referências declaradas apenas como `Usavel`; o campo continua compatível. | D → E |
| Q16 | Escolher dados de teste que distinguem implementações. | Com uma carga e recarga de uma, soma resulta em duas e atribuição em uma; saldo zero e teto podem ocultar o defeito. | C → D |
| Q17 | Localizar uma guarda antes dos efeitos em um ponto comum aos caminhos exigidos. | Em `Equipamento.usar`, verificar vida zero antes de `aplicarEm` e do consumo cobre uso direto e delegado. A alteração vale só nesta questão. | B → A |
| Q18 | Avaliar o alcance e os limites de asserções independentes. | `true` sem dano passa em I e falha em II. Cada teste reinicia os objetos; nenhum observa o saldo de cargas. | A → E; o teste II espera vida `34` em A e `36` em B. |
| Q19 | Analisar implementação concreta herdada e preservação de sobrescritas. | `Orbe` aproveita a implementação padrão; `Cajado` e `Amuleto` mantêm as próprias. Não se duplicam campos privados. | B → D |
| Q20 | Diagnosticar exposição de estado mutável e quebra de encapsulamento. | Devolver a lista real permite `add` sem passar pela guarda de `adicionar`; `private` não impede esse acesso indireto. | C → A |

Em Q13–Q20, as alternativas foram reordenadas. Q18 também muda os dados
numéricos do teste, preservando a propriedade observada. Conferir o texto da
alternativa evita ensinar uma correspondência mecânica entre letras.

## Ritmo proposto para 90 minutos

| Etapa | Referência interna | Foco |
| --- | --- | --- |
| Abertura | 5 min | Explicar a dinâmica, localizar o código de consulta e lembrar a independência das questões. |
| Q1–Q8 | 25 min | Construir a base comum de estado, referências, identidade, alvo e retorno. |
| Q9–Q13 | 25 min | Integrar fluxo, despacho, capacidades e composição; separar compilação de execução. |
| Q14–Q20 | 30 min | Justificar projeto, impacto de mudança, proteção de regras e qualidade dos testes. |
| Fechamento | 5 min | Recuperar as distinções centrais e registrar necessidades de retomada. |

As vinte correções incluem a conferência da B. A média de poucos minutos por
questão exige recortes e rastreios preparados: não reconstruir o cenário
inteiro em cada resolução. Usar respostas curtas nas questões já compreendidas
e concentrar explicação onde houver divergência de raciocínio, sem omitir a
habilidade ou a conferência de nenhuma questão.

O núcleo é a resolução justificada de todas as questões e a comparação A/B.
Se houver folga, aprofundar uma divergência observada, por exemplo com um
diagrama de referências em Q4/Q5 ou a tabela de passagem e falha dos testes
em Q18. Esses apoios podem integrar a correção principal se necessários.
Não acrescentar novos mecanismos Java para preencher tempo.

## Fechamento e evidências de nivelamento

Retomar três distinções que atravessaram a prova:

- referência, objeto e estado: compartilhar não é copiar; reatribuir uma
  variável não altera outras referências;
- contrato e execução: o tipo declarado delimita operações; o objeto concreto
  determina a implementação de uma chamada válida;
- regra e verificação: a proteção precisa alcançar os caminhos exigidos e o
  teste precisa observar a propriedade que se quer garantir.

Pedir a cada estudante que registre uma questão cujo raciocínio consegue agora
explicar e uma habilidade que ainda precisa retomar, indicando o passo em que
surge a dificuldade. É uma proposta de verificação formativa, sem nova nota ou
entrega. A recuperação individual em sala é proposta sem IA (Nível 0).

Sem respostas da turma, este plano não afirma que houve nivelamento nem
identifica dificuldades coletivas. As justificativas e dúvidas observadas
devem orientar as próximas retomadas; não alteram automaticamente o currículo.

## Cuidados para a autoria posterior

- A página autoguiada deve conter os recortes necessários e respostas
  imediatamente expansíveis, sem depender da explicação oral. Referenciar
  o gabarito não substitui a construção didática da aula.
- O deck pode organizar previsão individual, discussão e revelação da
  resolução, mantendo a ordem Q1–Q20 e a comparação breve com B.
- Nomear habilidades com ações observáveis, evitando rótulos isolados como
  “polimorfismo” ou “herança”.
- Não presumir laboratório, novos exercícios avaliativos, datas ou mudanças
  de nota. Slides e publicação não estão incluídos neste registro.
