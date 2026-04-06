class Gallina {
  float x, y;
  float noiseOffX, noiseOffY;
  float picoteo, aleteo;
  boolean asustada;
  float timerAsusto;
  color plumas;
  float zonaMin = 740;
  float zonaMax = 1180;
  Comida comidaObjetivo = null;

  Gallina(float px, float py) {
    this.x = constrain(px, zonaMin, zonaMax);
    this.y = py;
    noiseOffX = random(1000);
    noiseOffY = random(2000);
    plumas    = color(random(200, 255), random(100, 180), random(0, 80));
    picoteo   = 0;
    aleteo    = 0;
  }

  void actualizar() {
    picoteo += 0.12;
    aleteo  += 0.15;

    if (comidaObjetivo != null && !comidaObjetivo.agotada() && !asustada) {
      float dx = comidaObjetivo.x - x;
      if (abs(dx) > 6) {
        x += (dx > 0 ? 1 : -1) * 1.4;
      } else {
        comidaObjetivo.timer -= 5;
      }
      noiseOffX += 0.005; noiseOffY += 0.005;
      x = constrain(x, zonaMin, zonaMax);
      y = constrain(y, 530, 615);
      return;
    }
    comidaObjetivo = null;

    if (asustada) {
      x += (noise(noiseOffX) * 6 - 3) * 3;
      y += (noise(noiseOffY) * 4 - 2);
      timerAsusto--;
      if (timerAsusto <= 0) asustada = false;
    } else {
      x += (noise(noiseOffX) * 2 - 1) * 1.2;
      y += (noise(noiseOffY) * 2 - 1) * 0.4;
    }
    noiseOffX += 0.005;
    noiseOffY += 0.005;
    x = constrain(x, zonaMin, zonaMax);
    y = constrain(y, 530, 615);
  }

  void atraerHacia(Comida c) {
    if (dist(x, y, c.x, c.y) < 150 && !asustada)
      comidaObjetivo = c;
  }

  void asustar(float mx, float my) {
    if (dist(x, y, mx, my) < 80) {
      asustada       = true;
      timerAsusto    = 80;
      comidaObjetivo = null;
    }
  }

  void dibujar() {
    pushMatrix();
    translate(x, y);
    scale(0.75);

    fill(0, 0, 0, 30); noStroke(); ellipse(0, 12, 28, 7);

    float aAng = asustada ? sin(aleteo * 3) * 0.6 : sin(aleteo) * 0.2;
    fill(red(plumas)-30, green(plumas)-30, blue(plumas)-20); noStroke();
    pushMatrix(); rotate(-aAng); ellipse(-14, -4, 18, 10); popMatrix();
    pushMatrix(); rotate( aAng); ellipse( 14, -4, 18, 10); popMatrix();

    fill(plumas); ellipse(0, 0, 28, 22);

    float op = (sin(picoteo) > 0.5) ? 3 : 0;
    if (comidaObjetivo != null) op = abs(sin(picoteo * 3)) * 5;

    fill(plumas); ellipse(16, -14+op, 18, 16);
    fill(255, 180, 0); noStroke(); triangle(23, -12+op, 30, -10+op, 23, -8+op);
    fill(30); ellipse(19, -16+op, 5, 5);
    fill(255); ellipse(20, -17+op, 2, 2);
    fill(220, 50, 30); noStroke();
    ellipse(14, -22+op, 7, 9); ellipse(18, -24+op, 6, 8); ellipse(22, -22+op, 5, 7);
    fill(220, 80, 60); ellipse(22, -8+op, 6, 8);

    stroke(200, 150, 50); strokeWeight(2);
    line(-4, 10, -6, 18); line(4, 10, 6, 18);
    line(-6, 18, -10, 22); line(-6, 18, -4, 22);
    line( 6, 18,  10, 22); line( 6, 18,  4, 22);

    // Nota musical al comer — también cambiada a círculo para evitar unicode
    if (comidaObjetivo != null) {
      fill(255, 200, 50, 200); noStroke();
      ellipse(0, -30, 7, 7);
      ellipse(6, -36, 5, 5);
    }

    popMatrix();
  }
}
