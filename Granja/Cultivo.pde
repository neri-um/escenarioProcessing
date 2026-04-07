class Cultivo {
  float x, y;
  float crecimiento;
  int tipo;
  boolean maduro;

  Cultivo(float x, float y) {
    this.x=x; this.y=y; crecimiento=0; maduro=false; tipo=(int)random(3);
  }

  void actualizar() {
    if (crecimiento<1.0) crecimiento+=0.004; else { crecimiento=1.0; maduro=true; }
  }

  void dibujar() {
    pushMatrix(); translate(x,y); scale(crecimiento);
    if (tipo==0) dibujarMaiz(); else if (tipo==1) dibujarZanahoria(); else dibujarGirasol();
    popMatrix();
  }

  void dibujarMaiz() {
    stroke(80,140,40); strokeWeight(3); line(0,0,0,-45);
    noStroke(); fill(100,170,50); ellipse(-10,-20,22,10); ellipse(10,-30,22,10);
    fill(255,210,40); stroke(200,160,20); strokeWeight(1); rect(-6,-44,12,20,4);
    fill(240,190,30); noStroke();
    for (int r=0; r<4; r++) for (int c=0; c<2; c++) ellipse(-3+c*6,-42+r*5,4,4);
    stroke(220,180,60); strokeWeight(1); line(-3,-44,-5,-52); line(0,-44,0,-53); line(3,-44,5,-52);
  }

  void dibujarZanahoria() {
    noStroke(); fill(60,160,40);
    for (int i=-1; i<=1; i++) ellipse(i*7,-38,8,20);
    fill(80,180,50); ellipse(0,-34,6,16);
    fill(255,130,20); stroke(220,100,10); strokeWeight(1);
    beginShape(); vertex(-8,-28); vertex(8,-28); vertex(3,0); vertex(-3,0); endShape(CLOSE);
    stroke(220,100,10,160); strokeWeight(1);
    line(-5,-22,5,-22); line(-6,-15,6,-15); line(-4,-8,4,-8);
  }

  void dibujarGirasol() {
    stroke(80,140,40); strokeWeight(3); line(0,0,0,-50);
    noStroke(); fill(100,170,50);
    pushMatrix(); translate(-8,-28); rotate(-0.4); ellipse(0,0,20,10); popMatrix();
    pushMatrix(); translate(8,-38); rotate(0.4); ellipse(0,0,20,10); popMatrix();
    fill(255,210,20); noStroke();
    for (int a=0; a<12; a++) { float ang=radians(a*30); ellipse(cos(ang)*14,-50+sin(ang)*14,10,14); }
    fill(100,60,20); ellipse(0,-50,20,20);
    fill(80,45,15);
    for (int a=0; a<6; a++) { float ang=radians(a*60); ellipse(cos(ang)*5,-50+sin(ang)*5,3,3); }
    ellipse(0,-50,3,3);
  }
}
