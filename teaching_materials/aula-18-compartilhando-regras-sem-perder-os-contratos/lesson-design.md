# Desenho da Aula 18 — Compartilhando regras sem perder os contratos

Artifact identity: `lesson-design-poo-aula-18`.

## Contexto e intenção

Unidade 02, depois do inventário da Aula 17. Público: estudantes com repertório
de objetos, estado privado, construtores, interfaces, polimorfismo, composição,
listas, cast, `instanceof` e JUnit básico.

A referência docente é `specs/planejamento-fechamento-unidade-02.md`. O professor
aprovou o recorte de herança e classe abstrata com continuidade do inventário,
reservando exceções básicas e consolidação para a Aula 19. Posteriormente,
solicitou a correção decorrente da revisão e o laboratório correspondente,
escolhendo continuar o Projeto 2 com contagem por notificador.

A fonte canônica do papel `lesson.md` é
`docs/aulas/aula-18-compartilhando-regras-sem-perder-os-contratos.md`, identidade
`lesson-poo-aula-18`. Não duplicar o roteiro público neste diretório.

## Aprendizagem e trajetória

Pergunta: quando classes diferentes podem compartilhar implementação sem
perder suas responsabilidades?

O estudante deve reconhecer regras comuns, acompanhar a construção de um
único objeto de subclasse, distinguir estado privado e métodos herdados,
prever chamadas herdadas e sobrescritas e comparar herança, interfaces e
composição pelos requisitos.

1. Recuperar o reparo por capacidade e localizar a repetição entre equipamentos.
2. Extrair estado e algoritmo para `Equipamento`; passar os parâmetros por
   `super(...)` e conservar descrições específicas nas subclasses.
3. Explicar a classe abstrata, o único objeto e a proteção do estado;
   diagnosticar compilação e prever chamadas por referências diferentes.
4. Preservar `Reparavel` como dependência da bigorna e comparar com a
   composição das entregas, sem forçar a maçã à hierarquia.
5. Verificar a preservação dos reparos e fechar com previsão, diagnóstico e
   transferência para picareta. A proposta que apaga o reparo da base deve
   ser reconhecida também como incompleta para cumprir `Reparavel`.
6. Preparar a prática dos notificadores: um método herdado pode chamar uma
   operação sobrescrita no próprio objeto, depois da construção.

## Escopo, prática e limites

Incluídos: `extends`, `super(...)`, construtor protegido, campos privados,
classe e método abstratos, `@Override`, herança de implementação, identidade,
contratos e comparação com composição. Usar entradas válidas; o tratamento
de argumentos inválidos permanece na Aula 19. Não explorar hierarquias
profundas, padrões de projeto ou uma matriz completa de visibilidade.

Referência de 90 minutos: recuperação e repetição, 10; extração e construção,
25; abstração e chamadas, 20; comparação e ponte prática, 20; verificação e
fechamento, 15. O colaborador de durabilidade é aprofundamento elástico.
As perguntas têm respostas imediatas expansíveis e a ajuda de IA vem depois
da formulação própria, em Nível 1 — Tutor.

O Laboratório 18 continua a solução do Laboratório 16 do Projeto 2. A base
`NotificadorConsole` concentra impressão e contagem por objeto; os canais
sobrescrevem a identificação. `Lembrete`, o prefixo e o registro de testes
preservam suas implementações e dependem de `Notificador`. Os novos testes
distinguem contadores de canais e de lembretes, incluindo um canal compartilhado.
O laboratório permanece um artefato local separado, fora do par canônico Docemas.

Não estabelecer datas, novas avaliações ou decisões do Projeto 3. A aprovação
do desenho não aprova automaticamente os roteiros finais. Slides continuam
dependendo de aprovação semântica explícita e solicitação posterior.
