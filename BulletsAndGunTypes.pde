//Global variables
ArrayList <PVector> velB = new ArrayList <PVector>();
ArrayList <PVector> posB = new ArrayList <PVector>();
ArrayList <PVector> accB = new ArrayList <PVector>();


boolean isShooting = false;
boolean autoEnabled = false;
boolean boughtAuto = false;
boolean boughtShotgun = false;
boolean boughtLaser = false;
boolean boughtHomingMissile = false;
boolean boughtShockwave = false;

boolean readyToShoot;  
boolean shot = false; //when the player shoots this is set to true
float bulletSpeed;
float bulletSize;

float bulletEnergyCost;

int gun0EnergyCost = 20; 
int gun1EnergyCost = 70;  
int gun2EnergyCost = 10;  
int gun3EnergyCost = 120; 
int gun4EnergyCost = 100; 


int gun0FireRate = 1;
int gun1FireRate = 3;
int gun2FireRate = 0;
int gun3FireRate = 7;
int gun4FireRate = 5;

int fireRate;

int shotgunBulletsNum = 3;
float shotgunSpread = 7 ; //the higher the number the les spread

int laserLength = 1000;


int gunType = 0;

/*gunTypes:
 0 - regular
 1 - shotgun
 2 - laser
 3 - homing missile
 4 - shockwave
 */

void BulletsSetup() {
  bulletSpeed = 20;
  bulletSize = 10;
  readyToShoot = true;
  //  pos = new PVector(width/2, height/2, 0);
  sDir = new PVector(0, -1, 0);
}

void SelectEnergyCost () {
  if(infEnergy){
 bulletEnergyCost = 0; 
 }
 else if (gunType == 0) {
    bulletEnergyCost = gun0EnergyCost;
  } else if (gunType == 1) {
    bulletEnergyCost = gun1EnergyCost;
  } else if (gunType == 2) {
    bulletEnergyCost = gun2EnergyCost;
  } else if (gunType == 3) {
    bulletEnergyCost = gun3EnergyCost;
  } else if (gunType == 4) {
    bulletEnergyCost = gun4EnergyCost;
  }
}//end energyCost



void SelectFireRate () {
  if(infEnergy){
 fireRate = 0; 
 }
 else if (gunType == 0) {
    fireRate = gun0FireRate;
  } else if (gunType == 1) {
    fireRate = gun1FireRate;
  } else if (gunType == 2) {
    fireRate = gun2FireRate;
  } else if (gunType == 3) {
    fireRate = gun3FireRate;
  } else if (gunType == 4) {
    fireRate = gun4FireRate;
  }
}//end fireRate


//Shooting for each gunType

//regular
void gun0Shoot() {

  posB.add(new PVector(pos.x, pos.y, pos.z));

  PVector tempv = new PVector(sDir.x, sDir.y, sDir.z).mult(bulletSpeed);
  velB.add(tempv);
}

//shotgun
void gun1Shoot() {
  for (int i = 0; i<shotgunBulletsNum; i++) {
    posB.add(new PVector(pos.x, pos.y, pos.z));
    PVector tempv = new PVector(sDir.x, sDir.y, sDir.z).rotate(random(-PI/shotgunSpread, PI/shotgunSpread)).mult(bulletSpeed);
    velB.add(tempv);
  }
}


//laser
void gun2Shoot() {  


  //drawing the laser
  PVector laserTip = new PVector (pos.x - (laserLength*-sDir.x), pos.y-(laserLength*-sDir.y));
  stroke(200, 30, 10, 80); //colour of line
  strokeWeight(5);
  line(pos.x, pos.y, laserTip.x, laserTip.y);
  noStroke(); 

  //to find which asteroids the laser is hitting
  for (int i = 1; i <asteroids.size(); i++) {

    if (PVector.dist(getDistance(pos.x, pos.y, laserTip.x, laserTip.y, asteroids.get(i).pos.x, asteroids.get(i).pos.y), asteroids.get(i).pos)< asteroids.get(i).siz) {
               explosions.add(new Explosion(asteroids.get(i).pos, new PVector(asteroids.get(i).siz*10,asteroids.get(i).siz*10), explosions, explosionImages, 5)); 
         explosions.add(new Explosion(asteroids.get(i).pos, new PVector(asteroids.get(i).siz*10,asteroids.get(i).siz*10), explosions, explosionImages, 5)); 
      asteroids.remove(i);
    }
  }
}//end laser





//homing missile
void gun3Shoot() {

  int angleMissilesAreShotFrom = 70;

  posB.add(new PVector(pos.x, pos.y, pos.z));
  PVector tempv = new PVector(sDir.x, sDir.y, sDir.z).rotate(angleMissilesAreShotFrom).mult(bulletSpeed*.1);
  velB.add(tempv);
  accB.add(new PVector());
  homingMissileDelayArray.add(new PVector(0,0,0));


 
  posB.add(new PVector(pos.x, pos.y, pos.z));
  tempv = new PVector(sDir.x, sDir.y, sDir.z).rotate(-angleMissilesAreShotFrom).mult(bulletSpeed*.1);
  velB.add(tempv);
    accB.add(new PVector());
  homingMissileDelayArray.add(new PVector(0,0,0));

  
  
  
}

