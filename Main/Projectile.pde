class Projectile {
  float xpos, ypos;
  color projectileColor = color(150,0,0);
  int temp; 
  
  Projectile(float shootingPositionX,float shootingPositionY){
    xpos = shootingPositionX;
    ypos = shootingPositionY;
    temp = 1;
  }
  
  //Move a projectile upwards
  void move(){
    if(projectileOnScreen){
    ypos-= 10;}
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
      rect(xpos-PROJECTILE_WIDTH/2,ypos-PROJECTILE_HEIGHT/2,PROJECTILE_WIDTH,PROJECTILE_HEIGHT);
    }
  }
  
  //Delete a projectile if it has travelled off the screen
  void collide(){
    if(ypos <= 0 || ypos >= SCREENY){
    ypos = removeBullet;
    }
  }
}
