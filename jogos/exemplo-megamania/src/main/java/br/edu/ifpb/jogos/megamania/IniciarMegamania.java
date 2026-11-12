package br.edu.ifpb.jogos.megamania;

import br.edu.ifpb.jogos.desktop.Janela;

/** Exemplo para consulta, executado na mesma engine do projeto inicial. */
public class IniciarMegamania {
    public static void main(String[] args) {
        Janela.abrir(new JogoMegamania());
    }
}
