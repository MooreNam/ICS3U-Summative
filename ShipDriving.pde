

//Background Stars
int maxSize = 50;//number of stars

int mult = 1;
float size = 0.5; //starSize
PVector midPoint; //For PeasyCam

//Ship Control
PVector pos; //Position of ship
int shipLength = 25;
int shipHeight = 5;
int shipWidth = 12;
float speed = 0;   // Speed of ship
boolean leftBool, rightBool, thrustBool; 
float turning = 0.05; 

PVector vel;
PVector acc;
PVector sDir;
float speedLimit = 5;
float thrustEnergyCost = 2;
float energyRegen = 3;
float maxEnergy;
float Energy;


//aim
float aimLength = 1;
boolean isAiming = false;

//Tracers
float startSize = 30; // this is the tracers starting size
PVector[] posh = new PVector[maxSize];
PVector[] velh = new PVector[maxSize];
PVector[] acch = new PVector[maxSize];
float [] sizes = new float[maxSize];
float shrinkscale = 0.99;
float velscale = 2;
float  tracerSpread = 0.4;


void ShipDrivingSetup() {
   
  leftBool= false;
  rightBool= false;
  thrustBool= false;
  maxEnergy = 300;
Energy = maxEnergy;
  
  midPoint = new PVector(width/2, height/2, 0);
  pos = SpawnPosition(-150);
  vel = new PVector();
  acc = new PVector();
  sDir = midPoint.copy().sub(pos);
  sDir.normalize();
  ShipDrivingInit();
 
}

float Energy(){
 if(infEnergy){
  Energy += 11; 
 }
  
  if(thrustBool){
  Energy -= thrustEnergyCost;
  }
  else{
    Energy += energyRegen;
    
  }
  return Energy;
}

void ShipDrivingInit() {
  //initialize arrays
  for (int i = 0; i < maxSize; i++) {
    posh[i] = new PVector(-1000, -1000);
    velh[i] = PVector.random2D();
    velh[i].mult(velscale);
    acch[i] = new PVector(0, 0);
    sizes[i] = startSize;
  }
}

void aiming(){
  PVector aimingTip = new PVector (pos.x - (aimLength*-sDir.x), pos.y-(aimLength*-sDir.y));
  stroke(200,30,10,80); //colour of line
  strokeWeight(2.5);
  line(pos.x,pos.y, aimingTip.x, aimingTip.y);
  noStroke();
  
}

void ShipDrivingKeyPressed() {
  if (keyCode == LeftKey) {
    leftBool = true;
  }
  if (keyCode == RightKey) {
    rightBool = true;
  }
  if (keyCode == ThrustKey) {
    thrustBool = true;
  }
}

void ShipDrivingKeyReleased() { //Better control for ship (multiple keys at once without confusing keys for others)
  if (keyCode == LeftKey) {
    leftBool = false;
  }
  if (keyCode == RightKey) {
    rightBool = false;
  }
  if (keyCode == ThrustKey) {
    thrustBool = false;
  }
}




void tracers() {
  for (int i = maxSize -1; i > 0; i--) { //Move each tracer back in array

    posh[i] = posh[i-1];

    sizes[i] = sizes[i-1]*shrinkscale;  //Shrink tracer as moving through array

    velh[i] = velh[i-1];
  }

  if (thrustBool && Energy > 5) {
    posh[0] = new PVector(pos.x - (12*sDir.x), pos.y-(12*sDir.y));

    velh[0] = new PVector (random(-sDir.x -tracerSpread, -sDir.x +tracerSpread), random(-sDir.y-tracerSpread,-sDir.y+tracerSpread),0);

    velh[0].mult(velscale);

    sizes[0] = startSize;
  } else { // If not pressing thrust, Then spawn Tracers out of screen

    posh[0] = new PVector(-1000, -1000);
  }

  for (int i = 0; i < maxSize; i++) {
    posh[i].add(velh[i]);
    fill(255, 100 - (float)i/maxSize*254., 0, 255. - (float)i/15*254.);
    //fill(50 + (float)i/maxSize*205, 128+127*sin((float)frameCount* PI/60), 127. - cos((float)frameCount*PI/30), 255. - (float)i/maxSize*254.);
    pushMatrix();

    ellipse(posh[i].x, posh[i].y, sizes[i]/3, sizes[i]/3);

    popMatrix();
    //sphere(posh[i].x, posh[i].y, sizes[i]/3, sizes[i]/3);
  }
}


void ShipDriving() {
  Gravity();
  Energy();
  pos.add(vel);
  acc.set(0, 0, 0);
if(playingMultiplayer){
  if(player1Turn){
    fill(25,0,255);
  }
  
  else if(player2Turn){
    fill(255,0,25);
  }
}
else{
  fill(255);
}
  pushMatrix();
  translate(pos.x, pos.y);
  rotate(sDir.heading());
  noStroke();
  box(shipLength,shipWidth, shipHeight );
  popMatrix();
  if (leftBool) { //add to rotation
    sDir.rotate(-turning);
    //dir -= .05;
  }
  if (rightBool) {
    sDir.rotate(turning);
    // dir += .05;
  } 

  if (thrustBool && Energy > 0) { //Increase Speed
    //speed += .1;
    acc = sDir.copy().mult(0.5);
    shipSound();
  } else { //Decrease Speed
    vel.mult(0.98);
    //speed *= 0.99;
  }
  aiming();
  vel.limit(speedLimit);
  //  speed = constrain(speed, 0, 4); //speedlimit
}


void ShipDrivingDraw() {
    

  noStroke();
  tracers();
  aiming();
  ShipDriving();
  
  
  //cam.lookAt(pos.x, pos.y, 0, 0, 500);

}
