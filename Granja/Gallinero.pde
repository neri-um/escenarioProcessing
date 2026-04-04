class Gallinero {
  float x1, x2, cx;
  float baseY = 520;
  float altEdificio = 138;
  float anchoEdificio = 158;

  Gallinero(float a, float b) { x1=a; x2=b; cx=(a+b)/2.0; }

  void dibujar() {
    float top = baseY - altEdificio;
    fill(138,182,108); noStroke(); rect(x1, baseY, x2-x1, 180);
    fill(0,0,0,15);    noStroke(); ellipse(cx+5, baseY+6, anchoEdificio+10, 9);
    fill(228,198,118); noStroke(); rect(cx-anchoEdificio/2, top, anchoEdificio, altEdificio);
    fill(198,108,48);  noStroke();
    triangle(cx-anchoEdificio/2-12, top, cx+anchoEdificio/2+12, top, cx, top-68);
    fill(178,88,32);   noStroke(); rect(cx-anchoEdificio/2-12, top-5, anchoEdificio+24, 9, 2);
    // Tejas
    fill(158,72,25); noStroke();
    for (int i = 0; i < 5; i++) {
      float tx = cx - anchoEdificio/2 - 8 + i*36;
      arc(tx+18, top-5, 36, 18, PI, TWO_PI);
    }
    fill(138,58,18); noStroke(); rect(cx-5, top-70, 10, 73, 3);
    dibujarGallo(cx, top-72);
    fill(198,162,88); noStroke(); rect(cx-anchoEdificio/2, top+altEdificio*0.55, anchoEdificio, 7);
    // Tablones
    fill(208,172,98,120); noStroke();
    for (float bx = cx-anchoEdificio/2+8; bx < cx+anchoEdificio/2-8; bx += 22)
      rect(bx, top, 3, altEdificio);
    // Puerta
    fill(138,88,38); noStroke();
    rect(cx-16, baseY-58, 32, 58, 4,4,0,0);
    arc(cx, baseY-58, 32, 26, PI, TWO_PI);
    stroke(108,68,22); strokeWeight(2); noFill();
    rect(cx-16, baseY-58, 32, 58, 4,4,0,0);
    arc(cx, baseY-58, 32, 26, PI, TWO_PI);
    fill(205,165,65); noStroke(); ellipse(cx+8, baseY-30, 5,5);
    // Ventanas redondas — coordenadas fijas respecto a cx
    dibujarVentanaRedonda(cx-55, top+32, 24);
    dibujarVentanaRedonda(cx+55, top+32, 24);
    // Perchas
    stroke(138,98,42); strokeWeight(2);
    line(cx-70, top+62, cx-30, top+62);
    line(cx+30, top+62, cx+70, top+62);

    // Valla propia zona derecha
    dibujarValla(x1, x2);
    dibujarPosteVertical(x1);
  }

  void dibujarValla(float xa, float xb) {
    fill(228,225,212); noStroke();
    for (float px = xa+6; px < xb-6; px += 34)
      rect(px, 674, 7, 26, 2);
    rect(xa, 680, xb-xa, 5, 2);
    rect(xa, 690, xb-xa, 5, 2);
  }

  void dibujarGallo(float gx, float gy) {
    float ang = sin(frameCount*0.015)*0.7;
    pushMatrix(); translate(gx, gy);
    stroke(80,80,80); strokeWeight(2); line(0,0,0,-28);
    rotate(ang);
    fill(205,52,32); noStroke(); ellipse(8,-8,18,14);
    fill(205,52,32); triangle(0,-8,-12,-2,-10,-14);
    fill(205,52,32); ellipse(16,-12,10,9);
    fill(225,72,42);
    triangle(14,-16,16,-20,18,-16);
    triangle(16,-17,18,-21,20,-17);
    fill(225,185,42); triangle(20,-12,25,-11,20,-10);
    fill(20); ellipse(17,-13,3,3);
    popMatrix();
  }

  void dibujarVentanaRedonda(float wx, float wy, float r) {
    fill(88,52,18);       noStroke(); ellipse(wx, wy, r+8, r+8);
    fill(178,218,238,215);            ellipse(wx, wy, r,   r);
    fill(88,52,18);
    rect(wx-r/2, wy-1.5, r, 3);
    rect(wx-1.5, wy-r/2, 3, r);
    fill(255,255,255,85); arc(wx-r*0.15, wy-r*0.15, r*0.45, r*0.45, PI+QUARTER_PI, TWO_PI);
  }
  void dibujarPosteVertical(float px) {
  fill(215,210,195); noStroke();
  rect(px-6, 440, 12, 270, 3);
  rect(px-14, 465, 28, 6, 2);
  rect(px-14, 490, 28, 6, 2);
  rect(px-14, 520, 28, 6, 2);
}

}
