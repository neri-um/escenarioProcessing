class Particula {
  float x, y, vx, vy;
  float vida, maxVida;
  boolean activa, plantada;
  float plantadaX, plantadaY;
  String tipo;
  color colorFlor;
  float tamañoFlor;

  // Constructor con destino explícito
  Particula(float x, float y, float vx, float vy, String tipo,
            float destX, float destY) {
    this.x = x; this.y = y;
    this.vx = vx; this.vy = vy;
    this.tipo = tipo;
    maxVida = (tipo.equals("semilla")) ? 120 : 50;
    vida = maxVida; activa = true; plantada = false;
    plantadaX = destX;
    plantadaY = destY;
    colorFlor = color(random(200, 255), random(50, 200), random(50, 180));
    tamañoFlor = random(0.6, 1.4);
  }

  // Constructor para explosión de polvo (sin destino específico)
  Particula(float x, float y, float vx, float vy, String tipo) {
    this(x, y, vx, vy, tipo, random(970, 1190), random(530, 685));
  }

  void actualizar() {
    if (plantada) return;
    float dxTarget = plantadaX - x;
    vx = lerp(vx, dxTarget * 0.04, 0.08);
    x += vx; y += vy; vy += 0.15;
    if (tipo.equals("semilla") && y >= plantadaY) {
      x = plantadaX; y = plantadaY; plantada = true; return;
    }
    vida--; if (vida <= 0) activa = false;
  }

  void dibujar() {
    if (plantada) {
      pushMatrix(); translate(x, y); scale(tamañoFlor);
      stroke(60, 140, 30); strokeWeight(1.5); line(0, 0, 0, -14); noStroke();
      fill(colorFlor);
      for (int a = 0; a < 5; a++)
        ellipse(cos(radians(a*72))*6, (sin(radians(a*72))*6)-14, 8, 8);
      fill(255, 240, 80); ellipse(0, -14, 6, 6);
      popMatrix();
    } else {
      float alpha = map(vida, 0, maxVida, 0, 255);
      fill(tipo.equals("semilla") ? color(180,120,30,alpha) : color(200,180,120,alpha));
      noStroke();
      pushMatrix(); translate(x, y); rotate(frameCount*0.2); ellipse(0, 0, 5, 8); popMatrix();
    }
  }
}
