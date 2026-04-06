class Granjero {
  float x, y;
  boolean moverIzq, moverDer, moverArr, moverAbj;
  float velocidad = 3;
  int   direccion = 1;
  float animPiernas = 0;

  Granjero(float x, float y) { this.x=x; this.y=y; }

  void actualizar() {
    boolean moviendo = false;
    if (moverIzq) { x -= velocidad; direccion=-1; moviendo=true; }
    if (moverDer) { x += velocidad; direccion= 1; moviendo=true; }
    if (moverArr) { y -= velocidad; moviendo=true; }
    if (moverAbj) { y += velocidad; moviendo=true; }
    if (moviendo) animPiernas += 0.2;
    x = constrain(x, 20, width-20);
    y = constrain(y, 360, height-25);
  }

  void dibujar() {
    float escala = map(y, 360, height-25, 0.72, 1.1);
    pushMatrix();
    translate(x, y); scale(escala);
    if (direccion == -1) scale(-1,1);
    fill(0,0,0,32); noStroke(); ellipse(0,12,30,8);
    stroke(42,78,148); strokeWeight(5);
    float pA = (moverIzq||moverDer||moverArr||moverAbj) ? sin(animPiernas)*15 : 0;
    line(-6,-10,-6+pA,10); line(6,-10,6-pA,10);
    fill(62,98,198); noStroke(); rect(-14,-45,28,38,5);
    fill(32,58,158); rect(-10,-45,20,30,3);
    stroke(218,168,108); strokeWeight(5);
    float bA = (moverIzq||moverDer||moverArr||moverAbj) ? sin(animPiernas)*18 : 0;
    line(-14,-38,-28,-20+bA); line(14,-38,28,-20-bA);
    fill(218,168,108); noStroke(); rect(-5,-55,10,12); ellipse(0,-65,32,30);
    fill(48); ellipse(-7,-68,5,5); ellipse(7,-68,5,5);
    fill(255); ellipse(-6,-69,2,2); ellipse(8,-69,2,2);
    stroke(98,58,18); strokeWeight(2); line(-8,-60,0,-59); line(0,-59,8,-60);
    fill(208,168,78); noStroke(); rect(-20,-84,40,10,3);
    fill(188,148,58); rect(-14,-100,28,20,4);
    fill(178,78,18); rect(-14,-86,28,4);
    stroke(135,88,42); strokeWeight(3); line(20,-35,35,5);
    stroke(78,58,28); strokeWeight(2);
    for (int i=-1; i<=1; i++) line(35+i*4,5,35+i*5,12);
    popMatrix();
  }

  void teclaPresionada(int cod, char k) {
    if (cod==LEFT)  moverIzq=true;
    if (cod==RIGHT) moverDer=true;
    if (cod==UP)    moverArr=true;
    if (cod==DOWN)  moverAbj=true;
  }

  void teclaLiberada(int cod) {
    if (cod==LEFT)  moverIzq=false;
    if (cod==RIGHT) moverDer=false;
    if (cod==UP)    moverArr=false;
    if (cod==DOWN)  moverAbj=false;
  }
}
