ArrayList <PVector> alienPos = new ArrayList <PVector> ();
ArrayList <PVector> alienVel = new ArrayList <PVector> ();
ArrayList <PVector> alienPosB = new ArrayList <PVector> ();
ArrayList <PVector> alienVelB = new ArrayList <PVector> ();
ArrayList <PVector> alienBulletTimer = new ArrayList <PVector> ();

PVector [] corners = new PVector [4];

void alienSetup(){
  
}



void addAlien(){
  
      alienPos.add(SpawnPosition((int)random (-200)));
  alienVel.add(new PVector());
  alienBulletTimer.add(new PVector());
  
}

void alienBullets (){
  
}

void findClosestCorner(PVector pos){
  PVector closestCorner = new PVector (9999,9999);
  
}

void alienMovement (){
  
}


void alienDraw(){
  
   for(int i = 0; i <alienPos.size(); i++){
  pushMatrix();
  translate(alienPos.get(i).x,alienPos.get(i).y);
  rotate(sDir.heading());
  noStroke();
  box(shipLength,shipWidth, shipHeight );
  popMatrix();
   }
   
   
}
