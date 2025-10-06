//Goose game for BSc Computer Science OOP module - assignment 1
//Mother Goose
//Annie Crook

// Game play variables
// Game state, tracking score, wins and losses, and highscore
String gameState;
int wins;
int losses;
int lives;
int score;
int highscore;
boolean gameOver = false;
boolean levelUp;
Rules rules;

// Countdown timer
Timer countdownTimer;
int remainingTime;
int totalTime;

// Visuals
color c1 = color(155, 134, 101);
color c2 = color(255, 250, 242);
color c3 = color(255, 0, 0);
Goose g;
Catcher c;
Cloud cloud1;
Cloud cloud2;
Cloud cloud3;
Heart heart;
PImage menuBackground;
PFont font;

// Sounds
import ddf.minim.*;
Minim minim;
AudioPlayer geese;
AudioPlayer eggCatch;
AudioPlayer goldenEgg;
AudioPlayer badEgg;
AudioPlayer gameMusic;

// Array lists
ArrayList<Egg> eggs = new ArrayList<Egg>();
ArrayList<BadEgg> badEggs = new ArrayList<BadEgg>();
ArrayList<GoldenEgg> goldenEggs = new ArrayList<GoldenEgg>();
ArrayList<Grass> grass = new ArrayList<Grass>();

// Egg variables
Timer eggTimer;
int numEggs;
int eggInterval;
int fallingEggs;
float maxEggs;
int eggsCaught;

// Bad egg variables
Timer badEggTimer;
int numBadEggs;
int badEggInterval;
int fallingBadEggs;
float maxBadEggs;

// Golden egg variables
Timer goldenEggTimer;
int numGoldenEggs;
int goldenEggInterval;
int fallingGoldenEggs;
float maxGoldenEggs;

