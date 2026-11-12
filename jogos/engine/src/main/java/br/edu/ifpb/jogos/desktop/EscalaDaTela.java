package br.edu.ifpb.jogos.desktop;

/** Cálculos da infraestrutura, sem depender da criação de uma janela. */
final class EscalaDaTela {
    private EscalaDaTela() {
    }

    static boolean disponivel(int largura, int altura, int pixelsLargura, int pixelsAltura) {
        return largura > 0 && altura > 0 && pixelsLargura > 0 && pixelsAltura > 0;
    }

    static float calcular(int largura, int altura, int pixelsLargura, int pixelsAltura,
                          int larguraViewport, float larguraMundo) {
        if (!disponivel(largura, altura, pixelsLargura, pixelsAltura)
                || larguraViewport <= 0 || !Float.isFinite(larguraMundo) || larguraMundo <= 0) {
            return 0;
        }
        float escala = (float) ((double) larguraViewport / larguraMundo * pixelsLargura / largura);
        return Float.isFinite(escala) && escala > 0 ? escala : 0;
    }

    static int tamanhoFonte(double escala, float pixelsPorUnidade) {
        // Mesmo um viewport muito pequeno precisa de glifos rasterizáveis.
        return Math.max(8, (int) Math.round(20 * escala * pixelsPorUnidade));
    }
}
