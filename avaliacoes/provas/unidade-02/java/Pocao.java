public class Pocao implements Item, Usavel {
    private boolean consumida = false;

    @Override
    public boolean usar(Personagem alvo) {
        if (consumida) {
            return false;
        }
        alvo.recuperarVida(20);
        consumida = true;
        return true;
    }

    @Override
    public String descrever() {
        if (consumida) {
            return "Poção vazia";
        }
        return "Poção cheia";
    }
}
