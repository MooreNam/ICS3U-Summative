//coins
int coins;//amount of coins the player has
ArrayList <PVector> coinPos = new ArrayList <PVector>();
float coinDropPercentage = .25; //starts off at asteroids having a 25% chance to drop coins
float coinSize = 15;

//powerups
ArrayList <PVector> powerupPos = new ArrayList <PVector>();
ArrayList <Integer> powerupType  = new ArrayList <Integer>();
int powerupSize = 30;
int infEnergyAuraSize = 25;
int shieldSize = 60;

boolean shield;

boolean infEnergy;

 
void CoinsAndPowerupsSetup(){
shield = true;
infEnergy = false;
}


//coins
void coinDrop(PVector pos){
  float i = random(1);
  if (i <= coinDropPercentage){
    coinPos.add(pos.copy());
  }
}






//powerups



//draw
void CoinsAndPowerupsDraw(){

  for(int i = 0; i<coinPos.size();i++){
      fill(255,255,0);
    ellipse(coinPos.get(i).x,coinPos.get(i).y,coinSize,coinSize);
  }
  
  for(int i = 0; i<powerupPos.size();i++){
    
    if(powerupType.get(i) == 1){
          fill(0,70,255);
    }
    else if(powerupType.get(i) == 2){
    fill(255,25,0);
    }
    
    ellipse(powerupPos.get(i).x,powerupPos.get(i).y,powerupSize,powerupSize);
    
  }
  
 if(shield == true){
   fill(0,70,100,100);
    ellipse(pos.x,pos.y,shieldSize,shieldSize);
     shieldTimer++;
    if(shieldTimer >=180){
     shield = false;
     shieldTimer = 0;
    }
    
 }
  
  if(infEnergy == true){
    fill(255,25,0,255);
     ellipse(pos.x,pos.y,infEnergyAuraSize,infEnergyAuraSize);
    infEnergyTimer++; 
    if(infEnergyTimer >=160){
     infEnergy = false;
     infEnergyTimer = 0;
    }
  }
  
}
