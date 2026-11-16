public class Cajado extends Equipamento {
    public Cajado(int cargasIniciais) {
        super("Cajado", cargasIniciais, 3);
    }

    @Override
    public int getVariacaoVida() {
        return -12;
    }
}
