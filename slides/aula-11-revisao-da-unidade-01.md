---
marp: true
theme: poo
size: 16:9
paginate: true
lang: pt-BR
---

<!-- _class: section lead -->

# Aula 11 — Revisão da Unidade 01

<div class="statement">Um problema novo, as mesmas ideias</div>

<!--
Não anunciar uma lista de conteúdos. A aula inteira é uma investigação sobre um domínio desconhecido.
-->

---

<div class="chapter">Desafio</div>

## A pergunta da revisão

<div class="statement">Se eu entregar um sistema que você nunca viu, você consegue descobrir quem sabe o quê, quem faz o quê, quem conhece quem e o que muda depois de cada operação?</div>

---

<div class="chapter">Ato 1 — o problema</div>

## Missão de exploração

- robôs investigam uma região;
- cada robô usa um sensor;
- uma missão reúne participantes e registra observações;
- depois de encerrada, sua estrutura e seus registros são preservados.

Ainda não existem classes.

---

<!-- _class: activity -->

<div class="chapter">Ato 1 — o problema</div>

## Antes do código

1. Que coisas precisam manter estado próprio — e que substantivo não precisa virar classe?
2. Que responsabilidades já aparecem antes de escolher campos e métodos?

<!--
Coletar propostas. Exigir justificativa por estado, comportamento ou colaboração; não aceitar a regra automática “todo substantivo vira classe”.
-->

---

<div class="chapter">Ato 1 — o problema</div>

## Primeiras hipóteses

`Sensor`, `Robot`, `Leitura` e `Missao` podem ganhar papéis no modelo.

`Equipe` e `região` não precisam virar classes neste recorte.

<div class="key-point">Uma classe se justifica pelo papel de seus objetos, não apenas por um substantivo no enunciado.</div>

---

<!-- _class: code-focus -->

<div class="chapter">Primeiro objeto</div>

## Um sensor precisa nascer

```java
Sensor temperatura =
    new Sensor("Temperatura", "°C");
```

`new` cria uma identidade; os argumentos fornecem o estado inicial.

---

<!-- _class: activity code-focus -->

<div class="chapter">Primeiro objeto</div>

## E se a criação fosse vazia

```java
Sensor sensor = new Sensor();
sensor.tipo = "Temperatura";
sensor.unidade = "°C";
```

Em que momento o objeto faz sentido, e o que outro objeto observaria se recebesse `sensor` logo após o `new`?

---

<div class="chapter">Primeiro objeto</div>

## Existir não significa estar completo

Logo após `new Sensor()`:

```text
tipo = null
unidade = null
```

Os campos de referência possuem valor padrão `null`.

<div class="statement">O construtor faz a criação terminar com os dados necessários.</div>

---

<!-- _class: java-focus code-focus compact-code -->

<div class="chapter">Primeiro objeto</div>

## Argumento, parâmetro e campo

```java
public Sensor(String tipo, String unidade) {
    this.tipo = tipo;
    this.unidade = unidade;
}
```

```text
"Temperatura" → tipo → this.tipo
```

`this.tipo` é o campo do objeto atual; `tipo` é o parâmetro recebido.

---

<!-- _class: activity code-focus -->

<div class="chapter">Referências e identidade</div>

## Uma atribuição, nenhuma criação nova

```java
Sensor s1 = new Sensor("Temperatura", "°C");
Sensor s2 = s1;

// versão exploratória: campo ainda exposto
s2.unidade = "K";
```

1. Quantas variáveis e quantos objetos existem?
2. O que `s1` observa, o que foi copiado para `s2` e o que `s1 == s2` responderia?

---

<div class="chapter">Referências e identidade</div>

## Duas variáveis, um sensor

<div class="poo-diagram poo-diagram--shared">
  <div class="poo-var">s1</div><div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">Sensor#1</div><div class="poo-slots"><div class="poo-slot">tipo = "Temperatura"</div><div class="poo-slot">unidade = "K"</div></div></div>
  <div class="poo-var">s2</div><div class="poo-arrow"></div>
