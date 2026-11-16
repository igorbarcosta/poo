package br.edu.ifpb.jogos.desktop;

import br.edu.ifpb.jogos.base.Jogo;
import br.edu.ifpb.jogos.base.Tela;
import br.edu.ifpb.jogos.megamania.JogoMegamania;
import br.edu.ifpb.jogos.meujogo.MeuJogo;
import com.badlogic.gdx.backends.lwjgl3.Lwjgl3Application;
import com.badlogic.gdx.backends.lwjgl3.Lwjgl3ApplicationConfiguration;

public class Principal {
    public static void main(String[] args) {
        Jogo jogo;
        if (args.length == 0) {
            jogo = new JogoMegamania();
        } else if (args.length == 1 && args[0].equals("base")) {
            jogo = new MeuJogo();
        } else {
            System.err.println("Use sem argumentos para Megamania ou 'base' para MeuJogo.");
            return;
        }

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
