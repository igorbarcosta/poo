package br.edu.ifpb.jogos.megamania.modelo;

import java.util.List;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class PartidaTest {
    private static final double PASSO = 1.0 / 60;

    @Test
    void naveRespeitaAsDuasBordas() {
        Nave nave = new Nave();

        for (int i = 0; i < 600; i++) {
            nave.atualizar(PASSO, -1);
        }

        assertEquals(48, nave.getX(), 0.001);

        for (int i = 0; i < 600; i++) {
            nave.atualizar(PASSO, 1);
        }

        assertEquals(912, nave.getX() + nave.getLargura(), 0.001);
    }

    @Test
    void recargaRecusaDisparoAteExpirar() {
        Nave nave = new Nave();

        assertNotNull(nave.tentarDisparar());
        assertNull(nave.tentarDisparar());

        nave.atualizar(0.1, 0);
        assertNull(nave.tentarDisparar());

        nave.atualizar(0.13, 0);
        assertNotNull(nave.tentarDisparar());
    }

    @Test
    void protecaoEvitaPerderVariasVidasNoMesmoImpacto() {
        Nave nave = new Nave();
        Alvo alvo = nave;

        alvo.receberImpacto();
        alvo.receberImpacto();
        assertEquals(2, nave.getVidas());

        nave.atualizar(1.6, 0);
        alvo.receberImpacto();
        assertEquals(1, nave.getVidas());
    }

    @Test
    void naveMortaNaoDisparaNemPossuiVidasNegativas() {
        Nave nave = new Nave();

        for (int i = 0; i < 5; i++) {
            nave.receberImpacto();
            nave.atualizar(1.6, 0);
        }

        assertEquals(0, nave.getVidas());
        assertFalse(nave.estaVivo());
        assertNull(nave.tentarDisparar());
    }

    @Test
    void umProjetilNaoAtingeDoisAlvosSobrepostos() {
        Inimigo primeiro = new Inimigo(100, 200);
        Inimigo segundo = new Inimigo(100, 200);
        Projetil tiro = new Projetil(110, 205, true);

        assertTrue(tiro.tentarAtingir(primeiro));
        assertFalse(tiro.tentarAtingir(segundo));
        assertFalse(primeiro.estaVivo());
        assertTrue(segundo.estaVivo());
    }

    @Test
    void disparoQueErraContinuaAtivo() {
        Projetil tiro = new Projetil(100, 200, true);

        assertFalse(tiro.tentarAtingir(new Inimigo(500, 500)));
        assertTrue(tiro.estaAtivo());
    }

    @Test
    void projeteisSaemDeCenaNasDuasDirecoes() {
        Projetil jogador = new Projetil(100, 595, true);
        Projetil inimigo = new Projetil(100, 100, false);

        jogador.atualizar(0.1);
        inimigo.atualizar(0.1);

        assertFalse(jogador.estaAtivo());
        assertFalse(inimigo.estaAtivo());
    }

    @Test
    void formacaoInverteEDesceAoEncontrarABorda() {
        Inimigo inimigo = new Inimigo(864, 400);

        new MovimentoLateral().atualizar(List.of(inimigo), PASSO);

        assertTrue(inimigo.getX() < 864);
        assertEquals(376, inimigo.getY());
    }

    @Test
    void partidaInicialTemDezoitoObjetosDiferentes() {
        Partida partida = new Partida();

        assertEquals(18, partida.getInimigos().size());
        assertNotSame(partida.getInimigos().get(0), partida.getInimigos().get(1));
        assertEquals(3, partida.getNave().getVidas());
        assertEquals(0, partida.getPontos());
    }

    @Test
    void listasPublicasNaoPermitemRemoverElementos() {
        Partida partida = new Partida();

        assertThrows(UnsupportedOperationException.class, () -> partida.getInimigos().clear());
        assertThrows(UnsupportedOperationException.class, () -> partida.getProjeteis().clear());
    }

    @Test
    void colaboradorRecebidoDeterminaMovimentoDosMesmosObjetos() {
        Partida partida = new Partida(new MovimentoFormacao() {
            @Override
            public void atualizar(List<Inimigo> inimigos, double segundos) {
                for (Inimigo inimigo : inimigos) {
                    inimigo.deslocar(2, -1);
                }
            }
        });

        Inimigo referencia = partida.getInimigos().get(0);
        double x = referencia.getX();

        partida.atualizar(PASSO, 0, false);

        assertSame(referencia, partida.getInimigos().get(0));
        assertEquals(x + 2, referencia.getX());
    }

    @Test
    void partidaCompletaContaCadaAlvoUmaVezECongelaAposVitoria() {
        Partida partida = new Partida(new MovimentoFormacao() {
            @Override
            public void atualizar(List<Inimigo> inimigos, double segundos) {
                for (Inimigo inimigo : inimigos) {
                    inimigo.deslocar(461 - inimigo.getX(), 220 - inimigo.getY());
                }
            }
        });

        for (int i = 0; i < 600 && partida.getEstado() == Partida.Estado.JOGANDO; i++) {
            partida.atualizar(PASSO, 0, true);
        }

        assertEquals(Partida.Estado.VITORIA, partida.getEstado());
        assertEquals(1800, partida.getPontos());
        assertTrue(partida.getInimigos().isEmpty());

        double x = partida.getNave().getX();
        partida.atualizar(PASSO, 1, true);

        assertEquals(x, partida.getNave().getX());
        assertEquals(1800, partida.getPontos());
    }

    @Test
    void invasaoEncerraMesmoSeJogadorAindaPossuiVidas() {
        Partida partida = new Partida(new MovimentoFormacao() {
            @Override
            public void atualizar(List<Inimigo> inimigos, double segundos) {
                for (Inimigo inimigo : inimigos) {
                    inimigo.deslocar(0, -500);
                }
            }
        });

        partida.atualizar(PASSO, 0, false);

        assertEquals(Partida.Estado.DERROTA, partida.getEstado());
        assertEquals(3, partida.getNave().getVidas());

        double y = partida.getInimigos().get(0).getY();
        partida.atualizar(PASSO, 1, true);

        assertEquals(y, partida.getInimigos().get(0).getY());
    }

    @Test
    void argumentosInvalidosSaoRecusados() {
        assertThrows(IllegalArgumentException.class, () -> new Partida(null));
        assertThrows(IllegalArgumentException.class, () -> new Inimigo(Double.NaN, 200));

        Partida partida = new Partida();

        assertThrows(IllegalArgumentException.class, () -> partida.atualizar(-1, 0, false));
        assertThrows(IllegalArgumentException.class, () -> partida.atualizar(1, 0, false));
        assertThrows(IllegalArgumentException.class, () -> partida.atualizar(Double.NaN, 0, false));
        assertThrows(IllegalArgumentException.class, () -> partida.atualizar(PASSO, 2, false));

        assertEquals(0, partida.getPontos());
        assertEquals(18, partida.getInimigos().size());
    }
}
