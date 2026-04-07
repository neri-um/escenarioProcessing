class SistemaParticulas {
  ArrayList<Particula> particulas;

  SistemaParticulas() {
    particulas = new ArrayList<Particula>();
  }

void lanzarBajoGranjero(float gx, float gy, int n) {
  // Destino = justo donde está el granjero (en el suelo verde)
  float destinoX = gx;
  float destinoY = constrain(gy + 20, 530, 695); // un poco por debajo de sus pies

  for (int i = 0; i < n; i++)
    particulas.add(new Particula(
      gx, gy - 30,
      random(-2, 2), random(-5, -2),
      "semilla", destinoX + random(-15, 15), destinoY + random(-8, 8)
    ));
}


  void explosion(float x, float y, int n) {
    for (int i = 0; i < n; i++) {
      float ang = random(TWO_PI);
      float spd = random(1, 5);
      particulas.add(new Particula(x, y, cos(ang)*spd, sin(ang)*spd, "polvo"));
    }
  }

  void actualizar() {
    for (int i = particulas.size()-1; i >= 0; i--) {
      Particula p = particulas.get(i);
      p.actualizar();
      if (!p.activa && !p.plantada) particulas.remove(i);
    }
  }

  void dibujar() {
    for (Particula p : particulas) p.dibujar();
  }
}