</div>

<div class="key-point">Duas variáveis. Uma identidade. <code>s1</code> observa <code>"K"</code>; <code>s1 == s2</code> produz <code>true</code>.</div>

---

<!-- _class: activity code-focus -->

<div class="chapter">Referências e identidade</div>

## Agora há dois `new`

```java
Sensor s1 = new Sensor("Temperatura", "°C");
Sensor s2 = new Sensor("Temperatura", "°C");
```

Compare o estado observado com a identidade dos dois sensores.

---

<div class="chapter">Referências e identidade</div>

## Mesmos valores, objetos distintos

<div class="poo-diagram">
  <div class="poo-var">s1</div><div class="poo-arrow"></div><div class="poo-object"><div class="poo-object__header">Sensor#1</div><div class="poo-slots"><div class="poo-slot">tipo = "Temperatura"</div><div class="poo-slot">unidade = "°C"</div></div></div>
  <div class="poo-var">s2</div><div class="poo-arrow"></div><div class="poo-object"><div class="poo-object__header">Sensor#2</div><div class="poo-slots"><div class="poo-slot">tipo = "Temperatura"</div><div class="poo-slot">unidade = "°C"</div></div></div>
</div>

<div class="key-point"><code>s1 == s2</code> produz <code>false</code>.</div>

---

<!-- _class: concept-key -->

<div class="chapter">Referências e identidade</div>

## Estado não é identidade

- variável mantém uma referência;
- `new` cria um objeto;
- atribuição entre variáveis copia a referência;
- `==` verifica se duas referências chegam ao mesmo objeto.

---

<!-- _class: code-focus -->

<div class="chapter">Surge Robot</div>

## O sensor participa de outro objeto

```java
Sensor temperatura =
    new Sensor("Temperatura", "°C");

Robot r1 =
    new Robot("R1", 80, temperatura);
```

---

<!-- _class: activity -->

<div class="chapter">Surge Robot</div>

## Acompanhe as referências

1. Quantos objetos foram criados, e o robô contém uma cópia do sensor?
2. Quem conhece quem — e qual direção inversa ainda não é necessária?

---

<div class="chapter">Surge Robot</div>

## Um objeto como argumento

<div class="poo-diagram poo-diagram--objects">
  <div class="poo-object"><div class="poo-object__header">Robot#1</div><div class="poo-slots"><div class="poo-slot">identificador = "R1"</div><div class="poo-slot">bateria = 80</div><div class="poo-slot poo-slot--ref">sensor</div></div></div>
  <div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">Sensor#1</div><div class="poo-slots"><div class="poo-slot">tipo = "Temperatura"</div><div class="poo-slot">unidade = "°C"</div></div></div>
</div>

O parâmetro recebeu uma referência. Nenhuma cópia foi criada.

---

<!-- _class: trap code-focus -->

<div class="chapter">Estado protegido</div>

## O Java aceita; o domínio recusa

```java
robot.bateria = -20;
```

Um `int` guarda `-20`. Uma bateria do domínio não deveria.

<div class="statement">Se qualquer código com uma referência puder escrever o campo, onde está protegida a regra?</div>

---

<!-- _class: activity code-focus -->

<div class="chapter">Estado protegido</div>

## Duas tentativas

```java
robot.deslocar(15);
robot.deslocar(100);
```

Com bateria inicial `80`, qual operação muda o estado — e por que um `setBateria(...)` irrestrito não resolveria o problema?

---

<div class="chapter">Estado protegido</div>

## Uma operação com intenção

```java
public void deslocar(int consumo) {
    if (consumo > 0 && consumo <= bateria) {
        bateria -= consumo;
    }
}
```

Estado final: `bateria = 65`.

<div class="key-point">Encapsular é controlar mudanças significativas — não gerar getters e setters automaticamente.</div>

---

<div class="chapter">Surge Leitura</div>

## Uma observação precisa permanecer

