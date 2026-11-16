public abstract class Arma
        implements Disparo, Contabilizavel {
    private int acionamentos;

    protected Arma() {
        acionamentos = 0;
    }

    @Override
    public void disparar(Partida partida) {
        partida.registrarTiros(
            quantidadeTiros());
        acionamentos++;
    }

    @Override
    public int getAcionamentos() {
        return acionamentos;
    }

    protected abstract int quantidadeTiros();
}
