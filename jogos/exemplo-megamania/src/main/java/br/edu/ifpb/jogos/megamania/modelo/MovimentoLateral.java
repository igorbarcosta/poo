package br.edu.ifpb.jogos.megamania.modelo;

import java.util.List;

public class MovimentoLateral implements MovimentoFormacao {
    private int direcao = 1;

    @Override
    public void atualizar(List<Inimigo> inimigos, double segundos) {
        double dx = direcao * 76 * segundos;
        boolean chegouNaBorda = false;

        for (Inimigo inimigo : inimigos) {
            double proximoX = inimigo.getX() + dx;
            if (proximoX < 58 || proximoX + inimigo.getLargura() > 902) {
                chegouNaBorda = true;
            }
        }

        double dy = 0;
        if (chegouNaBorda) {
            direcao *= -1;
            dx = direcao * 76 * segundos;
            dy = -24;
        }

        for (Inimigo inimigo : inimigos) {
            inimigo.deslocar(dx, dy);
        }
    }
}
