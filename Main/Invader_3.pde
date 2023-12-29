class Invader3 extends GamePieces {
  
  int spacesMoved; //spacesMove
  float  SPACES_TO_BE_MOVED_VERTICALLY; //Vertical_Space_Moved
  
  Invader3(float startingPosX, float startingPosY){
    xpos = startingPosX;
    ypos = startingPosY;
    invaderImage= loadImage("invader.GIF");
    explosionImage= loadImage("exploding.GIF");
    bounce = 2;
    SPACES_TO_BE_MOVED_DOWN = INVADER_HEIGHT/2;
    spacesMovedDown = 0;
    dx = 2;
    dy = 2;
    timeOfExplosion =-1;
    spacesMoved = 0;
    exploded = false;
  }
  
  //Draw invader with his specific invader_2 configuration
  @Override
  void drawSpecific() {
      // Specific drawing logic for Invader1
      fill(invaderColor);
      noStroke();
      image(invaderImage, xpos-INVADER_WIDTH/2, ypos-INVADER_HEIGHT/2);
  }
  
  
  //Test to see if a projectile kills the invader. If so, make him explode.
  @Override
  int getScoreValue() {
    return 60; // Specific score for Invader1
  }
}
