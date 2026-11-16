public class Partida {
    private int vidas;
    private int tiros;
    private boolean fim;

    public Partida() {
        vidas = 3;
        tiros = 0;
        fim = false;
    }

    public void registrarTiros(int quantidade) {
        if (!fim && quantidade > 0) {
            tiros += quantidade;
        }
    }

    public void perderVida() {
        if (fim) {
            return;
        }
        vidas--;
        if (vidas == 0) {
            fim = true;
        }
    }

    public int getVidas() { return vidas; }
    public int getTiros() { return tiros; }
    public boolean terminou() { return fim; }
}
