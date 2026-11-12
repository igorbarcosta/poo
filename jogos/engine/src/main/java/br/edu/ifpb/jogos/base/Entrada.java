package br.edu.ifpb.jogos.base;

/** Teclas mantidas e ações de um único quadro; implementadas pela infraestrutura. */
public interface Entrada {
    boolean esquerda();

    boolean direita();

    boolean cima();

    boolean baixo();

    boolean acao();

    boolean confirmou();

    boolean pausou();

    boolean reiniciou();
}