```java
Leitura leitura = r1.realizarLeitura(23.4);
```

Ainda não decidimos quem cria nem o que esse registro conhece.

---

<!-- _class: activity -->

<div class="chapter">Surge Leitura</div>

## Decida pelas responsabilidades

1. Quem conhece o sensor necessário para criar o registro?
2. O que a leitura precisa preservar, e quem deve manter o histórico?

---

<div class="chapter">Surge Leitura</div>

## Uma decisão simples

`Leitura` preserva:

- referência para o `Robot` que realizou a ação;
- tipo e unidade observados naquele momento;
- valor registrado.

`Robot` cria a leitura. `Missao` manterá o histórico.

---

<!-- _class: code-focus compact-code -->

<div class="chapter">Surge Leitura</div>

## O robô colabora com o sensor

```java
public Leitura realizarLeitura(double valor) {
    return new Leitura(
        this,
        sensor.getTipo(),
        sensor.getUnidade(),
        valor
    );
}
```

O objeto solicita ao colaborador apenas as informações necessárias.

---

<div class="chapter">Surge Leitura</div>

## Trabalho distribuído

```text
Robot
  ├── conhece o Sensor atual
  ├── solicita tipo e unidade
  └── cria Leitura

Leitura
  └── preserva origem + contexto + valor
```

Nenhum objeto precisa conhecer tudo.

---

<!-- _class: activity code-focus compact-code -->

<div class="chapter">Consequências das referências</div>

## O sensor do robô muda

```java
Sensor original = new Sensor("Temperatura", "°C");
Robot robot = new Robot("R1", 80, original);
Sensor apoio = original;

Sensor novoSensor = new Sensor("Umidade", "%");
robot.trocarSensor(novoSensor);
```

`original == apoio` e `robot.usaSensor(original)` produzem quais resultados?

---

<div class="chapter">Consequências das referências</div>

## Trocar um campo não transforma objetos

<div class="columns">
<div>
<div class="poo-diagram poo-diagram--shared">
  <div class="poo-var">original</div><div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">Sensor#1</div><div class="poo-slots"><div class="poo-slot">tipo = "Temperatura"</div></div></div>
  <div class="poo-var">apoio</div><div class="poo-arrow"></div>
</div>
</div>
<div>
<div class="poo-diagram">
  <div class="poo-var">robot.sensor</div><div class="poo-arrow"></div><div class="poo-object"><div class="poo-object__header">Sensor#2</div><div class="poo-slots"><div class="poo-slot">tipo = "Umidade"</div></div></div>
</div>
</div>
</div>

`true` e `false`.

Uma `Leitura` anterior preserva tipo e unidade; a troca afeta apenas as próximas observações.

<div class="key-point">Uma decisão sobre referências produz consequências observáveis ao longo do tempo.</div>

---

<!-- _class: section -->

<div class="chapter">A história cresce</div>

## Surge Missao

```java
Missao missao = new Missao("Vale Norte");

missao.adicionarRobot(r1);
missao.adicionarRobot(r2);
```

Agora existe um conjunto a coordenar.

---

<!-- _class: activity -->

<div class="chapter">Surge Missao</div>

## Quem mantém a equipe

Defina quem deve guardar os participantes e justifique por que cada robô não precisa manter uma lista de missões.

---

<!-- _class: java-focus compact-code -->

<div class="chapter">Coleções</div>

## Duas coleções, dois papéis

```java
private List<Robot> robots;
private List<Leitura> leituras;

public Missao(String nome) {
    this.nome = nome;
    robots = new ArrayList<>();
    leituras = new ArrayList<>();
    encerrada = false;
}
```

Participantes existem antes da missão; leituras surgem durante ela.

---

<!-- _class: code-focus -->

<div class="chapter">Coleções</div>

## Adicionar mantém uma referência

```java
public void adicionarRobot(Robot robot) {
    if (!encerrada && !participa(robot)) {
        robots.add(robot);
    }
}
```

`add` não executa `new Robot()`.

---

