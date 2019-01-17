

void shopKeyReleased(){

  if(keyCode == '1'){
    gunType = 0;
  }
  
  else if(keyCode == '2'){
    if(boughtShotgun == false  ){
      if( coins >= 50){
          boughtShotgun = true;
      gunType = 1;
    coins-=50;
      }
    }
    
    else {
      gunType = 1;
    }
    
  }
  
  
  
    else if(keyCode == '3'){
    if(boughtLaser == false ){
      if( coins >= 150){
          boughtLaser = true;
      gunType = 2;
      coins -= 150;
      }
    }
    
    else{
      gunType = 2;
    }
    
  }
  
   else if(keyCode == '4'){
    if(boughtHomingMissile == false ){
      if( coins >= 110){
          boughtHomingMissile = true;
      gunType = 3;
      coins -= 110;
      }
    }
    
    else{
      gunType = 3;
    }
    
  }
  
   else if(keyCode == '5'){
    if(boughtShockwave == false ){
      if( coins >= 80){
          boughtShockwave = true;
      gunType = 4;
      coins -= 80;
      }
    }
    
    else{
      gunType = 4;
    }
    
  }
  
  else if(keyCode == '6'){
    if(boughtAuto == false ){
      if( coins >= 10){
          boughtAuto = true;
 autoEnabled =true;
      coins -= 10;
      }
    }
    
    else if (boughtAuto == true && autoEnabled == false){
 autoEnabled =true;
    }
    
    else if (boughtAuto == true && autoEnabled == true){
 autoEnabled =false;
    }
    
  }
  else if(keyCode == 'X'){
   gameState = 0; 
  }
  
}







void shopDraw(){
     background(240, 70, 25);
  text("Garage\n\ncoins: " + coins, width/2-15, height/2-230);
    text("Select the Key of What would you like to buy/equip/unequip\n\nPress 'x' to return to main menu", width/2-130, height/2-170);
  
      text("1 - Regular", width/2-230, height/2-110);
 
  
   text("2 - Shotgun (50)", width/2-30, height/2-110);
 
  
  
   text("3 - Laser (150)", width/2+170, height/2-110);
   
      text("4 - HomingMissiles (110)", width/2-230, height/2-40);
      
      

      text("5 - Shockwave (80)", width/2-30, height/2-40);
   
         text("6 - Auto (10)", width/2+170, height/2-40);

   
    if(gunType == 0){
          text("Equipped", width/2-230, height/2-90);
  }
  
  else if(gunType == 1){
          text("Equipped", width/2-30, height/2-90);
  }
  
  else if(gunType == 2){
          text("Equipped", width/2+170, height/2-90);
  }
  
   else if(gunType == 3){
          text("Equipped", width/2-230, height/2-20);
  }
  
   else if(gunType == 4){
          text("Equipped", width/2-30, height/2-20);
  }
  
  
  if(autoEnabled){
    
              text("In use", width/2+170, height/2-20);
  }
  
   
}
