package br.edu.ifpb.jogos.exemplos.salas;

import br.edu.ifpb.jogos.base.Cor;
import br.edu.ifpb.jogos.base.Entrada;
import br.edu.ifpb.jogos.base.Jogo;
import br.edu.ifpb.jogos.base.Tela;
import br.edu.ifpb.jogos.exemplos.salas.modelo.Jogador;
import br.edu.ifpb.jogos.exemplos.salas.modelo.Sala;
import br.edu.ifpb.jogos.exemplos.salas.modelo.Partida;

/** Entrada e apresentação. As regras permanecem no pacote modelo. */
public class JogoSalas implements Jogo {
    private Partida partida = new Partida();

    @Override
    public String getTitulo() { return "Exemplo — Salas conectadas"; }

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
        Sala sala = partida.getSalaAtual();
        Jogador jogador = partida.getJogador();
        tela.retangulo(0, 110, 960, 490, sala.isLuzLigada() ? Cor.LINHA : Cor.FUNDO);
        tela.retangulo(sala.getPortaX(), 300, 40, 100, Cor.AZUL);
        tela.texto("PORTA", sala.getPortaX() - 10, 430, 0.8, Cor.BRANCO);
        tela.retangulo(450, 330, 40, 40, sala.isLuzLigada() ? Cor.CIANO : Cor.LARANJA);
        tela.texto("INTERRUPTOR", 410, 410, 0.8, Cor.BRANCO);
        tela.retangulo(jogador.getX(), jogador.getY(), Jogador.TAMANHO, Jogador.TAMANHO, Cor.CIANO);
        tela.retangulo(0, 600, 960, 120, Cor.PAINEL);
        tela.retangulo(0, 0, 960, 110, Cor.PAINEL);
        tela.texto("SALAS CONECTADAS | SALA " + sala.getNumero(), 40, 680, 1.6, Cor.BRANCO);
        tela.texto("Luz desta sala: " + (sala.isLuzLigada() ? "LIGADA" : "DESLIGADA"),
                40, 640, 1, Cor.CIANO);
        tela.texto("ENTER sobre a porta: trocar sala; sobre o interruptor: alternar luz.",
                40, 90, 1, Cor.BRANCO);
        tela.texto("SETAS / WASD: mover     R: reiniciar     F11: tela cheia     ESC: sair",
                40, 45, 1, Cor.CINZA);
    }
}
