class Granero {
  float gx1, gx2, gcx;
  float baseY = 520;

  Granero(float a, float b) {
    this.gx1 = a; this.gx2 = b; this.gcx = (a+b)/2.0;
  }

  void dibujar() {
    float top = baseY - 200;

    fill(0,0,0,15); noStroke(); ellipse(gcx, baseY+6, 208, 9);

    // Cuerpo — rojo oscuro
    fill(148,38,28); noStroke(); rect(gcx-112, top, 224, 200);

    // Tejado
    fill(172,108,72); noStroke();
    triangle(gcx-128,top, gcx+128,top, gcx,top-110);
    fill(148,88,55); noStroke(); rect(gcx-128,top-6,256,10,2);
    fill(122,68,38); noStroke(); rect(gcx-6,top-113,12,116,3);

    veleta(gcx, top-115);

    // Franja horizontal
    fill(122,28,18); noStroke(); rect(gcx-112,top+90,224,9);

    // Ventanas
    win(gcx-98, top+35, 35, 32);
    win(gcx+48,  top+35, 35, 32);

    // Ventana circular
    fill(35,18,5); noStroke(); ellipse(gcx, top-50, 44, 44);
    fill(188,222,242,215);     ellipse(gcx, top-50, 36, 36);
    fill(35,18,5);
    rect(gcx-18, top-52, 36, 4);
    rect(gcx-2,  top-68, 4,  36);
    fill(255,255,255,80); arc(gcx-6, top-58, 14, 14, PI, TWO_PI);

    // PUERTA — primero arco oscuro de fondo, luego hojas, luego marco encima
    fill(28,14,3); noStroke(); arc(gcx, baseY-108, 72, 52, PI, TWO_PI);
    // Hojas de puerta
    fill(35,18,5); noStroke();
    rect(gcx-38, baseY-108, 38, 108, 4,4,0,0);
    rect(gcx,    baseY-108, 38, 108, 4,4,0,0);
    // Detalles interiores puerta
    stroke(48,28,8); strokeWeight(2);
    line(gcx-38, baseY-54, gcx-4,  baseY-54);
    line(gcx-21, baseY-108, gcx-21, baseY);
    line(gcx+4,  baseY-54, gcx+38, baseY-54);
    line(gcx+21, baseY-108, gcx+21, baseY);
    fill(208,172,80); noStroke();
    ellipse(gcx-6, baseY-54, 7,7); ellipse(gcx+6, baseY-54, 7,7);
    // Marco arco encima de todo — mismo color que cuerpo para integrarse
    stroke(122,28,18); strokeWeight(5); noFill();
    arc(gcx, baseY-108, 72, 52, PI, TWO_PI);
    // Marcos laterales
    stroke(122,28,18); strokeWeight(5);
    line(gcx-38, baseY,    gcx-38, baseY-108);
    line(gcx+38, baseY,    gcx+38, baseY-108);
    noStroke();

    // SIN letrero "GRANJA FELIZ"
  }

  void win(float wx, float wy, float w, float h) {
    fill(35,18,5); noStroke(); rect(wx-4,wy-4,w+8,h+8,5);
    fill(188,222,242,215);     rect(wx,wy,w,h,3);
    fill(35,18,5);
    rect(wx+w/2-2, wy, 4, h);
    rect(wx, wy+h/2-2, w, 4);
    fill(255,255,255,85); rect(wx+2,wy+2,w/2-5,h/2-5,2);
  }

  void veleta(float vx, float vy) {
    stroke(85,85,85); strokeWeight(2);
    line(vx,vy,vx,vy-34); line(vx-17,vy-21,vx+17,vy-21);
    fill(208,182,55); noStroke();
    float g = sin(frameCount*0.01)*0.85;
    pushMatrix(); translate(vx,vy-21); rotate(g);
    triangle(-15,-4,15,0,-15,4); popMatrix();
    fill(208,55,35); noStroke(); ellipse(vx,vy-37,10,8);
    triangle(vx,vy-41,vx-4,vy-46,vx+4,vy-46);
  }
}
