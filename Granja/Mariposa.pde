class Mariposa {
  float x, y;
  float noiseOffX, noiseOffY;
  float alas;
  color colorAla;

  Mariposa(float x, float y) {
    this.x = x;
    this.y = y;
    noiseOffX = random(1000);
    noiseOffY = random(2000);
    colorAla  = color(random(150, 255), random(80, 200), random(150, 255));
    alas = random(TWO_PI);
  }

  void actualizar() {
    x += (noise(noiseOffX) * 3 - 1.5);
    y += (noise(noiseOffY) * 3 - 1.5);
    noiseOffX += 0.006;
    noiseOffY += 0.006;
    alas += 0.25;
    x = constrain(x, 30, width - 30);
    y = constrain(y, 80, 430);
  }

  void dibujar() {
    pushMatrix();
    translate(x, y);
    float batir = sin(alas);

    fill(colorAla, 200);
    noStroke();
    pushMatrix(); rotate(-batir * 0.8); ellipse(-14, -6, 30, 20); popMatrix();
    pushMatrix(); rotate( batir * 0.8); ellipse( 14, -6, 30, 20); popMatrix();

    fill(red(colorAla)-40, green(colorAla)-20, blue(colorAla)-40, 180);
    pushMatrix(); rotate(-batir * 0.5); ellipse(-12, 6, 20, 14); popMatrix();
    pushMatrix(); rotate( batir * 0.5); ellipse( 12, 6, 20, 14); popMatrix();

    fill(40, 20, 10);
    noStroke();
    ellipse(0, 0, 5, 16);

    stroke(60, 30, 10);
    strokeWeight(1);
    line(0, -8, -8, -18); ellipse(-8, -18, 4, 4);
    line(0, -8,  8, -18); ellipse( 8, -18, 4, 4);

    popMatrix();
  }
}
