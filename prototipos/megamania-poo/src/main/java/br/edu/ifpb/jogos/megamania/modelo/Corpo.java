package br.edu.ifpb.jogos.megamania.modelo;

/** Geometria e identidade de um objeto no jogo, sem dependência gráfica. */
public abstract class Corpo {
    private double x;
    private double y;
    private final double largura;
    private final double altura;

    protected Corpo(double x, double y, double largura, double altura) {
        if (!Double.isFinite(x)
                || !Double.isFinite(y)
                || !Double.isFinite(largura)
                || !Double.isFinite(altura)
                || largura <= 0
                || altura <= 0) {
            throw new IllegalArgumentException("Posição finita e dimensões positivas são necessárias.");
        }

        this.x = x;
        this.y = y;
        this.largura = largura;
        this.altura = altura;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getLargura() {
        return largura;
    }

    public double getAltura() {
        return altura;
    }

    public double getCentroX() {
        return x + largura / 2;
    }

    protected void posicionar(double x, double y) {
        if (!Double.isFinite(x) || !Double.isFinite(y)) {
            throw new IllegalArgumentException("A posição precisa ser finita.");
        }

        this.x = x;
        this.y = y;
    }

    public boolean colideCom(Corpo outro) {
        return x < outro.x + outro.largura
                && x + largura > outro.x
                && y < outro.y + outro.altura
                && y + altura > outro.y;
    }
}
