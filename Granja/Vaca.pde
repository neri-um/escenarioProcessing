class Vaca {
  float x, y, vx, noiseOff, timerAsusto, colaMov, zonaMin = 20, zonaMax = 460;
  boolean asustada, comiendo, pausada;
  color manchaColor;
  Comida comidaObjetivo = null;
  float timerComiendo = 0, timerPausa = 0, timerMovimiento = 0;

  Vaca(float px, float py) {
    x = px; y = py; noiseOff = random(10000);
    vx = random(0.6, 1.2) * (random(1) > 0.5 ? 1 : -1);
    manchaColor = color(30); 
    timerMovimiento = random(60, 200); timerPausa = random(30, 120); pausada = random(1) > 0.5;
  }

  void actualizar() {
    colaMov += 0.08;
    
    if (comidaObjetivo != null && !comidaObjetivo.agotada() && !asustada) {
      float dx = comidaObjetivo.x - x;
      float dy = comidaObjetivo.y - y;
      float distancia = dist(x, y, comidaObjetivo.x, comidaObjetivo.y);
      
      if (distancia > 8) { 
        x += (dx / distancia) * 1.8; 
        y += (dy / distancia) * 1.8; 
        vx = (dx > 0) ? 1 : -1;      
      } else { 
        comiendo = true; timerComiendo = 40; comidaObjetivo.timer -= 15; 
      }
      
      if (timerComiendo > 0) timerComiendo--; else comiendo = false;
      
      x = constrain(x, zonaMin, zonaMax); 
      y = constrain(y, 530, 680); 
      return;
    }
    
    comidaObjetivo = null; comiendo = false;

    if (asustada) {
      x += vx * 5; timerAsusto--; if (timerAsusto <= 0) asustada = false;
      x = constrain(x, zonaMin, zonaMax); return;
    }

    if (pausada) {
      timerPausa--;
      if (timerPausa <= 0) { pausada = false; timerMovimiento = random(80, 240); vx = random(0.5, 1.3) * (random(1) > 0.5 ? 1 : -1); }
    } else {
      vx = lerp(vx, (noise(noiseOff) * 2 - 1) * 1.3, 0.015); noiseOff += 0.006;
      if (abs(vx) < 0.45) vx = vx >= 0 ? 0.45 : -0.45;
      x += vx; timerMovimiento--;
      if (timerMovimiento <= 0) { pausada = true; timerPausa = random(40, 150); }
    }
    if (x <= zonaMin) { x = zonaMin; vx = abs(vx); }
    if (x >= zonaMax) { x = zonaMax; vx = -abs(vx); }
  }

  void atraerHacia(Comida c) { if (dist(x, y, c.x, c.y) < 180 && !asustada) comidaObjetivo = c; }
  void asustar(float mx, float my) {
    if (dist(x, y, mx, my) < 100) { asustada = true; timerAsusto = 90; vx = abs(vx) * (mx < x ? 1 : -1) * 1.5; comidaObjetivo = null; pausada = false; }
  }

  void dibujar() {
    pushMatrix();
    translate(x, y);
    if (vx < 0) scale(-1, 1);

    fill(0, 0, 0, 30); noStroke(); ellipse(0, 40, 90, 15);
    noStroke(); 

    fill(210); rect(-25, 15, 12, 26, 4); rect(10, 15, 12, 26, 4);  
    fill(40); rect(-25, 34, 12, 7, 2); rect(10, 34, 12, 7, 2);

    stroke(180); strokeWeight(3); noFill(); bezier(-40, 5, -55, -5, -55, 15, -45, 25);
    noStroke(); fill(30); ellipse(-45, 25, 8, 12); 

    fill(255, 170, 190); arc(-8, 25, 26, 20, 0, PI);
    rect(-14, 25, 6, 10, 3); rect(-4, 25, 6, 10, 3);  

    fill(250); ellipse(-10, 0, 85, 60);
    fill(0, 0, 0, 15); arc(-10, 0, 85, 60, 0, PI);

    fill(manchaColor); ellipse(-25, -10, 22, 28); ellipse(10, 5, 25, 18);
    ellipse(-25, 15, 15, 12); ellipse(-2, -22, 16, 10);

    fill(255); rect(-35, 18, 12, 24, 4); rect(0, 18, 12, 24, 4);   
    fill(0,0,0,10); rect(-35, 18, 12, 6); rect(0, 18, 12, 6);
    fill(40); rect(-35, 35, 12, 7, 2); rect(0, 35, 12, 7, 2);

    fill(255); ellipse(15, -25, 18, 10); ellipse(55, -25, 18, 10); 
    fill(255, 190, 200); ellipse(55, -25, 8, 5);

    fill(220, 180, 120); triangle(28, -35, 22, -45, 32, -35); triangle(45, -35, 40, -45, 50, -35);

    fill(250); ellipse(35, -15, 38, 48);

    fill(255, 170, 190); ellipse(35, 2, 40, 24);
    fill(255, 150, 170); arc(35, 2, 40, 24, 0, PI);

    fill(230, 120, 140); ellipse(26, 2, 4, 6); ellipse(44, 2, 4, 6);   

    fill(255); ellipse(26, -20, 8, 8); ellipse(44, -20, 8, 8); 
    fill(40);  ellipse(26, -20, 4, 4); ellipse(44, -20, 4, 4); 
    fill(255); ellipse(26.5, -20.5, 1.5, 1.5); ellipse(44.5, -20.5, 1.5, 1.5); 

    fill(255, 100, 100, 80); ellipse(20, -12, 6, 4); ellipse(50, -12, 6, 4);

    if (comiendo) {
      float py = -55; fill(255, 80, 120, 220); 
      ellipse(-4, py, 10, 10); ellipse(4, py, 10, 10); triangle(-8.6, py+2.5, 8.6, py+2.5, 0, py+12);
    }
    if (asustada) {
      fill(255, 50, 50); rect(-1.5, -60, 3, 14, 1.5); ellipse(0, -42, 4, 4);
    }

    popMatrix();
  }
}
