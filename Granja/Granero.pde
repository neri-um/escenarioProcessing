class Granero {
  float gx1, gx2, gcx;
  float baseY = 520;

  Granero(float a, float b) { this.gx1 = a; this.gx2 = b; this.gcx = (a+b)/2.0; }

  void dibujar() {
    float top = baseY - 200;

    fill(158,42,32); rect(gcx-112, top, 224, 200);
    for (float px = gcx-112+8; px < gcx+112; px+=16) {
      fill(138,28,18, 100); rect(px, top, 3, 200);
      fill(180,60,50, 80);  rect(px+3, top, 2, 200);
    }

    fill(172,108,72);
    quad(gcx-128, top, gcx+128, top, gcx+80, top-70, gcx-80, top-70);
    triangle(gcx-80, top-70, gcx+80, top-70, gcx, top-115);
    fill(148,88,55); rect(gcx-128, top-6, 256, 12, 4); 
    fill(122,68,38); rect(gcx-6, top-118, 12, 122, 4); 

    veleta(gcx, top-115);

    fill(122,28,18); rect(gcx-112, top+90, 224, 10);

    win(gcx-65, top+45, 38, 38);
    win(gcx+65, top+45, 38, 38);

    fill(55,28,15); ellipse(gcx, top-45, 52, 52);
    fill(0,0,0,40); ellipse(gcx, top-45, 46, 46);
    fill(150,210,240); ellipse(gcx, top-45, 40, 40);
    fill(255,255,255,90); arc(gcx, top-45, 40, 40, PI, PI+HALF_PI); 
    fill(55,28,15); rect(gcx-20, top-47, 40, 4); rect(gcx-2, top-65, 4, 40);

    fill(28,14,3); arc(gcx, baseY-108, 76, 56, PI, TWO_PI);
    fill(45,22,10); rect(gcx-38, baseY-108, 38, 108, 6,0,0,0); rect(gcx, baseY-108, 38, 108, 0,6,0,0);
    
    stroke(25,10,5); strokeWeight(4);
    line(gcx-38, baseY-100, gcx-4, baseY-10); line(gcx-38, baseY-10, gcx-4, baseY-100);
    line(gcx+4, baseY-100, gcx+38, baseY-10); line(gcx+4, baseY-10, gcx+38, baseY-100);
    noStroke();
    
    fill(208,172,80); ellipse(gcx-8, baseY-54, 8,8); ellipse(gcx+8, baseY-54, 8,8);
    fill(255,255,255,150); ellipse(gcx-9, baseY-55, 3,3); ellipse(gcx+7, baseY-55, 3,3);
    
    stroke(102,22,12); strokeWeight(6); noFill();
    arc(gcx, baseY-108, 76, 56, PI, TWO_PI);
    line(gcx-38, baseY, gcx-38, baseY-108); line(gcx+38, baseY, gcx+38, baseY-108);
    noStroke();
    
    dibujarVallaSeparadora(740);
    dibujarVallaFrontal(gx1, gx2);
    
    float menuX = gcx + 75; 
    float menuY = baseY - 70; 
    fill(138, 88, 38); rect(menuX - 25, menuY - 15, 50, 30, 4); 
    fill(240, 220, 180); rect(menuX - 22, menuY - 12, 44, 24, 2); 
    fill(80, 40, 20); textSize(12); textAlign(CENTER, CENTER); text("MENU", menuX, menuY - 2);
  }

  boolean clickCartel(float mx, float my) {
    float menuX = gcx + 75; float menuY = baseY - 70;
    return (mx > menuX - 25 && mx < menuX + 25 && my > menuY - 15 && my < menuY + 15);
  }

  void win(float wx, float wy, float w, float h) { fill(55,28,15); rect(wx-w/2-6, wy-h/2-6, w+12, h+12, 6); fill(0,0,0,30); rect(wx-w/2-2, wy-h/2-2, w+4, h+4, 3); fill(150,210,240); rect(wx-w/2, wy-h/2, w, h, 3); fill(255,255,255,90); triangle(wx-w/2, wy-h/2, wx, wy-h/2, wx-w/2, wy); fill(55,28,15); rect(wx-2, wy-h/2, 4, h); rect(wx-w/2, wy-2, w, 4); }
  
  void veleta(float vx, float vy) { stroke(75,75,75); strokeWeight(3); strokeCap(ROUND); line(vx,vy,vx,vy-38); line(vx-20,vy-23,vx+20,vy-23); noStroke(); fill(218,192,65); float g = sin(frameCount*0.01)*0.6; pushMatrix(); translate(vx,vy-23); rotate(g); triangle(-16,-4,16,0,-16,4); popMatrix(); fill(208,55,35); ellipse(vx,vy-41,12,12); }
  
  void dibujarVallaFrontal(float xa, float xb) {
    float caminoIzq = 530;
    float caminoDer = 670;
    
    fill(245, 240, 230); rect(xa, 680, caminoIzq - xa, 6); fill(210, 205, 195); rect(xa, 686, caminoIzq - xa, 2);
    fill(245, 240, 230); rect(xa, 692, caminoIzq - xa, 6); fill(210, 205, 195); rect(xa, 698, caminoIzq - xa, 2);
    
    fill(245, 240, 230); rect(caminoDer, 680, xb - caminoDer, 6); fill(210, 205, 195); rect(caminoDer, 686, xb - caminoDer, 2);
    fill(245, 240, 230); rect(caminoDer, 692, xb - caminoDer, 6); fill(210, 205, 195); rect(caminoDer, 698, xb - caminoDer, 2);
    
    for (float px = xa + 5; px < xb; px += 35) {
      if (px > caminoIzq - 5 && px < caminoDer) continue;
      fill(255, 250, 240); rect(px - 5, 672, 10, 30, 2);
      triangle(px - 5, 672, px, 665, px + 5, 672);
      fill(0, 0, 0, 15); rect(px + 2, 672, 3, 30, 2);
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
}
