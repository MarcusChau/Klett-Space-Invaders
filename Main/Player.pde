class Player {
  float xpos; float ypos;
  color playerColor = color(100);
  
  Player(){ //Contstructor
    xpos = width/2;
    ypos = height - MARGIN;
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
      if(moveRight && xpos<= width-PLAYER_WIDTH/2-SCREEN_BORDER){
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
    
    beginShape();
    vertex(xpos, ypos - PLAYER_HEIGHT / 2); // top point
    vertex(xpos - PLAYER_WIDTH / 2, ypos + PLAYER_HEIGHT / 2); // bottom left
    vertex(xpos, ypos + PLAYER_HEIGHT / 4); // bottom center notch
    vertex(xpos + PLAYER_WIDTH / 2, ypos + PLAYER_HEIGHT / 2); // bottom right
    endShape(CLOSE);
  }
  
  //See if the player has been shot
  void explode(Projectile invaderProjectile){
    if(invaderProjectile.xpos <= xpos+PLAYER_WIDTH/2 && invaderProjectile.xpos >= xpos-PLAYER_WIDTH/2 && invaderProjectile.ypos>= ypos-PLAYER_HEIGHT  && invaderProjectile.ypos <= ypos+PLAYER_HEIGHT){
      bottomHit = true;
      setup = true;
    }
  }
}
