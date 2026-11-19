package br.edu.ifpb.jogos.exemplos.chaveporta.modelo;

/** A passagem está entre duas partes fixas da parede vertical. */
public class Porta {
    public static final double X = 650;
    public static final double LARGURA = 30;
    public static final double BASE = 290;
    public static final double TOPO = 430;
    private boolean aberta;

    public boolean tentarAbrir(Jogador jogador) {
        if (aberta || !jogador.usarChave()) { return false; }
        aberta = true;
        return true;
    }

    public double limitarX(double anterior, double proposto, double y, double tamanho) {
        if (aberta && y >= BASE && y + tamanho <= TOPO) { return proposto; }
        // Verifica a travessia, inclusive se o deslocamento ultrapassar a parede.
        if (anterior + tamanho <= X && proposto + tamanho > X) { return X - tamanho; }
        if (anterior >= X + LARGURA && proposto < X + LARGURA) { return X + LARGURA; }
        return proposto;
    }

    public double limitarY(double x, double proposto, double tamanho) {
        if (x < X + LARGURA && x + tamanho > X) {
            return Math.max(BASE, Math.min(TOPO - tamanho, proposto));
        }
        return proposto;
    }

    public boolean isAberta() { return aberta; }
}
