class LevelTransition {
  int level, time, duration;

  LevelTransition() {
    level = 1;
    duration = 2*FRAMES_PER_SECOND;
    time = -1;
  }

  //Change from one level to another
  void change(Invader2[] invaders2Array, Projectile[] playerProjectile, Projectile[] invaderProjectile, int[][] shieldPiece1Initializer) {
    projectileOnScreen = false;
    
    //Take all player projectiles away from the screen
    for (int i =0; i<playerProjectile.length; i++) {
      playerProjectile[i].xpos=-1890;
    }
    
    //Take all invaders' projectiles away from the screen
    for (int i =0; i<invaderProjectile.length; i++) {
      invaderProjectile[i].xpos=-1890;
    }
    
    //Print the level to stdout once activated, and set the activation time to the current time.
    if (time == -1) {
      time = frameCount;
      println("\n \n Level " + level);
    }
    
    //Draw the new level
    background(0);
    drawLayout();
    for (int i=0; i<shieldPiece1Initializer[1].length; i++) {
      for (int j=0; j<shieldPiece1Initializer.length; j++) {
        if (shieldPiece1Initializer[j][i]==1) {
          shieldPiece1Array[i][j] = new ShieldPiece(width/5-.5*shieldPiece1Initializer[1].length*CONSUMABLES_WIDTH+i*CONSUMABLES_WIDTH, height-4*MARGIN+j*CONSUMABLES_HEIGHT);
          shieldPiece1Array[i][j].draw();
        }
        if (shieldPiece2Initializer[j][i]==1) {
          shieldPiece2Array[i][j] = new ShieldPiece(2*width/5-.5*shieldPiece1Initializer[1].length*CONSUMABLES_WIDTH+i*CONSUMABLES_WIDTH, height-4*MARGIN+j*CONSUMABLES_HEIGHT);
          shieldPiece2Array[i][j].draw();
        }
        if (shieldPiece3Initializer[j][i]==1) {
          shieldPiece3Array[i][j] = new ShieldPiece(3*width/5-.5*shieldPiece1Initializer[1].length*CONSUMABLES_WIDTH+i*CONSUMABLES_WIDTH, height-4*MARGIN+j*CONSUMABLES_HEIGHT);
          shieldPiece3Array[i][j].draw();
        }
        if (shieldPiece4Initializer[j][i]==1) {
          shieldPiece4Array[i][j] = new ShieldPiece(4*width/5-.5*shieldPiece1Initializer[1].length*CONSUMABLES_WIDTH+i*CONSUMABLES_WIDTH, height-4*MARGIN+j*CONSUMABLES_HEIGHT);
          shieldPiece4Array[i][j].draw();
        }
      }
    }
    for (int i=0; i<invaders1Array.length; i++) {
      invaders1Array[i] = new Invader1(i*INVADER_WIDTH*AMOUNT_BETWEEN_INVADERS+INVADER_WIDTH*2, INVADER_HEIGHT*3.5+MARGIN);
      invaders1Array[i].draw();
      invaders1Array[i].dx=level*SPEED;
      invaders1Array[i].dy=level*SPEED/2;
      
      invaders2Array[i] = new Invader2(i*INVADER_WIDTH*AMOUNT_BETWEEN_INVADERS+INVADER_WIDTH*2, INVADER_HEIGHT*2+MARGIN);
      invaders2Array[i].draw();
      invaders2Array[i].dx=level*SPEED;
      invaders2Array[i].dy=level*SPEED/2;
      
      invaders3Array[i] = new Invader3(i*INVADER_WIDTH*AMOUNT_BETWEEN_INVADERS+INVADER_WIDTH*2, INVADER_HEIGHT+MARGIN);
      invaders3Array[i].draw();
      invaders3Array[i].dx=level*SPEED;
      invaders3Array[i].dy=level*SPEED/2;
    }
    
    randomInvaderPowerUp = int(random(invaders3Array.length-1));
    fill(255);
    textAlign(CENTER);
    textFont(gameFont, 70);
    
    //Flash the current level on the screen
    if (frameCount%20<10) {
      text("Level "+level, width/2, 2*height/3);
    }
    
    //Initialise the new level and move back into game mode
    if (frameCount-duration == time && frameCount>duration) {
      setup = false;
      time = -1;
    }
  }

