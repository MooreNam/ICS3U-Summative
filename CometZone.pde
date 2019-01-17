import peasy.*;
import ddf.minim.*;
int gameState;
int lives;
int maxLives = 3;
int maxMaxLives = 6;
int score;
int player1Score;
int player2Score;
boolean player1Turn = false;
boolean player2Turn = false;

int[] scores = new int[5];
int highScore = scores[0];
PeasyCam cam;
boolean playingMultiplayer = false;

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
 8 - instructions
 9 - multiplayer between turns
 10 - multiplayer end
 
 
 to do:
 
 FIX BULLET SHOOTING SOUND
 

 - settings
 - multiplayer 
 - alien ship that shoots at player(s)
 - coin animation showing how many coins the player has (bottom section of HUD)
 */



void setup() {
   
  midPoint = new PVector(width/2, height/2, mult/2); 

  smooth(8);
  size(680, 710, P3D);
   imageMode(CENTER);

  frameRate(50);

  BulletsSetup();
  HUDSetup();
  SoundSetup();
  ShipDrivingSetup();

  AsteroidMainSetup();
ExplosionsSetup();
  StarBackgroundSetup();
  TimerSetup();

  score = 0;
  gameState = 0;
  lives = 3;
}


void keyPressed() {

  if (gameState == 1) {
    gameState1KeyPressed();
  }
  CheatKeyPressed(cheatSpeed);
}//end keyPressed


void keyReleased() {

  if (gameState ==0) {
    gameState0KeyReleased();
  } else if (gameState == 1) {
    gameState1KeyReleased();
  } else if (gameState == 2) {
    gameState2KeyReleased();
  } else if (gameState == 3) {
    gameState3KeyReleased();
  }else if (gameState == 4) {
    gameState4KeyReleased();
  }
  else if(gameState == 6){
   gameState6KeyReleased(); 
  }
  else if(gameState == 7){
   gameState7KeyReleased(); 
  }
 else if (gameState == 8){
 gameState8KeyReleased ();
}
else if(gameState == 9){
 gameState9KeyReleased(); 
}

else if(gameState == 10){
 gameState10KeyReleased(); 
}
}//end keyReleased


void draw() {

  Timer();
  MusicSound();


  if (gameState == 0) {

    gameState0Draw();
  } else if (gameState == 1) {

    gameState1Draw();
  } else if (gameState == 2) {

    gameState2Draw();
  } else if (gameState == 3) {
    gameState3Draw();
  }else if (gameState == 4) {
    gameState4Draw();
  }else if (gameState == 5) {
    gameState5Draw();
  }else if (gameState == 6) {
    gameState6Draw();
  }  else if (gameState == 7) {
    gameState7Draw();
  }
  else if (gameState == 8) {
  gameState8Draw();
  }
    else if (gameState == 9) {
  gameState9Draw();
  }
    else if (gameState == 10) {
  gameState10Draw();
  }

}//end draw
