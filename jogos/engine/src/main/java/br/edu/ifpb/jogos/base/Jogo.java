package br.edu.ifpb.jogos.base;

/** Ponto de integração de qualquer jogo com a janela fornecida. */
public interface Jogo {
    String getTitulo();

    void atualizar(double segundos, Entrada entrada);

    void desenhar(Tela tela);
}
