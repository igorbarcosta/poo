package br.edu.ifpb.jogos.megamania.modelo;

public class Projetil extends Corpo {
    private final boolean doJogador;
    private boolean ativo = true;

    public Projetil(double x, double y, boolean doJogador) {
        super(x, y, 6, 16);
        this.doJogador = doJogador;
    }

    public void atualizar(double segundos) {
        double velocidade = doJogador ? 650 : -245;
        posicionar(getX(), getY() + velocidade * segundos);

        if (getY() > 602 || getY() + getAltura() < 112) {
            ativo = false;
        }
    }

    public boolean tentarAtingir(Alvo alvo) {
        if (!ativo || !alvo.estaVivo() || !alvo.colideCom(this)) {
            return false;
        }

        alvo.receberImpacto();
        ativo = false;
        return true;
    }

    public boolean isDoJogador() {
        return doJogador;
    }

    public boolean estaAtivo() {
        return ativo;
    }
}
