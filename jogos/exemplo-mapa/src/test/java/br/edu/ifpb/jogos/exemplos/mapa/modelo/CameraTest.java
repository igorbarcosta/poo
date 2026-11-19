package br.edu.ifpb.jogos.exemplos.mapa.modelo;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class CameraTest {
    @Test
    void jogadorPodeUltrapassarATelaMasNaoOMundo() {
        Jogador jogador = new Jogador();
        jogador.mover(1, 1, 5);
        assertTrue(jogador.getX() > 960);
        assertTrue(jogador.getY() > 720);
        jogador.mover(1, 1, 100);
        assertEquals(2360, jogador.getX());
        assertEquals(1560, jogador.getY());
        jogador.mover(-1, -1, 100);
        assertEquals(0, jogador.getX());
        assertEquals(0, jogador.getY());
    }

    @Test
    void cameraCentralizaSemAlterarPosicaoNoMundo() {
        Jogador jogador = new Jogador();
        jogador.posicionar(1200, 800);
        Camera camera = new Camera();
        camera.acompanhar(jogador);
        assertEquals(740, camera.getX());
        assertEquals(575, camera.getY());
        assertEquals(480, camera.paraTelaX(jogador.getX() + 20));
        assertEquals(355, camera.paraTelaY(jogador.getY() + 20));
        assertEquals(1200, jogador.getX());
        assertEquals(800, jogador.getY());
    }

    @Test
    void cameraNaoMostraAlemDasBordasDoMundo() {
        Jogador jogador = new Jogador();
        Camera camera = new Camera();
        jogador.posicionar(0, 0);
        camera.acompanhar(jogador);
        assertEquals(0, camera.getX());
        assertEquals(0, camera.getY());
        jogador.posicionar(2360, 1560);
        camera.acompanhar(jogador);
        assertEquals(1440, camera.getX());
        assertEquals(1110, camera.getY());
    }

    @Test
    void moverACameraNaoAlteraDistanciaEntreMarcos() {
        Jogador jogador = new Jogador();
        Camera camera = new Camera();
        double antes = camera.paraTelaX(1200) - camera.paraTelaX(300);
        jogador.posicionar(1400, 900);
        camera.acompanhar(jogador);
        assertEquals(antes, camera.paraTelaX(1200) - camera.paraTelaX(300));
    }
}
