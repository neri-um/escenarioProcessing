class Comida {
  float x, y;
  float vy = 0;
  boolean enSuelo = false;
  float timer = 480;
  float suelo;

  Comida(float px, float py) {
    this.x = px;
    this.y = py;
    suelo = constrain(py + random(30, 80), 530, 695);
  }

  void actualizar() {
    if (!enSuelo) {
      vy += 0.4;
      y  += vy;
      if (y >= suelo) { y = suelo; enSuelo = true; }
    } else {
      timer--;
    }
  }

  boolean agotada() { return enSuelo && timer <= 0; }

  void dibujar() {
    if (agotada()) return;
    float alpha = timer < 80 ? map(timer, 0, 80, 0, 255) : 255;

    if (!enSuelo) {
      pushMatrix(); translate(x, y); rotate(frameCount * 0.15);
      fill(218, 178, 88, alpha); noStroke(); rect(-5, -5, 10, 10, 2);
      fill(200, 155, 65, alpha); noStroke(); ellipse(0, 0, 6, 6);
      popMatrix();
    } else {
      pushMatrix(); translate(x, y);
      fill(0, 0, 0, 20 * alpha/255); noStroke(); ellipse(0, 4, 28, 6);
      fill(218, 178, 88, alpha); noStroke();
      ellipse(-6, 0, 6, 4); ellipse(2, -2, 5, 3); ellipse(8, 1, 6, 4);
      ellipse(-2, 3, 5, 3); ellipse(5, -1, 4, 3); ellipse(-8, 2, 5, 3);
      // Indicador nuevo — círculo brillante en lugar de símbolo unicode
      if (timer > 400) {
        float pulse = sin(frameCount * 0.2) * 3;
        fill(255, 230, 80, map(timer, 400, 480, 0, 180));
        ellipse(0, -14, 8 + pulse, 8 + pulse);
      }
      popMatrix();
    }
  }
}
