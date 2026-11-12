package br.edu.ifpb.jogos.megamania;

import br.edu.ifpb.jogos.base.Cor;
import br.edu.ifpb.jogos.base.Entrada;
import br.edu.ifpb.jogos.base.Jogo;
import br.edu.ifpb.jogos.base.Tela;
import br.edu.ifpb.jogos.megamania.modelo.Inimigo;
import br.edu.ifpb.jogos.megamania.modelo.Nave;
import br.edu.ifpb.jogos.megamania.modelo.Partida;
import br.edu.ifpb.jogos.megamania.modelo.Projetil;

/** Apresentação do exemplo. Traduz entrada em comandos do domínio. */
public class JogoMegamania implements Jogo {
    private Partida partida = new Partida();
    private boolean iniciou = false;
    private boolean pausado = false;
    private double tempoVisual = 0;

    @Override
    public String getTitulo() {
        return "Megamania POO";
    }

    @Override
    public void atualizar(double segundos, Entrada entrada) {
        tempoVisual += segundos;

        if (entrada.reiniciou()) {
            partida = new Partida();
            iniciou = true;
            pausado = false;
            return;
        }

        if (!iniciou) {
            if (entrada.confirmou()) {
                iniciou = true;
            }
            return;
        }

        if (entrada.pausou() && partida.getEstado() == Partida.Estado.JOGANDO) {
            pausado = !pausado;
        }

        if (pausado) {
            return;
        }

        int direcao = 0;
        if (entrada.esquerda()) {
            direcao--;
        }
        if (entrada.direita()) {
            direcao++;
        }

        partida.atualizar(segundos, direcao, entrada.acao());
    }

    @Override
    public void desenhar(Tela tela) {
        tela.retangulo(0, 0, 960, 720, Cor.FUNDO);
        for (int i = 0; i < 65; i++) {
            double y = 114 + ((i * 79 + 480 - tempoVisual * (8 + i % 3 * 6)) % 480 + 480) % 480;
            tela.retangulo(54 + (i * 137 % 848), y, i % 5 == 0 ? 2 : 1, 2, Cor.LINHA);
        }

        tela.texto("LAB / JOGOS EM JAVA", 48, 690, 1, Cor.CINZA);
        tela.texto("MEGAMANIA", 48, 660, 1.8, Cor.BRANCO);
        tela.texto("POO", 310, 658, 1.3, Cor.CIANO);
        tela.texto("PONTOS", 556, 685, 0.9, Cor.CINZA);
        tela.texto(String.format("%05d", partida.getPontos()), 556, 659, 1.5, Cor.CIANO);
        tela.texto("VIDAS", 710, 685, 0.9, Cor.CINZA);
        tela.texto("0" + partida.getNave().getVidas(), 710, 659, 1.5, Cor.BRANCO);
        tela.texto("ALVOS", 828, 685, 0.9, Cor.CINZA);
        tela.texto(String.format("%02d", partida.getInimigos().size()), 828, 659, 1.5, Cor.LARANJA);
        tela.retangulo(48, 616, 864, 1, Cor.LINHA);
        tela.retangulo(48, 110, 864, 1, Cor.LINHA);

        for (Inimigo inimigo : partida.getInimigos()) {
            desenharInimigo(tela, inimigo);
        }

        for (Projetil projetil : partida.getProjeteis()) {
            Cor cor = projetil.isDoJogador() ? Cor.CIANO : Cor.LARANJA;
            tela.retangulo(projetil.getX() - 2, projetil.getY(), 10, 16, Cor.LINHA);
            tela.retangulo(projetil.getX(), projetil.getY(), 6, 16, cor);
        }

        Nave nave = partida.getNave();
        if (!nave.estaProtegida() || ((int) (tempoVisual * 12)) % 2 == 0) {
            desenharNave(tela, nave.getX(), nave.getY());
        }

        tela.texto("A D / SETAS   mover       ESPAÇO   disparar", 48, 82, 1, Cor.BRANCO);
        tela.texto("P   pausar      R   reiniciar      ESC   sair", 48, 52, 0.9, Cor.CINZA);
        tela.texto("01 / FORMAÇÃO", 718, 82, 0.9, Cor.CIANO);
        tela.texto("F11   tela cheia", 718, 52, 0.9, Cor.CINZA);

        if (!iniciou) {
            painel(tela, "DEFENDA O SETOR", "Elimine a formação e desvie dos disparos.",
                    "ENTER PARA INICIAR", Cor.CIANO);
        } else if (pausado) {
            painel(tela, "PAUSA", "A partida está congelada.", "P PARA CONTINUAR", Cor.CIANO);
        } else if (partida.getEstado() == Partida.Estado.VITORIA) {
            painel(tela, "SETOR LIMPO", "Todos os alvos foram eliminados. Pontos: " + partida.getPontos(),
                    "R PARA JOGAR NOVAMENTE", Cor.CIANO);
        } else if (partida.getEstado() == Partida.Estado.DERROTA) {
            painel(tela, "FIM DE JOGO", "A formação venceu esta rodada. Pontos: " + partida.getPontos(),
                    "R PARA TENTAR NOVAMENTE", Cor.VERMELHO);
        }
    }

    private void desenharInimigo(Tela tela, Inimigo inimigo) {
        double x = inimigo.getX();
        double y = inimigo.getY();
        tela.retangulo(x + 7, y + 7, 24, 18, Cor.LARANJA);
        tela.retangulo(x, y + 5, 8, 12, Cor.LARANJA);
        tela.retangulo(x + 30, y + 5, 8, 12, Cor.LARANJA);
        tela.retangulo(x + 6, y, 7, 7, Cor.LARANJA);
        tela.retangulo(x + 25, y, 7, 7, Cor.LARANJA);
        tela.retangulo(x + 10, y + 25, 5, 3, Cor.LARANJA);
        tela.retangulo(x + 24, y + 25, 5, 3, Cor.LARANJA);
        tela.retangulo(x + 11, y + 13, 5, 5, Cor.FUNDO);
        tela.retangulo(x + 23, y + 13, 5, 5, Cor.FUNDO);
    }

    private void desenharNave(Tela tela, double x, double y) {
        tela.triangulo(x, y, x + 22, y + 30, x + 44, y, Cor.CIANO);
        tela.retangulo(x + 17, y + 3, 10, 15, Cor.BRANCO);
        tela.retangulo(x + 20, y + 10, 4, 9, Cor.AZUL);
        tela.retangulo(x + 7, y - 6, 6, 8, Cor.LARANJA);
        tela.retangulo(x + 31, y - 6, 6, 8, Cor.LARANJA);
    }

    private void painel(Tela tela, String titulo, String mensagem, String acao, Cor destaque) {
        tela.retangulo(176, 254, 608, 192, Cor.LINHA);
        tela.retangulo(178, 256, 604, 188, Cor.PAINEL);
        tela.retangulo(178, 438, 604, 6, destaque);
        tela.texto(titulo, 218, 406, 2, Cor.BRANCO);
        tela.texto(mensagem, 218, 357, 1, Cor.CINZA);
        tela.texto(acao, 218, 302, 1.1, destaque);
    }
}
