int HUDheight = 30;

PImage heart;

public void HUDSetup() {
    //imageMode(CENTER);
    heart  = loadImage("gameHeart.png");
}

public void HUDDraw() {
  cam.beginHUD();
  //top section
  fill(0,0,25);
  rect(0, 0, width, HUDheight);
  fill(255);
//lives  
for(int i = 0; i < lives ; i++){
       image(heart, 25+i*25, 18, 20, 20);
}
    
    text("score: " + score, 200, 18);
    
    text("Energy: " , 300, 18);




//min and max energy correction
if(Energy < 0){
   Energy = 0; 
  }
  
if(Energy > maxEnergy){
     Energy = maxEnergy; 
    }
  
  
  //display amount of energy
  noStroke();
    rect(350, 5, Energy/2, 20);


//bottom section
  fill(0,0,25);
  rect(0, height-HUDheight, width, HUDheight);
  fill(255);
  
  


  
if(shield){
fill(0,50,255);
  rect(100, height-28, 180-shieldTimer, 5);
}

if(infEnergy){
  fill(255,50,0);

  rect(100, height-15, 160-infEnergyTimer, 5);
}

if(playingMultiplayer ){
  fill(255);
  if(player1Turn){
text("player 1's turn",200,height-HUDheight/2);
  }
  else if(player2Turn){
    text("player 2's turn",200,height-HUDheight/2);

  }
}
  cam.endHUD();
}
