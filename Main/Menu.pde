class MainMenu{
  
  MainMenu(){
  }
  
  //Draw the main menu
  void display() {
    setMenuBackground();
    drawMenuText();
    highlightSelection();
    drawMenuBorders();
    updateMenuSelection();
  }
  
  void setMenuBackground() {
      fill(0,0,255);
      rect(0, 0, width, 40);
  }
  
  void drawMenuText() {
      textFont(gameFont, 70);
      textAlign(CENTER, CENTER);
      fill(255);
      stroke(255);
      text("Welcome", width / 2, height / 4);
      textFont(gameFont, 40);
      text("to Space Invaders", width / 2, height / 3);
      text("1 Player", width / 2, height / 2);
  }
  
  void highlightSelection() {
      if ((selection1 && frameCount % 20 < 10) || (selection2 && frameCount % 20 < 10)) {
          fill(255, 0, 0);
          noStroke();
          if (selection1) {
              text("1 Player", width / 2, height / 2);
          }
      }
  }
  
  void drawMenuBorders() {
      stroke(255);
      for (int i = 0; i < 2; i++) {
          line(i, 0, i, height);
          line(width - 1 - i, 0, width - 1 - i, height);
          line(0, height - 1 - i, width, height - 1 - i);
      }
  }
  
  void updateMenuSelection() {
      int modSelection = abs(currentSelection) % 3;
      selection1 = modSelection == 2;
      selection2 = modSelection == 1;
      selection3 = modSelection == 0;
  }
}
