package br.edu.ifpb.jogos.exemplos.salas.modelo;

/** A sala continua existindo mesmo quando não é a sala atual. */
public class Sala {
    private final int numero;
    private boolean luzLigada;

    public Sala(int numero) { this.numero = numero; }
    public void alternarLuz() { luzLigada = !luzLigada; }
    public int getNumero() { return numero; }
    public boolean isLuzLigada() { return luzLigada; }
    public double getPortaX() { return numero == 1 ? 860 : 60; }
}
