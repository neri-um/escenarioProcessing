class Establo {
  float x1, x2, cx;
  float baseY = 520;
  float altEdificio = 170;
  float anchoEdificio = 210;  // ← más ancho

  Establo(float a, float b) { x1=a; x2=b; cx=(a+b)/2.0; }

  void dibujar() {
    float top = baseY - altEdificio;
    // Suelo zona
    fill(128,172,100); noStroke(); rect(x1, baseY, x2-x1, 180);
    // Sombra
    fill(0,0,0,18); noStroke(); ellipse(cx+7, baseY+7, anchoEdificio+16, 11);
    // Cuerpo — verde oscuro azulado
    fill(72,108,88); noStroke(); rect(cx-anchoEdificio/2, top, anchoEdificio, altEdificio);
    // Listones de madera horizontales decorativos
    fill(62,95,76); noStroke();
    for (int i = 1; i < 6; i++)
      rect(cx-anchoEdificio/2, top + i*(altEdificio/6), anchoEdificio, 4);
    // Tejado — más bajo y ancho, color pizarra
    fill(88,98,108); noStroke();
    triangle(cx-anchoEdificio/2-18, top, cx+anchoEdificio/2+18, top, cx, top-70);
    fill(72,82,92); noStroke();
    rect(cx-anchoEdificio/2-18, top-6, anchoEdificio+36, 10, 2);
    // Tejas en tejado
    fill(60,70,80); noStroke();
    for (int i = 0; i < 7; i++) {
      float tx = cx - anchoEdificio/2 - 14 + i*38;
      arc(tx+19, top-6, 38, 16, PI, TWO_PI);
    }
    // Cumbrera
    fill(48,58,68); noStroke(); rect(cx-6, top-73, 12, 76, 4);
    dibujarVeleta(cx, top-75);
    // Franja blanca decorativa
    fill(200,215,205); noStroke();
    rect(cx-anchoEdificio/2, top+altEdificio*0.52, anchoEdificio, 7);
 // Puerta doble — las hojas se tocan en cx
fill(42,28,14); noStroke();
rect(cx-40, baseY-105, 40, 105, 4,4,0,0);  // hoja izquierda: de cx-40 a cx
rect(cx,    baseY-105, 40, 105, 4,4,0,0);  // hoja derecha:  de cx a cx+40
fill(30,18,6); arc(cx, baseY-105, 80, 52, PI, TWO_PI);
stroke(55,38,18); strokeWeight(2);
// Travesaño horizontal de cada hoja
line(cx-40, baseY-52, cx,    baseY-52);
line(cx,    baseY-52, cx+40, baseY-52);
// División central vertical de cada hoja
line(cx-20, baseY-105, cx-20, baseY);
line(cx+20, baseY-105, cx+20, baseY);
// Línea de cierre central
line(cx, baseY-105, cx, baseY);
// Pomos
fill(185,155,60); noStroke();
ellipse(cx-5, baseY-52, 8,8);
ellipse(cx+5, baseY-52, 8,8);
    // Ventanas — grandes y cuadradas, bien simétricas
    dibujarVentana(cx-95, top+28, 40, 36);
    dibujarVentana(cx+55, top+28, 40, 36);

    // Valla horizontal
    dibujarValla(x1, x2);
    // Valla vertical derecha (separador con granero)
    dibujarPosteVertical(x2);
  }

  void dibujarValla(float xa, float xb) {
    fill(228,225,212); noStroke();
    for (float px = xa+6; px < xb-6; px += 34)
      rect(px, 674, 7, 26, 2);
    rect(xa, 680, xb-xa, 5, 2);
    rect(xa, 690, xb-xa, 5, 2);
  }

  void dibujarPosteVertical(float px) {
    fill(215,210,195); noStroke();
    rect(px-6, baseY-80, 12, 270, 3);
    // Travesaños
    rect(px-14, baseY-55, 28, 6, 2);
    rect(px-14, baseY-30, 28, 6, 2);
    rect(px-14, baseY+5,  28, 6, 2);
  }

  void dibujarVeleta(float vx, float vy) {
    stroke(85,85,85); strokeWeight(2);
    line(vx,vy,vx,vy-36); line(vx-18,vy-22,vx+18,vy-22);
    fill(205,178,48); noStroke();
    float g = sin(frameCount*0.012)*0.9;
    pushMatrix(); translate(vx,vy-22); rotate(g);
    triangle(-16,-5,16,0,-16,5); popMatrix();
    fill(205,52,32); noStroke(); ellipse(vx,vy-38,11,9);
    triangle(vx,vy-43,vx-5,vy-49,vx+5,vy-49);
  }

  void dibujarVentana(float wx, float wy, float w, float h) {
    fill(50,75,60);       noStroke(); rect(wx-4, wy-4, w+8, h+8, 5);
    fill(168,212,232,215);            rect(wx,   wy,   w,   h,   3);
    fill(50,75,60);
    rect(wx + w/2-1.5, wy,         3, h);
    rect(wx,           wy+h/2-1.5, w, 3);
    fill(255,255,255,85); rect(wx+2, wy+2, w/2-5, h/2-5, 2);
  }
}
