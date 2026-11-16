public class Amuleto extends Equipamento {
    public Amuleto(int cargasIniciais) {
        super("Amuleto", cargasIniciais, 2);
    }

    @Override
    public int getVariacaoVida() {
        return 15;
    }
}
