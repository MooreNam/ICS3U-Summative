ArrayList<Explosion> explosions = new ArrayList<Explosion>();//need this to hold all explosions

PImage[] explosionImages = new PImage[8];//to hold the explosionImages of the explosion

 void ExplosionsSetup(){
  
   
   //loading explosionImages   
   for(int i = 0; i < explosionImages.length; i ++){
       explosionImages[i] = loadImage("explosion"+i+".png");
   }

}


void ExplosionsDraw(){
  //go throdugh the list of explosions update them and draw them
  for (int i = 0; i < explosions.size(); i++){
     explosions.get(i).draw();   //this is very important 
  }
}
  
  class Explosion {

  ArrayList<Explosion> explosions;
  PImage[] explosionImages ;
  PVector pos = new PVector();
  PVector siz = new PVector();//using this for the height and width
  float scale = 0.1;
  int count;
  int currentFrame;
  int framesPerImage = 1;//speed of animation with lower numbers going faster 
PVector exSize = new PVector(60, 60);//need this for how big of an explosion


//need to call this to make an explosion
  Explosion(PVector _pos, PVector _siz, ArrayList<Explosion> _e, PImage[] _explosionImages, int _framesPerImage) {
    explosions = _e;
    explosions.add(this);
    pos = _pos;
    siz = _siz;
    explosionImages = _explosionImages;
    framesPerImage = _framesPerImage;
    count = 0;
  }

 //don't confuse this with the main sketch's draw method
  void draw() {
     //have we gone through an complete animation?   
    if (checkActive()){
      image(explosionImages[currentFrame], pos.x, pos.y, siz.x, siz.y);
    }
    else {
       explosions.remove(this);//this removes it from the list if we are done exploding 
    }
  }

//this checks to see if we have completed one cycle of an explosion
  boolean checkActive() {
    count ++;
    currentFrame = count/framesPerImage;
    return currentFrame < explosionImages.length;
  }
}
