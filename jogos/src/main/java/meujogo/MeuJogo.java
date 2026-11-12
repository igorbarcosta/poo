package meujogo;

import br.edu.ifpb.jogos.base.Cor;
import br.edu.ifpb.jogos.base.Entrada;
import br.edu.ifpb.jogos.base.Jogo;
import br.edu.ifpb.jogos.base.Tela;

/** Ponto de partida, não uma arquitetura obrigatória para todos os jogos. */
public class MeuJogo implements Jogo {
    private Jogador jogador = new Jogador();

    @Override
    public String getTitulo() {
        return "Meu jogo";
    }

    @Override
    public void atualizar(double segundos, Entrada entrada) {
        if (entrada.reiniciou()) {
            jogador = new Jogador();
            return;
        }
        int horizontal = 0;
        int vertical = 0;
        if (entrada.esquerda()) { horizontal--; }
        if (entrada.direita()) { horizontal++; }
        if (entrada.baixo()) { vertical--; }
        if (entrada.cima()) { vertical++; }
        jogador.mover(horizontal, vertical, segundos);
    }

    @Override
    public void desenhar(Tela tela) {
        tela.retangulo(0, 0, Tela.LARGURA, Tela.ALTURA, Cor.FUNDO);
        tela.texto("MEU JOGO", 40, 670, 2, Cor.BRANCO);
        tela.texto("Comece pelas regras e pelos objetos do seu jogo.", 40, 625, 1, Cor.CIANO);
        tela.retangulo(jogador.getX(), jogador.getY(),
                jogador.getTamanho(), jogador.getTamanho(), Cor.CIANO);
        tela.texto("SETAS / WASD: mover     R: reiniciar", 40, 75, 1, Cor.BRANCO);
        tela.texto("F11: tela cheia     ESC: sair", 40, 40, 1, Cor.CINZA);
    }
}
