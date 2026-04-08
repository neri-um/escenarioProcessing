class Gallinero {
  float x1, x2, cx;
  float baseY = 520;
  float altEdificio = 138;
  float anchoEdificio = 158;

  Gallinero(float a, float b) { x1=a; x2=b; cx=(a+b)/2.0; }

  void dibujar() {
    float top = baseY - altEdificio;

    // Suelo propio, igual que el Establo
fill(128, 168, 98); noStroke(); rect(x1+50, baseY, x2-x1, 155);

    // Arbusto ENCIMA del suelo, ANTES del edificio
    dibujarArbusto(x2 - 10, baseY);
    
    fill(228,198,118); rect(cx-anchoEdificio/2, top, anchoEdificio, altEdificio);
    for (float bx = cx-anchoEdificio/2+8; bx < cx+anchoEdificio/2; bx += 18) { fill(208,172,98, 150); rect(bx, top, 4, altEdificio); fill(250,220,140, 100); rect(bx+4, top, 2, altEdificio); }
    
    fill(198,108,48); triangle(cx-anchoEdificio/2-14, top, cx+anchoEdificio/2+14, top, cx, top-72);
    fill(178,88,32); rect(cx-anchoEdificio/2-14, top-5, anchoEdificio+28, 9, 3);
    
    fill(158,72,25);
    for (int i = 0; i < 5; i++) { float tx = cx - anchoEdificio/2 - 8 + i*36; arc(tx+18, top-5, 36, 18, PI, TWO_PI); fill(255,255,255,20); arc(tx+18, top-5, 30, 12, PI, TWO_PI); fill(158,72,25); }
    
    fill(138,58,18); rect(cx-4, top-70, 8, 73, 3);
    dibujarGallo(cx, top-72);
    
    fill(198,162,88); rect(cx-anchoEdificio/2, top+altEdificio*0.55, anchoEdificio, 8);
    
    fill(108,68,22); rect(cx-18, baseY-60, 36, 60, 6,6,0,0); 
    fill(138,88,38); rect(cx-14, baseY-56, 28, 56, 4,4,0,0); 
    fill(118,68,18); rect(cx-2, baseY-56, 4, 56); 
    fill(240,200,80); ellipse(cx+8, baseY-28, 6, 6); 
    fill(255,255,255,150); ellipse(cx+7, baseY-29, 2, 2); 

    dibujarVentanaRedonda(cx-50, top+32, 26); dibujarVentanaRedonda(cx+50, top+32, 26);
    
    stroke(118,78,32); strokeWeight(4); strokeCap(ROUND); line(cx-65, top+64, cx-25, top+64); line(cx+25, top+64, cx+65, top+64); noStroke();

    dibujarVallaFrontal(x1, x2);
  }

  void dibujarGallo(float gx, float gy) { float ang = sin(frameCount*0.015)*0.5; pushMatrix(); translate(gx, gy); stroke(80,80,80); strokeWeight(3); line(0,0,0,-28); noStroke(); rotate(ang); fill(205,52,32); ellipse(8,-8,20,16); triangle(0,-8,-14,-2,-10,-16); ellipse(18,-14,12,12); fill(225,185,42); triangle(22,-14,28,-12,22,-10); fill(255); ellipse(19,-15, 4, 4); fill(20); ellipse(19.5,-15, 2, 2); popMatrix(); }
  void dibujarVentanaRedonda(float wx, float wy, float r) { fill(88,52,18); ellipse(wx, wy, r+10, r+10); fill(0,0,0,40); ellipse(wx, wy, r+4, r+4); fill(150,210,240); ellipse(wx, wy, r, r); fill(255,255,255,90); arc(wx, wy, r, r, PI, PI+HALF_PI); fill(88,52,18); rect(wx-r/2, wy-2, r, 4); rect(wx-2, wy-r/2, 4, r); }

  void dibujarArbusto(float bx, float by) {
    fill(82, 130, 70); noStroke();
    ellipse(bx, by - 5, 55, 45); ellipse(bx - 20, by + 5, 45, 35); ellipse(bx + 20, by + 5, 45, 35);
    fill(102, 150, 80);
    ellipse(bx, by - 10, 35, 25); ellipse(bx - 15, by, 25, 20); ellipse(bx + 15, by, 25, 20);
  }
  
  void dibujarVallaFrontal(float xa, float xb) { 
    fill(245, 240, 230); rect(xa, 680, xb - xa, 6); fill(210, 205, 195); rect(xa, 686, xb - xa, 2); 
    fill(245, 240, 230); rect(xa, 692, xb - xa, 6); fill(210, 205, 195); rect(xa, 698, xb - xa, 2); 
    for (float px = 5; px < width; px += 35) { 
      if (px >= xa && px <= xb) {
        fill(255, 250, 240); rect(px - 5, 672, 10, 30, 2); triangle(px - 5, 672, px, 665, px + 5, 672); fill(0, 0, 0, 15); rect(px + 2, 672, 3, 30, 2); 
      }
    } 
  }
}
