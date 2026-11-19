# Planejamento do Laboratório 21 — Objetos que interagem no seu jogo

## Decisões do professor

O laboratório evolui o jogo individual do Projeto 3 com mais um participante
visível e uma interação entre ele e o jogador. Inimigo, obstáculo, coletável,
porta ou parte interativa do cenário são possibilidades; decoração isolada
não atende à intenção. O professor aprovou esse recorte e as observações de
escopo, verificação e reinício.

O professor explicitou que não há associação obrigatória entre Aula 21 e
Laboratório 21. Na Unidade 03, o projeto segue um percurso mais independente
das aulas de mesmo número. Não exigir exceções, hierarquia, interface ou nova
classe coordenadora para vincular artificialmente os materiais.

## Intenção e ponto de partida

Passar de uma regra própria com resultado representado na tela para uma
colaboração entre participantes do jogo. Continuar o projeto iniciado no
Laboratório 19, preservando sua regra e suas verificações. Não há roteiro de
Laboratório 20 a presumir como requisito.

Quem já possui participantes e interações deve evoluir um comportamento
concreto desse conjunto, em vez de acrescentar duplicação para cumprir uma
contagem. O resultado precisa ter uma diferença de código e comportamento
em relação ao início da prática.

## Núcleo de referência — 90 minutos

| Etapa | Tempo | Mudança concreta |
| --- | --- | --- |
| Executar e delimitar | 10 min | Preparação: escolher uma interação pequena e resultados observáveis. |
| Incremento A | 25 min | Acrescentar ou evoluir o participante no modelo e desenhar seu estado. |
| Incremento B | 35 min | Implementar a interação no modelo e verificar aceitação e condição ausente com JUnit. |
| Incremento C | 20 min | Conectar a interação ao ciclo e à apresentação, completar reinício e conferir a execução. |

O apoio à geometria é condicional. Um coletável de uso único fornece uma
alternativa viável sem física, temporizador ou trajetória de projétil.
Disparo com projétil é uma opção de maior escopo, não requisito comum.
O efeito de contatos persistentes deve ser deliberado, sem impor uma regra
temporal nova. Não exigir relatório, nova entrega formal ou justificativa oral.

## Repertório e apoios

- Objetos, estado e encapsulamento: Aulas 03–05.
- Colaboração: Aula 06; leitura de participantes e consequências na Aula 20.
- Testes do modelo: Aula 13 e prática do Laboratório 19.
- Entrada, atualização, desenho e reinício: base e Laboratório 19.
- Detecção retangular: apoio opcional no roteiro e `Corpo.colideCom` no exemplo;
  não pressupor que o aluno já domina física ou que herda essa classe.
- IA Nível 3 — Colaborador, conforme o Projeto 3.

Usar o padrão de laboratório com a exceção de articulação teórica definida
pelo professor para a Unidade 03. A regra de autoria prática permanece:
cada incremento modifica o código, investigação tem critérios de conferência
e os requisitos devem servir a jogos diferentes.

## Artefatos e limites

Roteiro público: `docs/aulas/laboratorio-21-objetos-que-interagem-no-seu-jogo.md`.
Não alterar o Megamania, a engine, o ZIP, a Aula 21 ou seus slides. Não definir
datas, pesos, prazos ou mecanismos novos de avaliação. Orientações operacionais
continuam no Classroom. O material é preparado para revisão do professor;
a concordância com o desenho não é aprovação antecipada da redação.
