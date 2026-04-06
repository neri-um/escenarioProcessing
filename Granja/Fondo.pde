class Fondo {
  float[] nubX = new float[4];
  float[] nubY = new float[4];
  float[] nubV = new float[4];
  float[] nubW = new float[4];

  color fondoColor  = color(168, 198, 168);
  color sueloColor  = color(128, 168, 98);
  color tierraColor = color(158, 118, 78);

  Fondo() {
    for (int i = 0; i < 4; i++) {
      nubX[i] = random(width);
      nubY[i] = random(45, 120);
      nubV[i] = random(0.12, 0.35);
      nubW[i] = random(110, 220);
    }
  }

  void dibujar() {
    // Cielo degradado
    for (int i = 0; i < 520; i++) {
      float t = i / 520.0;
      stroke(lerpColor(color(148, 198, 218), color(188, 215, 188), t));
      line(0, i, width, i);
    }
    noStroke();

    // Nubes
    for (int i = 0; i < 4; i++) {
      nubX[i] += nubV[i];
      if (nubX[i] > width + 160) nubX[i] = -160;
      dibujarNube(nubX[i], nubY[i], nubW[i]);
    }

    // Colinas de fondo
    fill(118, 158, 88, 160); noStroke();
    ellipse(180,  535, 420, 110);
    ellipse(600,  540, 500, 120);
    ellipse(1020, 535, 400, 105);

    // Suelo verde
    fill(128, 168, 98); noStroke();
    rect(0, 520, width, 180);
    // Borde superior suelo
    fill(108, 148, 78);
    rect(0, 520, width, 6);


    dibujarZonaVerde(0, 240);

dibujarZonaVerde(960, 1200);  


    // Tierra
    fill(tierraColor); noStroke();
    rect(0, 700, width, 100);

    // Textura tierra
    stroke(132, 95, 55, 90); strokeWeight(1.5);
    for (int i = 0; i < 28; i++) {
      float sx = noise(i*14.2)*width;
      float sy = 715 + noise(i*6.3)*60;
      if (sx > width/2-38 && sx < width/2+38) continue;
      line(sx, sy, sx+noise(i*8.1)*65+20, sy);
    }

    // Camino central
    fill(178, 142, 100); noStroke();
    rect(width/2-28, 520, 56, height-520);
    fill(158, 122, 80);
    rect(width/2-28, 520, 4, height-520);
    rect(width/2+24, 520, 4, height-520);
    fill(195, 168, 122); noStroke();
    for (int i = 0; i < 11; i++) {
      float py = 536+i*26;
      ellipse(width/2-7, py, 16, 8);
      ellipse(width/2+9, py+13, 13, 7);
    }

    // Hierbecillas borde tierra
    stroke(102, 138, 68); strokeWeight(1.5);
    for (int i = 0; i < 42; i++) {
      float gx = noise(i*24.1)*width;
      float gy = 698+noise(i*42.7)*5;
      if (gx > width/2-38 && gx < width/2+38) continue;
      line(gx, gy, gx+noise(i*3.5)*7-3.5, gy-noise(i*7.3)*9-4);
    }

    dibujarVallaBaja();
  }

  // Rellena con árboles y arbustos la zona sin edificio
  void dibujarZonaVerde(float xa, float xb) {
    float cx = (xa+xb)/2.0;
    // Arbustos de fondo
    fill(88, 138, 68, 180); noStroke();
    ellipse(xa+40, 510, 70, 45);
    ellipse(xa+100, 506, 85, 50);
    ellipse(xa+160, 512, 65, 42);
    ellipse(xa+200, 508, 55, 38);
    // Árboles
    dibujarArbol(xa+55,  498, 58, color(82, 132, 72));
    dibujarArbol(xa+148, 502, 68, color(92, 142, 78));
    dibujarArbol(xa+210, 495, 52, color(78, 128, 68));
    // Flores en el suelo
    for (int i = 0; i < 8; i++) {
      float fx = xa + noise(i*31.2)*(xb-xa-20)+10;
      float fy = 535 + noise(i*52.7)*80;
      dibujarFlorSimple(fx, fy);
    }
  }

  void dibujarArboles() {
    // Árboles flanqueando el establo
    dibujarArbol(248, 500, 48, color(88, 138, 78));
    dibujarArbol(468, 498, 52, color(92, 142, 80));
    // Árboles flanqueando el granero
    dibujarArbol(490, 502, 44, color(82, 132, 70));
    dibujarArbol(712, 500, 46, color(88, 138, 78));
    // Árboles flanqueando el prado
    dibujarArbol(968, 498, 54, color(88, 138, 78));
    dibujarArbol(1185, 502, 50, color(92, 142, 80));
  }

  void dibujarArbol(float x, float y, float r, color c) {
    fill(0,0,0,14); noStroke();
    ellipse(x+5, y+7, r*1.7, r*0.45);
    fill(108,78,45); noStroke();
    rect(x-5, y, 10, 22, 3);
    fill(red(c)-15, green(c)-15, blue(c)-12);
    ellipse(x, y-r*0.18, r*1.85, r*1.65);
    fill(c);
    ellipse(x, y-r*0.28, r*1.75, r*1.55);
    fill(min(red(c)+20,255), min(green(c)+20,255), min(blue(c)+15,255));
    ellipse(x-r*0.18, y-r*0.48, r*1.05, r*0.88);
  }

  void dibujarNube(float x, float y, float w) {
    fill(242, 246, 242, 230); noStroke();
    rect(x-w/2, y-14, w, 24, 18);
    ellipse(x-w*0.16, y-16, w*0.5, 32);
    ellipse(x+w*0.1,  y-18, w*0.4, 28);
    fill(255,255,255,90);
    ellipse(x-w*0.05, y-18, w*0.25, 18);
  }

  void dibujarFlorSimple(float fx, float fy) {
    stroke(58,118,42); strokeWeight(1.2);
    line(fx, fy, fx, fy-8); noStroke();
    color[] pc = {color(248,185,195),color(255,215,155),color(198,225,248),color(218,198,248)};
    fill(pc[(int)(noise(fx*0.04,fy*0.04)*4)]);
    for (int a = 0; a < 5; a++)
      ellipse(fx+cos(radians(a*72))*4, (fy-8)+sin(radians(a*72))*4, 5, 5);
    fill(255,242,155); ellipse(fx, fy-8, 4, 4);
  }

void dibujarVallaBaja() {
  // Las vallas las dibuja cada edificio en su zona
  // No se dibuja nada aquí
}



}
