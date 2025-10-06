// Class for Goose
// The goose will be displayed at the bottom of the screen and move left and right
// The goose will appear to catch the falling eggs

class Goose {
  // Properties
  float x, y, w, h;

  // Constructor
  Goose() {
    x = width/2; //width = 800 so x = 400
    y = height - height/3; //height = 600 so y = 400
    w = 0;
    h = 0;
  }

  // Methods

  // keyPressed - method to move goose left and right with arrow key presses
  // movement restricted to stay within the borders of the screen
  void keyPressed() {
    if (keyPressed) {
      if (keyCode == LEFT && x > 0) {
        x -=10;
      } else if (keyCode == RIGHT && x < width) {
        x +=10;
      }
    }
  }//end key pressed

  // Draw Goose
  void drawGoose() { 

    //draw beak
    fill(0);
    stroke(0);
    // left coner, top right, bottom right
    triangle(x-68, y+50, x-45, y+35, x-45, y+54);

    //draw neck
    fill(0);
    rectMode(CORNER);
    rect(x-35, y+45, w+12, h+60);

    //draw head
    fill(255);
    ellipse(x-38, y+45, 30, 25);

    //draw eye
    fill(0);
    ellipse(x-43, y+42, 7, 3);

    //draw legs
    fill(25);
    rect(x-25, y+130, 5, 45);
    rect(x, y+130, 5, 45);

    //draw feet
    // top corner, bottom left corner, bottom right corner
    triangle(x-20, y+165, x-40, y+175, x-20, y+180);
    triangle(x+5, y+170, x-15, y+180, x+5, y+185);

    //draw body
    noStroke();
    fill(lerpColor(c2, c1, 0.2));
    ellipseMode(CENTER);
    ellipse(x, y+110, 75, 50);

    //draw tail
    fill(lerpColor(c2, c1, 0.2));
    // top x/y, bottom left x/y, bottom right x/y
    triangle(x+20, y+90, x+10, y+135, x+70, y+130);
  } //end of drawGoose
}//end of class body
