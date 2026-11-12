package br.edu.ifpb.jogos.desktop;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class EscalaDaTelaTest {
    @Test void janelaMinimizadaNaoProduzEscalaInvalida() {
        assertFalse(EscalaDaTela.disponivel(0, 0, 0, 0));
        assertEquals(0, EscalaDaTela.calcular(0, 0, 0, 0, 0, 960));
    }

    @Test void qualquerDimensaoIndisponivelSuspendeODesenho() {
        assertFalse(EscalaDaTela.disponivel(0, 720, 960, 720));
        assertFalse(EscalaDaTela.disponivel(960, 0, 960, 720));
        assertFalse(EscalaDaTela.disponivel(960, 720, 0, 720));
        assertFalse(EscalaDaTela.disponivel(960, 720, 960, 0));
    }

    @Test void viewportAindaNaoConfiguradoNaoGeraFonte() {
        assertEquals(0, EscalaDaTela.calcular(960, 720, 960, 720, 0, 960));
        assertEquals(0, EscalaDaTela.calcular(960, 720, 960, 720, 960, Float.NaN));
    }

    @Test void escalaUsaViewportEFramebufferHiDpi() {
        assertEquals(3, EscalaDaTela.calcular(1920, 1080, 3840, 2160, 1440, 960), 0.001);
    }

    @Test void restaurarJanelaRecuperaEscalaValida() {
        assertEquals(1, EscalaDaTela.calcular(960, 720, 960, 720, 960, 960), 0.001);
        assertEquals(0, EscalaDaTela.calcular(0, 0, 0, 0, 960, 960));
        assertEquals(2, EscalaDaTela.calcular(1920, 1440, 1920, 1440, 1920, 960), 0.001);
    }

    @Test void fontePequenaAindaTemGlifosRasterizaveis() {
        assertEquals(8, EscalaDaTela.tamanhoFonte(1, 0.01f));
        assertEquals(8, EscalaDaTela.tamanhoFonte(1, 0.1f));
    }

    @Test void fonteMantemTamanhoNormalEHiDpi() {
        assertEquals(20, EscalaDaTela.tamanhoFonte(1, 1));
        assertEquals(40, EscalaDaTela.tamanhoFonte(1, 2));
    }
}
