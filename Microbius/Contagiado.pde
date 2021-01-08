
float diamVirus = 30;
float velocidad = 500;

class Contagiado {
  float x, y;
  float angulo;
  float largo = 50;
  float ancho = 50;
    PImage contagiado;

  Contagiado( float x_, float y_ ) {
    x = x_;
    y = y_;
    angulo = radians(random(200,300));
    contagiado =loadImage("contagiado.png");
  }


  void borrarVirus() {
    ArrayList <FBody> cuerpos = mundo.getBodies();

    for ( FBody esteCuerpo : cuerpos ) {
      String nombre = esteCuerpo.getName();
      if ( nombre != null ) {
        if ( nombre.equals("virus") ) {
          if ( esteCuerpo.getY() > height-diamVirus) {
            mundo.remove( esteCuerpo );
            hayVirus=false;
            temperatura+=1;
          }
        }
      }
    }
  }


  void dibujar() {
    pushMatrix();
    translate( x, y );
    rotate( angulo );
     image( contagiado, -ancho/2, -ancho/2, largo, ancho );
    popMatrix();
  }


  void estornudo( FWorld mundo ) {
    FCircle virus = new FCircle( diamVirus );
    virus.setPosition( x, y );
   efecto[0].trigger();
    virus.setName( "virus" );
    virus.attachImage(loadImage("virus.png"));
    virus.setRestitution(2);
    virus.setFriction(0);
    virus.setVelocity (500, 500);


    float velx = velocidad * cos( angulo );
    float vely = velocidad * sin( angulo );
    
   // float velx = velocidad * cos( angulo );
    //float vely = velocidad * sin( angulo );

    virus.setVelocity( velx, vely );
    mundo.add( virus );
  }
}
