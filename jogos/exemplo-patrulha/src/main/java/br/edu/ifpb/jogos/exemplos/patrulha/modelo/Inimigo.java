package br.edu.ifpb.jogos.exemplos.patrulha.modelo;

/** Movimento autônomo entre dois limites, independente do teclado. */
public class Inimigo {
    private final double minimo;
    private final double maximo;
    private final double velocidade;
    private double x;
    private int direcao = 1;

    public Inimigo(double minimo, double maximo, double velocidade) {
        if (!Double.isFinite(minimo) || !Double.isFinite(maximo)
                || !Double.isFinite(velocidade) || maximo <= minimo || velocidade <= 0) {
            throw new IllegalArgumentException("Use limites finitos distintos e velocidade positiva.");
        }
        this.minimo = minimo;
        this.maximo = maximo;
        this.velocidade = velocidade;
        x = minimo;
    }

    public void atualizar(double segundos) {
        if (!Double.isFinite(segundos) || segundos < 0) {
            throw new IllegalArgumentException("O intervalo deve ser finito e não negativo.");
        }
        // A engine fornece passos de até 1/30 s. Ao alcançar uma borda,
        // invertemos a direção; o excesso de deslocamento não é descartado.
        x += direcao * velocidade * segundos;
        while (x < minimo || x > maximo) {
            if (x > maximo) {
                x = maximo - (x - maximo);
                direcao = -1;
            } else {
                x = minimo + (minimo - x);
                direcao = 1;
            }
        }
        if (x == maximo) { direcao = -1; }
        if (x == minimo) { direcao = 1; }
    }

    public double getX() { return x; }
    public double getY() { return 330; }
    public int getDirecao() { return direcao; }
    public double getMinimo() { return minimo; }
    public double getMaximo() { return maximo; }
}
