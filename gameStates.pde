
//removes lingering asteroids and bullets from previous game when retrying
void Clear (){
  
  //asteroids
 for(int i = 1; i <asteroids.size(); i++){
    asteroids.get(i).isDead = true; 
 }
 
 //aliens
 for(int i = 0; i < alienPos.size();i++){
  alienPos.remove(i);
  alienVel.remove(i);
 }
 
 
 //bullets
 //player's bullets
 for(int i = 0; i < posB.size(); i++){
        velB.clear(); 
        posB.clear(); 
        
 }
 
 //alien bullets
 for(int i = 0; i <alienPosB.size();i++){
   
   alienPosB.remove(i);
   alienVelB.remove(i);
   
 }
 
 
 //coins and powerups
 for(int i = 0; i < coinPos.size();i++){
  coinPos.remove(i); 
 }
 
 for(int i = 0; i <powerupPos.size();i++){
   powerupPos.remove(i);
   powerupType.remove(i);
 }
 
}//end clear


/*
gamestates:
 0 - start
 1 - single player
 2 - died
 3 - pause
 4 - settings
 5 - controls
 6 - music 
 7 - garage
 */



//what to draw during different gameStates
void gameState0Draw () {
  cam = new PeasyCam(this, midPoint.x, midPoint.y, 0, 500);

  background(240, 70, 25,100);
  text("COMET ZONE", width/2-60, height/2-150);
    text("High Score Is: " + highScore , width/2-65, height/2-60);
    text("Coins: " + coins , width/2-55, height/2-35);

  text("Press the spacebar to start\n\nPress '1' to open the Garage\n\nPress '2' to open the settings\n\nPress '3' to view the instructions\n\nPress '4' to enable/disable multiplayer mode", width/2-77, height/2+80);

  text("Multiplayer enabled = " + playingMultiplayer,width/2-65, height/2+205);


  cam.lookAt(width/2, height/2, 0, 100);
}

void gameState1Draw () {
  StarBackgroundDraw();
  AsteroidMainDraw();
  ExplosionsDraw();
  CoinsAndPowerupsDraw();
  ShipDrivingDraw();
  HitDetection();
  BulletsDraw();
  HUDDraw();
}

void gameState2Draw () {

  cam = new PeasyCam(this, midPoint.x, midPoint.y, 0, 500);

  background(240, 70, 25); 
  text("You are Dead x-x", width/2-40, height/2-60);
  text("Score: " + score, width/2-80, height/2);
  for (int i=0; i < scores.length; i++) {
    text("Score" + (i+1) + ": " + scores[i], width/2+60, height/2+(i*15));
  }
  text("Press 'r' to try again!\n\nPress '1' to open the Garage\n\nPress '2' to return to the Main Menu", width/2-77, height/2+90);

}

void gameState3Draw () {
  cam = new PeasyCam(this, midPoint.x, midPoint.y, 0, 500);

  background(240, 70, 25);
  fill(255);
  text("PAUSED", width/2-15, height/2-60);
  text("Press the spacebar to continue", width/2-70, height/2-20);
  text("Press '1' to head back to the Garage\n\nPress '2' to return to the main menu \n\n (your current score will not be counter if you don't continue)", width/2-85, height/2+20);
}

void gameState4Draw () {

    background(240, 70, 25);
  text("SETTINGS", width/2-15, height/2-60);
  text("1 - Controls\n2 - Music", width/2-15, height/2-30);
  
}


void gameState5Draw () { 
    background(240, 70, 25);
  text("Controls", width/2-15, height/2-60);
  
  for(int i = 0; i<KeyControls.length; i++){
    text((i+1)+" - " + "'" + KeyControls[i] + "'", width/2-25, height/2-40+(i*15));
  }
}

void gameState6Draw () {
    background(240, 70, 25);
  text("Music", width/2-15, height/2-120);
    text("Press 'm' to mute the game\n\n\n\n\n\n\nPress the corresponding \n\nkey to select the background music you want\n\n\n\n1 - PeacefulBackgroundMusic\n\n2 - Crazy 90s Pop\n\n(beware of volume)\n\n\n\nPress 3 to go back to the main menu", width/2-50, height/2-80);

}
void gameState7Draw () {
shopDraw();
}  

void gameState8Draw(){
      background(240, 70, 25);

    text("Instructions\n\nPress 'x' to return\nto the main menu", width/2-15, height/2-270);
    text("You are a spaceship that can fire bullets\n\nYou're goal is to last as long as possible\n\nTo do so, shoot incoming asterids to destroy them,\n\nand prevent them from combining with the large asteroid\n\nin the center. The larger the center asteroid gets, \n\nthe more powerful the gravity gets, which will lead to it\n\neventually sucking you in. You have 3 lives so use them wisely.\n\nYou can collect coins by destroying asteroids (25% chance)\n\n and then flying over them. Coins also occasionally spawn near\n\nthe center, so you can take some risks to get extra coins\n\nPay attention to your energy bar in the top right. flying and shooting\n\ndrains your energy, and different guns consume different amounts of energy\n\nAs for powerups, there are two. 1 is a shield making you invincible\n\nfor a short time, and the other powerup gives you \n\nunlimited energy for a short time.\n\n    HAVE FUN", width/2-190, height/2-208);

}

