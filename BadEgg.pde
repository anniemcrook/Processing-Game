// class with methods for the 'bad eggs'
// bad eggs are used to increase game difficulty - catch a bad egg and lose a life
// bad eggs increase as the number of caught eggs (the score) increases

class BadEgg {
  // Properties
  float x, y, w, h;
  float speedY;
  color c;

  // Constructor
  BadEgg() {
    x = random(width);
    y = -100;
    w = 35;
    h = 55;
    speedY = random(2, 4);
    c = color(67, 64, 34);
  }

  // Methods
  void fall() {
    y += speedY;
    if (y > height + h/2) {
      x = random(width);
      y = -100; // start eggs at -100 on the y axis staggers the fall
    }
  }//end of fall

  void displayBadEgg() {
    ellipseMode(CENTER);
    noStroke();
    fill(c);
    ellipse(x, y, w, h);
  }//end of displayBadEgg
}//end of class body
