class Establo {
  float x1, x2, cx;
  float baseY = 520;
  float altEdificio = 170;
  float anchoEdificio = 210;

  Establo(float a, float b) { x1=a; x2=b; cx=(a+b)/2.0; }

  void dibujar() {
    float top = baseY - altEdificio;

    fill(128,172,100); noStroke(); rect(x1, baseY, x2-x1, 180);

    
    fill(72,108,88); rect(cx-anchoEdificio/2, top, anchoEdificio, altEdificio);
    for (float y = top; y < baseY; y += 14) { fill(62,95,76); rect(cx-anchoEdificio/2, y, anchoEdificio, 3); fill(82,120,98); rect(cx-anchoEdificio/2, y+12, anchoEdificio, 2); }
    
    fill(88,98,108); triangle(cx-anchoEdificio/2-20, top, cx+anchoEdificio/2+20, top, cx, top-75);
    fill(72,82,92); rect(cx-anchoEdificio/2-20, top-8, anchoEdificio+40, 12, 4); 
    
    fill(60,70,80);
    float anchoTeja = (anchoEdificio + 40) / 6.0; 
    for (int i = 0; i < 6; i++) { 
      float tx = cx - (anchoEdificio/2) - 20 + (i * anchoTeja);
      arc(tx + (anchoTeja/2), top-8, anchoTeja, 18, PI, TWO_PI);
      fill(255,255,255,15); arc(tx + (anchoTeja/2), top-8, anchoTeja-6, 12, PI, TWO_PI); fill(60,70,80); 
    }
    
    fill(48,58,68); rect(cx-6, top-78, 12, 82, 4);
    dibujarVeleta(cx, top-80);
    
    fill(210,225,215); rect(cx-anchoEdificio/2, top+altEdificio*0.52, anchoEdificio, 8);
    fill(0,0,0,15); rect(cx-anchoEdificio/2, top+altEdificio*0.52+8, anchoEdificio, 3);
    
    fill(35,22,12); rect(cx-44, baseY-105, 44, 105, 6,0,0,0); rect(cx, baseY-105, 44, 105, 0,6,0,0);
    fill(25,12,5); arc(cx, baseY-105, 88, 56, PI, TWO_PI);
    
    stroke(55,38,18); strokeWeight(4);
    line(cx-40, baseY-80, cx-4, baseY-20); line(cx+4, baseY-20, cx+40, baseY-80); 
    line(cx-40, baseY-20, cx-4, baseY-80); line(cx+4, baseY-80, cx+40, baseY-20); line(cx, baseY-105, cx, baseY); 
    noStroke();
    
    fill(200,170,70); ellipse(cx-8, baseY-52, 10,10); ellipse(cx+8, baseY-52, 10,10);
    fill(255,255,255,150); ellipse(cx-9, baseY-53, 3,3); ellipse(cx+7, baseY-53, 3,3);
    
    dibujarVentana(cx-75, top+32, 44, 40); dibujarVentana(cx+75, top+32, 44, 40);

    dibujarVallaSeparadora(460);
    dibujarVallaFrontal(x1, x2);
  }

  void dibujarVeleta(float vx, float vy) { stroke(75,75,75); strokeWeight(3); strokeCap(ROUND); line(vx,vy,vx,vy-38); line(vx-20,vy-23,vx+20,vy-23); noStroke(); fill(215,188,58); float g = sin(frameCount*0.012)*0.7; pushMatrix(); translate(vx,vy-23); rotate(g); triangle(-18,-5,18,0,-18,5); popMatrix(); fill(205,52,32); ellipse(vx,vy-41,13,13); }
  void dibujarVentana(float wx, float wy, float w, float h) { fill(40,60,50); rect(wx-w/2-6, wy-h/2-6, w+12, h+12, 6); fill(0,0,0,30); rect(wx-w/2-2, wy-h/2-2, w+4, h+4, 3); fill(150,210,240); rect(wx-w/2, wy-h/2, w, h, 3); fill(255,255,255,90); triangle(wx-w/2, wy-h/2, wx, wy-h/2, wx-w/2, wy); fill(40,60,50); rect(wx-2, wy-h/2, 4, h); rect(wx-w/2, wy-2, w, 4); }
  
  void dibujarVallaFrontal(float xa, float xb) { 
    fill(245, 240, 230); rect(xa, 680, xb - xa, 6); fill(210, 205, 195); rect(xa, 686, xb - xa, 2); 
    fill(245, 240, 230); rect(xa, 692, xb - xa, 6); fill(210, 205, 195); rect(xa, 698, xb - xa, 2); 
    for (float px = 5; px < width; px += 35) { 
      if (px >= xa && px < xb) {
        fill(255, 250, 240); rect(px - 5, 672, 10, 30, 2); triangle(px - 5, 672, px, 665, px + 5, 672); fill(0, 0, 0, 15); rect(px + 2, 672, 3, 30, 2); 
      }
    } 
  }

  void dibujarVallaSeparadora(float px) {
    fill(235, 230, 220); rect(px - 3, 530, 6, 145);
    for (float y = 530; y <= 660; y += 30) {
      fill(255, 250, 240); rect(px - 5, y, 10, 24, 2); triangle(px - 5, y, px, y - 6, px + 5, y); 
      fill(0, 0, 0, 15); rect(px + 1, y, 4, 24, 2); 
      fill(245, 240, 230); rect(px - 8, y + 8, 16, 5, 1); 
    }
  }

  void dibujarArbusto(float bx, float by) {
    fill(82, 130, 70); noStroke();
    ellipse(bx, by - 5, 55, 45); ellipse(bx - 20, by + 5, 45, 35); ellipse(bx + 20, by + 5, 45, 35);
    fill(102, 150, 80);
    ellipse(bx, by - 10, 35, 25); ellipse(bx - 15, by, 25, 20); ellipse(bx + 15, by, 25, 20);
  }
}
