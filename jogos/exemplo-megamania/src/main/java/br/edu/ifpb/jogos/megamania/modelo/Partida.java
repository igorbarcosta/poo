package br.edu.ifpb.jogos.megamania.modelo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

/** Coordena regras da partida. Não conhece janela, teclado ou libGDX. */
public class Partida {
    public enum Estado {
        JOGANDO,
        VITORIA,
        DERROTA
    }

    private final Nave nave = new Nave();
    private final List<Inimigo> inimigos = new ArrayList<>();
    private final List<Projetil> projeteis = new ArrayList<>();
    private final MovimentoFormacao movimento;
    private final Random sorteio = new Random(42);
    private Estado estado = Estado.JOGANDO;
    private int pontos = 0;
    private double esperaInimigo = 1.4;

    public Partida() {
        this(new MovimentoLateral());
    }

    public Partida(MovimentoFormacao movimento) {
        if (movimento == null) {
            throw new IllegalArgumentException("A partida precisa de um movimento.");
        }

        this.movimento = movimento;

        for (int linha = 0; linha < 3; linha++) {
            for (int coluna = 0; coluna < 6; coluna++) {
                inimigos.add(new Inimigo(150 + coluna * 100, 440 + linha * 58));
            }
        }
    }

    /** O passo pequeno mantém colisões confiáveis mesmo em uma tela lenta. */
    public void atualizar(double segundos, int direcao, boolean disparar) {
        if (!Double.isFinite(segundos)
                || segundos < 0
                || segundos > 1.0 / 30 + 0.000001
                || direcao < -1
                || direcao > 1) {
            throw new IllegalArgumentException("Use passos de até 1/30 s e direção entre -1 e 1.");
        }

        if (estado != Estado.JOGANDO || segundos == 0) {
            return;
        }

        nave.atualizar(segundos, direcao);

        if (disparar) {
            Projetil novo = nave.tentarDisparar();
            if (novo != null) {
                projeteis.add(novo);
            }
        }

        movimento.atualizar(Collections.unmodifiableList(inimigos), segundos);

        esperaInimigo -= segundos;
        if (esperaInimigo <= 0 && !inimigos.isEmpty()) {
            projeteis.add(inimigos.get(sorteio.nextInt(inimigos.size())).disparar());
            esperaInimigo = 1.1;
        }

        for (Projetil projetil : projeteis) {
            projetil.atualizar(segundos);
            if (projetil.isDoJogador()) {
                for (Inimigo inimigo : inimigos) {
                    if (projetil.tentarAtingir(inimigo)) {
                        pontos += inimigo.getPontos();
                    }
                }
            } else {
                projetil.tentarAtingir(nave);
            }
        }

        for (int i = inimigos.size() - 1; i >= 0; i--) {
            if (!inimigos.get(i).estaVivo()) {
                inimigos.remove(i);
            }
        }

        for (int i = projeteis.size() - 1; i >= 0; i--) {
            if (!projeteis.get(i).estaAtivo()) {
                projeteis.remove(i);
            }
        }

        if (!nave.estaVivo() || invasoresChegaram()) {
            estado = Estado.DERROTA;
        } else if (inimigos.isEmpty()) {
            estado = Estado.VITORIA;
        }
    }

    private boolean invasoresChegaram() {
        for (Inimigo inimigo : inimigos) {
            if (inimigo.getY() <= nave.getY() + nave.getAltura()) {
                return true;
            }
        }

        return false;
    }

    public Nave getNave() {
        return nave;
    }

    public List<Inimigo> getInimigos() {
        return Collections.unmodifiableList(inimigos);
    }

    public List<Projetil> getProjeteis() {
        return Collections.unmodifiableList(projeteis);
    }

    public Estado getEstado() {
        return estado;
    }

    public int getPontos() {
        return pontos;
    }
}
