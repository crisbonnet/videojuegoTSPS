import tsps.*;
import fisica.*;
//-----------------------minim----------------
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;

AudioPlayer [] track;
int cantTrack=4;

AudioSample [] efecto;
int cantEfecto=5;
//-----------------------minim----------------

TSPS TodasLasPersonas;
PImage [] pantallas = new PImage[5];
PImage [] boton= new PImage[2];
PImage [] flecha =new PImage[6];
int numFlecha=0;

FMouseJoint cadena;

FWorld mundo;
String estado;
int tam=50;

Protagonista miProtagonista;

ArrayList <Obstaculo> misCajasVio;
ArrayList <Obstaculo> misCajasAma;
ArrayList <Obstaculo> misCajasVer;

ArrayList <Obstaculo> miAlcoholTop;
ArrayList <Obstaculo> miAlcoholD;
ArrayList <Obstaculo> miAlcoholI;


//----------------  virus-------------------
boolean hayVirus=false;
String estadoVirus;
Contagiado portador;
//----------------  virus-------------------

FBox contador;
FBox contador2;


int tiempo;
int temperatura;
int cantAlcohol;

Bordes bordeTop;
Bordes bordeLeft;
Bordes bordeRight;

int mov=1;

void setup()
{
  size(1000, 700);
  Fisica.init(this);

  mundo = new FWorld();
  mundo.setGravity(-1, 0); ///ver este valor

  bordeTop = new   Bordes(width, 5);
  bordeTop.setPosition(width/2, 2);
  mundo.add(bordeTop);

  bordeLeft = new   Bordes(5, height);
  bordeLeft.setPosition(2, height/2);
  mundo.add(bordeLeft);

  bordeRight = new   Bordes(5, height);
  bordeRight.setPosition(width-2, height/2);
  mundo.add(bordeRight);



  TodasLasPersonas= new TSPS(this, 12000);
  //========pantallas=============================================================
  for ( int i = 0; i < 5; i++ ) {
    pantallas[i] = loadImage("pantalla"+ i +".png");
  }

  //======= boton ==================================================================
  for ( int i = 0; i < 2; i++ ) {
    boton[i] = loadImage("boton"+ i +".png");
  }

  //-----------------------minim----------------
  minim =new Minim(this);
  track = new AudioPlayer[cantTrack];

  for (int i=0; i<cantTrack; i++) {
    track[i] = minim.loadFile("track"+i+".mp3", 2048);
  }

  efecto = new AudioSample[cantEfecto];

  for (int i=0; i<cantEfecto; i++) {
    efecto[i] = minim.loadSample("efecto"+i+".mp3", 512);
  }
  //-----------------------minim----------------


  miProtagonista = new Protagonista();
  miProtagonista.dibujar();
  mundo.add(miProtagonista);
  cadena =  new FMouseJoint(miProtagonista, width/2, height - 43);
  cadena.setFrequency(400000);
  mundo.add(cadena); 


  //---------------CAJAS------------------------

  misCajasVio= new ArrayList <Obstaculo> ();
  for (int i=0; i<22; i++) {
    for (int j=0; j<4; j++) {
      Obstaculo cajaVio = new Obstaculo (tam, tam, ("cajaVio"));//cajaVio
      cajaVio.iniciar();  
      if ((i+j)%2==0) {
        cajaVio.setPosition((i*tam-(tam/2)), 55+(j*tam-(tam/2)));
      }
      mundo.add(cajaVio);
      misCajasVio.add(cajaVio);
    }
  }

  misCajasAma= new ArrayList <Obstaculo> (); // IZQUIERDA PRIMER AMARILLO
  for (int i=0; i<3; i++) {
    Obstaculo cajasAma = new Obstaculo (tam, tam, "cajaAma");//cajaAma
    cajasAma.iniciar();
    cajasAma.setPosition(175+(i*tam), 80+( i*tam));
    mundo.add(cajasAma);
    misCajasAma.add(cajasAma);
  }

  misCajasVer= new ArrayList <Obstaculo> (); // DERECHA SEGUNDO verde chiquitoo------------------
  for (int i=0; i<2; i++) {
    Obstaculo cajasVer = new Obstaculo (tam, tam, "cajaVer");//cajaVer
    cajasVer.iniciar();
    cajasVer.setPosition(725-(i*tam), 130+( i*tam));
    mundo.add(cajasVer);
    misCajasVer.add(cajasVer);
  }

  misCajasVer= new ArrayList <Obstaculo> ();  //IZQUIERDA PRIMER VERDE DE ABAJO
  for (int i=0; i<5; i++) {
    Obstaculo cajasVer = new Obstaculo (tam, tam, "cajaVer");//cajaVer
    cajasVer.iniciar();
    cajasVer.setPosition(175-(i*tam), 180+( i*tam));
    mundo.add(cajasVer);
    misCajasVer.add(cajasVer);
  }

  misCajasAma= new ArrayList <Obstaculo> ();  //derecha PRIMER amarillo DE ABAJO ------------
  for (int i=0; i<2; i++) {
    Obstaculo cajasAma = new Obstaculo (tam, tam, "cajaAma");//cajaAma
    cajasAma.iniciar();
    cajasAma.setPosition(525+(i*tam), 130+( i*tam));
    mundo.add(cajasAma);
    misCajasVer.add(cajasAma);
  }

  misCajasAma= new ArrayList <Obstaculo> (); //DERECHA PRIMER amarillo DE ABAJO
  for (int i=0; i<5; i++) {
    Obstaculo cajasAma = new Obstaculo (tam, tam, "cajaAma");//cajaAma
    cajasAma.iniciar();
    cajasAma.setPosition(775+(i*tam), 130+( i*tam));
    mundo.add(cajasAma);
    misCajasAma.add(cajasAma);
  }

  misCajasVer= new ArrayList <Obstaculo> (); //izquierda chquito VERDE DE ABAJO
  for (int i=0; i<2; i++) {
    Obstaculo cajasVer = new Obstaculo (tam, tam, "cajaVer");
    cajasVer.iniciar();
    cajasVer.setPosition(425-(i*tam), 130+( i*tam));
    mundo.add(cajasVer);
    misCajasVer.add(cajasVer);
  }  

  misCajasVer= new ArrayList <Obstaculo> (); //IZQUIERDA SEGUNDO VERDE ARRIBA
  for (int i=0; i<5; i++) {
    Obstaculo cajasVer = new Obstaculo (tam, tam, "cajaVer");
    cajasVer.iniciar();
    cajasVer.setPosition(125-(i*tam), 30+( i*tam));
    mundo.add(cajasVer);
    misCajasVer.add(cajasVer);
  }

  misCajasVer= new ArrayList <Obstaculo> (); //DERECHA SEGUNDO VERDE ARRIBA
  for (int i=0; i<5; i++) {
    Obstaculo cajasVer = new Obstaculo (tam, tam, "cajaVer");
    cajasVer.iniciar();
    cajasVer.setPosition(825+(i*tam), 30+( i*tam));
    mundo.add(cajasVer);
    misCajasVer.add(cajasVer);
  }

  miAlcoholTop= new ArrayList <Obstaculo> ();
  for (int i=0; i<6; i++) {
    Obstaculo alcoholTop = new Obstaculo (tam, tam, "alcohol");
    alcoholTop.iniciar();
    alcoholTop.setPosition(275+(i*tam*2), 80);
    mundo.add(alcoholTop);
    miAlcoholTop.add(alcoholTop);
  }

  miAlcoholD= new ArrayList <Obstaculo> ();
  for (int i=0; i<3; i++) {
    Obstaculo alcoholD = new Obstaculo (tam, tam, "alcohol");
    alcoholD.iniciar();
    alcoholD.setPosition(775+(i*tam*2), 80+( i*tam*2));
    mundo.add(alcoholD);
    miAlcoholD.add(alcoholD);
  }

  miAlcoholI= new ArrayList <Obstaculo> ();
  for (int i=0; i<2; i++) {
    Obstaculo alcoholI = new Obstaculo (tam, tam, "alcohol");
    alcoholI.iniciar();
    alcoholI.setPosition(175-(i*tam*2), 130+( i*tam*2));
    mundo.add(alcoholI);
    miAlcoholI.add(alcoholI);
  }
  //---------------CAJAS------------------------

  //-----------------virus----------------------
  estadoVirus= "lanzamiento";
  portador = new Contagiado (random(100, 900), 250);
  //-----------------virus----------------------

  contador = new FBox(150, 50);
  contador.setPosition(75+50, 30);
  contador.setStatic(true);
  contador.setGrabbable(false);
  contador.attachImage(loadImage("contador-temperatura.png"));
  mundo.add(contador);

  contador2 = new FBox(150, 50);
  contador2.setPosition(width-75-50, 30);
  contador2.setStatic(true);
  contador2.setGrabbable(false);
  contador2.attachImage(loadImage("contador-alcohol.png"));
  mundo.add(contador2);
  estado = "instrucciones";
  cantAlcohol=0;
  temperatura=36;
  textSize(25);

  for (int i=0; i<6; i++) {
    flecha[i]=loadImage("flecha"+i+".png");
  }
} 

