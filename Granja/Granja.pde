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
ArrayList<Mariposa> mariposas; 

static final float TIERRA_Y = 700;
int cooldownCultivo = 0;
final int COOLDOWN_MAX = 360; 
boolean mostrarMenu = false;

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
  vacas     = new ArrayList<Vaca>();
  gallinas  = new ArrayList<Gallina>();
  cultivos  = new ArrayList<Cultivo>();
  mariposas = new ArrayList<Mariposa>(); 

  for (int i = 0; i < 3; i++) vacas.add(new Vaca(random(20, 460), random(555, 615)));
  for (int i = 0; i < 3; i++) gallinas.add(new Gallina(random(740, 1180), random(555, 615)));
  for (int i = 0; i < 5; i++) mariposas.add(new Mariposa(random(100, 1100), random(100, 400)));
}

void draw() {
  fondo.dibujar(); // ← el arbusto ya se dibuja dentro de aquí
  establo.dibujar();
  granero.dibujar();
  gallinero.dibujar();

  for (Cultivo c : cultivos) { c.actualizar(); c.dibujar(); }

  for (int i = comidas.size()-1; i >= 0; i--) {
    Comida c = comidas.get(i);
    c.actualizar(); c.dibujar();
    if (c.agotada()) { comidas.remove(i); continue; }
    for (Vaca v : vacas) v.atraerHacia(c);
    for (Gallina g : gallinas) g.atraerHacia(c);
  }

  boolean sobreAnimal = false;
  for (Vaca v : vacas) { v.actualizar(); v.dibujar(); if (dist(v.x, v.y, mouseX, mouseY) < 60) sobreAnimal = true; }
  for (Gallina g : gallinas) { g.actualizar(); g.dibujar(); if (dist(g.x, g.y, mouseX, mouseY) < 40) sobreAnimal = true; }
  
  if (sobreAnimal || granero.clickCartel(mouseX, mouseY)) cursor(HAND); else cursor(ARROW);

  for (Mariposa m : mariposas) { m.actualizar(); m.dibujar(); }

  semillas.actualizar(); semillas.dibujar();
  granjero.actualizar(); granjero.dibujar();
  ovni.actualizar(vacas); ovni.dibujar();

  if (cooldownCultivo > 0) cooldownCultivo--;
  
  mostrarInstrucciones();
}

void keyPressed() {
  granjero.teclaPresionada(keyCode, key);
  
  if (key == ' ') { 
    for(int i = 0; i < 8; i++) {
      semillas.lanzarBajoGranjero(granjero.x + random(-40, 40), granjero.y + random(-15, 15), 1); 
    }
  }
  
  if (key == 'p' || key == 'P') {
    if (granjero.y >= TIERRA_Y && cooldownCultivo <= 0) {
      cultivos.add(new Cultivo(granjero.x, granjero.y)); 
      cooldownCultivo = COOLDOWN_MAX; 
    }
  }
  
  if (key == 'u' || key == 'U') { ovni.activar(vacas); }
  
  if (key == 'v' || key == 'V') vacas.add(new Vaca(random(20, 460), random(555, 615)));
  if (key == 'g' || key == 'G') gallinas.add(new Gallina(random(740, 1180), random(555, 615)));
  
  if (key == 'f' || key == 'F') {
    for (int i = 0; i < 3; i++) { comidas.add(new Comida(constrain(granjero.x + random(-60, 60), 15, width-15), granjero.y - 20)); }
  }
}

void keyReleased() { granjero.teclaLiberada(keyCode); }

void mousePressed() {
  if (granero.clickCartel(mouseX, mouseY)) {
    mostrarMenu = !mostrarMenu; 
    return; 
  }
  for (Vaca v : vacas) { if (dist(v.x, v.y, mouseX, mouseY) < 100) { v.asustar(mouseX, mouseY); } }
  for (Gallina g : gallinas) { if (dist(g.x, g.y, mouseX, mouseY) < 80) { g.asustar(mouseX, mouseY); } }
  semillas.explosion(mouseX, mouseY, 6);
}

void mostrarInstrucciones() {
  if (!mostrarMenu) return; 

  float mx = width - 260;
  float my = height - 190;

  fill(245, 242, 228, 230); noStroke(); rect(mx, my, 248, 170, 10);
  fill(80, 55, 30); textSize(12); textAlign(LEFT, TOP);
  text("← → ↑ ↓ : Mover granjero",         mx + 10, my + 8);
  text("ESPACIO: Flores bajo el granjero",   mx + 10, my + 24);
  text("P: Plantar (en la tierra)",          mx + 10, my + 40);
  text("U: ¡Invocar OVNI!",                  mx + 10, my + 56);
  text("V: Nueva vaca  |  G: Nueva gallina", mx + 10, my + 72);
  text("F: Dar de comer",                    mx + 10, my + 88);
  text("Click: Asustar animales",            mx + 10, my + 104);

  fill(180, 120, 40, 120); noStroke(); rect(mx + 10, my + 124, 228, 8, 4);
  if (cooldownCultivo > 0) {
    fill(240, 190, 60); rect(mx + 10, my + 124, map(cooldownCultivo, 0, COOLDOWN_MAX, 0, 228), 8, 4);
    fill(80, 55, 30); textSize(10); text("Plantando... espera", mx + 10, my + 136);
  } else {
    fill(100, 160, 60); rect(mx + 10, my + 124, 228, 8, 4);
    fill(80, 55, 30); textSize(10); text("Listo para plantar (P)", mx + 10, my + 136);
  }
}
