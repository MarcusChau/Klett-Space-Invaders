class Invader1 extends GamePieces {
  
  Invader1(float startingPosX, float startingPosY){
    xpos = startingPosX;
    ypos = startingPosY;
    invaderImage = loadImage("invader.GIF");
    explosionImage = loadImage("exploding.GIF");
    bounce = 2;
    SPACES_TO_BE_MOVED_DOWN = INVADER_HEIGHT/2;
    spacesMovedDown = 0;
    dx = 2;
    dy = 2;
    timeOfExplosion = -1;
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
    return 30; // Specific score for Invader1
  }
}
