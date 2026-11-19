package br.edu.ifpb.jogos.exemplos.patrulha.modelo;

/** Posição do jogador neste exemplo; não depende de entrada ou desenho. */
public class Jogador {
    public static final int TAMANHO = 40;
    private double x = 120;
    private double y = 330;

    public void mover(int horizontal, int vertical, double segundos) {
        posicionar(x + horizontal * 260 * segundos, y + vertical * 260 * segundos);
    }

    // A coordenação do exemplo encaminha as alterações de posição.
    void posicionar(double novoX, double novoY) {
        x = Math.max(0, Math.min(920, novoX));
        y = Math.max(110, Math.min(560, novoY));
    }

    public boolean sobrepoe(double outroX, double outroY, double largura, double altura) {
        return x < outroX + largura && x + TAMANHO > outroX
                && y < outroY + altura && y + TAMANHO > outroY;
    }

    public double getX() { return x; }
    public double getY() { return y; }
}
