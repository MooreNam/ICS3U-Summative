
Asteroid main;



ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();

PShape model;

PImage texture;
PVector center;

void AsteroidMainSetup() {
  AsteroidMainInit();
}

void AsteroidMainInit() {
  cam = new PeasyCam(this, width, height, 0, 600);
  center = new PVector(width/2, height/2, 0);
  texture = loadImage("texture.jpg");
  model = loadShape("ast.obj"); 
  model.setTexture(texture);

//the main asteroid in the center
new Asteroid(asteroids, 500., model, center, new PVector(),false, false, 0);


} 



void AsteroidMainDraw() {
  for(int i = 0; i < asteroids.size();i++){
    if(asteroids.get(i).asteroidType == 0){
      main = asteroids.get(i);
    }
  }
  main.pos =center;
  
  for (int i = 0; i < asteroids.size(); i++) {
    asteroids.get(i).update();
    
  }
  fill(255,45,0,80);
  
  
    ellipse(main.pos.x,main.pos.y,main.mass*0.85,main.mass*0.85);

cam.lookAt(main.pos.x,main.pos.y,main.pos.z,1500,0);

AsteroidSpawning();



}//end main