PVector findClosestAsteroid(PVector pos){
  PVector target = new PVector(99999,999999);

  for(int i = 1; i < asteroids.size();i++){
    if(dist(pos.x,pos.y,asteroids.get(i).pos.x, asteroids.get(i).pos.y) < dist(pos.x,pos.y,target.x, target.y)){
      target = asteroids.get(i).pos.copy();
    }
  }
  
  
  return target;
}


//homing missile homing in
void homingMissilDraw () {
  for(int i = 0; i<posB.size(); i++){
    
    if(homingMissileDelayArray.get(i).x >=10 && asteroids.size() > 1){
 PVector tempAcc = PVector.sub(findClosestAsteroid(posB.get(i)), posB.get(i));//this gets the direction we need
  tempAcc.normalize(); //this reduces the magnitude to 1 so we can scale it
  

  tempAcc.mult(0.25);//velB.get(i).add(tempv);
  
  accB.get(i).add(tempAcc);
  
  velB.get(i).add(accB.get(i));
  
    accB.get(i).set(0, 0, 0);
    }
  }
  
}

//shockwave gun thingy
void gun4Shoot() {
  int seperation = 10;
  for (int i = 0; i<10; i++) {
    posB.add(new PVector(pos.x, pos.y, pos.z));
    PVector tempv = new PVector(sDir.x, sDir.y, sDir.z).rotate(PI/(i*seperation)).mult(bulletSpeed);
    velB.add(tempv);

    posB.add(new PVector(pos.x, pos.y, pos.z));
    tempv = new PVector(sDir.x, sDir.y, sDir.z).rotate(PI/(-i*seperation)).mult(bulletSpeed);
    velB.add(tempv);
  }
}




//Shooting style according to current gunType 
void SelectGunTypeShoot () {
  //regular 
  if (gunType == 0) {
    gun0Shoot();
  }

  //shotgun
  else if (gunType == 1) {
    gun1Shoot();
  }


  //laser
  else if (gunType == 2) {
    gun2Shoot();
  }


  //homing missile
  else if (gunType == 3) {
    gun3Shoot();
  }
  //shockwave
  else if (gunType == 4) {
    gun4Shoot();
  }
}


//shooting
void BulletsAndGunsKeyPressed() {
  if (keyCode == ShootKey ) {

    isShooting = true;
  }
}


void BulletsAndGunsKeyReleased() {
  if (keyCode == ShootKey) {
    isShooting = false;
  }
}


void shooting() {

  SelectEnergyCost();
  SelectFireRate();
  
  if (isShooting == true && Energy > bulletEnergyCost && gunTimer >= fireRate) {
    SelectGunTypeShoot();
    gunSound(); 
    Energy -= bulletEnergyCost;
    gunTimer = 0;
    if(boughtAuto == false){
      isShooting = false;
    }
  }






  //if(timePassed ){
  //  gunTimer++;
  //  if(gunTimer >= fireRate){
  //    readyToShoot = true;
  //    gunTimer = 0;
  //  }

  //}
}









public boolean detect(PVector pos1, PVector pos2, float rad) {
  boolean isFar = PVector.dist(pos1, pos2) > rad;
  return isFar;
}

void bullet() {



  for (int i = 0; i < posB.size(); i++) {
    PVector p = posB.get(i);
    PVector v = velB.get(i);

if(gunType == 3){
  homingMissilDraw(); 
  
  if(homingMissileDelayArray.get(i).x > 20){
    removeBullet(i);
  }
  
}


    p.add(v);

    noStroke();
    pushMatrix();
    translate(p.x, p.y, p.z);
    
   
    fill(random(50,255),random(50,255),random(50,255));
    
   
    
  
    sphere(bulletSize);
    
    popMatrix();


    if (detect(p, new PVector(width/2, height/2), width*2)) {
      posB.remove(p);
      velB.remove(v);
    }
    
    
    
  }
  
  if(timePassed){
    gunTimer++;
    if(gunType == 3){
    for(int i = 0; i < posB.size(); i++){
homingMissileDelayArray.get(i).x ++ ;
    }
    }
}
  
  
}//end bullet


boolean hitTarget(PVector target, PVector bulletPos, float targetRad, float bulletRad) {

  return target.dist(bulletPos)<targetRad+bulletRad;
}




//distance between a point and a line (for laser)
PVector getDistance( float x1, float y1, float x2, float y2, float x, float y ) {
  PVector result = new PVector(); 

  float dx = x2 - x1; 
  float dy = y2 - y1; 
  float d = sqrt( dx*dx + dy*dy ); 
  float ca = dx/d; // cosine
  float sa = dy/d; // sine 

  float mX = (-x1+x)*ca + (-y1+y)*sa; 

  if ( mX <= 0 ) {
    result.x = x1; 
    result.y = y1;
  } else if ( mX >= d ) {
    result.x = x2; 
    result.y = y2;
  } else {
    result.x = x1 + mX*ca; 
    result.y = y1 + mX*sa;
  }

  dx = x - result.x; 
  dy = y - result.y; 
  result.z = sqrt( dx*dx + dy*dy ); 

  return result;
}

void BulletsDraw() {
  
  shooting();
  bullet();
}
