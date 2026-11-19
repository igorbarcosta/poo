package br.edu.ifpb.jogos.exemplos.patrulha.modelo;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class InimigoTest {
    @Test
    void inimigoMoveSemEntradaDoJogador() {
        Partida partida = new Partida();
        partida.atualizar(1, 0, 0);
        assertEquals(360, partida.getInimigo().getX());
        assertEquals(120, partida.getJogador().getX());
    }

    @Test
    void bordaInverteDirecaoEPreservaExcesso() {
        Inimigo inimigo = new Inimigo(240, 720, 120);
        inimigo.atualizar(4);
        assertEquals(720, inimigo.getX());
        assertEquals(-1, inimigo.getDirecao());
        inimigo.atualizar(0.5);
        assertEquals(660, inimigo.getX());
        inimigo.atualizar(4);
        assertEquals(300, inimigo.getX());
        assertEquals(1, inimigo.getDirecao());
    }

    @Test
    void dividirIntervaloPreservaPercursoInclusiveNasBordas() {
        Inimigo inteiro = new Inimigo(240, 720, 120);
        Inimigo passos = new Inimigo(240, 720, 120);
        inteiro.atualizar(10);
        for (int i = 0; i < 1000; i++) { passos.atualizar(0.01); }
        assertEquals(inteiro.getX(), passos.getX(), 0.000001);
        assertEquals(inteiro.getDirecao(), passos.getDirecao());
    }

    @Test
    void intervaloZeroNaoMoveENegativoNaoAlteraEstado() {
        Inimigo inimigo = new Inimigo(240, 720, 120);
        inimigo.atualizar(0);
        assertEquals(240, inimigo.getX());
        assertThrows(IllegalArgumentException.class, () -> inimigo.atualizar(-1));
        assertEquals(240, inimigo.getX());
    }

    @Test
    void contatoNaoCriaRegraDeDano() {
        Partida partida = new Partida();
        partida.getJogador().posicionar(240, 330);
        assertTrue(partida.emContato());
        partida.getJogador().posicionar(100, 330);
        assertFalse(partida.emContato());
    }

    @Test
    void limitesEVeloCidadePrecisamSerValidos() {
        assertThrows(IllegalArgumentException.class, () -> new Inimigo(1, 1, 10));
        assertThrows(IllegalArgumentException.class, () -> new Inimigo(0, 100, 0));
    }
}
