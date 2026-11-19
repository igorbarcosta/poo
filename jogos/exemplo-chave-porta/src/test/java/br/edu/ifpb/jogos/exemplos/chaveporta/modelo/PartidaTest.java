package br.edu.ifpb.jogos.exemplos.chaveporta.modelo;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class PartidaTest {
    @Test
    void naoAbreSemChave() {
        Partida partida = new Partida();
        partida.getJogador().posicionar(600, 330);
        assertFalse(partida.interagir());
        assertFalse(partida.getPorta().isAberta());
    }

    @Test
    void coletaPorContatoEAbreSomentePertoDaPorta() {
        Partida partida = new Partida();
        partida.getJogador().posicionar(270, 330);
        partida.mover(0, 0, 0);
        assertTrue(partida.getJogador().possuiChave());
        assertFalse(partida.getChave().isDisponivel());
        assertFalse(partida.interagir());
        assertTrue(partida.getJogador().possuiChave());
        partida.getJogador().posicionar(600, 330);
        assertTrue(partida.interagir());
        assertTrue(partida.getPorta().isAberta());
        assertFalse(partida.getJogador().possuiChave());
        assertFalse(partida.interagir());
    }

    @Test
    void chaveNaoPodeSerColetadaDuasVezes() {
        Jogador jogador = new Jogador();
        Chave chave = new Chave();
        assertFalse(chave.tentarColetar(jogador));
        jogador.posicionar(270, 330);
        assertTrue(chave.tentarColetar(jogador));
        assertTrue(jogador.usarChave());
        assertFalse(chave.tentarColetar(jogador));
        assertFalse(jogador.possuiChave());
    }

    @Test
    void portaFechadaBloqueiaMesmoDeslocamentoGrande() {
        Partida partida = new Partida();
        partida.mover(1, 0, 4);
        assertEquals(610, partida.getJogador().getX());
        assertFalse(partida.getPorta().isAberta());
    }

    @Test
    void portaAbertaPermitePassagemMasParedeContinuaBloqueando() {
        Partida partida = new Partida();
        partida.getJogador().receberChave();
        partida.getJogador().posicionar(600, 330);
        partida.interagir();
        partida.mover(1, 0, 1);
        assertTrue(partida.getJogador().getX() > Porta.X + Porta.LARGURA);
        partida.getJogador().posicionar(600, 150);
        partida.mover(1, 0, 1);
        assertEquals(610, partida.getJogador().getX());
    }

    @Test
    void dentroDaPassagemNaoAtravessaAParedeNaVertical() {
        Partida partida = new Partida();
        partida.getJogador().receberChave();
        partida.getJogador().posicionar(600, 330);
        partida.interagir();
        partida.getJogador().posicionar(650, 330);
        partida.mover(0, 1, 1);
        assertEquals(390, partida.getJogador().getY());
        partida.mover(0, -1, 1);
        assertEquals(290, partida.getJogador().getY());
    }

    @Test
    void novaPartidaRestauraChavePortaEInventario() {
        Partida partida = new Partida();
        partida.getJogador().receberChave();
        partida.getJogador().posicionar(600, 330);
        partida.interagir();
        Partida nova = new Partida();
        assertTrue(nova.getChave().isDisponivel());
        assertFalse(nova.getJogador().possuiChave());
        assertFalse(nova.getPorta().isAberta());
    }
}
