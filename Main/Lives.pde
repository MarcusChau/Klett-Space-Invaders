class Lives {
  
  int livesRemaining;
  
  Lives(){
    livesRemaining = 3;
  }
  
  //Draw lives (In the shape of love hearts in the top right hand corner of the screen)
  void draw(){
      noStroke();
      fill(255,0,0);
      if(livesRemaining <= 0){
      fill(155);
      }
      
      ellipse(width-70,10,5,5);
      ellipse(width-60,10,5,5);
      triangle(width-75,11,width-55,11,width-65,27);
      if(livesRemaining == 1){
        fill(155);
      }
      
      ellipse(width-45,10,5,5);
      ellipse(width-35,10,5,5);
      triangle(width-50,11,width-30,11,width-40,27);
      if(livesRemaining == 2){
        fill(155);
      }
      
      ellipse(width-20,10,5,5);
      ellipse(width-10,10,5,5);
      triangle(width-25,11,width-5,11,width-15,27);
    }
}
