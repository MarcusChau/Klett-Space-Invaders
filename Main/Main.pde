import ddf.minim.*;

//Defining all constants
final static int PLAYER_WIDTH = 30, PLAYER_HEIGHT = 15;
final static int FRAMES_PER_SECOND = 30, MARGIN = 30;
final static int INVADER_WIDTH = 28, INVADER_HEIGHT = 26;
final static int CONSUMABLES_WIDTH = 4, CONSUMABLES_HEIGHT = 8;
final static int POWER_UP_HEIGHT = 30, POWER_UP_WIDTH = 30;
final static int SCREEN_BORDER = 3;
boolean isSpacePressed = false;


final static int EXPLOSION_TIME = 8, AMOUNT_OF_INVADERS = 10;
final static float SPACE_WHILE_DANCING = 2.4, AMOUNT_BETWEEN_INVADERS = 1.5, BULLET_DELAY = 1, SPEED = 2;


boolean moveDown, movedOut, projectileOnScreen, menuScreen, setup, bottomHit, powerUpScreen, shot, moveLeft, moveRight, keyBeingPressed, paused, selection1, selection2, selection3, tutorial;
float stash, currentPowerUp, bulletCooldown;
int currentSelection, score, livesRemaining, killCount, powerUpTime, currentPlayerProjectileIndex, currentInvaderProjectileIndex, fireRate, randomInvaderPowerUp, radomFire, finalScore, spacesMovedDown, removeInvader, removeBullet, removePowerUp;
int[][] shieldPiece1Initializer, shieldPiece2Initializer, shieldPiece3Initializer, shieldPiece4Initializer;
PFont gameFont, scoreFont;
String[] highScoresStrings, scoreHolders;
String typing;


Player thePlayer;
Lives playerLives;
Invader3 invader3;
Invader1 invaders1Array[];
Invader2 invaders2Array[];
Invader3 invaders3Array[];
Minim minim;
AudioPlayer soundtrack;
AudioPlayer player;
AudioPlayer invaderDeath;
Projectile playerProjectile[];
Projectile invaderProjectile[];
MainMenu mainMenu;
LevelTransition levelTransition;
PowerUp powerUp;
ShieldPiece shieldPiece1Array[][];
ShieldPiece shieldPiece2Array[][];
ShieldPiece shieldPiece3Array[][];
ShieldPiece shieldPiece4Array[][];

// Inializing Screen attributes as well as all properties that have to do with the screen (processing function)
void setup(){
  fullScreen();
  ellipseMode(RADIUS);
  frameRate(FRAMES_PER_SECOND);
  background(0);
  
  moveDown = movedOut = projectileOnScreen = menuScreen = setup = bottomHit = powerUpScreen = shot = moveLeft = moveRight = keyBeingPressed = paused = selection1 = selection2 = selection3 = tutorial = false;
  menuScreen = true;
  
  // Initialize numeric variables
  currentSelection = 100000001;
  score = livesRemaining = killCount = spacesMovedDown = randomInvaderPowerUp = radomFire = finalScore = currentPlayerProjectileIndex = currentInvaderProjectileIndex = 0;
  stash = currentPowerUp = bulletCooldown = 0.0;
  powerUpTime = 30;
  removeInvader = height + 100;
  removeBullet = height + 1000;
  removePowerUp = height + 100000;
  livesRemaining = 3;
  fireRate = 2; 
  playerLives = new Lives();
  thePlayer = new Player();
  mainMenu = new MainMenu();
  levelTransition = new LevelTransition();
  invader3 = new Invader3(99999,99999);
  invaders1Array = new Invader1[AMOUNT_OF_INVADERS];
  invaders2Array = new Invader2[AMOUNT_OF_INVADERS];
  invaders3Array = new Invader3[AMOUNT_OF_INVADERS];
  playerProjectile = new Projectile[200];
  invaderProjectile = new Projectile[200];
  powerUp = new PowerUp(invader3);
  minim = new Minim(this);

  
  // Here shield piece Arrays can be drawn out in 1s and 0s, which will be reflected in the way they are arranged in the game.
  // Each 1 in a 2D array will materialise as part of one of a player's shields during the game.
  
  shieldPiece1Initializer = createInitialPattern();
  shieldPiece2Initializer = createInitialPattern();
  shieldPiece3Initializer = createInitialPattern();
  shieldPiece4Initializer = createInitialPattern();
  
  shieldPiece1Array = intitializeShield(shieldPiece1Initializer);
  shieldPiece2Array = intitializeShield(shieldPiece2Initializer);
  shieldPiece3Array = intitializeShield(shieldPiece3Initializer);
  shieldPiece4Array = intitializeShield(shieldPiece4Initializer);
  
  
  for(int i=0; i<playerProjectile.length; i++){
    playerProjectile[i] = new Projectile(-50,-50);
  }
  for(int i=0; i<invaderProjectile.length; i++){
    invaderProjectile[i] = new Projectile(-50,-50);
  }
  for(int i=0; i<invaders1Array.length; i++){
    invaders1Array[i] = new Invader1(60,i*INVADER_HEIGHT*SPACE_WHILE_DANCING+INVADER_HEIGHT);
  }
  for(int i=0; i<invaders2Array.length; i++){
    invaders2Array[i] = new Invader2(width-60,i*INVADER_HEIGHT*SPACE_WHILE_DANCING+INVADER_HEIGHT);
  }
  randomInvaderPowerUp = int(random(invaders3Array.length-1));
  
  // Initialise different sounds used in the game imported from the folder the game is in
  invaderDeath = minim.loadFile("Invader Death.mov");
  
  // Initialise different fonts
  gameFont = loadFont("DINCondensed-Bold-48.vlw");
  scoreFont = loadFont("HiraKakuStdN-W8-48.vlw");
}


