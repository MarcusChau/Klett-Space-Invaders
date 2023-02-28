class Player {
  float xpos; float ypos;
  color playerColor = color(200);
  
  Player(){ //Contstructor
    xpos = SCREENX/2;
    ypos = SCREENY - MARGIN;
  }
  
  //Move the player
  void move() {
      if(moveLeft && xpos>=PLAYER_WIDTH/2+SCREEN_BORDER){
        if(currentPowerUp == 1){ 
          xpos-= 6;
        }
        else{
          xpos-=3;
        }
      }
      if(moveRight && xpos<= SCREENX-PLAYER_WIDTH/2-SCREEN_BORDER){
        if(currentPowerUp == 1){
          xpos+= 6;
        }
        else{
          xpos+=3;
        }
     }
  }
  
  //Draw the player
  void draw(){
    fill(playerColor);
    noStroke();
    ellipse(xpos,SCREENY-MARGIN,PLAYER_WIDTH/1.5,PLAYER_HEIGHT/1.5);
  }
  
  //See if the player has been shot
  void explode(Projectile invaderProjectile){
    if(invaderProjectile.xpos <= xpos+PLAYER_WIDTH/2 && invaderProjectile.xpos >= xpos-PLAYER_WIDTH/2 && invaderProjectile.ypos>= ypos-PLAYER_HEIGHT  && invaderProjectile.ypos <= ypos+PLAYER_HEIGHT){
      bottomHit = true;
      setup = true;
    }
  }
}
