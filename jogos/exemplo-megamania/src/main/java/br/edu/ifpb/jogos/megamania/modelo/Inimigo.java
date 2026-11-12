package br.edu.ifpb.jogos.megamania.modelo;

public class Inimigo extends Corpo implements Alvo {
    private boolean vivo = true;

    public Inimigo(double x, double y) {
        super(x, y, 38, 28);
    }

    public void deslocar(double dx, double dy) {
        posicionar(getX() + dx, getY() + dy);
    }

    public Projetil disparar() {
        return new Projetil(getCentroX() - 3, getY() - 16, false);
    }

    @Override
    public void receberImpacto() {
        vivo = false;
    }

    @Override
    public boolean estaVivo() {
        return vivo;
    }

    public int getPontos() {
        return 100;
    }
}
