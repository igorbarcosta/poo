package br.edu.ifpb.jogos.base;

/** Coordenadas lógicas: 960 x 720, origem no canto inferior esquerdo. */
public interface Tela {
    int LARGURA = 960;
    int ALTURA = 720;

    void retangulo(double x, double y, double largura, double altura, Cor cor);

    void circulo(double x, double y, double raio, Cor cor);

    void triangulo(double x1, double y1, double x2, double y2,
                   double x3, double y3, Cor cor);

    void texto(String texto, double x, double y, double escala, Cor cor);
}
