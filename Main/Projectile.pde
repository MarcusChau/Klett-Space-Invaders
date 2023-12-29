class Projectile {
  float xpos, ypos;
  color projectileColor = color(196, 180, 84);
  int temp; 
  
  Projectile(float shootingPositionX,float shootingPositionY){
    xpos = shootingPositionX;
    ypos = shootingPositionY;
    temp = 1;
  }
  
  boolean hits(GamePieces invader) {
    return xpos <= invader.xpos + INVADER_WIDTH / 2 && xpos >= invader.xpos - INVADER_WIDTH / 2 &&
           ypos >= invader.ypos - INVADER_HEIGHT / 2 && ypos <= invader.ypos + INVADER_HEIGHT / 2;
  }
  
  //Move a projectile upwards
  void move(){
    if(projectileOnScreen){
      ypos-= 10;
    }
  }
  
  //Move a projectile downwards
  void drop(){
    if(projectileOnScreen){
      ypos+= 10*temp;
    }
  }
  
  //Draw a projectile
  void draw(){
    if(projectileOnScreen){
      fill(projectileColor);
      noStroke();
      rect(xpos-CONSUMABLES_WIDTH/2,ypos-CONSUMABLES_HEIGHT/2,CONSUMABLES_WIDTH,CONSUMABLES_HEIGHT);
    }
  }
  
  //Delete a projectile if it has travelled off the screen
  void collide(){
    if(ypos <= 0 || ypos >= height){
    ypos = removeBullet;
    }
  }
}
