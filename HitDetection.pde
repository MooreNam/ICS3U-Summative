


int EnergyFromAsteroids = 270;



void scoreUpdate(){
  scoreUpdate:
  for(int i = 0; i < scores.length ; i++){
  if(score > scores[i]){
   
    for(int j = scores.length-1; j > i ; j--){
      scores[j] = scores[j-1];
    }
    scores[i] = score;
    break scoreUpdate;
  }
  }  
  
   highScore = scores[0];

  }//end scoreUpdate
  
  
  
void removeBullet(int i){
         posB.remove(i);
        velB.remove(i);
        if(gunType == 3){
        accB.remove(i);
        homingMissileDelayArray.remove(i); 
        }
}


void removePowerup(int i){
  powerupPos.remove(i);
  powerupType.remove(i);
}


void HitDetection() {
  
  for (int i = 0; i < asteroids.size(); i++) {
     
     //main asteroids and asteroids
     //if(hitTarget(main.pos, asteroids.get(i).pos, main.siz, asteroids.get(i).siz)){
     //  if(i == 0){
     //   continue; 
     //  }
     //  else if (i > 0){
         
     //  }
       
     //}
    
    //player and asteroids
     if (hitTarget(asteroids.get(i).pos, pos, asteroids.get(i).siz, shipLength+5)&& shield == false) {
    ShipDrivingSetup();;
    lives--;
  }
  
   
   
  if (lives <= 0) {
    if(playingMultiplayer == false){
    scoreUpdate();  
    gameState = 2;

    }
    else{
     if(player1Turn){
       player1Turn = false;
       player1Score = score;
gameState = 9;
   }
     else if(player2Turn){
    player2Turn = false;
    player2Score = score;
    gameState = 10;
     }
    }
lives =  maxLives;;
    
  }
    

    
    //asteroids and bullets
    for(int j = 0; j < posB.size(); j++){
      
    
 
      
      if(hitTarget(asteroids.get(i).pos, posB.get(j), asteroids.get(i).siz, bulletSize)){
        if(asteroids.get(i).asteroidType != 0){
         explosions.add(new Explosion(asteroids.get(i).pos, new PVector(asteroids.get(i).siz*10,asteroids.get(i).siz*10), explosions, explosionImages, 5)); 
        }
        
    if(asteroids.get(i).asteroidType == 1){
     
        
        
     asteroids.get(i).isDead = true;
     removeBullet(j);
       score += 75;
       Energy += EnergyFromAsteroids;
       
       coinDrop(asteroids.get(i).pos);
 asteridDestroyedSound();      

 }
        
        else if(asteroids.get(i).asteroidType == 2){
         
 score += 50;
       Energy += EnergyFromAsteroids;
     removeBullet(j);

asteroids.get(i).asteroidType = 1;
      Asteroid baby = new Asteroid(asteroids.get(i),asteroids.get(i).mass/2,PVector.random2D()); 
            baby.asteroidType = 1;
            
        }
        
        
        
        else if (asteroids.get(i).asteroidType == 0){
               removeBullet(j);

        
        }
       
     }
    }
  }

 //player and coins
 for (int i = 0; i < coinPos.size(); i++) {
   if (hitTarget(coinPos.get(i), pos, coinSize, shipLength+5)) {
     coinPos.remove(i);
    coins++;
  }
 }
 
 
 
 //player and powerups
  for (int i = 0; i < powerupPos.size(); i++) {
 if (hitTarget(powerupPos.get(i), pos, powerupSize, shipLength+5)) {

   if(powerupType.get(i) == 1){
   shield = true;  
   removePowerup(i);
   }
   else if(powerupType.get(i) == 2){
   infEnergy = true;  

   removePowerup(i);
 


   }
   
 }
  }
 

 }//end hit detection
