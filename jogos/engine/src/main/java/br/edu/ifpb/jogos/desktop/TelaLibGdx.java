package br.edu.ifpb.jogos.desktop;

import br.edu.ifpb.jogos.base.Cor;
import br.edu.ifpb.jogos.base.Tela;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Texture.TextureFilter;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.freetype.FreeTypeFontGenerator;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.utils.Disposable;
import com.badlogic.gdx.utils.viewport.FitViewport;

import java.util.HashMap;
import java.util.Map;

/** Adaptador gráfico: nenhum tipo de libGDX vaza para a API dos jogos. */
class TelaLibGdx implements Tela, Disposable {
    private final ShapeRenderer formas = new ShapeRenderer();
    private final SpriteBatch lote = new SpriteBatch();
    private final FreeTypeFontGenerator gerador = new FreeTypeFontGenerator(
            Gdx.files.classpath("fontes/DejaVuSans.ttf"));
    private final Map<Integer, BitmapFont> fontes = new HashMap<>();
    private final FitViewport viewport;
    private float escalaPixels;
    private boolean desenhandoFormas;
    private boolean desenhandoTexto;

    TelaLibGdx(FitViewport viewport) {
        this.viewport = viewport;
    }

    boolean iniciar() {
        float novaEscala = EscalaDaTela.calcular(Gdx.graphics.getWidth(), Gdx.graphics.getHeight(),
                Gdx.graphics.getBackBufferWidth(), Gdx.graphics.getBackBufferHeight(),
                viewport.getScreenWidth(), viewport.getWorldWidth());
        if (novaEscala == 0) {
            return false;
        }
        formas.setProjectionMatrix(viewport.getCamera().combined);
        lote.setProjectionMatrix(viewport.getCamera().combined);
        // O framebuffer pode ter mais pixels que a janela em monitores HiDPI.
        if (Float.compare(novaEscala, escalaPixels) != 0) {
            liberarFontes();
            escalaPixels = novaEscala;
        }
        return true;
    }

    private void prepararForma(Cor cor) {
        if (desenhandoTexto) {
            lote.end();
            desenhandoTexto = false;
        }

        if (!desenhandoFormas) {
            formas.begin(ShapeRenderer.ShapeType.Filled);
            desenhandoFormas = true;
        }

        int rgb = cor.getRgb();
        formas.setColor(
                (rgb >> 16 & 255) / 255f,
                (rgb >> 8 & 255) / 255f,
                (rgb & 255) / 255f,
                1);
    }

    @Override
    public void retangulo(double x, double y, double largura, double altura, Cor cor) {
        prepararForma(cor);
        formas.rect((float) x, (float) y, (float) largura, (float) altura);
    }

    @Override
    public void circulo(double x, double y, double raio, Cor cor) {
        prepararForma(cor);
        formas.circle((float) x, (float) y, (float) raio);
    }

    @Override
    public void triangulo(double x1, double y1, double x2, double y2,
                          double x3, double y3, Cor cor) {
        prepararForma(cor);
        formas.triangle(
                (float) x1, (float) y1,
                (float) x2, (float) y2,
                (float) x3, (float) y3);
    }

    @Override
    public void texto(String texto, double x, double y, double escala, Cor cor) {
        if (desenhandoFormas) {
            formas.end();
            desenhandoFormas = false;
        }

        if (!desenhandoTexto) {
            lote.begin();
            desenhandoTexto = true;
        }

        int tamanho = EscalaDaTela.tamanhoFonte(escala, escalaPixels);
        BitmapFont fonte = fontes.computeIfAbsent(tamanho, this::criarFonte);
        int rgb = cor.getRgb();
        fonte.setColor(
                (rgb >> 16 & 255) / 255f,
                (rgb >> 8 & 255) / 255f,
                (rgb & 255) / 255f,
                1);
        fonte.getData().setScale((float) (20 * escala / tamanho));
        fonte.draw(lote, texto, (float) x, (float) y);
    }

    private BitmapFont criarFonte(int tamanho) {
        var parametros = new FreeTypeFontGenerator.FreeTypeFontParameter();
        parametros.size = tamanho;
        parametros.minFilter = TextureFilter.Linear;
        parametros.magFilter = TextureFilter.Linear;
        BitmapFont fonte = gerador.generateFont(parametros);
        fonte.setUseIntegerPositions(false);
        return fonte;
    }

    private void liberarFontes() {
        fontes.values().forEach(BitmapFont::dispose);
        fontes.clear();
    }

    void terminar() {
        if (desenhandoFormas) {
            formas.end();
            desenhandoFormas = false;
        }

        if (desenhandoTexto) {
            lote.end();
            desenhandoTexto = false;
        }
    }

    @Override
    public void dispose() {
        formas.dispose();
        lote.dispose();
        liberarFontes();
        gerador.dispose();
    }
}
