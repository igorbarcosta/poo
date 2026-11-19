package br.edu.ifpb.jogos.exemplos.salas.modelo;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class PartidaTest {
    @Test
    void portaMudaSalaEColocaJogadorLongeDaPortaDeChegada() {
        Partida partida = new Partida();
        partida.getJogador().posicionar(860, 330);
        partida.interagir();
        assertEquals(2, partida.getSalaAtual().getNumero());
        assertEquals(140, partida.getJogador().getX());
        partida.interagir();
        assertEquals(2, partida.getSalaAtual().getNumero());
        partida.getJogador().posicionar(60, 330);
        partida.interagir();
        assertEquals(1, partida.getSalaAtual().getNumero());
        assertEquals(770, partida.getJogador().getX());
    }

    @Test
    void estadoDaSalaPermaneceAoSairEVoltar() {
        Partida partida = new Partida();
        Sala primeira = partida.getSalaAtual();
        partida.getJogador().posicionar(450, 330);
        partida.interagir();
        assertTrue(primeira.isLuzLigada());
        partida.getJogador().posicionar(860, 330);
        partida.interagir();
        assertFalse(partida.getSalaAtual().isLuzLigada());
        partida.getJogador().posicionar(60, 330);
        partida.interagir();
        assertSame(primeira, partida.getSalaAtual());
        assertTrue(partida.getSalaAtual().isLuzLigada());
    }

    @Test
    void enterForaDePortaOuInterruptorNaoMudaSalaOuLuz() {
        Partida partida = new Partida();
        partida.interagir();
        assertEquals(1, partida.getSalaAtual().getNumero());
        assertFalse(partida.getSalaAtual().isLuzLigada());
    }

    @Test
    void novaPartidaReiniciaSalasEJogador() {
        Partida antiga = new Partida();
        antiga.getJogador().posicionar(450, 330);
        antiga.interagir();
        Partida nova = new Partida();
        assertFalse(nova.getSalaAtual().isLuzLigada());
        assertTrue(antiga.getSalaAtual().isLuzLigada());
        assertEquals(120, nova.getJogador().getX());
    }
}
