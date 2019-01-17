

double   timerA ;  //start
double timerB; //current
boolean timePassed ;



int smallAsteroidTimer;
int bigAsteroidTimer;
int asteroidSpawnTimer;
int bulletTimer;
int RespawnShieldTimer;
boolean Respawning;
int coinSpawnTimer;
int coinDisappearTimer;
int gunTimer;
int powerupSpawnTimer;
int shieldTimer;
int infEnergyTimer;
int alienSpawnTimer;
ArrayList <PVector> homingMissileDelayArray = new ArrayList <PVector> ();


void TimerSetup(){
     timerA = millis();  //start
 timerB = millis() - timerA; //current
 timePassed = false;



 smallAsteroidTimer = 0;
 bigAsteroidTimer = 0;
 bulletTimer = 0;
 RespawnShieldTimer = 0;
 Respawning = true;
 coinDisappearTimer = 0;
 coinSpawnTimer = 0;
 gunTimer = 0;
shieldTimer = 0;
infEnergyTimer = 0;
alienSpawnTimer = 0;

}


boolean Timer(){
 timePassed = false;
  
  timerB = millis() - timerA;
  
  if(timerB > 100){
          timePassed = true;
        timerA = millis();

  }

    return timePassed;
}