<div class="chapter">Coleções</div>

## Uma coleção não copia seus elementos

<div class="poo-diagram">
  <div class="poo-var">r1</div><div class="poo-arrow"></div>
  <div class="poo-object"><div class="poo-object__header">Robot#1</div><div class="poo-slots"><div class="poo-slot">identificador = "R1"</div></div></div>
  <div class="poo-var">robots[0]</div><div class="poo-arrow"></div>
</div>

<div class="key-point">A variável externa e a posição da lista chegam à mesma identidade.</div>

---

<div class="chapter">Registrar leituras</div>

## Uma nova operação integra o modelo

```java
missao.registrarLeitura(r1, 23.4);
```

A chamada envolve participação, criação, colaboração e armazenamento.

---

<!-- _class: activity -->

<div class="chapter">Registrar leituras</div>

## Antes da implementação

1. Como a missão sabe se o robô participa?
2. Quem cria a leitura — e em que ordem verificamos, criamos e guardamos?

---

<!-- _class: code-focus compact-code -->

<div class="chapter">Registrar leituras</div>

## Coordenação sem invadir o robô

```java
public void registrarLeitura(Robot robot, double valor) {
    if (!encerrada && participa(robot)) {
        Leitura leitura = robot.realizarLeitura(valor);
        leituras.add(leitura);
    }
}
```

`Missao` protege a regra; `Robot` produz o registro.

---

<!-- _class: activity -->

<div class="chapter">Registrar leituras</div>

## A ordem também conta objetos

Decida se uma missão encerrada deve criar uma `Leitura` antes de recusar o registro.

---

<div class="chapter">Registrar leituras</div>

## A verificação vem antes da criação

Uma tentativa recusada:

- não cria `Leitura`;
- não altera a lista;
- não pede trabalho ao robô.

<div class="statement">Preservar o estado pode preservar também a quantidade de objetos criados.</div>

---

<!-- _class: activity -->

<div class="chapter">Relações</div>

## Desenhe somente o que os objetos mantêm

1. Quais referências existem depois do primeiro registro?
2. Qual seta seria desnecessária para as responsabilidades atuais?

---

<div class="chapter">Relações</div>

## O grafo necessário

<div style="display: grid; gap: 18px;">
  <div style="align-items: center; display: grid; gap: 12px; grid-template-columns: 1fr 54px 1fr 54px 1fr;">
    <div class="poo-object" style="min-width: 0;"><div class="poo-object__header">Missao#1</div><div class="poo-slots"><div class="poo-slot poo-slot--ref">robots[0]</div></div></div>
    <div class="poo-arrow"></div>
    <div class="poo-object" style="min-width: 0;"><div class="poo-object__header">Robot#1</div><div class="poo-slots"><div class="poo-slot poo-slot--ref">sensor</div></div></div>
    <div class="poo-arrow"></div>
    <div class="poo-object" style="min-width: 0;"><div class="poo-object__header">Sensor#1</div><div class="poo-slots"><div class="poo-slot">tipo = "Temperatura"</div></div></div>
  </div>
  <div style="align-items: center; display: grid; gap: 12px; grid-template-columns: 1fr 54px 1fr 54px 1fr;">
    <div class="poo-object" style="min-width: 0;"><div class="poo-object__header">Missao#1</div><div class="poo-slots"><div class="poo-slot poo-slot--ref">leituras[0]</div></div></div>
    <div class="poo-arrow"></div>
    <div class="poo-object" style="min-width: 0;"><div class="poo-object__header">Leitura#1</div><div class="poo-slots"><div class="poo-slot poo-slot--ref">robot</div></div></div>
    <div class="poo-arrow"></div>
    <div class="poo-object" style="min-width: 0;"><div class="poo-object__header">Robot#1</div><div class="poo-slots"><div class="poo-slot">identificador = "R1"</div></div></div>
  </div>
</div>

As duas trilhas mostram o mesmo grafo; nenhuma seta reversa foi inventada.

---

