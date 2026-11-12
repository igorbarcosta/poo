package meujogo;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class JogadorTest {
    @Test
    void movimentoDependeDoTempoDecorrido() {
        Jogador jogador = new Jogador();
        jogador.mover(1, 0, 0.5);

        assertEquals(590, jogador.getX(), 0.001);
        assertEquals(340, jogador.getY(), 0.001);
    }

    @Test
    void dividirOIntervaloPreservaODeslocamento() {
        Jogador primeiro = new Jogador();
        Jogador segundo = new Jogador();
        primeiro.mover(1, 1, 0.4);
        segundo.mover(1, 1, 0.2);
        segundo.mover(1, 1, 0.2);

        assertEquals(primeiro.getX(), segundo.getX(), 0.001);
        assertEquals(primeiro.getY(), segundo.getY(), 0.001);
    }

    @Test
    void movimentoRespeitaAsDuasBordasHorizontais() {
        Jogador jogador = new Jogador();
        jogador.mover(1, 0, 10);
        assertEquals(920, jogador.getX(), 0.001);

        jogador.mover(-1, 0, 10);
        assertEquals(0, jogador.getX(), 0.001);
    }

    @Test
    void movimentoPreservaAsFaixasDeTexto() {
        Jogador jogador = new Jogador();
        jogador.mover(0, 1, 10);
        assertEquals(560, jogador.getY(), 0.001);

        jogador.mover(0, -1, 10);
        assertEquals(110, jogador.getY(), 0.001);
    }

    @Test
    void semDirecaoNaoHaDeslocamento() {
        Jogador jogador = new Jogador();
        jogador.mover(0, 0, 1);

        assertEquals(460, jogador.getX(), 0.001);
        assertEquals(340, jogador.getY(), 0.001);
    }
}
