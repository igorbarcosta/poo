package br.edu.ifpb.jogos.exemplos.chaveporta;

import br.edu.ifpb.jogos.base.Cor;
import br.edu.ifpb.jogos.base.Entrada;
import br.edu.ifpb.jogos.base.Jogo;
import br.edu.ifpb.jogos.base.Tela;
import br.edu.ifpb.jogos.exemplos.chaveporta.modelo.Jogador;
import br.edu.ifpb.jogos.exemplos.chaveporta.modelo.Porta;
import br.edu.ifpb.jogos.exemplos.chaveporta.modelo.Partida;

/** Entrada e apresentação. As regras permanecem no pacote modelo. */
public class JogoChavePorta implements Jogo {
    private Partida partida = new Partida();

    @Override
    public String getTitulo() { return "Exemplo — Chave e porta"; }

    @Override
    public void atualizar(double segundos, Entrada entrada) {
        if (entrada.reiniciou()) {
            partida = new Partida();
            return;
        }
        int horizontal = 0;
        int vertical = 0;
        if (entrada.esquerda()) { horizontal--; }
        if (entrada.direita()) { horizontal++; }
        if (entrada.baixo()) { vertical--; }
        if (entrada.cima()) { vertical++; }
        partida.mover(horizontal, vertical, segundos);
        if (entrada.confirmou()) { partida.interagir(); }
    }

    @Override
    public void desenhar(Tela tela) {
        tela.retangulo(0, 0, Tela.LARGURA, Tela.ALTURA, Cor.FUNDO);
        Jogador jogador = partida.getJogador();
        Porta porta = partida.getPorta();
        tela.retangulo(Porta.X, 110, Porta.LARGURA, Porta.BASE - 110, Cor.CINZA);
        tela.retangulo(Porta.X, Porta.TOPO, Porta.LARGURA, 600 - Porta.TOPO, Cor.CINZA);
        if (!porta.isAberta()) {
            tela.retangulo(Porta.X, Porta.BASE, Porta.LARGURA, Porta.TOPO - Porta.BASE, Cor.VERMELHO);
        }
        if (partida.getChave().isDisponivel()) {
            tela.retangulo(270, 338, 24, 24, Cor.LARANJA);
        }
        tela.texto("CHAVE", 250, 405, 0.8, Cor.BRANCO);
        tela.texto("PORTA", 570, 470, 0.8, Cor.BRANCO);
        tela.texto("SAÍDA", 810, 520, 1.2, Cor.AZUL);
        tela.retangulo(jogador.getX(), jogador.getY(), Jogador.TAMANHO, Jogador.TAMANHO, Cor.CIANO);
        tela.retangulo(0, 600, 960, 120, Cor.PAINEL);
        tela.retangulo(0, 0, 960, 110, Cor.PAINEL);
        tela.texto("CHAVE E PORTA", 40, 680, 1.6, Cor.BRANCO);
        tela.texto("Chave: " + (jogador.possuiChave() ? "NO JOGADOR" : "AUSENTE")
                + "   |   Porta: " + (porta.isAberta() ? "ABERTA" : "FECHADA"), 40, 640, 1, Cor.CIANO);
        tela.texto("Recolha a chave por contato. ENTER perto da porta: tentar abrir.",
                40, 90, 1, Cor.BRANCO);
        tela.texto("SETAS / WASD: mover     R: reiniciar     F11: tela cheia     ESC: sair",
                40, 45, 1, Cor.CINZA);
    }
}
