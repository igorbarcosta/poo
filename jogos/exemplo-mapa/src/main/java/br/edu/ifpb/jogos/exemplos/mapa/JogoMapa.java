package br.edu.ifpb.jogos.exemplos.mapa;

import br.edu.ifpb.jogos.base.Cor;
import br.edu.ifpb.jogos.base.Entrada;
import br.edu.ifpb.jogos.base.Jogo;
import br.edu.ifpb.jogos.base.Tela;
import br.edu.ifpb.jogos.exemplos.mapa.modelo.Jogador;
import br.edu.ifpb.jogos.exemplos.mapa.modelo.Camera;
import br.edu.ifpb.jogos.exemplos.mapa.modelo.Mundo;

/** Entrada e apresentação. As regras permanecem no pacote modelo. */
public class JogoMapa implements Jogo {
    private Mundo mundo = new Mundo();
    private Camera camera = new Camera();

    @Override
    public String getTitulo() { return "Exemplo — Mapa e câmera"; }

    @Override
    public void atualizar(double segundos, Entrada entrada) {
        if (entrada.reiniciou()) {
            mundo = new Mundo();
            camera = new Camera();
            return;
        }
        int horizontal = 0;
        int vertical = 0;
        if (entrada.esquerda()) { horizontal--; }
        if (entrada.direita()) { horizontal++; }
        if (entrada.baixo()) { vertical--; }
        if (entrada.cima()) { vertical++; }
        mundo.mover(horizontal, vertical, segundos);
        camera.acompanhar(mundo.getJogador());
    }

    @Override
    public void desenhar(Tela tela) {
        tela.retangulo(0, 0, Tela.LARGURA, Tela.ALTURA, Cor.FUNDO);
        Jogador jogador = mundo.getJogador();
        // Mundo: convertemos coordenadas apenas ao desenhar.
        for (int x = 0; x <= Mundo.LARGURA; x += 200) {
            tela.retangulo(camera.paraTelaX(x), camera.paraTelaY(0), 2, Mundo.ALTURA, Cor.LINHA);
        }
        for (int y = 0; y <= Mundo.ALTURA; y += 200) {
            tela.retangulo(camera.paraTelaX(0), camera.paraTelaY(y), Mundo.LARGURA, 2, Cor.LINHA);
        }
        desenharMarco(tela, 300, 250, "A");
        desenharMarco(tela, 1200, 800, "B");
        desenharMarco(tela, 2200, 1450, "C");
        tela.retangulo(camera.paraTelaX(jogador.getX()), camera.paraTelaY(jogador.getY()),
                Jogador.TAMANHO, Jogador.TAMANHO, Cor.CIANO);
        // Os painéis cobrem o mundo fora da faixa de observação.
        tela.retangulo(0, 600, 960, 120, Cor.PAINEL);
        tela.retangulo(0, 0, 960, 110, Cor.PAINEL);
        tela.texto("MAPA E CÂMERA", 40, 680, 1.6, Cor.BRANCO);
        tela.texto(String.format("Mundo: x %.0f  y %.0f   |   Câmera: x %.0f  y %.0f",
                jogador.getX(), jogador.getY(), camera.getX(), camera.getY()), 40, 640, 1, Cor.CIANO);
        tela.texto("Procure os marcos A, B e C no mundo de 2400 x 1600.", 40, 90, 1, Cor.BRANCO);
        tela.texto("SETAS / WASD: mover     R: reiniciar     F11: tela cheia     ESC: sair",
                40, 45, 1, Cor.CINZA);
    }

    private void desenharMarco(Tela tela, double x, double y, String nome) {
        tela.retangulo(camera.paraTelaX(x), camera.paraTelaY(y), 100, 80, Cor.AZUL);
        tela.texto(nome, camera.paraTelaX(x + 30), camera.paraTelaY(y + 55), 1.4, Cor.BRANCO);
    }
}
