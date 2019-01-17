PVector SpawnPoint;

int side;








//to spawn in different things from a certain distance from the edge
PVector SpawnPosition(int distanceFromEdge){
   side = (int)random(1,5);
   
      if(side == 1){
        SpawnPoint = new PVector (random(0,width),0+distanceFromEdge,0);
      }
      
      else if(side == 2){
                SpawnPoint = new PVector (width-distanceFromEdge,random(0,height),0);

      }
      
      else if(side == 3){
                SpawnPoint = new PVector (random(0,width),height-distanceFromEdge,0);

      }
      
      else if(side == 4){
 SpawnPoint= new PVector (0+distanceFromEdge,random(0,height),0);

      }

      return SpawnPoint;
}









void AsteroidSpawning(){
  
  
if(timePassed == true){
  //timers
       smallAsteroidTimer++;
              bigAsteroidTimer++;
              coinSpawnTimer++;
              powerupSpawnTimer++;
}
              
              //0 - main
              //1 - small
              //2 - big
   
              
              //small:
  if(smallAsteroidTimer >= 30){
      SpawnPosition(-500);
 new Asteroid(asteroids, random(6.,10.), model, SpawnPoint, new PVector(),true, false,1);
       smallAsteroidTimer = 0;
  }
  
  //big:
  if(bigAsteroidTimer >= 80){
      SpawnPosition(-500);
 new Asteroid(asteroids, random(25.,30.), model, SpawnPoint, new PVector(),true, false,2);
       bigAsteroidTimer = 0;
  }
  
  //Random spawning coins near main
  if(coinSpawnTimer >= 60){
      coinPos.add(SpawnPosition(100));
      coinSpawnTimer = 0;
  }
  
   //Random spawning powerups
  if(powerupSpawnTimer >= 120){
      powerupPos.add(SpawnPosition((int)random (-150,-375)));
      powerupType.add((int)random(1,3));
      
      powerupSpawnTimer = 0;
  }

//alien spawning




 
}
