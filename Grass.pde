// Grass class to create a ground for the goose to move on
// Grass is created with randomly placed triangles acrros the bottom of the screen
// Grass objects are stored in an array list, each given a random shade of green color

class Grass {
  
 // properties
 float x;
 float y;
 color c;
 // variables for color of grass to create multiple shades of green
 float r = random(60, 80);
 float g = random(150, 180);
 float b = random(50, 90);
 
 // constructor
 Grass() {
   x = random(width);
   y = random(height-100, height-50);
   c = color(r, g, b);
 }
 
 //method
 void drawGrass() {
 noStroke();
 fill(c);
 triangle(x, y, x-25, height, x+25, height);
 }
 
 void drawBackGrass() {
 noStroke();
 fill(c);
 triangle(x, y-100, x-25, height-50, x+25, height-50);
 }
}
