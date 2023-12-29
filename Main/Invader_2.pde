class Invader2 extends GamePieces {
  int spacesMoved;
  float  SPACES_TO_BE_MOVED_VERTICALLY;
  
  Invader2(float startingPosX, float startingPosY){
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
  
  @Override
  void drawSpecific() {
      // Specific drawing logic for Invader1
      fill(invaderColor);
      noStroke();
      image(invaderImage, xpos-INVADER_WIDTH/2, ypos-INVADER_HEIGHT/2);
  }
  

  @Override
  int getScoreValue() {
    return 50; // Specific score for Invader1
  }
}
