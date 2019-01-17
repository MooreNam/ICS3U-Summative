class Asteroid{
  
  static final float G = 0.000008;
  static final float LOW_MASS = 1;
  
  PImage img;
  
  PShape model;
  
  ArrayList <Asteroid> asteroids;
  
  PVector pos; 
  
  PVector vel= new PVector();
  
  PVector acc = new PVector();
  
  PVector spin = new PVector();
  //
  float mass = 0.5;
  
  float siz = 1000;
  
  boolean isDead;
  
  boolean gravity = true;
  
  int asteroidType;
    

    
  //the general purpose constructor
  public Asteroid(ArrayList<Asteroid> a, float m, PShape s, PVector p, PVector v,boolean willItHaveGravity, boolean dead, int bigOrSmall){
    asteroids = a;
    asteroids.add(this);
    model = s;
    pos = p;
    vel = v;
    mass = m;
    spin = setSpin();
    siz = setSize();
    gravity= willItHaveGravity;
    isDead = dead;
    asteroidType = bigOrSmall;
  }
  
  //constructor to make babies
  public Asteroid(Asteroid parent, float m, PVector newVel){
    int i = 25;
    asteroids = parent.asteroids;
    asteroids.add(this);
    model = parent.model;
    pos = parent.pos.copy().add(newVel.copy().mult(i));//clear it away from the parent and sibings 
    vel = parent.vel.copy().add(newVel);//give new velocity
    mass = m;
    parent.pos.sub(newVel.copy().mult(i));
    parent.vel.sub(newVel);
    parent.mass -= mass;
    parent.siz = parent.setSize();
    spin = setSpin();
    siz = setSize();


  }
  
  public Asteroid(Asteroid main, PVector p){
    asteroids = main.asteroids;
    asteroids.add(this);
    model = main.model;
    pos = p; 
    spin = setSpin();
    vel = calcOrbitalVelocity(main);
    siz = setSize();
  }
  
  float setSize(){
    return 10.* pow(mass, 0.33);
  }
  
  PVector setSpin(){
     return new PVector(random(-PI/100., PI/100.),random(-PI/100., PI/100.),random(-PI/100., PI/100.)); 
  }
  
  void move(){
    if(gravity){
    acc.add(calcForce());
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    //rot.add(spin);
  }
  }
 
  PVector calcForce() {
    PVector tempAcc = new PVector();
    for (int i = 0; i <  asteroids.size(); i++) {
   
      Asteroid other = asteroids.get(i);
      
      // println(tempAcc.mag());
      if (this == other ) {
        continue;
      }
      
      PVector r = PVector.sub(pos, other.pos);

      if (r.mag()>siz) {  
        r.normalize();
        PVector grav = PVector.mult(r, - G*other.mass/r.magSq());
        tempAcc.add(grav);
        
        
      } else if(r.mag() < siz*0.666d ){// && mass / other.mass >= 5) {
        //lets have an inelastic collision
        
       
        vel.mult(mass).add(other.vel.mult(other.mass));
        vel.div(mass + other.mass);
       
        mass  += other.mass;
    
        siz = setSize();
        
        asteroidType = 0;

       
 other.isDead = true;//change this to asteroids.other.dead = true;
     score -=10;
     
     if(score < 0){
      score = 0; 
     }

     
      } else {
        //lets bounce them off each other
        
      }
    }
      
    return tempAcc;
      
  }//end calcForce
  
  void drawA() {

    pushMatrix();
    translate(pos.x, pos.y, pos.z );
    scale(siz);
    model.rotateX(spin.x);
    model.rotateY(spin.y);
    model.rotateZ(spin.z);
    shape(model, 0, 0 );

    popMatrix();
  }
  void checkPos(PVector center) {
    //periodic boundary conditions
    //was centered on the original location but now centered on the ship 
    if (pos.dist(center) > 10*width) {
      pos.mult(-1);
    }
  }

  void checkPos() {
    //periodic boundary conditions
    if (pos.dist(center) > 10*width) {
      pos.mult(-1);
    }
  }
  
  
  //not sure this is used currently, but will be handy once we have bullets.
   void checkDestroy() {
    if (isDead) {

      asteroids.remove(this);
      
    }
  }
  
   PVector calcOrbitalVelocity(Asteroid main) {
    //get a velocity based on how far away the asteroid is
    PVector temp = PVector.sub(pos,main.pos);
    float dist = temp.mag();
    float speed = sqrt(G*main.mass/dist);
    temp.normalize();
    temp.mult(speed*300);
    float randDir = random(50);
    
    if (randDir < 50){
        randDir = PI*0.5;    
    }
    else {
       randDir = -PI*0.5; 
    }
    temp.rotate(randDir);
    //rotate it by either 90 or 270    
    return new PVector(0,0,0);
  }
  
  void update(PVector origin) {
    move();

    checkPos(origin);
    drawA();
    checkDestroy();
  }

  
  void update() {
    move();
    
    checkPos();
    drawA();
    checkDestroy();
  }

}
