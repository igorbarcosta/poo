package br.edu.ifpb.jogos.exemplos.mapa.modelo;

/** O tamanho do mundo é independente do tamanho da janela. */
public class Mundo {
    public static final int LARGURA = 2400;
    public static final int ALTURA = 1600;
    private final Jogador jogador = new Jogador();

    public void mover(int horizontal, int vertical, double segundos) {
        jogador.mover(horizontal, vertical, segundos);
    }

    public Jogador getJogador() { return jogador; }
}
