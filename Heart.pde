// Class to draw hearts to represent remaining lives

public class Heart {
  // Properties
  // by using variables for x and y coordinates it is possible to draw multiple hearts using the draw method
  int heartX;
  int heartY;
  color h;

  // Constructor
  Heart() {
    heartX = 0;
    heartY = 0;
  }

  // Methods
  void drawHeart(int heartX, int heartY) {
    ellipseMode(CENTER);
    noStroke();
    fill(c3);
    ellipse(heartX+50, heartY+20, 14, 15);
    ellipse(heartX+60, heartY+20, 14, 15);
    triangle(heartX+42.5, heartY+22, heartX+67.5, heartY+22, heartX+55, heartY+36);
  }
} //end class life
