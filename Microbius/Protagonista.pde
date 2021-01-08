/*class Protagonista extends FCircle {
   float posxOriginal = width/2;
  float posy = height-20; 
  
  
   //constructor
 // Protagonista(float ancho, float alto) {
    Protagonista(float diametro) {
    //super(ancho,alto);
     super(diametro);
    setPosition(posxOriginal, posy);
    setRestitution(1);
    setFriction (0);
    setRotatable(false);
  }

 void dibujar() {
    setName("protagonista");   
    
 attachImage(loadImage("barbijo.png"));
  }


}
*/

class Protagonista extends FPoly {
  float posxOriginal = 0;
  float posy = height;

  Protagonista() {
    vertex(posxOriginal, 0 - 43);
    vertex(posxOriginal+30, 0-39);
    vertex(posxOriginal + 71, 0 - 35);
    vertex(posxOriginal + 71, 0 - 15);
   
    vertex(posxOriginal - 71, 0 - 15);
    vertex(posxOriginal - 71, 0 - 35);
     vertex(posxOriginal-30, 0-39);
    setRestitution(0.9);
    setDensity(500);
    setDamping(2);
    posy = height-40 ;
    
    setPosition(width/2, posy);
  }
  
 
  void dibujar() {
    setName("protagonista");   
    setDamping(0);
    setRestitution(1);
    setFriction(0);
    setRotatable(false);
    attachImage(loadImage("barbijo.png"));
  }
  
  
 
}
