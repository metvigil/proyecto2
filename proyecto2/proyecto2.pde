int anchoPantalla = 1300;
int altoPantalla = 730;
int maxMeteoritos = 100;

PImage espacio, cohete;
int x;
int y;
int cohetex;
int cohetey;

Meteorito[] meteoritos;

int alturaMetorito = 30;

int nVidas;
int maxVidas=6;
boolean hasPerdido;
boolean hasGanado;

void setup() {
  size(1300, 730);
  textSize(72);
  espacio = loadImage("fondoespaciotierra.jpg");
  cohete=loadImage("cohete.png");
  cohetey = height-cohete.height;
  cohetex = width/2;
  x=0;
 
  nVidas=maxVidas;
  crearMeteoritos();
}

void resetearBolas(){
   x=0;
   y = int(random(0,height/2));
}

void crearMeteoritos() {
  meteoritos = new Meteorito[maxMeteoritos];
  for (int i=0; i<maxMeteoritos; i++) {
    meteoritos[i] = new Meteorito("meteorito2.png", int(random(1,3)), anchoPantalla, altoPantalla);
  }
}



void actualizarMeteoritos() {
  for (int i=0; i<maxMeteoritos; i++){
     Meteorito m = meteoritos[i];
     m.actualizarPintar(anchoPantalla, altoPantalla);
     // Comprobando colisión con el cohete
     if (m.colision(cohetex,cohetey,cohete.width, cohete.height)) {
       // 1) Resetear posición para evitar re-colisionar en el siguiente draw()
       m.posicionar(anchoPantalla, altoPantalla);
       // 2) Decrementar vidas
       gestionarColision();
     }
  }
}

void gestionarColision() {
  if (nVidas>0){
    nVidas--;
  } 
  if (nVidas==0){
    hasPerdido = true;
    draw();
    noLoop();
  }
}

void comprobarHasGanado(){
  if (cohetey<=0 && cohetex>=width/2-100 && cohetex<=width/2+100) {
    hasGanado=true;
    draw();
    noLoop();
  }
}

void draw() {
  background(espacio);
  if (hasPerdido) {
    text("Eres un gañán y has perdido", anchoPantalla/2-100, altoPantalla/2);
  }
  if (hasGanado){
    text("Qué bien, Eres un Campeón!!!", anchoPantalla/2-100, altoPantalla/2);
  } else {
    comprobarHasGanado();
  }
  //Luna
  noStroke();
  fill(255,255,255);
  ellipse(width/2, -100, 450, 450);
  
  pintarVidas();
  
  image(cohete, cohetex, cohetey);
  
  if (x>=width) {
      resetearBolas();
  }
  for (int i=0; i<3; i=i+1) {
    noStroke();
    fill(100, 100, 100);
    ellipse(x-i*200, y+i*100, 30, 30);
    x=x+1;  
  }
  
  actualizarMeteoritos();
}

void pintarVidas(){
  int anchoRect = 20;
  int altoRect = 30;
  int xRect = 30;
  int yRect = 20;
  // pintar rectangulos verdes según las vidas que te quedan
  xRect = pintarRectangulos(xRect, yRect, anchoRect, altoRect, nVidas, 0, 255, 0);
  
  // pintar rectangulos rojos según las vidas que has perdido
  pintarRectangulos(xRect, yRect, anchoRect, altoRect, maxVidas-nVidas, 255, 0, 0);
}

int pintarRectangulos(int xRect, int yRect, int anchoRect, int altoRect, int nRect, int rojo, int verde, int azul) {
  stroke(0,0,0);
  fill(rojo, verde, azul);
  for (int i=0; i<nRect; i++){
    rect(xRect, yRect, anchoRect, altoRect);
    xRect+=anchoRect+1;
  }
  return xRect;
}

void keyReleased(){
  if (keyCode==RIGHT){
    cohetex+=15;
  }
  if (keyCode == LEFT) {
    cohetex-=15;
  }
  if (keyCode==DOWN) {
    cohetey+=10;
  }
  if (keyCode== UP) {
    cohetey-=10;
  }
}