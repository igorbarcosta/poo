# Exemplo — Chave e porta

Na raiz da pasta `meu-jogo`, selecione **Exemplo — Chave e porta** em
**Executar e Depurar** e pressione **F5**. Alternativa no PowerShell:

```powershell
.\gradlew.bat chave-porta
```

Linux/macOS: `./gradlew chave-porta`. Abra sempre a raiz completa, não apenas esta
subpasta. Setas/WASD movem, R reinicia, Esc fecha e F11 alterna tela cheia.

Uma chave laranja pode ser recolhida uma única vez. A porta vermelha bloqueia
uma passagem na parede; Enter perto dela tenta usar a chave e abrir.

## Observe

1. Tente alcançar a porta sem recolher a chave: a parede bloqueia e Enter não abre.
2. Volte e encoste no quadrado laranja. Ele desaparece e o painel informa a chave.
3. Perto da porta, pressione Enter. A chave é consumida e a passagem fica livre.
4. Atravesse; as partes cinza da parede continuam bloqueando fora da passagem.
5. Volte ao local da chave: ela não reaparece nem pode ser recolhida outra vez.
6. R restaura chave, porta e jogador.

## O comportamento está aqui

| Classe/método | Responsabilidade |
| --- | --- |
| `modelo/Chave.tentarColetar` | Contato e disponibilidade do recurso. |
| `modelo/Jogador.receberChave` e `usarChave` | Posse e consumo de uma chave. |
| `modelo/Porta.tentarAbrir` | Condição para abrir e estado da porta. |
| `Porta.limitarX` e `limitarY` | Bloqueio da parede e da passagem. |
| `modelo/Partida` | Movimento, tentativa de coleta e proximidade para abrir. |
| `JogoChavePorta` | Entrada e representação do estado. |

A coleta altera dois participantes: a chave fica indisponível e o jogador passa
a possuí-la. Abrir consome a chave apenas na primeira abertura aceita. O teste
de proximidade pertence à coordenação; a porta controla a condição de abertura.
O exemplo possui **uma chave**, sem um sistema completo de inventário.

## Para adaptar ao seu jogo

- O modelo completo usa `Partida`, `Jogador`, `Chave` e `Porta`. Todas são classes
  locais deste exemplo; nenhuma depende dos outros exemplos.
- Se quiser somente a colaboração chave/porta, adapte os métodos de posse e
  consumo ao inventário que você já tiver. Troque as coordenadas da chave e da
  interação junto com o desenho correspondente.
- Para preservar o bloqueio deste exemplo, encaminhe movimento por
  `Partida.mover`. Mover diretamente pelo jogador contornaria a parede.
- `Porta.limitarX` considera a travessia da parede, mesmo em deslocamento grande.
  Dentro da passagem aberta, `limitarY` impede entrar nas partes fixas da parede.
  É uma parede vertical específica, não um sistema geral de física ou mapas.

Uma experiência pequena é impedir a coleta apenas encostando as bordas.
A comparação já exige área de sobreposição positiva: confirme isso ao criar
seus dados de teste. `PartidaTest` verifica recusa sem chave, distância,
coleta única, consumo, bloqueio, passagem aberta e reinício do modelo.

## Ler, testar e reaproveitar

O fonte começa em `src/main/java/br/edu/ifpb/jogos/exemplos/chaveporta/`.
`IniciarChavePorta` apenas abre a janela. As regras estão em `modelo/` e os
testes em `src/test/java/`.

Para executar somente os testes deste exemplo, use
`.\gradlew.bat :exemplo-chave-porta:test` na raiz. No Linux/macOS:
`./gradlew :exemplo-chave-porta:test`.
Ao copiar classes para `src/main/java/meujogo/`, ajuste `package` e imports
para os nomes do seu projeto. Compare as dependências antes de copiar.
Não copie `build.gradle`, a engine ou as configurações do exemplo por cima
do seu projeto. Consulte o [catálogo](../EXEMPLOS.md) para o roteiro comum.
