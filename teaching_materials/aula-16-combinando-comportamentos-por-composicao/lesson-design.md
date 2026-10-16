# Desenho da Aula 16 — Combinando comportamentos por composição

Artifact identity: `lesson-design-poo-aula-16`.

## Contexto e intenção

Unidade 02, após a Aula 15 e o Laboratório 15. O professor aprovou aprofundar
composição e delegação pelo problema de oferecer seguro para entregas normais
e expressas. O avanço é um objeto cumprir um contrato e usar um colaborador
desse mesmo contrato para realizar parte do comportamento.

A fonte canônica do papel `lesson.md` neste consumidor é
`docs/aulas/aula-16-combinando-comportamentos-por-composicao.md`, identidade
`lesson-poo-aula-16`. Seguir o mapeamento das aulas anteriores, sem duplicar
o roteiro público em outro arquivo.

Pré-requisitos: referências e construtores; colaboração e relações das Aulas
06–08; contrato `Entrega`, polimorfismo e despacho das Aulas 14–15; JUnit da
Aula 13; percurso de listas. Público: estudantes da disciplina de POO em Java.

## Aprendizagem e trajetória

Pergunta: como acrescentar um comportamento a diferentes implementações sem
repetir suas regras nem modificar o cliente?

O estudante deve distribuir responsabilidades, explicar os dois papéis de
`EntregaComSeguro`, acompanhar referências e chamadas e verificar delegação.

1. Partir das entregas normal (`10.0`) e expressa (`25.0`). Seguro opcional
   acrescenta `5.0` por cálculo, independentemente da modalidade. São valores
   didáticos do recorte, sem regras de contratação ou indenização.
2. Comparar repetição de fórmulas e escolha de modalidade dentro de `Pedido`.
   Construir `EntregaComSeguro`, que recebe uma `Entrega`, delega o cálculo
   com o mesmo pedido e acrescenta o seguro ao resultado.
3. Prever normal segurada (`15.0`) e expressa segurada (`30.0`), reconstruir
   chamadas e representar os campos. Distinguir cumprir contrato de manter
   uma referência; preservar o primeiro fechamento válido.
4. Diagnosticar custo-base fixo e criação interna de uma modalidade; investigar
   o impacto de uma nova entrega de `15.0`, que segurada custa `20.0`.
5. Verificar cálculos, não acumulação e preservação do colaborador. Um
   colaborador de observação, fornecido em código, torna chamadas e argumento
   verificáveis com recursos Java e JUnit já conhecidos.
6. Transferir para o contrato `Efeito` da Aula 15: delegar um efeito e depois
   recuperar cinco pontos. Preparar a operação sem retorno e a concatenação
   de prefixo para o laboratório, sem entregar sua implementação.

## Escopo e condução

Incluídos: composição de comportamentos, delegação, dependência pelo contrato,
responsabilidades, identidade, impacto de mudança e testes. Relacionar o uso
atual de composição à colaboração anterior sem confundir essa técnica com
posse exclusiva ou ciclo de vida das partes da Aula 08.

Excluídos por decisão do professor: cast, inspeção de tipos e aprofundamento
do acesso a métodos específicos fora do contrato. Não introduzir herança,
classes abstratas, sobrecarga, exceções ou catálogo de padrões de projeto.

Referência de encontro: 90 minutos. A Aula 15 foi bem avaliada em ritmo e tempo;
preservar a alternância entre previsão, explicação, diagnóstico e transferência.
O tempo inclui formulação de respostas e discussão; não publicar cronograma
de minutos. O diagnóstico adicional pode aprofundar a análise conforme o ritmo.
Separar solicitações, explicitar estados e objetos e oferecer respostas
imediatas expansíveis. A página é autoguiada; a condução síncrona pode coletar
hipóteses individuais antes da explicação, sem exigir trabalho em pares.

## Relação com o Laboratório 16

O professor escolheu `NotificadorComPrefixo` no Projeto 2. A classe recebe
prefixo e destino pelo contrato, acrescenta o prefixo ao argumento de cada
chamada e delega um único envio. Preservar `Lembrete`, os canais existentes,
o canal inicial, a mensagem original e um aviso por envio.

A prática parte do Laboratório 15. Integra o novo objeto às operações existentes,
inclusive a lista, e acrescenta testes que observam mensagem e número de envios
com um notificador de registro fornecido. Mantém IA Nível 1 e entrega somente
dos arquivos Java, como os laboratórios anteriores.

Preparação: construtor/campo pelo contrato e operação sem retorno nesta aula;
concatenação de strings explicitada na ponte final; observação de delegação
nos testes desta aula; listas e contadores no par anterior. Não há decisão
pendente para a redação do par. O roteiro produzido ainda será submetido à
apreciação pedagógica do professor antes de qualquer derivação de slides.
