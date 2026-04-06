class Ovni {
  float x, y;
  float vx;
  boolean activo;
  boolean abduciendo;
  boolean yendo;
  Vaca vacaObjetivo;
  float rayoAlpha;
  color[] luces = {
    color(255, 50,  50),
    color(50,  255, 50),
    color(50,  50,  255),
    color(255, 255, 0)
  };
  int luzActual = 0;
  float timerLuzCambio = 0;

  Ovni() {
    activo = false;
  }

  void activar(ArrayList<Vaca> vacas) {
    if (activo || vacas.size() == 0) return;
    activo     = true;
    abduciendo = false;
    yendo      = false;
    rayoAlpha  = 0;

    vacaObjetivo = vacas.get((int)random(vacas.size()));

    if (vacaObjetivo.x < width/2) {
      x  = -150;
      vx = 2.5;
    } else {
      x  = width + 150;
      vx = -2.5;
    }
    y = 180;
  }

  void actualizar(ArrayList<Vaca> vacas) {
    if (!activo) return;

    timerLuzCambio++;
    if (timerLuzCambio > 12) {
      luzActual      = (luzActual + 1) % luces.length;
      timerLuzCambio = 0;
    }

    if (!abduciendo && !yendo) {
      float targetX = vacaObjetivo.x;
      if (abs(x - targetX) > 5) {
        x += vx;
      } else {
        abduciendo = true;
        x          = targetX;
      }
    } else if (abduciendo) {
      rayoAlpha        = min(rayoAlpha + 4, 160);
      vacaObjetivo.y  -= 1.5;
      vacaObjetivo.x   = x;
      if (vacaObjetivo.y < y + 40) {
        vacas.remove(vacaObjetivo);
        abduciendo = false;
        yendo      = true;
        vx         = (x < width/2) ? -3 : 3;
      }
    } else if (yendo) {
      rayoAlpha = max(rayoAlpha - 5, 0);
      x += vx;
      y -= 0.5;
      if (x < -200 || x > width + 200) {
        activo = false;
      }
    }
  }

  void dibujar() {
    if (!activo) return;

    if (abduciendo || rayoAlpha > 0) {
      noStroke();
      fill(100, 220, 255, rayoAlpha);
      beginShape();
      vertex(x - 18, y + 18);
      vertex(x + 18, y + 18);
      vertex(x + 45, vacaObjetivo.y);
      vertex(x - 45, vacaObjetivo.y);
      endShape(CLOSE);
      fill(180, 240, 255, rayoAlpha * 0.5);
      beginShape();
      vertex(x - 6,  y + 18);
      vertex(x + 6,  y + 18);
      vertex(x + 15, vacaObjetivo.y);
      vertex(x - 15, vacaObjetivo.y);
      endShape(CLOSE);
    }

    pushMatrix();
    translate(x, y);

    noStroke();
    fill(100, 220, 255, 30);
    ellipse(0, 10, 160, 40);

    fill(200, 210, 220);
    stroke(150, 160, 170);
    strokeWeight(2);
    ellipse(0, 0, 130, 45);

    fill(170, 180, 190);
    noStroke();
    ellipse(0, 8, 120, 22);

    fill(160, 220, 255, 200);
    stroke(120, 180, 220);
    strokeWeight(1.5);
    arc(0, -4, 70, 55, PI, TWO_PI);

    fill(255, 255, 255, 80);
    noStroke();
    arc(-12, -18, 28, 22, PI, TWO_PI);

    noStroke();
    for (int i = 0; i < 8; i++) {
      float ang = radians(i * 45);
      float lx  = cos(ang) * 52;
      float ly  = sin(ang) * 16 + 4;
      color lc  = luces[(luzActual + i) % luces.length];
      fill(lc);
      ellipse(lx, ly, 9, 9);
      fill(red(lc), green(lc), blue(lc), 80);
      ellipse(lx, ly, 16, 16);
    }

    stroke(160, 170, 180);
    strokeWeight(2);
    line(0, -28, 0, -42);
    fill(255, 80, 80);
    noStroke();
    ellipse(0, -44, 8, 8);

    fill(185, 195, 205);
    noStroke();
    ellipse(0, 6, 30, 12);
    fill(210, 220, 230);
    ellipse(0, 5, 18, 8);

    popMatrix();
  }
}
