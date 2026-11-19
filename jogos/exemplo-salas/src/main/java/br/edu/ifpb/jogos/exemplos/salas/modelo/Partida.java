package br.edu.ifpb.jogos.exemplos.salas.modelo;

/** Mantém duas salas, escolhe a atual e encaminha a interação. */
public class Partida {
    private final Jogador jogador = new Jogador();
    private final Sala primeira = new Sala(1);
    private final Sala segunda = new Sala(2);
    private Sala atual = primeira;

    public void mover(int horizontal, int vertical, double segundos) {
        jogador.mover(horizontal, vertical, segundos);
    }

    public void interagir() {
        if (jogador.sobrepoe(atual.getPortaX(), 300, 40, 100)) {
            atual = atual == primeira ? segunda : primeira;
            // A chegada fica afastada da porta: não dispara outra transição.
            jogador.posicionar(atual == segunda ? 140 : 770, 330);
        } else if (jogador.sobrepoe(450, 330, 40, 40)) {
            atual.alternarLuz();
        }
    }

    public Jogador getJogador() { return jogador; }
    public Sala getSalaAtual() { return atual; }
}
