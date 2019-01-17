
char[] cheatSpeed = new char[] {'m','o','o','l','a','h'};


int j = 0;



void CheatKeyPressed( char[] cheat) {
  cheat:
for (int i = j; i < cheat.length; ) {
    if (i == cheat.length-1 && key == cheat[i]) { //if i is the last letter in the cheat and the user presses that key change background
coins += 99999;
      j = 0;
            break cheat;

    } else if (key == cheat[i]) { //if user presses the right charachter in the cheat
      //Add 1 to K so program can check for next letter
      j++;  
      break;
    } else if (key != cheat[i]) { //if user presses any other keys start from beginning
      j = 0;
      break;
    }
  }
  
}//end CheatKeyPressed
