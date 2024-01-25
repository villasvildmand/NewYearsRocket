import processing.sound.*;
SoundFile start;
SoundFile raket1;
SoundFile raket2;

//deklaration af raket batterier
Raket1 r1;
Raket2 r2;
Raket3 r3;
Raket4 r4;

Raket[] batteri;

void setup() {
  size(600, 400, P2D); //size(1500, 800);
  start = new SoundFile(this, "start.mp3");
  raket1 = new SoundFile(this, "multiRaket.mp3");
  raket2 = new SoundFile(this, "raket1.mp3");

  // hvis ikke er height ikke initialiseret
  /*r1 = new Raket1();
  r2 = new Raket2();
  r3 = new Raket3();
  r4 = new Raket4();*/
  
  batteri = new Raket[5];
  for(int i = 0; i < 5; i++) {
    /*batteri[i] = new Raket1();
    batteri[i+1] = new Raket2();
    batteri[i+2] = new Raket3();*/
    batteri[i] = new Raket5();
  }
}



void draw() {
  background(80);

  /*r1.flyvRaket();
  r2.flyvRaket();
  r3.flyvRaket();
  r4.flyvRaket();*/
  for(int i = 0; i < batteri.length; i++) {
    batteri[i].flyvRaket();
  }
  
  text((int) frameRate, 10, 10);
}
