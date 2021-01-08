class Obstaculo extends FBox
{
  String tipo;
int mov=1;


  Obstaculo (float ancho, float alto, String _tipo) {
    super (ancho, alto);
    setStatic (true);
    setRestitution(0.5);
    setGrabbable(false);
    ancho=50;
    alto=50;
    tipo=_tipo;
    
 
  }

 void iniciar() {
    if (tipo.equals ("cajaVio")) {
      setName("cajaVio");
     attachImage(loadImage("caja4.png"));
   
    } 
    else if (tipo.equals("alcohol")) {
      setName("alcohol");
      attachImage(loadImage("alcohol.png"));
   
    }
     else if (tipo.equals("cajaCel")) {
      setName("cajaCel"); 
     attachImage(loadImage("caja-cel0.png"));
    }
    else if (tipo.equals("cajaVer")) {
      setName("cajaVer");
      attachImage(loadImage("cajaver.png"));
    }
    else if (tipo.equals("cajaAma")) {
      setName("cajaAma");
      attachImage(loadImage("cajaama.png"));
    }
  }

}
