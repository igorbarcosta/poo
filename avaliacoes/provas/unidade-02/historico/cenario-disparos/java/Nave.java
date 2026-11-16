public class Nave {
    private Partida partida;
    private Disparo disparo;

    public Nave(Partida partida,
                Disparo disparo) {
        this.partida = partida;
        this.disparo = disparo;
    }

    public void disparar() {
        if (partida.terminou()) {
            return;
        }
        disparo.disparar(partida);
    }
}
