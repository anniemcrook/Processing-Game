// Class for Eggs
// The eggs will fall from the sky to be caught by the goose
// 100 eggs will be added to the array list, caught eggs will be moved below screen

class Egg {
  // Properties
  float x, y, w, h;
  float speedY;
  color c;

  // Constructor
  Egg() {
    x = random(width);
    y = 0;
    w = 30;
    h = 50;
    speedY = random(2, 4);
    c = color(191, 172, 135);
  }

  // Methods
  // Eggs fall
  void fall() {
    y += speedY;
    if (y > height + h/2) {
      x = random(width);
      y = 0;
    }
  }//end of update

  // Draw Eggs
  void displayEgg() {
    ellipseMode(CENTER);
    noStroke();
    fill(c);
    ellipse(x, y, w, h);
  }//end of displayEgg
}//end of class body
