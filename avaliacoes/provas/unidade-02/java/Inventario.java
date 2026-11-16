import java.util.ArrayList;
import java.util.List;

public class Inventario {
    private List<Item> itens;

    public Inventario() {
        itens = new ArrayList<>();
    }

    public void adicionar(Item item) {
        itens.add(item);
    }

    public Item obter(int indice) {
        return itens.get(indice);
    }

    public void listar() {
        for (Item item : itens) {
            System.out.println(
                item.descrever());
        }
    }
}