//-------------------------------------SETUP-------------------------------------
void setup() {
  size (800, 600, P2D);
  gameState = "START";
  menuBackground = loadImage("campusGoose.jpg"); //background image for home, win and lose screens
  menuBackground.resize(width, height);
  font = loadFont("BMDoHyeon-OTF-48.vlw");

  // Initialising game play variables
  lives = 3; //starting lives is 3
  score = 0;
  wins = 0;
  losses = 0;
  countdownTimer = new Timer(1000); //timer counts down in 1000 milliseconds (== 1 second)
  totalTime = 60; //total time for game is 60 seconds (can be increased by catching golden eggs)
  remainingTime = totalTime;
  highscore = 0;
  rules = new Rules();

  // Initialising objects
  g = new Goose();
  c = new Catcher();
  heart = new Heart();
  cloud1 = new Cloud(width, 0);
  cloud2 = new Cloud(width - 600, 100);
  cloud3 = new Cloud(width - 400, 200);
  // Grass loop
  for (int i = 0; i < 80; i++) {
    grass.add(new Grass());
  }

  // Sounds - background music and sound effects
  minim = new Minim(this);
  geese = minim.loadFile("data/sounds/Geese.mp3");
  geese.loop(0);
  eggCatch = minim.loadFile("data/sounds/eggCatch.mp3");
  goldenEgg = minim.loadFile("data/sounds/goldenEgg.mp3");
  badEgg = minim.loadFile("data/sounds/badEgg.mp3");
  gameMusic = minim.loadFile("data/sounds/GameMusic.mp3");
  gameMusic.setGain(-10.0);
  gameMusic.loop(0);

  // Eggs
  numEggs = 100; // total eggs possible to collect
  maxEggs = 4; // max number of eggs that can fall at any time
  for (int i = 0; i < numEggs; i++) {
    eggs.add(new Egg()); //100 eggs added to ArrayList
  }
  fallingEggs = 0;
  eggInterval = 200; //200 milliseconds interval between each egg appearance
  eggTimer = new Timer(eggInterval);
  eggTimer.start(); // adding egg timer prevents all eggs from being released at once at the start of the game
  eggsCaught = 0;

  // Bad eggs
  numBadEggs = 20;
  maxBadEggs = 1; // Initially bad eggs are limited to release 1 at a time
  for (int i = 0; i < numBadEggs; i++) {
    badEggs.add(new BadEgg()); // 20 bad eggs added to ArrayList
  }
  fallingBadEggs = 0;
  badEggInterval = 2000;
  badEggTimer = new Timer(badEggInterval);
  badEggTimer.start();

  // Golden eggs
  numGoldenEggs = 5;
  maxGoldenEggs = 1;
  for (int i = 0; i < numGoldenEggs; i++) {
    goldenEggs.add(new GoldenEgg()); // 5 golden eggs added to ArrayList
  }
  fallingGoldenEggs = 0;
  goldenEggInterval = 2000;
  goldenEggTimer = new Timer(goldenEggInterval);
  goldenEggTimer.start();
}//end setup
//------------------------------------DRAW------------------------------------
void draw() { // set up the various states for game play
  clearBackground(); // Clears the game play background in case of switching from PLAY to WIN or LOSE
  tint(255, 63); // Mutes colours of background image
  image(menuBackground, 0, 0);
  if (gameState == "START") {
    startGame();
  } else if (gameState == "PLAY") {
    playGame();
  } else if (gameState == "WIN") {
    winGame();
  } else if (gameState == "LOSE") {
    loseGame();
  }
} //end draw
//--------------------------------START GAME-------------------------------------
// First screen to start game
// Displays rules, objectives of the game, and how to play
void startGame() {
  // Game title
  textAlign(CENTER);
  fill(44, 66, 188);
  textFont(font);
  textSize(60);
  text("Mother Goose", width/2, height/2 - 100);
  // Buttons
  playButton(); // Start game
  rulesButton(); // How to play
  // Track wins and losses and highscore
  displayScore();
}//end start game
//------------------------------------PLAY GAME--------------------------------------
// Sets up game logic and the main code for how the game works
void playGame() {
  // Game logic
  if (score == 100) {
    //win
    gameState = "WIN";
    wins += 1;
  }
  if (lives == 0) {
    //lose
    gameState = "LOSE";
    losses += 1;
  }
  // countdown timer
  if (countdownTimer.complete() == true) {
    if (remainingTime > 1) {
      remainingTime--;
      countdownTimer.start();
    } else {
      gameState = "LOSE"; // When time runs out go to Game Over screen (LOSE state)
      losses +=1;
    }
  }

  background(137, 206, 234, 100); // Sky color for main game background

  // Grass - display a triangle of grass for each object in array list grass in random shades of green
  for (int i = 0; i < grass.size(); i++) {
    grass.get(i).drawGrass();
  }

  // Clouds
  cloud1.drift(0.5);
  cloud1.drawCloud();
  cloud2.drift(0.8);
  cloud2.drawCloud();
  cloud3.drift(0.4);
  cloud3.drawCloud();

  // Hearts (lives) hearts disappear as lives are lost
  int h = 0; // h represents heartX in heart constructor
  for (int i = lives; i > 0; i--) {
    heart.drawHeart(h, 0);
    h += 30; // Each heart is 30 pixels apart on the x-axis
  }

  // Goose and catcher - catcher moves together with the goose with left and right keys
  // Goose g represents the visual catcher for the player, catcher c is invisible to the player
  g.keyPressed();
  g.drawGoose();
  c.keyPressed();
  c.display(); 

  //eggs - timer to stagger release of eggs
  if (eggTimer.complete() == true) {
    fallingEggs++;
    eggTimer.start();
  }
  // methods for making eggs fall and displaying the eggs
  for (int i = 0; i < maxEggs; i++) {
    eggs.get(i).fall();
    eggs.get(i).displayEgg();
    // check collision(egg catch)
    // if eggs are caught, remove to fixed position below screen so they will not fall again
    if (checkCaught(c, eggs.get(i))==true) {
      eggCatch.play(0); // Sound effect alerting player they caught an egg
      eggs.get(i).y = height + 50;
      score += 1;
      eggsCaught += 1;
    }
  } //end eggs
  
  //bad eggs timer to stagger release
  if (badEggTimer.complete() == true) {
    fallingBadEggs++;
    badEggTimer.start();
  }
  // methods to make bad eggs fall and display bad eggs
  for (int i = 0; i < maxBadEggs; i++) {
    badEggs.get(i).fall();
    badEggs.get(i).displayBadEgg();
    // falling bad eggs increases to 2 when score reaches 40
    if (score == 40) {
      levelUp = true; // Displays message alerting an increase in the number of falling eggs
      maxBadEggs = 2;
    }
    // Remove message alerting increase in bad eggs when score reaches 43
    if (score == 43) {
      levelUp = false;
    }
    // Bad eggs increases to 3 when score reaches 60
    if (score == 60) {
      levelUp = true;
      maxBadEggs = 3;
    }
    // Remove message alerting increase in bad eggs when score reaches 63
    if (score == 63) {
      levelUp = false;
    }
    // Bad eggs increases to 4 when score reaches 80
    if (score == 80) {
      levelUp = true;
      maxBadEggs = 4;
    }
    // Remove message alerting increase in bad eggs when score reaches 83
    if (score == 83) {
      levelUp = false;
    }
    if (checkBadCaught(c, badEggs.get(i))==true) {
      // if bad eggs are caught, they rejoin in random x position
      badEgg.play(0); // Sound effect alerting player to catching a bad egg and losing a life
      badEggs.get(i).y = - 50;
      badEggs.get(i).x = random(0, width);
      lives -=1; // One life(heart) removed
    }
  }// end bad eggs

  // Golden eggs - timer to stagger release of eggs
  if (goldenEggTimer.complete() == true) {
    // fallingGoldenEggs++;
    goldenEggTimer.start();
  }
  // Methods for making golden eggs fall and displaying the golden eggs
  for (int i = 0; i < maxGoldenEggs; i++) {
    goldenEggs.get(i).fall();
    goldenEggs.get(i).displayGoldenEgg();
    // check collision(egg catch)
    // if eggs are caught, remove to fixed position below screen so they will not fall again
    if (checkGoldenCaught(c, goldenEggs.get(i))==true) {
      goldenEgg.play(0); // Sound effect alerting player they caught a golden egg and increased their time
      goldenEggs.get(i).y = height + 50; 
      remainingTime += 5; // Remaining time increases by 5 seconds
      goldenEggTimer.start();
    }
  }

  // Display message alerting to increase in difficulty, i.e. an extra bad egg falling
  if (levelUp == true) {
    displayLevelUp();
  }

  // Store score for highscore on win and lose screens
  if (score > highscore) {
    highscore = score;
  }

  // Display score and countdown timer across the top of the screen
  // Score
  textAlign(RIGHT);
  fill(0);
  textSize(20);
  text("Eggs saved: " + score, width - 50, 30);

  // remaining time
  String s = "Remaining time: " + remainingTime;
  textAlign(CENTER);
  textSize(20);
  text(s, width/2, 30);
}//end play game

