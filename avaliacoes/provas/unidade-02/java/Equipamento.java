public abstract class Equipamento
        implements Item, Usavel, Recarregavel {
    private String nome;
    private int cargas;
    private int maximo;

    protected Equipamento(String nome,
                          int cargasIniciais,
                          int maximo) {
        this.nome = nome;
        cargas = cargasIniciais;
        this.maximo = maximo;
    }

    @Override
    public boolean usar(Personagem alvo) {
        if (cargas == 0) {
            return false;
        }
        aplicarEm(alvo);
        cargas--;
        return true;
    }

    @Override
    public void recarregar(int quantidade) {
        if (quantidade <= 0) {
            return;
        }
        cargas += quantidade;
        if (cargas > maximo) {
            cargas = maximo;
        }
    }

    @Override
    public int getCargas() { return cargas; }

    @Override
    public String descrever() {
        return nome + ": " + cargas
            + "/" + maximo;
    }

    private void aplicarEm(Personagem alvo) {
        int variacao = getVariacaoVida();
        if (variacao < 0) {
            alvo.receberDano(-variacao);
        } else {
            alvo.recuperarVida(variacao);
        }
    }

    // Variação de vida aplicada por usar:
    // negativa: dano; positiva: recuperação.
    public abstract int getVariacaoVida();
}
