package br.edu.ifpb.jogos.base;

public enum Cor {
    FUNDO(0x080F21),
    PAINEL(0x111E35),
    LINHA(0x233650),
    BRANCO(0xE6EEF8),
    CINZA(0xAABAD0),
    CIANO(0x62EAD5),
    AZUL(0x5697F5),
    LARANJA(0xFFAD66),
    VERMELHO(0xFF667E);

    private final int rgb;

    Cor(int rgb) {
        this.rgb = rgb;
    }

    public int getRgb() {
        return rgb;
    }
}
