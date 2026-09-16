# Desenho da Aula 10 — Completando as regras do pedido

## Ponto de partida

A aula parte da Versão 9 do Projeto 1. `Pedido` mantém uma lista privada de
`ItemPedido`, cria os itens a partir de um `Produto` e de uma quantidade,
calcula o total por delegação e registra se está fechado. Depois de `fechar()`,
não aceita novas inclusões. `ItemPedido` mantém o produto associado, sua
quantidade e o cálculo do subtotal; `Produto` mantém descrição e preço.

Os estudantes já trabalharam estado, encapsulamento, invariantes simples,
referências e identidade, construtores, colaboração, composição, coleções,
percurso com `for` aprimorado e análise localizada de impacto.

## Problema organizador e decisões da versão

O pedido já pode receber itens e ser fechado, mas ainda não permite corrigir
uma quantidade nem retirar uma linha. A frase “remover um item” é insuficiente:
é preciso decidir qual item, o que é removido e o que o fechamento impede.

A pergunta central é: **como completar as operações de um pedido sem quebrar
as responsabilidades que já construímos?**

Para manter o Projeto 1 pequeno e verificável, esta versão adota as seguintes
decisões explícitas:

- cada pedido mantém no máximo um `ItemPedido` para cada **mesma instância** de
  `Produto`; uma tentativa de adicionar novamente a mesma referência não cria
  outra linha;
- as operações recebem o `Produto` já existente para localizar a linha; a
  comparação é por identidade de referência (`==`), não por texto, preço ou
  uma nova regra de igualdade;
- `removerItem(produto)` remove a linha inteira daquele produto; se ela não
  existir, o pedido permanece como está;
- `alterarQuantidade(produto, novaQuantidade)` atualiza a quantidade positiva
  da linha encontrada; quantidade zero significa remover essa linha; quantidade
  negativa não altera o pedido;
- depois de fechado, o pedido não adiciona, remove nem altera quantidades;
  operações recusadas preservam o estado; e
- nesta versão, as operações permanecem `void`; observar total e cenários é
  suficiente para verificar a preservação do estado, sem introduzir contratos
  de retorno ou exceções.

Essas são escolhas deste domínio didático, não regras universais de pedidos.

## Aprendizagem esperada

Ao final, o estudante deve ser capaz de:

- reconhecer uma frase de requisito ainda ambígua e formular as decisões que
  faltam antes de programar;
- justificar `Pedido` como responsável por localizar itens da sua coleção e
  decidir se uma mudança estrutural é permitida;
- justificar `ItemPedido` como responsável por proteger sua quantidade válida
  e por calcular o subtotal;
- explicar por que o cliente solicita operações de domínio ao pedido em vez de
  receber a lista interna;
- usar a identidade já estudada para localizar uma linha por seu `Produto`;
- prever as consequências de remover, alterar para zero e fechar o pedido; e
- localizar o impacto da evolução, preservando `Produto` e o cálculo por
  delegação.

## Java necessário

Para localizar e remover uma linha com segurança durante o percurso, a aula
introduz somente o uso pragmático de `size()`, `get(indice)` e
`remove(indice)`. O índice permanece um detalhe interno da implementação de
`Pedido`, não uma forma de o cliente identificar uma linha do domínio.

## Trajetória narrativa e dimensionamento

O núcleo é planejado para aproximadamente 90 minutos, em três blocos. As
estimativas são de autoria, não cronograma do estudante.

### 10.1 — Remover ainda não é um requisito completo

Partir de um pedido aberto com teclado e mouse. A necessidade de desfazer uma
linha expõe perguntas sobre identificação, linhas repetidas, resultado de uma
remoção e pedido fechado. Comparar `pedido.getItens().remove(...)` com uma
solicitação de domínio ao pedido. Escolher uma linha por referência de
`Produto`, remoção inteira e estado inalterado quando não encontrada.

O estudante percebe que o índice da lista é detalhe de armazenamento, não a
identidade do item no domínio. Como `Pedido` criou e mantém seus itens, ele
percorre a lista com um índice interno para remover a posição encontrada;
`ItemPedido` oferece apenas a pergunta necessária para saber se representa
aquele mesmo produto.

### 10.2 — Alterar uma quantidade muda a linha, não o pedido inteiro

A necessidade seguinte é corrigir uma quantidade. Separar duas decisões:
`Pedido` localiza a linha e autoriza a mudança; `ItemPedido` recebe a nova
quantidade e preserva sua regra local. Quantidade zero é tratada antes como
remoção estrutural pelo pedido; quantidade positiva é delegada ao item;
quantidade negativa preserva o estado.

O percurso da lista reaparece como mecanismo de localização, sem transformar a
aula em catálogo de coleções. Uma atividade contrasta uma implementação em que
`Pedido` escreve a quantidade diretamente com a delegação a
`ItemPedido.alterarQuantidade(...)`.

### 10.3 — Fechar protege o conjunto inteiro de operações de edição

Confrontar remoção e alteração com a regra já existente de fechamento. A
decisão desta versão é coerente: se o pedido fechado já não pode ter sua
estrutura ampliada, também não pode perder linha nem alterar a quantidade que
compõe seu total. A guarda fica nas operações de `Pedido`; o item não precisa
conhecer o pedido.

Fechar com uma matriz de impacto: `Pedido` ganha operações e guarda a coleção;
`ItemPedido` ganha uma consulta de identidade e alteração validada de sua
quantidade; `Produto` não muda; `calcularTotal()` não muda. A ponte para a Aula
11 é um conjunto de comportamentos claros que poderá ser verificado com JUnit.

## Verificações formativas

Cada atividade terá dados suficientes e resposta expansível imediata. O núcleo
inclui: diagnóstico do getter que expõe a lista; decisão sobre a ambiguidade de
remover; previsão de uma sequência com remoção e alteração para zero;
distribuição de responsabilidades; diagnóstico de acesso indevido ao estado do
item; e previsão das mesmas operações antes e depois de `fechar()`.

## Relação com o laboratório e a próxima aula

O Laboratório 10 implementa a Versão 10 a partir da Versão 9: acrescenta as
operações de localização, remoção e alteração, preserva a coleção privada e
verifica cenários abertos e fechados. Cada incremento deve mudar o programa e
ter resultado observável.

A Aula 11 poderá transformar as regras claras desta versão em comportamentos a
verificar com JUnit, sem antecipar testes nesta aula.

## Limites do desenho

Não introduzir interfaces, polimorfismo, herança, classes abstratas, SOLID,
exceções como eixo, `equals`/`hashCode`, `Stream`, lambdas, Generics como tema,
persistência, DTOs, serviços, repositórios, camadas ou UML formal. Não criar
novos estados de pedido, reabertura, descontos, preço histórico, retorno de
status, tratamento de `null` ou políticas de catálogo além das escolhas locais
necessárias para esta versão.
