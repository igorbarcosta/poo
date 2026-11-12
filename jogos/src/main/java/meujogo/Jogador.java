package meujogo;

/** Estado e regra de movimento do exemplo inicial; não depende de janela ou teclado. */
public class Jogador {
    private double x = 460;
    private double y = 340;

    public double getX() { return x; }

    public double getY() { return y; }

    public int getTamanho() { return 40; }

    public void mover(int horizontal, int vertical, double segundos) {
        x += horizontal * 260 * segundos;
        y += vertical * 260 * segundos;
        x = Math.max(0, Math.min(960 - getTamanho(), x));
        y = Math.max(110, Math.min(600 - getTamanho(), y));
    }
}
