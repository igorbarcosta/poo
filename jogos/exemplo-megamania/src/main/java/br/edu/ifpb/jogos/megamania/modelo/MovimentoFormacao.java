package br.edu.ifpb.jogos.megamania.modelo;

import java.util.List;

/** Contrato para variar o movimento sem alterar os inimigos nem a partida. */
public interface MovimentoFormacao {
    void atualizar(List<Inimigo> inimigos, double segundos);
}
