package br.edu.ifpb.jogos.exemplos.mapa.modelo;

/** Janela de observação do mundo. Não modifica as posições dos participantes. */
public class Camera {
    public static final int LARGURA_VISAO = 960;
    public static final int ALTURA_VISAO = 490;
    private double x;
    private double y;

    public void acompanhar(Jogador jogador) {
        x = limitar(jogador.getX() + Jogador.TAMANHO / 2.0 - LARGURA_VISAO / 2.0,
                Mundo.LARGURA - LARGURA_VISAO);
        y = limitar(jogador.getY() + Jogador.TAMANHO / 2.0 - ALTURA_VISAO / 2.0,
                Mundo.ALTURA - ALTURA_VISAO);
    }

    private double limitar(double valor, double maximo) {
        return Math.max(0, Math.min(maximo, valor));
    }

    public double paraTelaX(double mundoX) { return mundoX - x; }
    // 110 reserva a faixa inferior para os controles.
    public double paraTelaY(double mundoY) { return 110 + mundoY - y; }
    public double getX() { return x; }
    public double getY() { return y; }
}
