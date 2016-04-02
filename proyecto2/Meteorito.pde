class Meteorito {
  
  PImage imagen;
  int velocidad;
  
  int x,y;
  
  public Meteorito (String nombreImagen, int velocidadY, int anchoPantalla, int altoPantalla) {
    this.imagen = loadImage(nombreImagen);
    this.velocidad = velocidadY;
    posicionar(anchoPantalla, altoPantalla);
  }
  
  void posicionar(int anchoPantalla, int altoPantalla) {
    x = int(random(0, anchoPantalla-imagen.width));
    y = -imagen.height - int(random(5,altoPantalla*1.2));
  }
  
  void actualizarPintar(int anchoPantalla, int altoPantalla) {
    y = y + velocidad;
    // Resetear la posición si se ha salido de la pantalla
    if (y>altoPantalla){
      posicionar(anchoPantalla, altoPantalla);
    }
    image(imagen, x, y);
  }
  
  boolean colision(int x, int y, int ancho, int alto) {
    boolean hayColision = true;
    if (this.x+imagen.width < x || x+ancho < this.x || this.y+imagen.height < y || y+alto < this.y ) {
      hayColision = false;
    } 
    return hayColision;
  }
  
}