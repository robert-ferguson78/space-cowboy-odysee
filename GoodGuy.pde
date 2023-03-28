// GoodGuy Class
public class GoodGuy
{
  //propertys
  private int xCoord;
  private int yCoord;
  private float normalSpeed = 3;
  private float boostSpeed = 5;
  private float speed;
  private boolean boost = false;
  private int goodGuyDiam;

  //constructor
  public GoodGuy() {
  }

  public GoodGuy(int goodGuyDiam) {
    setGoodGuyDiam(goodGuyDiam);
    xCoord = width/2;
    yCoord = height/2;
  }

  //methords
  public void display() //draw GoodGuy (space cowboy)
  {
    fill(000);
    noStroke();
    circle(xCoord, yCoord, goodGuyDiam);
    image(goodGuyImage, xCoord - goodGuyDiam/2, yCoord - goodGuyDiam/2);
  }

  public void update() //set up movement while still on game area confines
  {
    if (boost == true) {
      speed = boostSpeed;
    } else {
      speed = normalSpeed;
    }
    if (left == true && xCoord > (0 + goodGuyDiam / 2)) {
      xCoord -= speed;
    }
    if (right == true && xCoord < (width - goodGuyDiam / 2)) {
      xCoord += speed;
    }
    if (up == true && yCoord > (0 + goodGuyDiam / 2)) {
      yCoord -= speed;
    }
    if (down == true && yCoord < (height - goodGuyDiam)) { // slight adjutment so space cowboy graphic stays fully on screen when at the bottom
      yCoord += speed;
    }
  }

  //map out direction based on key assigned values and return (8 axis of movement)
  String directionMoved() {
    if (left == false && right == false && up == true && down == false) direction = "up";
    if (left == false && right == false && up == false && down == true) direction = "down";
    if (left == true && right == false && up == false && down == false) direction = "left";
    if (left == false && right == true && up == false && down == false) direction = "right";
    if (left == true && right == false && up == false && down == true) direction = "down-left";
    if (left == false && right == true && up == false && down == true) direction = "down-right";
    if (left == true && right == false && up == true && down == false) direction = "up-left";
    if (left == false && right == true && up == true && down == false) direction = "up-right";
    return direction;
  }

  //set up keys pressed and released so 2 key values can be true at a time so move can player vertically with keys and cursor keys
  void goodGuyMovedPressed() {
    if (keyCode == LEFT || key == 'a' || key == 'A') left = true;
    if (keyCode == RIGHT || key == 'd' || key == 'D') right = true;
    if (keyCode == UP || key == 'w' || key == 'W') up = true;
    if (keyCode == DOWN || key == 's' || key == 'S') down = true;
    if (key == 'B' || key == 'b') {
      boost = true;
    }
  }
  void goodGuyMovedReleased() {
    if (keyCode == LEFT || key == 'a' || key == 'A') left = false;
    if (keyCode == RIGHT || key == 'd' || key == 'D') right = false;
    if (keyCode == UP || key == 'w' || key == 'W') up = false;
    if (keyCode == DOWN || key == 's' || key == 'S') down = false;
    if (key == 'B' || key == 'b') {
      boost = false;
    }
  }

  //reset the GoodGuy when killed
  private void reset() {
    xCoord = width/2;
    yCoord = height/2;
  }//end reset

  public void isShooting() {
    //shooting if true pleyer can shoot projectiles/bullets
    if (space == true) {
      if (fireingTimer.complete()) {
        projectiles[nextProjectile].fire(goodGuy.getXCoord(), goodGuy.getYCoord(), direction);
        nextProjectile = (nextProjectile+1)%projectiles.length;
        fireingTimer.start();
        pewPew.play(); //had to add the pew pew sound effect
      }//end fireingtimer
    }//end space bar firing
  }

  //getter methods
  public int getXCoord()
  {
    return xCoord;
  }

  public int getYCoord()
  {
    return yCoord;
  }

  public float getNormalSpeed()
  {
    return normalSpeed;
  }

  public float getBoostSpeed()
  {
    return boostSpeed;
  }

  public boolean getBoost()
  {
    return boost;
  }

  public int getGoodGuyDiam()
  {
    return goodGuyDiam;
  }

  //setter methods
  public void setGoodGuyDiam(int goodGuyDiam)
  {
    //Check the goodGuy diameter is between 20 and 40
    if ((goodGuyDiam >= 20) && (goodGuyDiam <= 40)) {
      this.goodGuyDiam = goodGuyDiam;
    } else {
      //default size is 20
      this.goodGuyDiam = 20;
    }
  }

  public void setBoost(boolean boost)
  {
    this.boost = boost;
  }

  public void setBoostSpeed(float boostSpeed)
  {
    this.boostSpeed = boostSpeed;
  }

  public void setNormalSpeed(float normalSpeed)
  {
    this.normalSpeed = normalSpeed;
  }

  public void setYCoord(int yCoord)
  {
    this.yCoord = yCoord;
  }

  public void setXCoord(int xCoord)
  {
    this.xCoord = xCoord;
  }
}
