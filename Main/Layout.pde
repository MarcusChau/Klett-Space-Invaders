// Method for drawing different parts of the screen
void drawLayout() {
  drawTopBar();
  drawBorders();
  drawPowerUps();
}

void drawTopBar() {
  fill(255);
  rect(0, 0, width, 30);
  displayText("Klett Space Invaders", width / 2, 23, CENTER);
  displayText("Score: " + score, SCREEN_BORDER + 2, 23, LEFT);
}

void displayText(String text, float x, float y, int align) {
  textFont(gameFont, 25);
  textAlign(align);
  fill(0);
  text(text, x, y);
}

void drawBorders() {
  stroke(255);
  line(0, 0, 0, height); // Left border
  line(width - 1, 0, width - 1, height); // Right border
  line(0, height - 1, width, height - 1); // Bottom border
  line(0, height - 2 * MARGIN, width, height - 2 * MARGIN); // Upper border
}

void drawPowerUps() {
  if (stash > 0) {
    drawActivePowerUp();
  }
  if (currentPowerUp != 0) {
    displayText(str(powerUpTime), width - SCREEN_BORDER, height - MARGIN, RIGHT);
  }
}

void drawActivePowerUp() {
  fill(255);
  stroke(255, 0, 0);
  ellipse(width - 100, MARGIN / 2, 13, 13);
  noStroke();
  fill(255, 0, 0);

  switch (int(stash)) {
    case 1:
      drawPowerUpType1();
      break;
    case 2:
      drawPowerUpType2();
      break;
    case 3:
      drawPowerUpType3();
      break;
    case 4:
      drawPowerUpType4();
      break;
  }
}

void drawPowerUpType1() {
  drawTriangle(width - 100, MARGIN / 2, -0.3, -0.2);
  drawTriangle(width - 100, MARGIN / 2, 0.3, 0.2);
}

void drawPowerUpType2() {
  ellipse(width - 100, MARGIN / 2, 0.2 * POWER_UP_WIDTH, 0.2 * POWER_UP_HEIGHT);
}

void drawPowerUpType3() {
  textAlign(CENTER);
  text("3", width - 98, MARGIN / 2 + 10);
}

void drawPowerUpType4() {
  rect(width - 100 - 0.2 * POWER_UP_WIDTH, MARGIN / 2 - 0.2 * POWER_UP_HEIGHT, 0.4 * POWER_UP_WIDTH, 0.4 * POWER_UP_HEIGHT);
}

void drawTriangle(float x, float y, float dy, float dx) {
  triangle(x, y + dy * POWER_UP_HEIGHT, x, y, x + dx * POWER_UP_WIDTH, y);
}

// Key event handling
void keyPressed() {
  if (!paused) {
    handleGameControls();
  }
  handleGlobalControls();
}

void handleGameControls() {
  // Handling movement
  if (keyCode == LEFT) {
    moveLeft = true;
  }
  if (keyCode == RIGHT) {
    moveRight = true;
  }

  // Handling shooting
  if ((key == ' ' || keyCode == UP) && bulletCooldown == 0) {
    projectileOnScreen = true;
    shot = true;
    bulletCooldown = BULLET_DELAY;
    isSpacePressed = true;
  }
}

void handleGlobalControls() {
  // Menu, tutorial, pause
  if (menuScreen) {
    handleMenuKey();
  } else if (tutorial) {
    handleTutorialKey();
  } else if (key == 'p' || key == 'P') {
    paused = !paused;
  }
}


void handleMenuKey() {
  if (keyPressed) {
    if (keyCode == UP) {
      currentSelection += 1;
    } else if (keyCode == DOWN) {
      currentSelection -= 1;
    } else {
      handleMenuSelection();
    }
  }
}

void handlePauseKey() {
  if (paused && keyPressed && (key == 'p' || key == 'P')) paused = false;
}

void handleGameKey() {
  if (!menuScreen && !tutorial && !paused && keyPressed) {
    moveLeft = keyCode == LEFT;
    moveRight = keyCode == RIGHT;
    handleShooting();
    if (key == 'p' || key == 'P') paused = true;
  }
}

void handleShooting() {
  
  if ((keyCode == UP || key == ' ') && bulletCooldown == 0) {
    projectileOnScreen = shot = true;
    bulletCooldown = BULLET_DELAY;
  }
  isSpacePressed = true;
}


void keyReleased() {
  // Handling movement
  if (keyCode == LEFT) {
    moveLeft = false;
  }
  if (keyCode == RIGHT) {
    moveRight = false;
  }
}


void handleTutorialKey() {
  if (keyPressed && keyCode == LEFT) {
    tutorial = false;
    menuScreen = true;
  }
}

void handleMenuSelection() {
  if (key == '\n') {
    if (selection1) {
      score = 0;
      menuScreen = false;
      setup = true;
    } else if (selection2) {
      menuScreen = false;
      tutorial = true;
    }
  }
}
