// Class for the egg catcher
// This catcher will run alongside the goose invisibly to catch eggs
// It will look as if the goose is catching the eggs but as the gooose is made up of
// multiple shapes, the catcher is used to code the collision

class Catcher {
  // Properties
  float x, y, w, h;

  // Constructor
  Catcher() {
    x = width/2;
    y = 500; //middle of goose
    w = 150; //width of goose
    h = 135; //height of goose
  }//end constructor

  // Methods
  void display() {
    noStroke();
    fill(155, 134, 101, 0);
    ellipseMode(CENTER);
    ellipse(x, y, w, h);
  } //end display

  void keyPressed() { // Checks if left or right key pressed to move catcher
  // Movement limited to keep catcher within the borders of the screen
    if (keyPressed) {
      if (keyCode == LEFT && x > 0) {
        x-=10;
      } else if (keyCode == RIGHT && x < width) {
        x +=10;
        //  }
      }
    }
  }//end key pressed
} //end class body
