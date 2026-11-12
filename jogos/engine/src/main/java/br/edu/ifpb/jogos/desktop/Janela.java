package br.edu.ifpb.jogos.desktop;

import br.edu.ifpb.jogos.base.Jogo;
import br.edu.ifpb.jogos.base.Tela;
import com.badlogic.gdx.backends.lwjgl3.Lwjgl3Application;
import com.badlogic.gdx.backends.lwjgl3.Lwjgl3ApplicationConfiguration;

/** Inicialização fornecida: qualquer jogo usa a mesma janela e os mesmos contratos. */
public final class Janela {
    private Janela() {
    }

    public static void abrir(Jogo jogo) {
        Lwjgl3ApplicationConfiguration config = new Lwjgl3ApplicationConfiguration();
        config.setTitle(jogo.getTitulo());
        var monitor = Lwjgl3ApplicationConfiguration.getDisplayMode();
        double escala = Math.min(1280.0 / Tela.LARGURA,
                Math.min(monitor.width * 0.9 / Tela.LARGURA,
                        monitor.height * 0.9 / Tela.ALTURA));
        config.setWindowedMode((int) (Tela.LARGURA * escala), (int) (Tela.ALTURA * escala));
        config.setWindowSizeLimits(640, 480, -1, -1);
        config.setMaximized(true);
        config.useVsync(true);
        config.setForegroundFPS(60);
        config.disableAudio(true);
        new Lwjgl3Application(new Aplicacao(jogo), config);
    }
}
