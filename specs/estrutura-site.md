# Estrutura do site

Este documento registra as decisões de estrutura já definidas para o site da disciplina.

- O site concentra o conteúdo didático permanente da disciplina.
- O Google Classroom é o LMS oficial para avisos, entregas, atividades, avaliações e notas.
- A navegação principal segue a ordem: **Início**, **Disciplina**, **Aulas**, **Laboratórios** e **Materiais**.
- **Início** orienta o estudante por meio de cards para os destinos principais, sem duplicar essa função em tabelas ou repetir o conteúdo das demais páginas.
- **Disciplina** reúne organização acadêmica e apoio: Plano de Ensino, Cronograma e Monitoria, nessa ordem.
- **Cronograma** registra a sequência temporal e as datas já confirmadas. É atualizado progressivamente: encontros futuros ainda não consolidados não devem ser inventados, e ajustes podem ocorrer conforme o andamento da turma, dos checkpoints e dos projetos.
- **Aulas** reúne a fundamentação conceitual.
- **Laboratórios** reúne a aplicação prática e a evolução incremental dos projetos.
- **Monitoria** concentra as informações de apoio ao estudante dentro do grupo Disciplina.
- **Materiais** reúne ambiente, referências e conteúdos de consulta.
- **Plano de Ensino** registra a estrutura e as regras formais da disciplina dentro do grupo Disciplina.
- Os grupos Disciplina, Aulas, Laboratórios e Materiais devem ser recolhíveis quando a navegação nativa permitir, para que o aluno expanda apenas o percurso que deseja consultar.
- Os rótulos internos devem evitar repetir o tipo já comunicado pelo grupo. Preferir `Aulas → 01 — Objetos e referências` a `Aulas → Aula 01 — Objetos e referências`; aplicar a mesma regra a Laboratórios e grupos semelhantes. Essa concisão pertence ao menu e não altera títulos, headings, nomes de arquivos ou URLs.
- Páginas de índice devem usar o próprio título da seção como link quando a navegação indexada puder fazê-lo sem duplicação. Quando a estrutura física não permitir essa solução, usar um rótulo discreto como **Visão geral**.
- Páginas curtas de orientação, como a home, podem omitir o índice lateral quando ele não acrescentar navegação real. Páginas longas continuam usando o índice normalmente.
- O menu deve priorizar escaneabilidade e usar os recursos nativos de navegação antes de qualquer customização em JavaScript ou CSS.
- Todos os ícones de navegação pertencem à família Lucide. Eles marcam apenas categorias de primeiro nível; itens internos permanecem textuais, sem repetir ícones quando o grupo já fornece contexto semântico. O ícone discreto do topo representa a identidade conceitual da disciplina sem funcionar como marca gráfica independente.
- Aulas e Laboratórios são trilhas distintas na navegação do estudante e possuem páginas de entrada próprias. Essa separação é pedagógica e não exige diretórios físicos distintos: os arquivos podem permanecer juntos em `docs/aulas/` quando isso preservar URLs e simplificar a manutenção.
- Aulas e laboratórios continuam organizados pedagogicamente por unidades e relacionados como fundamentação seguida de prática, embora apareçam em seções separadas no menu.
- As datas pertencem ao cronograma, não ao nome das páginas de aula.
- Os conteúdos devem ser reaproveitáveis entre semestres.
