// Class for Golden Eggs
// Golden eggs will be used to increase the remaining time by 5 seconds
// Golden egg is slightly larger than normal eggs to increase visibility

class GoldenEgg {
  
  // Properties
  float x, y, w, h;
  float speedY;
  color g;

  // Constructor
  GoldenEgg() {
    x = random(width);
    y = -1800; // starting the golden eggs on -1800 on the y axis staggers the release
    w = 35;
    h = 55;
    speedY = 3;
    g = color(255, 215, 0);
  }

  // Methods
  void fall() {
    y += speedY;
    if (y > height + h/2) {
      x = random(width);
      y = -1800;
    }
  }//end of update

  void displayGoldenEgg() {
    ellipseMode(CENTER);
    noStroke();
    fill(g);
    ellipse(x, y, w, h);
  }//end of displayEgg
}//end of class body
