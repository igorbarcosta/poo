package br.edu.ifpb.jogos.exemplos.chaveporta.modelo;

/** Um único objeto só pode ser recolhido uma vez. */
public class Chave {
    private boolean disponivel = true;

    public boolean tentarColetar(Jogador jogador) {
        if (!disponivel || !jogador.sobrepoe(270, 338, 24, 24)) {
            return false;
        }
        disponivel = false;
        jogador.receberChave();
        return true;
    }

    public boolean isDisponivel() { return disponivel; }
}