void handleMenuScreen() {
  mainMenu.display();
}

void handleGameSetup() {
  if(bottomHit==true){
    if(playerLives.livesRemaining>0){
      levelTransition.goBackUp(invaders2Array, playerLives, playerProjectile, invaderProjectile);
    }
    else{
      levelTransition.gameOver(invaders1Array,invaders2Array,invaders3Array,playerLives);
    }
  }
  else{
    levelTransition.change(invaders2Array, playerProjectile, invaderProjectile, shieldPiece1Initializer);
  }
  thePlayer.draw();
  drawLayout();
  playerLives.draw();
}

void gamePause() {
  if (frameCount%40<20) {
    fill(0,0,255);
  }
  else{
    fill(0);
  }
  noStroke();
  textAlign(CENTER);
  textFont(gameFont, 100);
  text("Game Paused", width/2, 2*height/3);
}

void playGameMode() {
  background(0,0,255);
  //If powerup-invader has been shot, emit power-up and kill invader
  if(invaders3Array[randomInvaderPowerUp].exploded && frameCount - invaders3Array[randomInvaderPowerUp].timeOfExplosion == 7){
    powerUp = new PowerUp(invaders3Array[randomInvaderPowerUp]);
    powerUpScreen = true;
  }
  //if power-up is on screen
  if(powerUpScreen){
    powerUp.move();
    powerUp.draw();
    if(projectileOnScreen){
      for(int k=0;k<playerProjectile.length;k++){
        powerUp.store(playerProjectile[k]);
      }
    }
    powerUp.activate();
    powerUp.deActivate();
  }
    
  //if projectile is on screen
  if(projectileOnScreen){
      for(int k=0;k<invaderProjectile.length;k++){
        thePlayer.explode(invaderProjectile[k]);
      }
    }
  //if the player has shot
  if(shot == true){
    //if the player has the 3rd power up, shoot three projectiles
    if(currentPowerUp==3){
      playerProjectile[currentPlayerProjectileIndex] = new Projectile(thePlayer.xpos-4*CONSUMABLES_WIDTH,thePlayer.ypos);
      playerProjectile[currentPlayerProjectileIndex+1] = new Projectile(thePlayer.xpos,thePlayer.ypos);
      playerProjectile[currentPlayerProjectileIndex+2] = new Projectile(thePlayer.xpos+4*CONSUMABLES_WIDTH,thePlayer.ypos);
      shot = false;
      currentPlayerProjectileIndex+=3;
    }
    else{
      playerProjectile[currentPlayerProjectileIndex] = new Projectile(thePlayer.xpos,thePlayer.ypos);
      shot = false;
      currentPlayerProjectileIndex++;}
    //if the player has shot more bullets than allowed, overwrite the first projectile used (wrap around the list of projectile)  
    if(currentPlayerProjectileIndex>=playerProjectile.length-3){currentPlayerProjectileIndex=0;
  }
}
   //randomly let invaders shoot projectiles
  if(int(random(20*levelTransition.level+10))==1){
    projectileOnScreen=true;
    radomFire = int(random(invaders2Array.length));
    invaderProjectile[currentInvaderProjectileIndex] = new Projectile(invaders2Array[radomFire].xpos,invaders2Array[radomFire].ypos);
    currentInvaderProjectileIndex++;
    //if the invaders have shot more bullets than allowed, overwrite the first projectile (wrap around the list of projectile)
    if(currentInvaderProjectileIndex>=invaderProjectile.length-3){currentInvaderProjectileIndex=0;
  }
}
  //if projectiles are on the screen
  if(projectileOnScreen){
    //take care of player's projectiles
    for(int k=0;k<playerProjectile.length;k++){
      playerProjectile[k].move();
      playerProjectile[k].draw();
      playerProjectile[k].collide();
    }
    //take care of invaders' projectiles
    for(int k=0;k<invaderProjectile.length;k++){
      invaderProjectile[k].drop();
      invaderProjectile[k].draw();
      invaderProjectile[k].collide();
    }
  }
      
  //take care of all the shields' shield pieces
  handleShields(shieldPiece1Array, shieldPiece1Initializer);
  handleShields(shieldPiece2Array, shieldPiece2Initializer);
  handleShields(shieldPiece3Array, shieldPiece3Initializer);
  handleShields(shieldPiece4Array, shieldPiece4Initializer);
    
  //move all the space-invader_1s
  handleInvaders(invaders1Array);
  handleInvaders(invaders2Array);
  handleInvaders(invaders3Array);
    
  //Take care of general drawing
  thePlayer.move();
  thePlayer.draw();
  drawLayout();
  playerLives.draw();
  levelTransition.checkTransition();
  //count down the power-up time
  if(frameCount % FRAMES_PER_SECOND == 0 && currentPowerUp != 0){
    powerUpTime--;
  }
  //take care of bullet-cooldown time
  if((frameCount % FRAMES_PER_SECOND == 0 || frameCount % FRAMES_PER_SECOND == FRAMES_PER_SECOND/2) && bulletCooldown > 0 && fireRate == 4){
    bulletCooldown -= fireRate;
  }
  else if((frameCount % FRAMES_PER_SECOND == 0 || frameCount % FRAMES_PER_SECOND == FRAMES_PER_SECOND/2) && bulletCooldown > 0 && fireRate == 2){
    bulletCooldown -= fireRate;
  }
  if(bulletCooldown < 0){
    bulletCooldown=0;
  }
}


