package br.edu.ifpb.jogos.exemplos.patrulha;

import br.edu.ifpb.jogos.base.Cor;
import br.edu.ifpb.jogos.base.Entrada;
import br.edu.ifpb.jogos.base.Jogo;
import br.edu.ifpb.jogos.base.Tela;
import br.edu.ifpb.jogos.exemplos.patrulha.modelo.Jogador;
import br.edu.ifpb.jogos.exemplos.patrulha.modelo.Inimigo;
import br.edu.ifpb.jogos.exemplos.patrulha.modelo.Partida;

/** Entrada e apresentação. As regras permanecem no pacote modelo. */
public class JogoPatrulha implements Jogo {
    private Partida partida = new Partida();

    @Override
    public String getTitulo() { return "Exemplo — Inimigo em patrulha"; }

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
        partida.atualizar(segundos, horizontal, vertical);
    }

    @Override
    public void desenhar(Tela tela) {
        tela.retangulo(0, 0, Tela.LARGURA, Tela.ALTURA, Cor.FUNDO);
        Jogador jogador = partida.getJogador();
        Inimigo inimigo = partida.getInimigo();
        tela.retangulo(240, 320, 520, 2, Cor.LINHA);
        tela.retangulo(240, 300, 2, 100, Cor.CINZA);
        tela.retangulo(760, 300, 2, 100, Cor.CINZA);
        tela.retangulo(inimigo.getX(), inimigo.getY(), 40, 40, Cor.LARANJA);
        double ponta = inimigo.getX() + (inimigo.getDirecao() == 1 ? 34 : 6);
        tela.circulo(ponta, inimigo.getY() + 20, 4, Cor.FUNDO);
        tela.retangulo(jogador.getX(), jogador.getY(), Jogador.TAMANHO, Jogador.TAMANHO, Cor.CIANO);
        tela.retangulo(0, 600, 960, 120, Cor.PAINEL);
        tela.retangulo(0, 0, 960, 110, Cor.PAINEL);
        tela.texto("INIMIGO EM PATRULHA", 40, 680, 1.6, Cor.BRANCO);
        tela.texto(String.format("Inimigo: x %.0f   |   Direção: %s   |   Contato: %s",
                inimigo.getX(), inimigo.getDirecao() == 1 ? "DIREITA" : "ESQUERDA",
                partida.emContato() ? "SIM" : "NÃO"), 40, 640, 1, Cor.CIANO);
        tela.texto("O inimigo se move sozinho; o contato só é indicado, sem dano.", 40, 90, 1, Cor.BRANCO);
        tela.texto("SETAS / WASD: mover     R: reiniciar     F11: tela cheia     ESC: sair",
                40, 45, 1, Cor.CINZA);
    }
}
