package br.edu.ifpb.jogos.exemplos.chaveporta.modelo;

/** Decide quando coletar e quando solicitar a abertura, sem conhecer teclado. */
public class Partida {
    private final Jogador jogador = new Jogador();
    private final Chave chave = new Chave();
    private final Porta porta = new Porta();

    public void mover(int horizontal, int vertical, double segundos) {
        double novoX = jogador.getX() + horizontal * 260 * segundos;
        novoX = porta.limitarX(jogador.getX(), novoX, jogador.getY(), Jogador.TAMANHO);
        double novoY = porta.limitarY(novoX,
                jogador.getY() + vertical * 260 * segundos, Jogador.TAMANHO);
        jogador.posicionar(novoX, novoY);
        chave.tentarColetar(jogador);
    }

    public boolean interagir() {
        if (!jogador.sobrepoe(590, 270, 120, 180)) { return false; }
        return porta.tentarAbrir(jogador);
    }

    public Jogador getJogador() { return jogador; }
    public Chave getChave() { return chave; }
    public Porta getPorta() { return porta; }
}
