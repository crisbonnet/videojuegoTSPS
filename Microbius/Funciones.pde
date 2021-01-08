boolean reiniciar=false;


void botones() {
  boolean reiniciar=false;

  TSPSPerson[] ArrayPersonas= TodasLasPersonas.getPeopleArray();
  for (int i=0; i<ArrayPersonas.length; i++) {
    if (estado.equals("instrucciones") && ArrayPersonas[i].centroid.x*width > width - 700 ) {
      estado = "inicio";
    }else if (estado.equals("inicio") && ArrayPersonas[i].centroid.y*height < height - 500 ) {
      estado = "juego";
    } else if ((estado.equals("ganar") || estado.equals("perder") )
      && ArrayPersonas[i].centroid.y* height <height - 500 ) {
      reiniciar=true;
    }
  }

  if (reiniciar) {
    setup();
    estado="inicio";
    hayVirus=false;

    reiniciar=false;
  }
}


//-----------------------------COLISIONES--------------------------------

void contactStarted( FContact colision ) { 
  FBody uno = colision.getBody1(); //caja
  FBody dos = colision.getBody2(); //virus

  if ( hayColisionEntre( colision, "cajaCel", "virus" ) ) { 
    dos.setVelocity (500, 500);
    dos.setAngularVelocity(20);

    uno.attachImage(loadImage("caja1.png"));
    uno.setName("cajaAma2"); 
    efecto[1].trigger();
    efecto[1].setGain(-10);
  } else if ( hayColisionEntre( colision, "cajaVio", "virus" ) ) {   
    dos.setVelocity (500, 500);
    dos.setAngularVelocity(50);
    mundo.remove(uno);
    efecto[3].trigger();
  }else if ( hayColisionEntre( colision, "cajaAma", "virus" ) ) {   
    dos.setVelocity (400, 400);
    dos.setAngularVelocity(50);
    uno.attachImage(loadImage("caja5.png"));
    uno.setName("cajaVio2");
    efecto[3].trigger();
  }else if ( hayColisionEntre( colision, "cajaVer", "virus" ) ) {   
    dos.setVelocity (500, 500);
    dos.setAngularVelocity(50);
    uno.attachImage(loadImage("caja-cel2.png"));
    uno.setName("cajaCel2");
    efecto[3].trigger();
  } else if ( hayColisionEntre( colision, "alcohol", "virus" ) ) {   
    dos.setVelocity (400, 400);

    mundo.remove( uno );
    cantAlcohol++;

    efecto[4].trigger();
    efecto[4].setGain(+15);
  } else if (hayColisionEntre( colision, "protagonista", "virus" ) ) {   
    dos.setVelocity (400, 400);
  } else if (hayColisionEntre( colision, "borde", "virus" ) ) {   
    dos.setVelocity (300, 300);


    //-----------------------aca se eliminan las cajas con el nuevo nombre
  } else if ( hayColisionEntre( colision, "cajaVio2", "virus" ) ) {   
    dos.setVelocity (350, 350);
    dos.setAngularVelocity(50);
    mundo.remove( uno );
    efecto[3].trigger();
  } else if ( hayColisionEntre( colision, "cajaVer2", "virus" ) ) {   
    dos.setVelocity (350, 350);
    dos.setAngularVelocity(50);
    mundo.remove( uno );
    efecto[3].trigger();
  } else if ( hayColisionEntre( colision, "cajaAma2", "virus" ) ) {   
    dos.setVelocity (300, 300);
    dos.setAngularVelocity(50);
    mundo.remove( uno );
    efecto[3].trigger();
  }else if ( hayColisionEntre( colision, "cajaCel2", "virus" ) ) {   
    dos.setVelocity (300, 300);
    dos.setAngularVelocity(50);
    mundo.remove( uno );
    efecto[3].trigger();
  }
}



boolean hayColisionEntre( FContact contact, String nombreUno, String nombreDos ) {
  boolean resultado = false;
  FBody uno = contact.getBody1();
  FBody dos = contact.getBody2();
  String etiquetaUno = uno.getName();
  String etiquetaDos = dos.getName();

  if ( etiquetaUno != null && etiquetaDos != null ) {
    //println( etiquetaUno+" <-> "+etiquetaDos); //te dice que objetos chocan

    if ( 
      ( nombreUno.equals( etiquetaUno ) && nombreDos.equals( etiquetaDos ) ) ||
      ( nombreDos.equals( etiquetaUno ) && nombreUno.equals( etiquetaDos ) )
      ) {
      resultado = true;
    }
  }
  return resultado;
}

//-----------------------------COLISIONES--------------------------------


void moverBarbijo() {
  TSPSPerson[] ArrayPersonas= TodasLasPersonas.getPeopleArray();
   for (int i=0; i<ArrayPersonas.length; i++) {
   float px = ArrayPersonas[i].centroid.x*width;
  //float px= mouseX;
  cadena.setTarget(px, miProtagonista.posy);
  }
}
