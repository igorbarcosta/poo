public class DisparoRepetido implements Disparo {
    private Disparo base;

    public DisparoRepetido(Disparo base) {
        this.base = base;
    }

    @Override
    public void disparar(Partida partida) {
        base.disparar(partida);
        base.disparar(partida);
    }
}
