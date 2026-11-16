package br.edu.ifpb.jogos.desktop;

import br.edu.ifpb.jogos.base.Jogo;
import br.edu.ifpb.jogos.base.Tela;
import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input.Keys;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.utils.viewport.FitViewport;

/** Infraestrutura entregue pronta: ciclo gráfico e limite de tempo por quadro. */
class Aplicacao extends ApplicationAdapter {
    private final Jogo jogo;
    private final Teclado teclado = new Teclado();
    private FitViewport viewport;
    private TelaLibGdx tela;
    private int larguraJanela;
    private int alturaJanela;

    Aplicacao(Jogo jogo) {
        this.jogo = jogo;
    }

    @Override
    public void create() {
        viewport = new FitViewport(Tela.LARGURA, Tela.ALTURA);
        tela = new TelaLibGdx(viewport);
    }

    @Override
    public void render() {
        if (Gdx.input.isKeyJustPressed(Keys.ESCAPE)) {
            Gdx.app.exit();
        }

        if (Gdx.input.isKeyJustPressed(Keys.F11)) {
            alternarTelaCheia();
        }

        // Descartar o excesso evita saltos depois de arrastar/minimizar a janela.
        jogo.atualizar(Math.min(Gdx.graphics.getDeltaTime(), 1.0 / 30), teclado);

        Gdx.gl.glClearColor(0.03f, 0.05f, 0.10f, 1);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        viewport.apply();
        tela.iniciar();
        jogo.desenhar(tela);
        tela.terminar();
    }

    private void alternarTelaCheia() {
        if (Gdx.graphics.isFullscreen()) {
            Gdx.graphics.setWindowedMode(larguraJanela, alturaJanela);
        } else {
            larguraJanela = Gdx.graphics.getWidth();
            alturaJanela = Gdx.graphics.getHeight();
            Gdx.graphics.setFullscreenMode(Gdx.graphics.getDisplayMode());
        }
    }

    @Override
    public void resize(int largura, int altura) {
        viewport.update(largura, altura, true);
    }

    @Override
    public void dispose() {
        tela.dispose();
    }
}
