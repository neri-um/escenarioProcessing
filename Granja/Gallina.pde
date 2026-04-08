class Gallina {
  float x, y, aleteo, picoteo, noiseOffX, noiseOffY, zonaMin = 740, zonaMax = 1180;
  boolean asustada, comiendo; 
  float timerAsusto, timerComiendo;
  color plumas; Comida comidaObjetivo = null;

  Gallina(float px, float py) {
    x = px; y = py; aleteo = random(TWO_PI); picoteo = random(TWO_PI);
    noiseOffX = random(1000); noiseOffY = random(2000);
    plumas = random(1) > 0.5 ? color(250, 245, 235) : color(150, 100, 50);
  }

  void actualizar() {
    aleteo += asustada ? 0.4 : 0.1; picoteo += 0.15;
    
    if (comidaObjetivo != null && !comidaObjetivo.agotada() && !asustada) {
      float dx = comidaObjetivo.x - x;
      float dy = comidaObjetivo.y - y;
      float distancia = dist(x, y, comidaObjetivo.x, comidaObjetivo.y);
      
      if (distancia > 5) { 
        x += (dx / distancia) * 1.5; y += (dy / distancia) * 1.5; 
      } else { 
        comiendo = true; timerComiendo = 40; comidaObjetivo.timer -= 10; 
      }
      if (timerComiendo > 0) timerComiendo--; else comiendo = false;
      x = constrain(x, zonaMin, zonaMax); y = constrain(y, 530, 680); 
      return;
    }
    
    comidaObjetivo = null; comiendo = false;
    
    if (asustada) {
      x += (noise(noiseOffX) * 8 - 4); y += (noise(noiseOffY) * 6 - 3);
      timerAsusto--; if (timerAsusto <= 0) asustada = false;
    } else {
      x += (noise(noiseOffX) * 2 - 1) * 1.2; y += (noise(noiseOffY) * 2 - 1) * 0.4;
    }
    noiseOffX += 0.005; noiseOffY += 0.005;
    x = constrain(x, zonaMin, zonaMax); y = constrain(y, 530, 615);
  }

  void atraerHacia(Comida c) { if (dist(x, y, c.x, c.y) < 150 && !asustada) comidaObjetivo = c; }
  void asustar(float mx, float my) { if (dist(x, y, mx, my) < 80) { asustada = true; timerAsusto = 80; comidaObjetivo = null; comiendo = false; } }

  void dibujar() {
    pushMatrix(); translate(x, y); scale(0.75);

    fill(0, 0, 0, 25); noStroke(); ellipse(0, 14, 30, 8);
    stroke(220, 160, 40); strokeWeight(2.5); strokeCap(ROUND);
    line(-4, 10, -6, 18); line(4, 10, 6, 18); line(-6, 18, -10, 22); line(-6, 18, -4, 22); line( 6, 18,  10, 22); line( 6, 18,  4, 22);
    noStroke();

    fill(plumas); ellipse(0, 0, 28, 22);

    float aAng = asustada ? sin(aleteo * 3) * 0.6 : sin(aleteo) * 0.2;
    fill(red(plumas)-40, green(plumas)-40, blue(plumas)-30); noStroke();
    pushMatrix(); rotate(-aAng); ellipse(-14, -4, 18, 10); popMatrix(); 
    pushMatrix(); rotate( aAng); fill(0,0,0,15); ellipse(14, -2, 18, 10); fill(red(plumas)-20, green(plumas)-20, blue(plumas)-15); ellipse( 14, -4, 18, 10); popMatrix();

    float op = (sin(picoteo) > 0.5) ? 3 : 0;
    if (comiendo) op = abs(sin(picoteo * 3)) * 6; else if (comidaObjetivo != null) op = abs(sin(picoteo * 2)) * 4;

    fill(plumas); ellipse(16, -14+op, 18, 16);
    fill(255, 180, 0); triangle(23, -12+op, 30, -10+op, 23, -8+op);

    fill(255); ellipse(18, -16+op, 7, 7); fill(40);  ellipse(19, -16+op, 3.5, 3.5); fill(255); ellipse(19.5, -16.5+op, 1.5, 1.5); 
    fill(255, 100, 100, 90); ellipse(15, -12+op, 5, 3);
    fill(230, 40, 30); ellipse(14, -22+op, 7, 9); ellipse(18, -24+op, 6, 8); ellipse(22, -22+op, 5, 7); ellipse(22, -8+op, 6, 8); 

    if (comiendo) { float py = -40; fill(255, 80, 120, 220); noStroke(); ellipse(12, py, 8, 8); ellipse(20, py, 8, 8); triangle(8.5, py+2, 23.5, py+2, 16, py+10); }
    if (asustada) { fill(255, 50, 50); noStroke(); rect(14.5, -45, 3, 12, 1.5); ellipse(16, -30, 4, 4); }

    popMatrix();
  }
}
