// Class for clouds
// Clouds will move across the background - not part of game play

public class Cloud {
  
  // Properties
  float cloudX = 0;
  float cloudY = 0;

  // Constructor
  Cloud(float cloudX, float cloudY) {
    this.cloudX = cloudX;
    this.cloudY = cloudY;
  }

  // Methods
  // move cloud
  void drift(float speed) {
    cloudX = cloudX - speed;
    if (cloudX < -100) {
      cloudX = width;
    }
  }

  // draw cloud
  void drawCloud() { //need to set x, y and speed for each cloud)
    noStroke();
    fill(255);
    ellipseMode(CENTER);
    ellipse(cloudX, cloudY + 60, 70, 25); //left most cloud lump
    ellipse(cloudX + 50, cloudY + 70, 65, 40); //bottom right
    ellipse(cloudX + 40, cloudY + 50, 60, 30); //middle top
    ellipse(cloudX + 60, cloudY + 60, 70, 30); //right
    ellipse(cloudX + 25, cloudY + 80, 50, 30); //bottom left
    cloudX = cloudX - 0.5;
  }
}// end of class body