void draw() {
  if (estado.equals("instrucciones")) {
    image(pantallas[4], 0, 0); 
      image(flecha[numFlecha], 720, 550);
      if (frameCount%10==0) {
        if (numFlecha<5) {
          numFlecha++;
        } else  {
          numFlecha=0;
        }
      }
      track[0].play();
      /*if (frameCount >1800) {
        estado = "inicio";
      }*/
      botones();
      
    } else if (estado.equals("inicio")) {
      image(pantallas[0], 0, 0);
      image(boton[0], width/2 - 100, height - 600);
      botones();
    } else if (estado.equals ("juego")) {
      image(pantallas[1], 0, 0);
      mundo.step();

      moverBarbijo();
      mundo.draw();

      track[0].pause();
      track[1].setGain(-15);
      track[1].play();

      //-----------------virus----------------------
      if (hayVirus==false) {
        estadoVirus.equals("lanzamiento") ;
        if ( estadoVirus.equals("lanzamiento")) {
          portador.dibujar();

          hayVirus=true;
          portador.estornudo( mundo );
        }
      } else if (hayVirus==true) {
        estadoVirus.equals("jugando");
        portador.borrarVirus();
      }
      //-----------------virus----------------------

      text(temperatura+"ºC", 120, 40);
      text(cantAlcohol, 895, 40);

      if ( temperatura==40) {
        estado="perder";
      } else if ((cantAlcohol==2) && (temperatura <40)) {
        estado="ganar";
      }
    } else if (estado.equals ("perder")) {
      image(pantallas[2], 0, 0);
      track[1].pause();
      track[3].play();
      image(boton[1], width/2 - 100, height - 600);
      botones();
    } else if ( estado.equals("ganar")) {
      image(pantallas[3], 0, 0);
      track[1].pause();
      track[2].play();

      image(boton[1], width/2 - 100, height - 600);
      botones();
    }
  }



  void mousePressed() {
    if (estado.equals("instrucciones") && (mouseX > 700 && mouseX< 700+111 && 
      mouseY > 550 && mouseY <550+93)) {
      estado= "inicio";
    } else if (estado.equals("inicio") && (mouseX > width/2-100 && mouseX< width/2+100 && 
      mouseY > height-600 && mouseY <height-500)) {
      estado= "juego";
    } else if ( (estado.equals("perder")|| estado.equals("ganar")) && 
      (mouseX > width/2-100 && mouseX< width/2+100 && 
      mouseY > height-600 && mouseY <height-500)) {
      estado="inicio";
      hayVirus=false;
      setup();
      //reiniciar=false;
    }
  }
