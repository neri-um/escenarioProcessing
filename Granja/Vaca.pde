class Vaca {
  float x, y;
  float vx;
  float noiseOff;
  boolean asustada;
  float timerAsusto;
  float colaMov;
  color manchaColor;
  float zonaMin = 20;
  float zonaMax = 460;
  Comida comidaObjetivo = null;
  boolean comiendo = false;
  float timerComiendo = 0;
  // Pausa aleatoria independiente por vaca
  float timerPausa = 0;
  float timerMovimiento = 0;
  boolean pausada = false;

  Vaca(float px, float py) {
    x = px;
    y = py;
    // Offset muy separado y único para cada vaca
    noiseOff    = random(10000);
    vx          = random(0.6, 1.2) * (random(1) > 0.5 ? 1 : -1);
    manchaColor = color(random(30, 80));
    colaMov     = 0;
    // Empezar en estado aleatorio para que no arranquen todas igual
    timerMovimiento = random(60, 200);
    timerPausa      = random(30, 120);
    pausada         = random(1) > 0.5;
  }

  void actualizar() {
    colaMov += 0.08;

    // Ir hacia comida
    if (comidaObjetivo != null && !comidaObjetivo.agotada() && !asustada) {
      float dx = comidaObjetivo.x - x;
      if (abs(dx) > 8) {
        x  += (dx > 0 ? 1 : -1) * 1.8;
        vx  = (dx > 0) ? 1 : -1;
      } else {
        comiendo             = true;
        timerComiendo        = 40;
        comidaObjetivo.timer -= 15;
      }
      if (timerComiendo > 0) timerComiendo--;
      else comiendo = false;
      x = constrain(x, zonaMin, zonaMax);
      return;
    }
    comidaObjetivo = null;
    comiendo       = false;

    if (asustada) {
      x += vx * 5;
      timerAsusto--;
      if (timerAsusto <= 0) asustada = false;
      x = constrain(x, zonaMin, zonaMax);
      return;
    }

    // Sistema pausa/movimiento independiente
    if (pausada) {
      timerPausa--;
      if (timerPausa <= 0) {
        pausada         = false;
        timerMovimiento = random(80, 240);
        // Nueva dirección aleatoria al arrancar
        vx = random(0.5, 1.3) * (random(1) > 0.5 ? 1 : -1);
      }
    } else {
      // Movimiento con noise propio
      float n = noise(noiseOff) * 2 - 1;
      noiseOff += 0.006;

      vx = lerp(vx, n * 1.3, 0.015);
      if (abs(vx) < 0.45) vx = vx >= 0 ? 0.45 : -0.45;

      x += vx;

      timerMovimiento--;
      if (timerMovimiento <= 0) {
        pausada    = true;
        timerPausa = random(40, 150);
      }
    }

    // Rebotar en bordes
    if (x <= zonaMin) { x = zonaMin; vx =  abs(vx); }
    if (x >= zonaMax) { x = zonaMax; vx = -abs(vx); }
  }

  void atraerHacia(Comida c) {
    if (dist(x, y, c.x, c.y) < 180 && !asustada)
      comidaObjetivo = c;
  }

  void asustar(float mx, float my) {
    if (dist(x, y, mx, my) < 100) {
      asustada       = true;
      timerAsusto    = 90;
      vx             = abs(vx) * (mx < x ? 1 : -1) * 1.5;
      comidaObjetivo = null;
      pausada        = false;
    }
  }

  void dibujar() {
    pushMatrix();
    translate(x, y);
    if (vx < 0) scale(-1, 1);

    fill(0, 0, 0, 35); noStroke(); ellipse(0, 20, 80, 12);

    fill(230); stroke(180); strokeWeight(1);
    rect(-28, 5, 12, 20, 3); rect(-10, 5, 12, 20, 3);
    rect(6,   5, 12, 20, 3); rect(22,  5, 12, 20, 3);

    fill(240); noStroke(); ellipse(0, -5, 80, 45);
    fill(manchaColor); ellipse(-15, -8, 22, 18); ellipse(20, 0, 18, 14);

    fill(240); ellipse(42, -12, 35, 28);
    fill(255, 200, 180); ellipse(55, -6, 18, 12);
    fill(80); ellipse(52, -6, 4, 3); ellipse(57, -6, 4, 3);
    fill(40); ellipse(46, -17, 7, 7);
    fill(255); ellipse(47, -18, 2, 2);

    fill(255, 200, 180); noStroke(); ellipse(34, -22, 14, 10);
    fill(220, 200, 140);
    triangle(34, -24, 30, -36, 38, -34);
    triangle(44, -22, 42, -34, 50, -32);

    stroke(180); strokeWeight(2.5); noFill();
    beginShape();
    for (int i = 0; i <= 10; i++) {
      float t = i / 10.0;
      curveVertex(-38 - t*18, -5 + sin(colaMov + t*PI*2) * 12 * t);
    }
    endShape();

    fill(220, 180, 50); noStroke(); rect(36, -4, 10, 8, 2);
    stroke(180, 140, 30); strokeWeight(1.5); line(41, 4, 41, 8);

    if (comiendo) {
      float py = -50;
      fill(255, 80, 120, 200); noStroke();
      ellipse(-5, py, 9, 9);
      ellipse( 5, py, 9, 9);
      triangle(-12, py+2, 12, py+2, 0, py+14);
    }

    if (asustada) {
      fill(255, 50, 50); noStroke();
      rect(-3, -50, 6, 14, 2);
      ellipse(0, -32, 6, 6);
    }

    popMatrix();
  }
}
