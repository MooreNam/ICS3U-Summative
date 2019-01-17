Minim minim;

AudioPlayer gun1, rocket, background1, background2,astroidDestroyed;

boolean muted;

int backgroundMusicSelector = 1;

void SoundSetup() {
  minim = new Minim(this);

      //loading files
      
      gun1 = minim.loadFile("RetroLaserGun.wav");
      rocket = minim.loadFile("RumblingEngine.wav");
      background1 = minim.loadFile("PeacefulBackgroundMusic.wav");
      background2 = minim.loadFile("90sPop.wav");
      astroidDestroyed = minim.loadFile("SoftPoppingSound.aiff");
      muted = false;

     
}


void gunSound (){
 if(muted == false ){
       gun1.rewind(); 

      gun1.play();
   
   } 
}

void shipSound (){
  if(muted == false){
  rocket.play();
      if(rocket.position() == rocket.length()){
       rocket.rewind(); 
      }
  }
}

void asteridDestroyedSound(){
  if(muted == false){
        astroidDestroyed.rewind(); 
 astroidDestroyed.play();
  }
}

void SoundKeyReleased() {

    
  }
  
  
  
  
  
  
  void MusicSound (){
   if(backgroundMusicSelector == 1){
    background1.play();
    background2.pause();
   }
   else if(backgroundMusicSelector == 2){
background2.play();
    background1.pause();

     
   }
   
   
   
    if(muted == true){
       background1.pause();
              background2.pause();

       rocket.pause();
       
       
    }
    
    if(muted == false && (background1.position() == background1.length()  || background2.position() == background2.length())){
      background1.rewind();
          background2.rewind();
    
  }
  }
