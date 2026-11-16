package br.edu.ifpb.jogos.megamania.modelo;

/** A capacidade de receber um impacto não exige pertencer à mesma hierarquia. */
public interface Alvo {
    boolean colideCom(Corpo corpo);

    void receberImpacto();

    boolean estaVivo();
}
