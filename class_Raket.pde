// lyde: https://www.epidemicsound.com/sound-effects/fireworks/ //<>// //<>// //<>// //<>// //<>//
class Raket {
  PVector location = new PVector(0, height);
  PVector velocity;

  int dia=5;

  // farver RGB og opauqe værdi alfa
  int r=int(random(256));
  int g=int(random(256));
  int b=int(random(256));
  int alfa=255;

  int gram = int(random(100, 400));
  int lunte= int(random(1, 10));
  float angle=int(random(1, 7));
  boolean soundPayed = false;
  boolean lift= true; // bruges til bang lyd


  //construktor
  Raket() {
    velocity = new PVector(angle, -3);
  }



  void visRaket() {
    fill(0);
    //noStroke();
    circle(location.x, location.y, dia);
    stroke(2);
  }




  void playFireSound() {
    if (location.y==height) {
      start.play();
    }
  }

  void playExplodingSound() {
    if (!soundPayed && !lift) {
      raket2.play();
      soundPayed = true;
    }
  }

  void moveRaket() {

    location.add(velocity);
    if (location.y < gram) { // hvis  jeg har nået toppen og ikke er færdig
      velocity.x=0.8;
      velocity.y=-0.1;
      lift=false;
    }
  }


  //er raketten færdig??
  boolean done() {
    if (location.y<gram ) {
      return true;
    }
    return false;
  }


  void display() {
    println(location);
    println(velocity);

    println( dia);

    // farver RGB og opauqe værdi alfa
    println( r);
    println( g);
    println( b);
    println(alfa);

    println(gram);
    println(lunte);
    println(angle);
    println(soundPayed);
    println(lift);
  }

  void flyvRaket() {
    playFireSound();
    moveRaket();
    if (done()) {
      eksploderRaket();
    } else {
      visRaket();
    }
    playExplodingSound();
  }

  void reset() {


    // farver RGB og opauqe værdi alfa
    r=int(random(256));
    g=int(random(256));
    b=int(random(256));
    alfa=255;

    gram = int(random(100, 400));
    lunte= int(random(1, 10));
    angle=int(random(1, 7));
    soundPayed = false;
    lift= true; // bruges til bang lyd
    location = new PVector(0, height);
    velocity = new PVector(angle, -3);
    dia=5;
  }



  void eksploderRaket() {
  } // made to overwrite
}
/*************************************/

class Raket1 extends Raket {
  void eksploderRaket() {
    noStroke();
    if (dia < 500) {
      fill(r, g, b, alfa);
      dia++;
      circle(location.x, location.y, dia);
      // gør eksplosion gennemsigtig
      alfa--;
    }
    stroke(2);
  }
}
/*************************************/

class Raket2 extends Raket {

  void eksploderRaket() {

    pushMatrix();
    translate(location.x, location.y);
    stroke(r, b, g, alfa);

    for (int i=0; i<360; i++) {
      fill(r, g, b, alfa);
      rect(0, 0, 0, 1*i);
      rotate(1);
    }
    popMatrix();
    // gør eksplosion gennemsigtig
    alfa--;
  }
}

/*************************************/

class Raket3 extends Raket {



  void eksploderRaket() {

    pushMatrix();
    translate(location.x, location.y);
    stroke(r, b, g, alfa);

    for (int i=0; i<100; i++) {
      fill(r, g, b, alfa);
      rect(0, 0, 0, 1*i);
      rotate(1);
    }
    popMatrix();
    // gør eksplosion gennemsigtig
    alfa--;
  }
}

class Raket4 extends Raket {
  boolean init = false;
  PVector[] particlePositions;
  PVector[] particleVelocities;
  int[] particleLifetimes;
  int[] maxParticleLifetimes;
  float[] particleSizes;

  int particleCount;

  color colorDark;
  color colorLight;

  Raket4() {
    particleCount = (int) random(8, 12);
    particlePositions = new PVector[particleCount];
    particleVelocities = new PVector[particleCount];
    particleLifetimes = new int[particleCount];
    maxParticleLifetimes = new int[particleCount];
    particleSizes = new float[particleCount];

    colorMode(HSB, 360, 100, 100);
    final int hue = (int) random(360);
    this.colorDark = color(hue, 100, 50);
    this.colorLight = color(hue-30, 100, 50);
    colorMode(RGB, 255, 255, 255);
  }

  float colorFromSize(float size) {
    return lerpColor(this.colorDark, this.colorLight, size);
  }

