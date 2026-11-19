package br.edu.ifpb.jogos.exemplos.patrulha.modelo;

public class Partida {
    private final Jogador jogador = new Jogador();
    private final Inimigo inimigo = new Inimigo(240, 720, 120);

    public void atualizar(double segundos, int horizontal, int vertical) {
        jogador.mover(horizontal, vertical, segundos);
        inimigo.atualizar(segundos);
    }

    public Jogador getJogador() { return jogador; }
    public Inimigo getInimigo() { return inimigo; }
    public boolean emContato() {
        return jogador.sobrepoe(inimigo.getX(), inimigo.getY(), 40, 40);
    }
}
