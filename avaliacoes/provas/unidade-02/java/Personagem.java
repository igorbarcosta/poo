public class Personagem {
    private int vida;
    private Usavel equipado;

    public Personagem(int vidaInicial) {
        vida = vidaInicial;
        equipado = null;
    }

    public void receberDano(int quantidade) {
        if (quantidade > 0) {
            vida -= quantidade;
            if (vida < 0) {
                vida = 0;
            }
        }
    }

    public void recuperarVida(int quantidade) {
        if (quantidade > 0) {
            vida += quantidade;
            if (vida > 100) {
                vida = 100;
            }
        }
    }

    public int getVida() { return vida; }

    public void equipar(Usavel item) {
        equipado = item;
    }

    public Usavel getEquipado() {
        return equipado;
    }

    public boolean usarEquipadoEm(
            Personagem alvo) {
        if (equipado == null) {
            return false;
        }
        return equipado.usar(alvo);
    }
}