  void eksploderRaket() {
    if (init == false) {
      init = true;
      //Lav partikler

      for (int i = 0; i < particleCount; i++) {
        final float size = pow(random(1.0), 3)*0.8+0.2;
        particleSizes[i] = size;
        particlePositions[i] = new PVector(location.x, location.y);
        particleVelocities[i] = PVector.fromAngle(random(TWO_PI*0.4, TWO_PI*1.2)).mult(size*12.0);
        final int lifetime = (int) map(size, 0.0, 1.0, 30.0, 120.0);
        maxParticleLifetimes[i] = lifetime;
        particleLifetimes[i] = lifetime;
      }
    }
    noStroke();
    //opdater og render partikler
    for (int i = 0; i < particleLifetimes.length; i++) {
      if (particleLifetimes[i] > 0) {
        //fill(lerpColor(color(0, 10, 145), color(134, 226, 247), particleSizes[i]), (float) particleLifetimes[i]/maxParticleLifetimes[i]*255);
        fill(colorFromSize(particleSizes[i]));
        particleLifetimes[i]--;
        particlePositions[i].add(particleVelocities[i]);

        //Luftmodstand
        PVector drag = particleVelocities[i].copy();
        drag.normalize();
        drag.mult(-1);

        final float c = 0.01;//map(particleSizes[i], 0.0, 1.0, 0.01, 0.01);
        final float speedSq = particleVelocities[i].magSq();
        drag.setMag(c * speedSq);

        particleVelocities[i].add(drag);

        //Tyngdekraft
        particleVelocities[i].y += map(particleSizes[i], 0.0, 1.0, 0.2, 0.5);

        circle(particlePositions[i].x, particlePositions[i].y, map(particleSizes[i], 0.0, 1.0, 6.0, 10.0));
        fill(255);
        circle(particlePositions[i].x, particlePositions[i].y, map(particleSizes[i], 0.0, 1.0, 3.0, 5.0));
      }
    }
  }
}

/*************************************/

//Virker kun hvis size() indeholder P2D eller P3D: fx size(800, 800, P2D);
//P2D rendereren kan øge FPS'en, men kan måske få ting til at se lidt anderledes ud.

class Raket5 extends Raket { 
  private boolean initialized = false;
  private PGraphics pg;

  private PVector[] particlePositions;
  private PVector[] particleVelocities;
  private color[] particleColors;
  private int[] particleRadii;

  private int particleCount;

  Raket5() {
    this.pg = createGraphics(width, height, P3D);
    this.pg.beginDraw(); //Nødvending for at det ikke hakker hver gang raketten springer
    this.pg.endDraw();

    this.particleCount = (int) random(3, 8);

    this.particlePositions = new PVector[this.particleCount];
    this.particleVelocities = new PVector[this.particleCount];
    this.particleColors = new color[this.particleCount];
    this.particleRadii = new int[this.particleCount];

    for (int i = 0; i < this.particleCount; i++) {
      this.particlePositions[i] = new PVector(0, 0, 0);
      this.particleVelocities[i] = PVector.random3D().mult(random(1.0, 4.0));
      this.particleColors[i] = color(random(0, 255), random(0, 255), random(0, 255));
      this.particleRadii[i] = (int) random(5, 20);
    }
  }

  private void init() {
    for (int i = 0; i < this.particleCount; i++) {
      this.particlePositions[i].x = location.x;
      this.particlePositions[i].y = location.y;
    }
  }

  void eksploderRaket() {
    if (!this.initialized) {
      this.init();
      this.initialized = true;
    }

    this.pg.beginDraw();
    this.pg.clear();
    this.pg.noStroke();

    this.pg.ambientLight(128, 128, 128);
    this.pg.directionalLight(200, 200, 200, 0, 1, 0);
    this.pg.directionalLight(150, 150, 150, 0, -1, 0);

    for (int i = 0; i < this.particleCount; i++) {
      //Physics
      this.particleVelocities[i].y += 0.1; //Tyngdekraft

      this.particlePositions[i].add(this.particleVelocities[i]);

      //Rendering

      this.pg.pushMatrix();

      this.pg.translate(this.particlePositions[i].x, this.particlePositions[i].y, this.particlePositions[i].z);
      this.pg.rotateY(millis()*0.005f);
      this.pg.rotateX(millis()*0.01f);
      this.pg.rotateZ(millis()*0.001f);

      this.pg.fill(this.particleColors[i]);
      this.pg.box(this.particleRadii[i]);

      this.pg.popMatrix();
    }

    this.pg.endDraw();

    image(pg, 0, 0);
  }
}