  //
  void goBackUp(Invader2[] invaders2Array, Lives lives, Projectile[] playerProjectile, Projectile[] invaderProjectile){
    projectileOnScreen = false;
    for(int i =0; i<playerProjectile.length; i++){
      playerProjectile[i].xpos=-1890;
    }
    for(int i =0; i<invaderProjectile.length; i++){
      invaderProjectile[i].xpos=-1890;
    }
    if(time == -1){
      lives.livesRemaining--;
      time = frameCount;
    }
    else{
      background(0);
      drawLayout();
      for(int i=0; i<shieldPiece1Initializer[1].length; i++){
        for(int j=0; j<shieldPiece1Initializer.length; j++){
          if(shieldPiece1Initializer[j][i]==1){
            shieldPiece1Array[i][j] = new ShieldPiece(width/5-.5*shieldPiece1Initializer[1].length*CONSUMABLES_WIDTH+i*CONSUMABLES_WIDTH, height-4*MARGIN+j*CONSUMABLES_HEIGHT);
            shieldPiece1Array[i][j].draw();
          }
          if(shieldPiece2Initializer[j][i]==1){
            shieldPiece2Array[i][j] = new ShieldPiece(2*width/5-.5*shieldPiece1Initializer[1].length*CONSUMABLES_WIDTH+i*CONSUMABLES_WIDTH, height-4*MARGIN+j*CONSUMABLES_HEIGHT);
            shieldPiece2Array[i][j].draw();
          }
          if(shieldPiece3Initializer[j][i]==1){
            shieldPiece3Array[i][j] = new ShieldPiece(3*width/5-.5*shieldPiece1Initializer[1].length*CONSUMABLES_WIDTH+i*CONSUMABLES_WIDTH, height-4*MARGIN+j*CONSUMABLES_HEIGHT);
            shieldPiece3Array[i][j].draw();
          }
          if(shieldPiece4Initializer[j][i]==1){
            shieldPiece4Array[i][j] = new ShieldPiece(4*width/5-.5*shieldPiece1Initializer[1].length*CONSUMABLES_WIDTH+i*CONSUMABLES_WIDTH, height-4*MARGIN+j*CONSUMABLES_HEIGHT);
            shieldPiece4Array[i][j].draw();
          }
        }
      }
      lives.draw();
      if(livesRemaining>0){
        for(int i=0; i<invaders1Array.length; i++){
          if(invaders1Array[i].killed == false){
            invaders1Array[i] = new Invader1(i*INVADER_WIDTH*AMOUNT_BETWEEN_INVADERS+INVADER_WIDTH*2, INVADER_HEIGHT*3.5+MARGIN);
            invaders1Array[i].draw();
            invaders1Array[i].dx =level*SPEED;
            invaders1Array[i].dy =level*SPEED/2;
          }
        }
        for (int i=0; i<invaders2Array.length; i++){
          if (invaders2Array[i].killed == false){
            invaders2Array[i] = new Invader2(i*INVADER_WIDTH*AMOUNT_BETWEEN_INVADERS+INVADER_WIDTH*2, INVADER_HEIGHT*2+MARGIN);
            invaders2Array[i].draw();
            invaders2Array[i].dx =level*SPEED;
            invaders2Array[i].dy =level*SPEED/2;
          }
        }
        for (int i=0; i<invaders3Array.length; i++){
          if (invaders3Array[i].killed == false){
            invaders3Array[i] = new Invader3(i*INVADER_WIDTH*AMOUNT_BETWEEN_INVADERS+INVADER_WIDTH*2, INVADER_HEIGHT*1+MARGIN);
            invaders3Array[i].draw();
            invaders3Array[i].dx =level*SPEED;
            invaders3Array[i].dy =level*SPEED/2;
          }
        }
        fill(255);
        textAlign(CENTER);
        textFont(gameFont, 70);
        if (frameCount%20<10){
          text("Level " + level, width/2, 2*height/3);
        }
        if (frameCount-duration == time && frameCount>duration){
          bottomHit = false;
          setup = false;
          time = -1;
        }
      }
    }
  }


