package br.edu.ifpb.jogos.exemplos.chaveporta.modelo;

/** Posição do jogador neste exemplo; não depende de entrada ou desenho. */
public class Jogador {
    public static final int TAMANHO = 40;
    private boolean temChave;
    private double x = 120;
    private double y = 330;

    // A coordenação do exemplo encaminha as alterações de posição.
    void posicionar(double novoX, double novoY) {
        x = Math.max(0, Math.min(920, novoX));
        y = Math.max(110, Math.min(560, novoY));
    }

    public boolean sobrepoe(double outroX, double outroY, double largura, double altura) {
        return x < outroX + largura && x + TAMANHO > outroX
                && y < outroY + altura && y + TAMANHO > outroY;
    }

    public void receberChave() { temChave = true; }
    public boolean usarChave() {
        if (!temChave) { return false; }
        temChave = false;
        return true;
    }
    public boolean possuiChave() { return temChave; }

    public double getX() { return x; }
    public double getY() { return y; }
}
