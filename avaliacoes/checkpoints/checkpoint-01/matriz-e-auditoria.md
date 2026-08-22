# Checkpoint 1 — matriz de evidências e auditoria

Documento interno. Escopo confirmado nas aulas, laboratórios e retrospectivas até a Aula 04: classe, objeto, campos, estado, comportamento, `void`, métodos, `new`, variáveis de tipo de classe, referências, identidade com `==`, estados independentes, acesso por `.`, `public`, `private`, acesso de pacote, getters, `if`, valores padrão de campos e inicialização de variáveis locais. Ficam fora: `!`, `++`, `--`, `+=`, construtores explícitos, `this`, `null`, APIs e conceitos posteriores.

## Estrutura específica deste instrumento

- Q1: 6 itens de 0,5 — 3,0 pontos;
- Q2: 6 itens de 0,5 — 3,0 pontos;
- Q3–Q10: 8 questões de 0,5 — 4,0 pontos.

Total: 10,0 pontos. Esta distribuição pertence somente ao Checkpoint 1 e não define fórmula para instrumentos futuros.

## Matriz item → evidência

| Item | Informação nova sobre a aprendizagem | A | B |
| --- | --- | --- | --- |
| Q1a | Reconhece identidade após cópia de referência com `==`. | `true` | `true` |
| Q1b | Distingue a identidade do objeto criado por outro `new`. | `false` | `false` |
| Q1c | Acompanha estado inteiro alterado por referência compartilhada. | `2` | `1` |
| Q1d | Consulta por uma referência o estado booleano alterado pela outra. | `true` | `true` |
| Q1e | Preserva o estado inteiro independente do segundo objeto. | `1` | `2` |
| Q1f | Preserva o estado booleano independente do segundo objeto. | `false` | `false` |
| Q2a | Determina o efeito de `private` sobre acesso externo direto. | F | F |
| Q2b | Reconhece consulta pública a campo privado por getter. | V | V |
| Q2c | Aplica a regra que bloqueia subida com porta aberta. | V | V |
| Q2d | Aplica corretamente o limite máximo de andar. | F | V |
| Q2e | Distingue acesso externo do acesso por método da própria classe. | V | F |
| Q2f | Reconhece que `private` não altera cópia de referência nem cria objeto. | F | V |
| Q3 | Distingue campo como estado e método como comportamento. | C | D |
| Q4 | Interpreta `void` como ausência de valor devolvido. | E | A |
| Q5 | Reconhece acesso de pacote na ausência de modificador. | B | E |
| Q6 | Distingue inicialização de campo `int` e variável local. | D | C |
| Q7 | Seleciona operação que mantém no objeto a responsabilidade do domínio. | A | B |
| Q8 | Distingue classe como definição e objetos com estados próprios. | C | D |
| Q9 | Reconhece `new` como criação de um novo objeto. | E | A |
| Q10 | Reconhece que o método acessa o estado do próprio objeto. | B | C |

## Resolução integral

### Variante A

- Q1: `true`, `false`, `2`, `true`, `1`, `false`.
- Q2: F, V, V, F, V, F.
- Q3–Q10: C, E, B, D, A, C, E, B.

`principal` e `painel` referenciam o mesmo objeto, que termina no andar 2 com porta aberta. `servico` é distinto e termina no andar 1 com porta fechada.

### Variante B

- Q1: `true`, `false`, `1`, `true`, `2`, `false`.
- Q2: F, V, V, V, F, V.
- Q3–Q10: D, A, E, C, B, D, A, C.

`cabine` e `painel` referenciam o mesmo objeto, que termina no andar 1 com porta aberta. `carga` é distinto e termina no andar 2 com porta fechada.

## Auditorias

### Redundância e cobertura

Q1 produz seis observações complementares dentro de um único teste: duas identidades, dois estados compartilhados e dois estados independentes. Não há pergunta separada sobre quantidade de objetos ou sobre quais variáveis compartilham referência. Q2 mede seis consequências diferentes da evolução, sem repetir getter, `private` ou compilação como único foco. Q3–Q10 excluem esses focos e cobrem oito conhecimentos ainda não suficientemente observados: estado/comportamento, `void`, acesso de pacote, inicialização, responsabilidade, classe/objeto, `new` e acesso ao estado próprio.

### Entrega de respostas e dependência

Nenhuma saída de Q1 aparece em Q2–Q10. Nenhuma alternativa fornece resposta de outra questão. Cada impressão pode ser calculada diretamente do cenário; cada afirmação de Q2 declara a situação necessária; Q3–Q10 são independentes. Um erro não cria cascata obrigatória.

### Determinação, sintaxe e conteúdo ensinado

Todas as regras de domínio e modificações aparecem no cenário ou no próprio enunciado. Há exatamente uma resposta correta em cada múltipla escolha. Não são usados `!portaAberta`, operadores abreviados, APIs ou mecanismos posteriores; permanecem `portaAberta == false` e `andarAtual = andarAtual + 1;`.

### Alternativas e distribuição

Cada Q3–Q10 possui exatamente A–E, com quatro distratores baseados em confusões observáveis no escopo. Distribuição: A = C,E,B,D,A,C,E,B (A:1, B:2, C:2, D:1, E:2); B = D,A,E,C,B,D,A,C (A:2, B:1, C:2, D:2, E:1). Não há padrão previsível.

### Equivalência das variantes

As variantes preservam estrutura, pesos, conceitos, quantidade de chamadas e comparações, volume de leitura e esforço. Em Q1, troca-se qual objeto recebe uma ou duas subidas; em Q2, alternam-se situações verdadeiras e falsas equivalentes; em Q3–Q10, mudam a ordem dos distratores e a posição correta sem alterar o conceito.

## Duração estimada

Leitura do cenário: 8 min; Q1: 9 min; Q2: 10 min; Q3–Q10: 18 min; quadro e revisão: 5 min. Total: 50 minutos.
