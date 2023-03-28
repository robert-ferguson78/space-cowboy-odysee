/* Cowboy Space Odysee
 main game tab */
import javax.swing.*;
import processing.sound.*;
SoundFile pewPew;

//Global variables

//firing and direction varibales
boolean space;
int nextProjectile, nextBadGuy;
boolean up, down, left, right;
String direction = "up";

//setting screen up for direct user input
boolean intro = true;
boolean nameTypeActive;

//player stat variables
int lives = 3;
int score;
boolean goodGuyDead = false;

//game variables
boolean playGame = true;
boolean gameOver = false;
boolean exitGame = false;
boolean playerWantToPlayAgain = false;
boolean replayGameOption = false;

//Arrays for scoring and names
int scoreList[] = {0, 0, 0, 0, 0, 0};
String names[] = {"Enter Name", "Enter Name", "Enter Name", "Enter Name", "Enter Name", "Enter Name"};

int textStartX = 500;
int textStartY = 450;

//difficulty setting variable and default enemy numbers
int difficulty;
int badguyNum = 20;
int orbsNum = 3;
int orbsStillNum = 3;

//font variable
PFont jetBrains;

//image variables
PImage goodGuyImage;
PImage badGuyImage;
PImage bonusOrbPurpleImage;
PImage bonusOrbGoldImage;

//Objects fom classes
GoodGuy goodGuy;
Timer fireingTimer;
Timer pewPewTimer;
Timer badGuyTimer;
Timer bonusOrbsTimer;
Timer bonusOrbsStillTimer;
PlayerStats playerStats;
UserInput userInput;

//object arrays from classes
Projectile[] projectiles;
BadGuy[] badGuys;
BonusOrbs[] bonusOrbs;
BonusOrbs[] bonusOrbsStill;

void setup()
{
  //spec for size 1280 by 720
  size(1280, 720);
  noCursor();

  //asking user for diffulty setting
  difficulty = Integer.parseInt(JOptionPane.showInputDialog("Choose Diffulty Level \n 1 = Panzy mode (easy) \n 2 = You should be fine mode (normal = deafult) \n 3 = May the force be with you (Hard) \n\nYou choose: ", "2"));

  //setting difficulty enemy numbers with normal being the defult variables in game
  if (difficulty == 1) {
    badguyNum = 10;
    orbsNum = 4;
    orbsStillNum = 4;
  } else if (difficulty == 3) {
    badguyNum = 30;
    orbsNum = 1;
    orbsStillNum = 1;
  }

  //load sound
  pewPew = new SoundFile (this, "pew.wav");

  //load images for characters
  goodGuyImage = loadImage("goodguy.png");
  badGuyImage = loadImage("badguy.png");
  bonusOrbPurpleImage = loadImage("purple.png");
  bonusOrbGoldImage = loadImage("gold.png");

  //load sound

  //set font and default size for text
  jetBrains = loadFont("JetBrainsMono-Regular_Bold-48.vlw");
  textFont(jetBrains, 16);

  //set up player stats board
  playerStats = new PlayerStats(score);
  playerStats.setGameOver(false);

  //set up GoodGuy
  goodGuy = new GoodGuy(20);

  //set up projectiles/bullets off screen
  projectiles = new Projectile[20];
  for (int k = 0; k < projectiles.length; k++) {
    projectiles[k] = new Projectile(-1000, -1000);
  }

  //place bad guys off screen in random locations
  badGuys = new BadGuy[badguyNum];
  for (int l = 0; l < badGuys.length; l++) {
    badGuys[l] = new BadGuy(20);
    badGuys[l].reset();
  }

  //place bonus orb moving in game
  bonusOrbs = new BonusOrbs[orbsNum];
  for (int m = 0; m < bonusOrbs.length; m++) {
    bonusOrbs[m] = new BonusOrbs(20, true);
    bonusOrbs[m].spawningOrb();
  }

  //place bonus orb stationary in game
  bonusOrbsStill = new BonusOrbs[orbsStillNum];
  for (int n = 0; n < bonusOrbsStill.length; n++) {
    bonusOrbsStill[n] = new BonusOrbs(20);
    bonusOrbsStill[n].spawningOrb();
  }

  //set up projectile/bullet with timer to control rate of fire
  nextProjectile = 0;
  fireingTimer = new Timer(200);
  fireingTimer.start();


  //set up user input
  userInput = new UserInput();
}//end setup

