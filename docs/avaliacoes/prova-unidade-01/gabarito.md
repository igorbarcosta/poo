# Gabarito comentado — Prova da Unidade 01

[Consulte a prova aplicada (PDF)](prova-unidade-01.pdf).

## Respostas

| Questão | Resposta | Questão | Resposta |
| --- | --- | --- | --- |
| Q1 | C | Q11 | `2` |
| Q2 | B | Q12 | `2` |
| Q3 | C | Q13 | `1` |
| Q4 | B | Q14 | `1` |
| Q5 | C | Q15 | `1` |
| Q6 | `1` | Q16 | `2` |
| Q7 | `2` | Q17 | `1` |
| Q8 | `true` | Q18 | `1` |
| Q9 | `false` | Q19 | `1` |
| Q10 | `1` | Q20 | `2` |

## Q1 a Q5 — Responsabilidades e relações

- **Q1 — C.** `Eleicao` coordena cadastro, votação e apuração. `Eleitor` guarda o próprio estado de participação, e cada `Voto` guarda a referência ao candidato escolhido.
- **Q2 — B.** Retornar `votos` entrega a própria lista interna. O cliente poderia inserir ou remover elementos sem passar pelas operações e regras de `Eleicao`.
- **Q3 — C.** `setVotou(boolean)` permitiria marcar um eleitor como votante sem registrar um voto ou desfazer livremente esse estado. A operação `registrarVoto()` expressa a mudança permitida pelo modelo.
- **Q4 — B.** `Candidato` não precisa percorrer votos para cumprir suas responsabilidades. A eleição já mantém os votos e consulta cada `Voto` ao apurar ou verificar a retirada de um candidato.
- **Q5 — C.** Os objetos `Voto` são criados durante a votação e mantidos pela `Eleicao`. Um `Candidato` pode existir antes do cadastro e ser associado a uma eleição; estar em uma lista não torna essas duas relações equivalentes.

## Trecho I — Q6 a Q8

- **Q6 — `1`.** `referencia = new Candidato(...)` passa a apontar para Bia. A eleição ainda contém Ana; retirar Bia não encontra essa referência na lista.
- **Q7 — `2`.** `alias` aponta para a mesma Ana já cadastrada, então o novo cadastro é ignorado. `outraAna` tem número e nome iguais, mas é outro objeto; o cadastro usa `==` e a adiciona.
- **Q8 — `true`.** `apoio` e `titular` apontam para o mesmo `Eleitor`. O voto em `outraAna` é aceito e `registrarVoto()` altera esse objeto compartilhado.

## Trecho II — Q9 a Q11

- **Q9 — `false`.** `e1` e `e2` são eleitores distintos, apesar de terem a mesma identificação. O voto de `e1` não altera `e2`.
- **Q10 — `1`.** A primeira tentativa de `e3` falha porque Caio ainda não está cadastrado. Após o cadastro, a segunda tentativa registra um voto para ele.
- **Q11 — `2`.** `ana1` recebe o voto de `e1` e o voto do eleitor `E5`. Os dois votos em `ana2` não entram nessa contagem, mesmo que ela tenha os mesmos dados de `ana1`.

## Trecho III — Q12 a Q14

- **Q12 — `2`.** Os três candidatos são objetos distintos. Retirar `ana1` remove somente sua referência da lista original.
- **Q13 — `1`.** `outraEleicao` tem sua própria lista. Ela cadastra `ana1` e registra nela o voto de `outroEleitor`, embora `ana1` tenha sido retirado da primeira eleição.
- **Q14 — `1`.** O voto em `ana2` impede sua retirada. `bia` não recebeu votos e é removida; resta apenas `ana2`.

## Trecho IV — Q15 a Q17

- **Q15 — `1`.** Depois de votar na eleição da manhã, `compartilhado` já está marcado como votante. Sua tentativa na eleição da tarde falha; o voto de `livre` em Bia é registrado.
- **Q16 — `2`.** Bia pode ser retirada da eleição da manhã, onde não recebeu votos. Na eleição da tarde ela recebeu um voto, então permanece cadastrada junto com Ana.
- **Q17 — `1`.** `atual` primeiro aponta para `manha`, que é encerrada. Depois passa a apontar para uma nova eleição, `Noite`. Nela, Bia é cadastrada antes do encerramento; o cadastro posterior de Ana é recusado.

## Trecho V — Q18 a Q20

- **Q18 — `1`.** Os três votos de `principal` são, na ordem, para Ana, Bia e Ana. Ao receber `memoria = bia`, a variável passa a apontar para Bia; só um voto é para esse objeto.
- **Q19 — `1`.** A primeira tentativa de voto falha porque Ana havia sido retirada de `ordem`. Depois de cadastrá-la novamente, o voto é aceito e impede a retirada seguinte.
- **Q20 — `2`.** Antes de encerrar `finalEleicao`, Bia é retirada e Caio é cadastrado: restam Ana e Caio. Após o encerramento, retirada, cadastro e voto são recusados.

!!! warning "Erro comum"

    `==` compara a identidade das referências usadas neste código. Candidatos ou eleitores com dados iguais podem ser objetos diferentes; duas variáveis também podem apontar para o mesmo objeto. Além disso, cada `Eleicao` guarda suas próprias listas, enquanto um mesmo `Eleitor` compartilhado mantém seu estado ao ser passado a eleições diferentes.
