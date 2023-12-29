// This is the blueprint for invader 1, 2 and 3
abstract class GamePieces {
  float xpos, ypos, speed, lastPosition, dx, dy;
  color invaderColor = color(0,0, 255);
  PImage invaderImage, explosionImage;
  int bounce, timeOfExplosion, SPACES_TO_BE_MOVED_DOWN, spacesMovedDown;
  boolean killed, exploded;
  
  void move() {
    // Code for moving
    if(killed == false){
      if(exploded == false){
 
        if(xpos-INVADER_WIDTH/2-SCREEN_BORDER <= 0){
          moveDown = true;
        }
      
        if(spacesMovedDown >= SPACES_TO_BE_MOVED_DOWN){
          moveDown = false;
          spacesMovedDown = 0;
          dx = -dx;
          xpos += dx;
        }
      
        if(moveDown == true){
          spacesMovedDown++;
          ypos += dy;
        }
        else{
          xpos += dx;
        }
      
        if(xpos+INVADER_WIDTH/2+SCREEN_BORDER >= width){
          moveDown = true;
        }
        
        if(ypos+INVADER_HEIGHT/2>=height-2*MARGIN){
          setup = true;
          bottomHit = true;
        }
      } 
    }
  }
  
   void draw() {
     if (!killed) {
       if (!exploded) {
         drawSpecific(); // Draw the specific invader
        } else {
         image(explosionImage, xpos - INVADER_WIDTH / 2, ypos - INVADER_HEIGHT / 2);
        }
      }
    }

  // Abstract method to be implemented in subclasses
  abstract void drawSpecific();
  
  
  void explode(Projectile projectile) {
    if (!exploded && !killed && projectile.hits(this)) {
      exploded = true;
      invaderDeath.play();
      invaderDeath.rewind();
      invaderImage = explosionImage;
      timeOfExplosion = frameCount;
      if (currentPowerUp != 4) {
        projectile.xpos = removeBullet; // Assuming this removes the bullet
      }
      score += getScoreValue(); // Score value might depend on the type of invader
    }
  }

  // General disappear method applicable to all invaders
  void disappear() {
    if (exploded && frameCount - timeOfExplosion == EXPLOSION_TIME) {
      killed = true;
      killCount++;
      xpos = removeInvader;
      ypos = removeInvader;
    }
  }

  // Method to return score value for different invader types
  int getScoreValue() {
    return 0; // Default score value, override in derived classes
  }
}
