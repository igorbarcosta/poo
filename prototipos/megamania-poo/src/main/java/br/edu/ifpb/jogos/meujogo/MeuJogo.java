package br.edu.ifpb.jogos.meujogo;

import br.edu.ifpb.jogos.base.Cor;
import br.edu.ifpb.jogos.base.Entrada;
import br.edu.ifpb.jogos.base.Jogo;
import br.edu.ifpb.jogos.base.Tela;

/** Exemplo mínimo independente das regras de Megamania. Execute com --args=base. */
public class MeuJogo implements Jogo {
    private double x = 460;
    private double y = 340;

    @Override
    public String getTitulo() {
        return "Meu jogo - base comum";
    }

    @Override
    public void atualizar(double segundos, Entrada entrada) {
        if (entrada.esquerda()) {
            x -= 260 * segundos;
        }
        if (entrada.direita()) {
            x += 260 * segundos;
        }
        if (entrada.cima()) {
            y += 260 * segundos;
        }
        if (entrada.baixo()) {
            y -= 260 * segundos;
        }

        x = Math.max(48, Math.min(872, x));
        y = Math.max(120, Math.min(550, y));

        if (entrada.reiniciou()) {
            x = 460;
            y = 340;
        }
    }

    @Override
    public void desenhar(Tela tela) {
        tela.retangulo(0, 0, 960, 720, Cor.FUNDO);
        tela.texto("SEU JOGO COMECA AQUI", 48, 658, 2, Cor.BRANCO);
        tela.texto("Mesma janela. Outras regras. Outros objetos.", 48, 615, 1.2, Cor.CIANO);
        tela.retangulo(x, y, 40, 40, Cor.CIANO);
        tela.texto("SETAS / WASD   mover       R   recomecar       ESC   sair", 48, 76, 1, Cor.CINZA);
    }
}