ShieldPiece[][] intitializeShield(int[][] pattern) {
  ShieldPiece[][] shieldArray = new ShieldPiece[13][5];
  
  for(int i=0;i<13; i++){
    for(int j=0; j<5; j++){
      shieldArray[i][j] = new ShieldPiece(999,999);
    }
  }
  
  return shieldArray;
}

int[][] createInitialPattern() {
  return new int[][] {
    { 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
    { 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1 },
    { 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1 },
    { 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1 }      
  };
}



void handleShields(ShieldPiece[][] shieldArray, int[][] shieldInitializer) {
    for (int i = 0; i < shieldInitializer[1].length; i++) {
        for (int j = 0; j < shieldInitializer.length; j++) {
            if (shieldInitializer[j][i] == 1) {
                shieldArray[i][j].draw();
                checkShieldExplosion(shieldArray[i][j]);
            }
            if (shieldArray[i][j].hit) {
                shieldInitializer[j][i] = 0;
            }
        }
    }
}

void checkShieldExplosion(ShieldPiece shieldPiece) {
    for (int k = 0; k < invaderProjectile.length; k++) {
        shieldPiece.explode(invaderProjectile[k]);
    }
    for (int k = 0; k < playerProjectile.length; k++) {
        shieldPiece.explode(playerProjectile[k]);
    }
}

void handleInvaders(GamePieces[] invaderArray) {
    for (int i = 0; i < invaderArray.length; i++) {
        GamePieces invader = invaderArray[i];
        invader.move();
        invader.draw();
        invader.disappear();

        if (projectileOnScreen) {
            for (int k = 0; k < playerProjectile.length; k++) {
                invader.explode(playerProjectile[k]);
            }
        }
    }
}


void draw(){
  // MENU SCREEN
  if(menuScreen){
    handleMenuScreen();
  }
    
  // GAME SETUP (happens upon starting a new game.)  
  else if(setup){
    handleGameSetup();
  }
  
  // PAUSED GAME  
  else if(paused){
    gamePause();
  }
  
  // PLAYING IN GAME MODE
  else{
    playGameMode();
  }
}