void draw()
{
  //set timer for bad guys to respawn in
  badGuyTimer = new Timer(200);
  badGuyTimer.start();

  //set timer for moving orbs to spawn in
  bonusOrbsTimer = new Timer(200);
  bonusOrbsTimer.start();

  //set timer for orbs in still positiion to appear randomly
  bonusOrbsStillTimer = new Timer(200);
  bonusOrbsStillTimer.start();

  //display user input and instructions
  if (intro == true) {
    nameTypeActive = true;
    userInput.display();
  }

  //diaplay intro
  if (intro == false) {
    background(0);
    playerStats.display();

    //reset the game back to intro
    if (playerWantToPlayAgain == true && gameOver == true) {
      resetGame();
    } else if (exitGame == true && gameOver == true) {
      //exit the game and close
      exit();
    }

    //Check if all lives are gone for game over, and ask player to play again
    if (gameOver == false) {
      //updates in the gamer details overlay and update top 5 leaderboard
      playerUpdate();
    } else {
      //display top 5 leaderboard and ask player to play again
      playGame = false;
      fill(#ffffff);
      textSize(16);
      sortPlayerPositions();
      text(("Game Over your score was: " + str(playerStats.getScore())), 500, 500);
      replayGameOption = true;
      text("Play Another Game: Y/N", 500, 550);
    }

    //pass in all lives
    playerStats.setLives(lives);

    //game has started
    if (playGame == true) {
      goodGuy.isShooting();

      //display projectiles on screen and check if they have hit bad guys and do resets
      int p = 0;
      while (p < projectiles.length - 1) {
        projectiles[p].update();
        for (int j = 0; j < badGuys.length; j++) {
          for (int k = 0; k < bonusOrbs.length; k++) {
            for (int l = 0; l < bonusOrbsStill.length; l++) {
              //do check for hit detection between projectiles and bad guys and do resets and game stat changes
              if (badGuysHitProjectiles(projectiles[p], badGuys[j])) {
                projectiles[p].reset();
                badGuys[j].spawning();
                score++;
                playerStats.setScore(score);
              }
              if (orbHitProjectiles(projectiles[p], bonusOrbs[k])) {
                projectiles[p].reset();
                bonusOrbs[k].spawningOrb();
                score = score + 10;
                playerStats.setScore(score);
              }
              if (orbHitProjectiles(projectiles[p], bonusOrbsStill[l])) {
                projectiles[p].reset();
                bonusOrbsStill[l].spawningOrb();
                //bonusOrbsTimer.start();
                score = score + 5;
                playerStats.setScore(score);
              }
              //check to see if godguy has been hit and do resets and update game stats
              if (goodGuyHit(goodGuy, badGuys[j]) || goodGuyHitOrb(goodGuy, bonusOrbs[k]) || goodGuyHitOrb(goodGuy, bonusOrbsStill[l])) {
                for (int m = 0; m < badGuys.length; m++) {
                  for (int n = 0; n < bonusOrbs.length; n++) {
                    int o = 0;
                    while (o < bonusOrbs.length) {
                      projectiles[p].reset();
                      badGuys[m].spawning();
                      bonusOrbs[n].spawningOrb();
                      bonusOrbsStill[o].spawningOrb();
                      o++;
                    }
                  }
                }
                goodGuy.reset();
                goodGuyDead = true;
                lives-- ;
                playerStats.setLives(lives);
              }
            }
          }
        }
        projectiles[p].display();
        //reset all projectiles if GgoodGuy is dead
        if (goodGuyDead == true) {
          projectiles[p].reset();
        }
        p++;
      }
      //turn googdGuy back to life to shoot again
      goodGuyDead = false;


      //display badGuys and have them move around on screen after respawn
      for (int i = 0; i < badGuys.length; i++) {
        badGuys[i].update();
        badGuys[i].display();
      }

      //display moving orbs and have them move around on screen
      for (int i = 0; i < bonusOrbs.length; i++) {
        bonusOrbs[i].update();
        bonusOrbs[i].display();
      }

      //display stationary orbs on screen
      for (int i = 0; i < bonusOrbsStill.length; i++) {
        bonusOrbsStill[i].update();
        bonusOrbsStill[i].display();
      }

      //if bad guy is less that the lenght of the array of bad guys respawn him
      for ( int i = 0; i < badGuys.length; i++) {
        if (badGuyTimer.complete()) {
          badGuys[i].spawning();
          badGuyTimer.start();
        }//end badGuyTimer
      }

      //if bonus orb is less that the lenght of the array of bonus orbs respawn orb
      for ( int i = 0; i < bonusOrbs.length; i++) {
        if (bonusOrbsTimer.complete()) {
          bonusOrbs[i].spawningOrb();
          bonusOrbsTimer.start();
        }//end badGuyTimer
      }

      //goodGuy on screen with position update
      goodGuy.update();
      goodGuy.display();
    }

    //set game to over
    if (lives == 0) {
      gameOver = true;
    }
  }
}//end draw

//check bad guys for Hits with prejctiles
boolean badGuysHitProjectiles(Projectile projectile, BadGuy badGuy) {
  float distancX = (projectile.getProjectileX()) - (badGuy.getXCoord());
  float distancY = (projectile.getProjectileY()) - (badGuy.getYCoord());
  float widths = projectile.getProjectileDiam();
  float heights = projectile.getProjectileDiam();
  if (abs(distancX) < widths) {
    if (abs(distancY) < heights) {
      return true;
    }
  }
  return false;
}

//check moving orb for Hits with prejctiles
boolean orbHitProjectiles(Projectile projectile, BonusOrbs bonusOrbs) {
  float distancX = (projectile.getProjectileX()) - (bonusOrbs.getXCoord());
  float distancY = (projectile.getProjectileY()) - (bonusOrbs.getYCoord());
  float widths = projectile.getProjectileDiam();
  float heights = projectile.getProjectileDiam();
  if (abs(distancX) < widths) {
    if (abs(distancY) < heights) {
      return true;
    }
  }
  return false;
}

//check goodguy for Hits with bonus orbs
boolean goodGuyHitOrb(GoodGuy goodGuy, BonusOrbs bonusOrbs) {
  float distancX = (goodGuy.getXCoord()) - (bonusOrbs.getXCoord());
  float distancY = (goodGuy.getYCoord()) - (bonusOrbs.getYCoord());
  float widths = goodGuy.getGoodGuyDiam();
  float heights = goodGuy.getGoodGuyDiam();
  if (abs(distancX) < widths) {
    if (abs(distancY) < heights) {
      return true;
    }
  }
  return false;
}

//check goodguy for Hits with bad guys
boolean goodGuyHit(GoodGuy goodGuy, BadGuy badGuy) {
  float distancX = (goodGuy.getXCoord()) - (badGuy.getXCoord());
  float distancY = (goodGuy.getYCoord()) - (badGuy.getYCoord());
  float widths = goodGuy.getGoodGuyDiam();
  float heights = goodGuy.getGoodGuyDiam();
  if (abs(distancX) < widths) {
    if (abs(distancY) < heights) {
      return true;
    }
  }
  return false;
}

//reset game variables
public void resetGame() {
  playGame = true;
  lives = 3;
  score = 0;
  gameOver = false;
  playerWantToPlayAgain = false;
  playerStats.setScore(0);
}

//add in score and name to seperate arrays
public void playerUpdate() {
  if (score >= scoreList[0]) {
    scoreList[0] = score;
    names[0] = userInput.getUserInputName();
  }
}

/*sort position based on scores in array and use same index to position name in array
 to match score position (keeps current score and name at same array index)*/
public void sortPlayerPositions() {
  int lengthScore = scoreList.length;
  for (int i = 0; i < lengthScore - 1; i++) {
    if (scoreList[i] > scoreList[i + 1]) { //sorting 2 values at a time in loop swaping them if value is higher for lowest to highest
      int tempScore = scoreList[i]; // temporary store value to be swapped
      scoreList[i] = scoreList[i + 1]; // swapping value
      scoreList[i + 1] = tempScore; // puttgin back in value stored from temp variable
      String tempName = names[i]; // applying same operation to names as array is same size to keep values paired by index position
      names[i] = names[i + 1];
      names[i + 1] = tempName;
      i = -1;
    }
  }

  //display the scores to the screen in order of highest at top to lowest at bottom
  textSize(24);
  text("Top 5 High Scores", 500, 150);
  int lengthScore2 = scoreList.length;
  int lengthName2 = names.length;

  int i = 1;
  while (i < lengthScore2) {
    for (int j = 1; j < lengthName2; j++) {
      int str = scoreList[i];
      String strName = names[i];
      textSize(16);
      text(" Name: " + strName + " - Score: " + str, textStartX, textStartY - i * 50 ); //display on screen the higest scores at the top and lowest at the bottom
    }
    i++;
  }
}

//keyPressed handlers
public void keyPressed() {
  //feed in key presses from GoodGuy class for movement of player and direction
  goodGuy.goodGuyMovedPressed();
  goodGuy.directionMoved();
  if (key == ' ') { //setting up space bar for single fire
    space = true;
  }
}//end keyPressed

//keyReleased handlers
public void keyReleased() {
  //feed in key releases from GoodGuy class for movement of player and direction
  goodGuy.goodGuyMovedReleased();
  if (key == ' ') { //setting up space bar for single fire
    space = false;
  }
  //feed in key releases from UserInput class
  userInput.keyLogging();
  //play again option and exit game
  if (key == 'Y' || key == 'y') {
    playerWantToPlayAgain = true;
    replayGameOption = false;
    intro = true;
  }
  if (key == 'N' || key == 'n' && replayGameOption == true) {
    exitGame = true;
  }
}//end keyReleased