void gameState9Draw(){
    cam = new PeasyCam(this, midPoint.x, midPoint.y, 0, 500);

        background(240, 70, 25);
    text("Player1 scored: " + player1Score + "\n\n\n\nPress 'n' when player2 is ready to play", width/2-20, height/2-70);
    

}

void gameState10Draw(){
    cam = new PeasyCam(this, midPoint.x, midPoint.y, 0, 500);

          background(240, 70, 25);
text("Player2 scored: " + player2Score,width/2-20, height/2-70);

if(player1Score > player2Score){
  text("Player1 WINS by " +( player1Score-player2Score) + " points",width/2-20, height/2);

}
else if(player2Score > player1Score){
    text("Player2 WINS by " +( player2Score-player1Score) + " points",width/2-20, height/2);

}
else if(player1Score == player2Score){
    text("       It's a TIE\n\nBoth players scored " +( player1Score) + " points",width/2-20, height/2);

}

text("Press '1' to go back to the main menu",width/2-35, height/2+50);


}




//keyPressed



void gameState1KeyPressed(){
   ShipDrivingKeyPressed();
    BulletsAndGunsKeyPressed();
    
    if(keyCode == 'P'){
      gameState = 3;
    }
}









//keyReleased
void gameState0KeyReleased(){
 
  if (keyCode == ' ') {
    
    if(playingMultiplayer){
     player1Turn = true;
     player2Turn = false;
     player1Score = 0;
     player2Score = 0;
    }
    
                 Clear();

      ShipDrivingSetup();
        TimerSetup();
CoinsAndPowerupsSetup();
      score = 0;
      lives =  maxLives;

   gameState = 1;
   
  }
  
  
  else if(keyCode == '1'){
    gameState = 7;
  }
  
  else if(keyCode == '2'){
   gameState = 4; 
  }
  
  else if(keyCode == '3'){
   gameState = 8; 
  }
  else if(keyCode == '4'){
    if(playingMultiplayer == false){
        playingMultiplayer = true; 
 
    }
    else{
         playingMultiplayer = false; 

    }
    
  }

}

void gameState1KeyReleased(){
   ShipDrivingKeyReleased();
   BulletsAndGunsKeyReleased();
}

void gameState2KeyReleased(){
  
    if (keyCode == 'R') {
          Clear();

      ShipDrivingSetup();
      main.mass = 500.;
        TimerSetup();
CoinsAndPowerupsSetup();

      score = 0;
      gameState = 1;
      
  }
  else if (keyCode == '1'){
    gameState = 7;
  }
  else if (keyCode == '2'){
    gameState = 0;
  }


}

void gameState3KeyReleased(){
   if (keyCode == ' '){
      gameState = 1;
    }
    else if (keyCode == '1'){
      gameState = 7;
            Clear();
     
      main.mass = 500.;

      score = 0;
lives =  maxLives;    }
    else if (keyCode == '2'){
      gameState = 0;
            Clear();
     
      main.mass = 500.;

      score = 0;
lives =  maxLives;    }

}

void gameState4KeyReleased (){
  if (keyCode == '1'){
   gameState = 5; 
  }
  else if (keyCode == '2'){
    gameState = 6;
  }

}

void gameState6KeyReleased(){
  
    if (keyCode == 'M'){
      
      if(muted == false){
        muted = true;
      }
      
      else if(muted == true){
       muted = false; 
      }
    }
    
    else if(keyCode == 1){
     gameState = 0;  
    }
    
    else if(keyCode == '1'){
  backgroundMusicSelector = 1;
}

else if(keyCode == '2'){
  backgroundMusicSelector = 2;
}

else if(keyCode == '3'){
gameState = 0;
}



}




void gameState7KeyReleased(){
 shopKeyReleased(); 
}

void gameState8KeyReleased(){
  if(keyCode == 'X'){
   gameState = 0; 
  }
}

void gameState9KeyReleased(){
  if(keyCode == 'N'){
    player2Turn = true;
    Clear();

      ShipDrivingSetup();
      main.mass = 500.;
        TimerSetup();
CoinsAndPowerupsSetup();
      score = 0;
   gameState = 1; 
  }
}

void gameState10KeyReleased(){
  if(keyCode == '1'){
   gameState = 0; 
  }
}
