public class DisparoRegistro implements Disparo {
    private int chamadas = 0;
    private Partida ultimaPartida = null;

    @Override
    public void disparar(Partida partida) {
        chamadas++;
        ultimaPartida = partida;
    }

    public int getChamadas() {
        return chamadas;
    }

    public Partida getUltimaPartida() {
        return ultimaPartida;
    }
}
