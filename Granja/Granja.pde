Fondo fondo;
Establo   establo;
Granero   granero;
Gallinero gallinero;
Granjero  granjero;
SistemaParticulas semillas;
Ovni ovni;
ArrayList<Comida> comidas;

ArrayList<Vaca>    vacas;
ArrayList<Gallina> gallinas;
ArrayList<Cultivo> cultivos;

static final float TIERRA_Y = 700;
int cooldownCultivo = 0;
final int COOLDOWN_MAX = 180;

void setup() {
  size(1200, 800);
  fondo     = new Fondo();
  establo   = new Establo(0, 480);
  granero   = new Granero(480, 720);
  gallinero = new Gallinero(720, 1200);
  granjero  = new Granjero(600, 580);
  semillas  = new SistemaParticulas();
  ovni      = new Ovni();
  comidas   = new ArrayList<Comida>();

  vacas    = new ArrayList<Vaca>();
  gallinas = new ArrayList<Gallina>();
  cultivos = new ArrayList<Cultivo>();

  for (int i = 0; i < 3; i++)
    vacas.add(new Vaca(random(20, 460), random(555, 615)));
  for (int i = 0; i < 3; i++)
    gallinas.add(new Gallina(random(740, 1180), random(555, 615)));
}

void draw() {
  fondo.dibujar();
  establo.dibujar();
  granero.dibujar();
  gallinero.dibujar();

  for (Cultivo c : cultivos) { c.actualizar(); c.dibujar(); }

  for (int i = comidas.size()-1; i >= 0; i--) {
    Comida c = comidas.get(i);
    c.actualizar();
    c.dibujar();
    if (c.agotada()) { comidas.remove(i); continue; }
    for (Vaca v    : vacas)    v.atraerHacia(c);
    for (Gallina g : gallinas) g.atraerHacia(c);
  }

  for (Vaca v    : vacas)    { v.actualizar(); v.dibujar(); }
  for (Gallina g : gallinas) { g.actualizar(); g.dibujar(); }

  semillas.actualizar();
  semillas.dibujar();

  granjero.actualizar();
  granjero.dibujar();

  ovni.actualizar(vacas);
  ovni.dibujar();

  if (cooldownCultivo > 0) cooldownCultivo--;
  mostrarInstrucciones();
}

void keyPressed() {
  granjero.teclaPresionada(keyCode, key);
  if (key == ' ') semillas.lanzarBajoGranjero(granjero.x, granjero.y, 8);
  if (key == 'p' || key == 'P') {
    if (granjero.y >= TIERRA_Y && cooldownCultivo <= 0) {
      cultivos.add(new Cultivo(granjero.x, granjero.y));
      cooldownCultivo = COOLDOWN_MAX;
    }
  }
  if (key == 'u' || key == 'U') ovni.activar(vacas);
  if (key == 'v' || key == 'V') vacas.add(new Vaca(random(20, 460), random(555, 615)));
  if (key == 'g' || key == 'G') gallinas.add(new Gallina(random(740, 1180), random(555, 615)));
  if (key == 'f' || key == 'F') {
    for (int i = 0; i < 3; i++) {
      float fx = constrain(granjero.x + random(-60, 60), 15, width-15);
      comidas.add(new Comida(fx, granjero.y - 20));
    }
  }
}

void keyReleased() { granjero.teclaLiberada(keyCode); }

void mousePressed() {
  for (Vaca v    : vacas)    v.asustar(mouseX, mouseY);
  for (Gallina g : gallinas) g.asustar(mouseX, mouseY);
  semillas.explosion(mouseX, mouseY, 6);
}

void mostrarInstrucciones() {
  fill(245, 242, 228, 220);
  noStroke();
  rect(10, 10, 248, 170, 10);
  fill(80, 55, 30);
  textSize(12);
  textAlign(LEFT, TOP);
  text("← → ↑ ↓ : Mover granjero",         20, 18);
  text("ESPACIO: Flores bajo el granjero",   20, 34);
  text("P: Plantar (en la tierra)",          20, 50);
  text("U: ¡Invocar OVNI!",                  20, 66);
  text("V: Nueva vaca  |  G: Nueva gallina", 20, 82);
  text("F: Dar de comer",                    20, 98);
  text("Click: Asustar animales",            20, 114);

  // Barra cooldown
  fill(180, 120, 40, 120); noStroke();
  rect(20, 134, 218, 8, 4);
  if (cooldownCultivo > 0) {
    fill(240, 190, 60);
    rect(20, 134, map(cooldownCultivo, 0, COOLDOWN_MAX, 0, 218), 8, 4);
    fill(80, 55, 30); textSize(10);
    text("Plantando... espera", 20, 146);
  } else {
    fill(100, 160, 60);
    rect(20, 134, 218, 8, 4);
    fill(80, 55, 30); textSize(10);
    text("Listo para plantar (P)", 20, 146);
  }
}
