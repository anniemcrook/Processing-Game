// Class for rules display box

class Rules {

  // Properties
  int x;
  int y;
  int w;
  int h;

  // Constructor
  Rules() {
    x = width/2;
    y = height/2;
    w = 550;
    h = 250;
  }

  // Methods
  void displayRules() {
    // draw box for rules to display within
    stroke(0);
    fill(255);
    rectMode(CENTER);
    rect(x, y, w, h);
    // the rules and how to play text
    textAlign(CENTER);
    textSize(14);
    fill(0);
    String s = "Help Mother Goose catch her falling eggs.\nWatch out for the bad eggs!\n\nHow many eggs can you save in the time?\n**Catch all one hundred to win!**\nHint - catch the golden eggs to add more time!\n\n Use the left and right arrow keys to move Mother Goose.";
    text(s, x, y - 85);
    // draw arrow keys icons for visual aid in game play
    fill(5);
    rect(x-30, y+90, 40, 20, 5);
    rect(x+30, y+90, 40, 20, 5);
    fill(255);
    triangle(x-35, y+90, x-30, y+95, x-30, y+85);
    triangle(x+35, y+90, x+30, y+95, x+30, y+85);
  }
}