<!-- _class: activity -->

<div class="chapter">Relações</div>

## Direção exige justificativa

`Robot` precisa conhecer `Missao`, e `Sensor` precisa guardar as leituras que ajudou a produzir?

---

<div class="chapter">Relações</div>

## Conhecimento mínimo

- `Robot → Sensor`: produzir observações e trocar o componente;
- `Leitura → Robot`: preservar a origem;
- `Missao → Robot`: coordenar participantes;
- `Missao → Leitura`: preservar registros.

<div class="key-point">A relação inversa só entra quando uma responsabilidade a exige.</div>

---

<!-- _class: activity -->

<div class="chapter">Composição</div>

## Nem toda relação tem o mesmo papel

Qual relação representa participantes independentes, e qual representa partes estruturais preservadas pelo todo?

---

<!-- _class: concept-key -->

<div class="chapter">Composição</div>

## Composição como responsabilidade estrutural

- `Missao → Robot`: associação com participantes independentes;
- `Robot → Sensor`: componente da configuração atual do robô;
- `Missao → Leitura`: registros que formam a estrutura histórica da missão.

<div class="statement">“Possuir uma referência” não basta para chamar toda relação de composição.</div>

---

<!-- _class: section -->

<div class="chapter">Nova regra</div>

## Missão aberta e encerrada

Depois de `missao.encerrar()`:

- não entram nem saem participantes;
- não há troca de sensor pela missão;
- não surgem novas leituras;
- os registros existentes permanecem.

---

<!-- _class: activity -->

<div class="chapter">Nova regra</div>

## Localize a proteção

Quem deve manter o estado encerrado e impedir as mudanças, sem fazer `Robot` conhecer `Missao`?

---

<!-- _class: code-focus -->

<div class="chapter">Nova regra</div>

## Cada missão controla sua transição

```java
private boolean encerrada;

public void encerrar() {
    encerrada = true;
}
```

As operações de edição consultam esse campo antes de mudar as coleções ou pedir trabalho a um robô.

---

<div class="chapter">Estado por instância</div>

## Duas missões, dois estados

```java
Missao norte = new Missao("Vale Norte");
Missao sul = new Missao("Vale Sul");

norte.encerrar();
sul.adicionarRobot(r1);
```

Fechar `norte` não altera `sul`.

---

<!-- _class: activity -->

<div class="chapter">Criação evitada</div>

## Depois de encerrar

```java
missao.registrarLeitura(r1, 25.0);
```

Quantas leituras são efetivamente criadas, e qual estado muda?

---

<div class="chapter">Criação evitada</div>

## Nenhuma mudança

```text
novas Leitura = 0
participantes = iguais
registros = iguais
```

A guarda executa antes de `robot.realizarLeitura(...)`.

---

<!-- _class: activity -->

<div class="chapter">Remover participantes</div>

## Não entregue a coleção

```java
missao.removerRobot(r1);
```

Por que `Missao` deve localizar e remover o participante, em vez de entregar sua coleção ao `Main`?

---

<!-- _class: code-focus compact-code -->

<div class="chapter">Remover participantes</div>

## O dono da coleção coordena

```java
public void removerRobot(Robot procurado) {
    if (!encerrada) {
        for (int i = 0; i < robots.size(); i++) {
            if (robots.get(i) == procurado) {
                robots.remove(i);
                return;
            }
        }
    }
}
```

Leituras antigas não são apagadas.

---

<!-- _class: activity -->

<div class="chapter">Alterar uma parte</div>

## A missão troca o sensor

```java
missao.trocarSensor(r1, novoSensor);
```

Quem localiza o robô, e quem realmente altera o campo `sensor`?

---

<!-- _class: code-focus compact-code -->

<div class="chapter">Alterar uma parte</div>

## Localizar e delegar

```java
public void trocarSensor(Robot procurado,
                         Sensor novoSensor) {
    if (!encerrada) {
        for (Robot robot : robots) {
            if (robot == procurado) {
                robot.trocarSensor(novoSensor);
                return;
            }
        }
    }
}
```

