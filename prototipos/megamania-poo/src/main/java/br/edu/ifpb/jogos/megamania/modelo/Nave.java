package br.edu.ifpb.jogos.megamania.modelo;

public class Nave extends Corpo implements Alvo {
    private int vidas = 3;
    private double protecao = 0;
    private double esperaDisparo = 0;

    public Nave() {
        super(458, 126, 44, 30);
    }

    public void atualizar(double segundos, int direcao) {
        posicionar(Math.max(48, Math.min(868, getX() + direcao * 390 * segundos)), getY());
        protecao = Math.max(0, protecao - segundos);
        esperaDisparo = Math.max(0, esperaDisparo - segundos);
    }

    /** Uma tentativa em recarga é recusada sem produzir um novo projétil. */
    public Projetil tentarDisparar() {
        if (!estaVivo() || esperaDisparo > 0) {
            return null;
        }

        esperaDisparo = 0.22;
        return new Projetil(getCentroX() - 3, getY() + getAltura(), true);
    }

    @Override
    public void receberImpacto() {
        if (estaVivo() && !estaProtegida()) {
            vidas--;
            protecao = 1.5;
        }
    }

    @Override
    public boolean estaVivo() {
        return vidas > 0;
    }

    public boolean estaProtegida() {
        return protecao > 0;
    }

    public int getVidas() {
        return vidas;
    }
}