//-------------------------------CHECK CATCH-------------------------------------
// Check caught eggs
boolean checkCaught(Catcher c, Egg egg) {
  // if the x and y coordinates of the egg match cross the x and y coordinates of the catcher
  if (egg.x > (c.x - c.w/2) && egg.x < (c.x + c.w/2) && egg.y > (c.y - c.h/2) && egg.y < (c.y + c.h/2)) {
    return true;
  } else {
    return false;
  }
}//end checkCaught

// Check caught bad eggs
boolean checkBadCaught(Catcher c, BadEgg badEgg) {
  if (badEgg.x > (c.x - c.w/2) && badEgg.x < (c.x + c.w/2) && badEgg.y > (c.y - c.h/2) && badEgg.y < (c.y + c.h/2)) {
    return true;
  } else {
    return false;
  }
}//end bad egg checkCaught

// Check caught golden eggs
boolean checkGoldenCaught(Catcher c, GoldenEgg goldenEgg) {
  if (goldenEgg.x > (c.x - c.w/2) && goldenEgg.x < (c.x + c.w/2) && goldenEgg.y > (c.y - c.h/2) && goldenEgg.y < (c.y + c.h/2)) {
    return true;
  } else {
    return false;
  }
}//end golden egg checkCaught
//----------------------------------WIN GAME--------------------------------------
// Screen displays if gamestate = win, i.e. after successfully collecting 100 eggs
void winGame() {
  textAlign(CENTER);
  textFont(font);
  textSize(25);
  fill(0, 0, 255);
  text("CONGRATULATIONS!! YOU WIN!", width/2, height/3);
  textSize(15);
  fill(0);
  text("Play again?", width/2, height/3+40);
  playButton(); // Start Game button if player wants to play again
  rulesButton(); // How to play button in case player didn't read before starting the first time
  resetGame(); // Reset eggs, score and lives
  displayScore(); // Displays running count of wins and losses
}//end win game
//-----------------------------------LOSE GAME-------------------------------------
// screen displays if gamestate = lose, i.e. after losing all 3 lives
void loseGame() {
  textAlign(CENTER);
  textSize(50);
  fill(255, 0, 0);
  text("GAME OVER", width/2, height/3);
  textSize(15);
  fill(0);
  text("Play again?", width/2, height/3 + 40);
  playButton();
  rulesButton();
  resetGame();
  displayScore();
}//end lose game
//------------------------------------RESET GAME--------------------------------------
void resetGame() {
  // Resets eggs, timer, lives, and score when starting a new game
  score = 0;
  lives = 3;
  maxBadEggs = random(0, 1); // Resets bad egg count to prevent previous level up still being in play
  remainingTime = totalTime; // Resets time tp 60 seconds
  countdownTimer.start();
  levelUp = false;
  g.x = width/2; // Resets goose to center of screen
  c.x = width/2; // Resets catcher to center of screen
}
//------------------------------------PLAY BUTTON------------------------------------
// method for play button that is used in multiple sections
void playButton() {
  //button
  stroke(0);
  fill(121, 45, 133);
  rectMode(CENTER);
  rect(width/2, height/2, 200, 70);
  fill(255);
  textFont(font);
  textSize(25);
  text("START GAME", width/2, height/2+10);
  // Button limits for click
  float leftEdge = width/2 - 100;
  float rightEdge = width/2 + 100;
  float topEdge = height/2 - 35;
  float bottomEdge = height/2 + 35;
  // Check button click
  if (mousePressed == true &&
    mouseX > leftEdge &&
    mouseX < rightEdge &&
    mouseY > topEdge &&
    mouseY < bottomEdge
    ) {
    gameState = "PLAY";
    resetGame(); // Calls reset game method when Start Game button is pressed
  }
}
//---------------------------------HOW TO PLAY BUTTON---------------------------------
// button for home screen displaying clear text on the goal and how to play the game
void rulesButton() {
  //button
  stroke(0);
  fill(121, 45, 133);
  rectMode(CENTER);
  rect(width/2, height/3 * 2, 200, 70);
  fill(255);
  textFont(font);
  textSize(20);
  text("HOW TO PLAY", width/2, height/3 * 2 + 10);
  //button sides for click
  float leftEdge = width/2 - 100;
  float rightEdge = width/2 + 100;
  float topEdge = (height/3 * 2) - 30;
  float bottomEdge = (height/3 * 2) + 40;
  //check button click
  if (mousePressed == true &&
    mouseX > leftEdge &&
    mouseX < rightEdge &&
    mouseY > topEdge &&
    mouseY < bottomEdge
    ) {
    rules.displayRules(); // How to play, aim of game, is displayed while the button is being pressed
  }
}
//-------------------------------------SCOREBOARD-------------------------------------
// Displays a running count of wins and losses on each screen (start, win, lose)
void displayScore() {
  textAlign(LEFT);
  textSize(15);
  fill(0);
  String s = "Wins: " + wins + "\n" + "Losses: " + losses + "\n" + "Highscore: " + highscore;
  text(s, 175, 30);
}
//-----------------------------------CLEAR BACKGROUND---------------------------------
// Removes the gameplay background for the screens (start, win, lose)
void clearBackground() {
  rectMode(CORNER);
  fill(200);
  rect(0, 0, width, height);
}
//-----------------------------------LEVEL UP-----------------------------------------
// Display text upon reaching score 40, 60 and 80: number of falling bad eggs increasing by 1
// Text will disappear 
void displayLevelUp() {
  textAlign(CENTER);
  fill(255, 0, 0);
  textSize(50);
  text("BAD EGGS INCREASING!", width/2, height/3);
}
//----------------------------------CLOSE AUDIO----------------------------------------
// Essential method to stop sound effects cleanly when closing the sketch window
void stop() {
  geese.close();
  eggCatch.close();
  goldenEgg.close();
  badEgg.close();
  gameMusic.close();
  minim.stop();
  super.stop();
}