`Missao` localiza; `Robot` protege o próprio estado.

---

<!-- _class: activity code-focus -->

<div class="chapter">Identidade reaparece</div>

## Outro robô com o mesmo texto

```java
Robot r1 = new Robot("R1", 80, sensor);
missao.adicionarRobot(r1);

Robot outroR1 = new Robot("R1", 80, sensor);
missao.removerRobot(outroR1);
```

A busca por referência encontra o participante?

---

<div class="chapter">Identidade reaparece</div>

## Mesmo identificador não é a mesma identidade

```text
r1 == outroR1  →  false
```

A missão continua com `r1`.

Não precisamos introduzir `equals()` nem `hashCode()` para a regra desta versão.

---

<!-- _class: section -->

<div class="chapter">Mudança de dinâmica</div>

## Quatro `main` independentes

Agora cada bloco começa do zero.

Consultas como `quantidadeRobots()`, `quantidadeLeituras()` e `estaEncerrada()` devolvem valores — não as coleções internas.

Preveja a saída, desenhe o estado final e explique pelas responsabilidades — não apenas pela sintaxe.

---

<!-- _class: activity code-focus compact-code -->

<div class="chapter">Main 1 — criação e identidade</div>

## Main 1

```java
Sensor a = new Sensor("Temperatura", "°C");
Sensor b = a;
Sensor c = new Sensor("Temperatura", "°C");

System.out.println(a == b);
System.out.println(a == c);
System.out.println(b.getUnidade());
```

1. O que será impresso?
2. Quantos objetos existem?
3. Quais variáveis apontam para o mesmo objeto?
4. Desenhe o estado final.
5. Por que o resultado ocorre?

---

<div class="chapter">Main 1 — revelação</div>

## Duas criações, três variáveis

```text
true
false
°C
```

`a` e `b` chegam a `Sensor#1`; `c` chega a `Sensor#2`.

---

<!-- _class: activity code-focus compact-code -->

<div class="chapter">Main 2 — estado protegido</div>

## Main 2

```java
Sensor sensor = new Sensor("Temperatura", "°C");
Robot robot = new Robot("R1", 60, sensor);
Robot apoio = robot;
robot.deslocar(15);
apoio.deslocar(80);
apoio.deslocar(-5);
System.out.println(robot.getBateria());
System.out.println(robot == apoio);
```

<ol style="font-size: 0.76em; line-height: 1.2; margin-top: 0.35em;">
  <li>Qual é o estado inicial?</li>
  <li>Quais operações produzem mudança?</li>
  <li>Qual operação preserva o estado?</li>
  <li>Por quê?</li>
  <li>Qual regra está sendo protegida?</li>
</ol>

---

<div class="chapter">Main 2 — revelação</div>

## Apenas um deslocamento é aceito

```text
45
true
```

O consumo `80` não cabe na carga atual; `-5` não é positivo.

As duas variáveis chegam ao mesmo robô.

---

<!-- _class: activity code-focus compact-code -->

<div class="chapter">Main 3 — colaboração e coleções</div>

## Main 3

```java
Sensor t = new Sensor("Temperatura", "°C");
Sensor u = new Sensor("Umidade", "%");
Robot r1 = new Robot("R1", 80, t);
Robot r2 = new Robot("R2", 70, u);

Missao m = new Missao("Vale Norte");
m.adicionarRobot(r1);
m.adicionarRobot(r2);
m.registrarLeitura(r1, 23.4);
m.registrarLeitura(r2, 61.0);

System.out.println(m.quantidadeRobots());
System.out.println(m.quantidadeLeituras());
System.out.println(m.quantidadeLeiturasDe(r1));
```

---

<!-- _class: activity -->

<div class="chapter">Main 3 — colaboração e coleções</div>

## Explique a execução

1. Quais linhas serão impressas?
2. Quantos objetos existem?
3. Quem colaborou para produzir cada resultado?
4. Quem não precisou conhecer a missão?
5. Quais relações existem ao final?

