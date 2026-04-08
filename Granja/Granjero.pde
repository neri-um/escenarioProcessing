class Granjero {
  float x, y;
  boolean moverIzq, moverDer, moverArr, moverAbj;
  float velocidad = 3.5; 
  int   direccion = 1;
  float animPiernas = 0;

  Granjero(float x, float y) { this.x=x; this.y=y; }

  void actualizar() {
    boolean moviendo = false;
    if (moverIzq) { x -= velocidad; direccion=-1; moviendo=true; }
    if (moverDer) { x += velocidad; direccion= 1; moviendo=true; }
    if (moverArr) { y -= velocidad; moviendo=true; }
    if (moverAbj) { y += velocidad; moviendo=true; }
    if (moviendo) animPiernas += 0.25;
    
    x = constrain(x, 20, width-20);
    y = constrain(y, 500, height-25); // No vuela al cielo
  }

  void dibujar() {
    float escala = map(y, 360, height-25, 0.72, 1.1);
    pushMatrix();
    translate(x, y); scale(escala);
    if (direccion == -1) scale(-1,1);
    
    fill(0,0,0,32); noStroke(); ellipse(0,12,30,8);
    
    float rebote = (moverIzq||moverDer||moverArr||moverAbj) ? abs(sin(animPiernas))*3 : 0;
    translate(0, -rebote);

    stroke(42,78,148); strokeWeight(7); strokeCap(ROUND);
    float pA = (moverIzq||moverDer||moverArr||moverAbj) ? sin(animPiernas)*12 : 0;
    line(-6,-10,-6+pA,10); 
    line(6,-10,6-pA,10);
    noStroke();

    float bA = (moverIzq||moverDer||moverArr||moverAbj) ? sin(animPiernas)*15 : 0;
    stroke(200,60,60); strokeWeight(6); strokeCap(ROUND);
    line(12,-38, 24,-20-bA);
    noStroke(); fill(240,190,150); ellipse(24,-20-bA, 8, 8); 

    pushMatrix();
    translate(24, -20-bA); 
    rotate(radians(15));   
    stroke(135,88,42); strokeWeight(4); strokeCap(SQUARE);
    line(0, -30, 0, 35);   
    stroke(180,190,200); strokeWeight(2.5); strokeCap(ROUND);
    line(-6, -30, 6, -30); 
    for (int i=-1; i<=1; i++) line(i*5, -30, i*6, -45); 
    popMatrix();

    fill(200,60,60); noStroke(); rect(-14,-45,28,38,6);
    fill(160,40,40); rect(-14,-45,10,38,6,0,0,6); 

    fill(62,98,198); rect(-12,-35,24,28,4);
    fill(42,78,148); rect(-12,-35,8,28,4,0,0,4); 
    
    fill(230,190,50); ellipse(-7,-30, 4, 4); ellipse(7,-30, 4, 4);

    stroke(200,60,60); strokeWeight(6); strokeCap(ROUND);
    line(-12,-38, -24,-20+bA);
    noStroke(); fill(240,190,150); ellipse(-24,-20+bA, 8, 8); 

    fill(218,168,108); noStroke(); rect(-5,-55,10,12); 
    
    fill(240,190,150); ellipse(0,-65,34,32);
    
    fill(255); ellipse(-7,-68, 8, 8); ellipse(7,-68, 8, 8);   
    fill(40);  ellipse(-6,-68, 4, 4); ellipse(8,-68, 4, 4);   
    fill(255); ellipse(-7,-69, 1.5, 1.5); ellipse(7,-69, 1.5, 1.5); 
    
    fill(220,150,110); ellipse(0,-62, 6, 5); 
    
    noStroke(); fill(255,100,100,80); 
    ellipse(-12,-60, 6, 4); ellipse(12,-60, 6, 4);
    
    stroke(98,58,18); strokeWeight(1.5); noFill(); 
    beginShape();
    curveVertex(-8,-58); curveVertex(-6,-57); curveVertex(0,-56); curveVertex(6,-58);
    endShape();

    fill(230,200,100); noStroke();
    rect(-22,-82,44,8,4); 
    fill(210,180,80);
    rect(-16,-100,32,22,6,6,0,0); 
    fill(178,78,18); rect(-16,-86,32,5); 

    popMatrix();
  }

  void teclaPresionada(int cod, char k) {
    if (cod==LEFT || k=='a' || k=='A')  moverIzq=true;
    if (cod==RIGHT || k=='d' || k=='D') moverDer=true;
    if (cod==UP || k=='w' || k=='W')    moverArr=true;
    if (cod==DOWN || k=='s' || k=='S')  moverAbj=true;
  }

  void teclaLiberada(int cod) {
    if (cod==LEFT || key=='a' || key=='A')  moverIzq=false;
    if (cod==RIGHT || key=='d' || key=='D') moverDer=false;
    if (cod==UP || key=='w' || key=='W')    moverArr=false;
    if (cod==DOWN || key=='s' || key=='S')  moverAbj=false;
  }
}