  //Draw game over, to be called when the player dies
  void gameOver(Invader1[] invaders1Array, Invader2[] invaders2Array, Invader3[] invaders3Array, Lives lives){
    if (time == -1){
      time = frameCount;
    }
    background(0);
    drawLayout();
    for (int i=0; i<shieldPiece1Initializer[1].length; i++){
      for (int j=0; j<shieldPiece1Initializer.length; j++){
        if (shieldPiece1Initializer[j][i]==1){
          shieldPiece1Array[i][j] = new ShieldPiece(width/5-.5*shieldPiece1Initializer[1].length*CONSUMABLES_WIDTH+i*CONSUMABLES_WIDTH, height-4*MARGIN+j*CONSUMABLES_HEIGHT);
          shieldPiece1Array[i][j].draw();
        }
        if (shieldPiece2Initializer[j][i]==1){
          shieldPiece2Array[i][j] = new ShieldPiece(2*width/5-.5*shieldPiece1Initializer[1].length*CONSUMABLES_WIDTH+width/4+j*CONSUMABLES_WIDTH, height-4*MARGIN+j*CONSUMABLES_HEIGHT);
          shieldPiece2Array[i][j].draw();
        }
        if (shieldPiece3Initializer[j][i]==1){
          shieldPiece3Array[i][j] = new ShieldPiece(3*width/5-.5*shieldPiece1Initializer[1].length*CONSUMABLES_WIDTH+width/2+i*CONSUMABLES_WIDTH, height-4*MARGIN+j*CONSUMABLES_HEIGHT);
          shieldPiece3Array[i][j].draw();
        }
        if (shieldPiece4Initializer[j][i]==1){
          shieldPiece4Array[i][j] = new ShieldPiece(4*width/5+width/2-.5*shieldPiece1Initializer[1].length*CONSUMABLES_WIDTH+width/2+i*CONSUMABLES_WIDTH, -4*MARGIN+j*CONSUMABLES_HEIGHT);
          shieldPiece4Array[i][j].draw();
        }
      }
    }
    fill(255);
    textAlign(CENTER);
    textFont(gameFont, 80);
    for (int i=0; i<invaders1Array.length; i++){
      invaders1Array[i].draw();
    }
    for (int i=0; i<invaders2Array.length; i++){
      invaders2Array[i].draw();
    }
    for (int i=0; i<invaders3Array.length; i++){
      invaders3Array[i].draw();
    }
    //Flash "GAME OVER" on the screen
    if (frameCount%20<10){
      text("GAME OVER", width/2, height/2);
    }
    
    if (frameCount-duration == time && frameCount>duration){
      bottomHit = false;
      setup =false;
      level = 1;
      currentPowerUp = 0;
      stash = 0;
      killCount = 0;
      time = -1;
      lives.livesRemaining = 3;
      for (int i=0; i<invaders1Array.length; i++){
        invaders1Array[i] = new Invader1(60, i*INVADER_HEIGHT*SPACE_WHILE_DANCING+INVADER_HEIGHT);
      }
      for (int i=0; i<invaders2Array.length; i++){
        invaders2Array[i] = new Invader2(width-60, i*INVADER_HEIGHT*SPACE_WHILE_DANCING+INVADER_HEIGHT);
      }
      finalScore = score;
    }
  }

  //Check if all space invaders have been killed (if level transition should take place)
  void checkTransition(){
    if (killCount == 30){
      killCount = 0;
      level += 1;
      setup = true;
    }
  }
}