---

<div class="chapter">Main 3 — revelação</div>

## Duas equipes na memória, um fluxo de colaboração

```text
2
2
1
```

Nove objetos relevantes: 7 do domínio + 2 listas internas. Objetos `String` não entram nesta contagem.

`Missao → Robot → Sensor` participa da criação; `Missao → Leitura → Robot` preserva o registro.

---

<!-- _class: code-focus compact-code -->

<div class="chapter">Main 4 — integração</div>

## Main 4 — preparação

```java
Sensor t = new Sensor("Temperatura", "°C");
Sensor u = new Sensor("Umidade", "%");
Robot r1 = new Robot("R1", 80, t);
Robot r2 = new Robot("R2", 70, t);

Missao m = new Missao("Vale Norte");
m.adicionarRobot(r1);
m.adicionarRobot(r2);
m.registrarLeitura(r1, 22.0);
m.trocarSensor(r2, u);
m.registrarLeitura(r2, 58.0);
m.removerRobot(r1);
m.encerrar();
```

---

<!-- _class: code-focus compact-code -->

<div class="chapter">Main 4 — integração</div>

## Main 4 — depois do encerramento

```java
m.registrarLeitura(r2, 60.0);
m.adicionarRobot(r1);
m.trocarSensor(r2, t);

System.out.println(m.quantidadeRobots());
System.out.println(m.quantidadeLeituras());
System.out.println(m.quantidadeLeiturasDe(r1));
System.out.println(r2.usaSensor(u));
System.out.println(m.estaEncerrada());
```

---

<!-- _class: activity -->

<div class="chapter">Main 4 — integração</div>

## Explique o sistema inteiro

1. Quais linhas serão impressas?
2. Qual é o estado final da missão?
3. Quais operações realmente produziram mudanças?
4. Quais foram recusadas?
5. Quantos objetos foram efetivamente criados?
6. Que objetos continuam compartilhados por referência?
7. Quem preservou cada regra?
8. Que colaboração produziu o resultado final?

---

<div class="chapter">Main 4 — revelação</div>

## Estado final preservado

```text
1
2
1
true
true
```

- participante: somente `r2`;
- registros: duas leituras, uma de cada robô;
- objetos: 2 sensores + 2 robôs + 1 missão + 2 listas + 2 leituras = **9**;
- as três operações posteriores ao encerramento não mudam nem criam objetos.

---

<!-- _class: activity -->

<div class="chapter">Transferência</div>

## Sem robôs agora

1. Um campeonato encerrado recebe novas partidas: quem protege a regra?
2. A verificação ocorre antes ou depois de criar o registro da partida?
3. Um livro precisa guardar todos os empréstimos apenas para fornecer seu título?

---

<!-- _class: synthesis -->

## A trajetória que reconstruímos

<div class="sequence">
  <div class="step">problema</div><div class="arrow">→</div>
  <div class="step">objetos</div><div class="arrow">→</div>
  <div class="step">responsabilidades</div><div class="arrow">→</div>
  <div class="step">estado + comportamento</div><div class="arrow">→</div>
  <div class="step">estado válido</div><div class="arrow">→</div>
  <div class="step">referências</div><div class="arrow">→</div>
  <div class="step">encapsulamento</div><div class="arrow">→</div>
  <div class="step">colaboração</div><div class="arrow">→</div>
  <div class="step">coleções</div><div class="arrow">→</div>
  <div class="step">relações</div><div class="arrow">→</div>
  <div class="step">composição</div><div class="arrow">→</div>
  <div class="step">regras + mudanças de estado</div>
</div>

<div class="statement">Objetos mantêm seu estado, colaboram por referências e protegem as regras das estruturas que controlam.</div>

---

<!-- _class: section lead -->

# Amanhã, outro sistema

<div class="statement">Você consegue descobrir quem sabe o quê, quem faz o quê, quem conhece quem e o que acontece depois de cada operação?</div>
