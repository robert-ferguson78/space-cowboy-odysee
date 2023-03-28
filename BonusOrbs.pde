// BonusOrbs Class
public class BonusOrbs
{
  //propertys
  private float xCoord, yCoord;
  private int top, right, bottom, spawnOrbDirection;
  private float speed = 1.5;
  private float speedX;
  private float speedY;
  private int orbSize;
  private boolean floating; //is orb stationary or moving

  //constructor
  public BonusOrbs() {
  }

  public BonusOrbs(int orbSize) {
    setOrbSize(orbSize);
    floating = false;
  }

  public BonusOrbs(int orbSize, boolean floating) {
    setOrbSize(orbSize);
    setFloating(floating);
  }

  //methords
  public void display() //draw the Orb
  {
    fill(000);
    noStroke();
    circle(xCoord, yCoord, orbSize);
    if (floating == true) {
      image(bonusOrbGoldImage, xCoord - orbSize/2, yCoord - orbSize/2);
      checkBounds();
    } else {
      image(bonusOrbPurpleImage, xCoord - orbSize/2, yCoord - orbSize/2);
    }
  }

  public void update()
  {
    if (floating == true) {
      xCoord = xCoord + speedX;
      yCoord = yCoord + speedY;
    }
  }

  //Orb entering and moving from offscreen in random directions or appearing still in random locations
  public void spawningOrb()
  {
    if (floating == true) {
      top = 1;
      right = 2;
      bottom = 3;
      spawnOrbDirection = int(random(1, 5));

      if (spawnOrbDirection == top) {
        xCoord = int(random(0, width));
        yCoord = -50;
        speedX = speed;
        speedY = speed;
      } else if (spawnOrbDirection == right) {
        xCoord = width + 50;
        yCoord = int(random(0, height));
        speedX = -speed;
        speedY = speed;
      } else if (spawnOrbDirection == bottom) {
        xCoord = int(random(0, width));
        yCoord = height + 50;
        speedX = -speed;
        speedY = -speed;
      } else {
        xCoord = -50;
        yCoord = int(random(0, height));
        speedX = speed;
        speedY = -speed;
      }
    } else {
      xCoord = random(0 + orbSize, width - orbSize);
      yCoord = random(0 + orbSize, height - orbSize);
    }
  }//end spawning

  private void checkBounds() {
    if (xCoord < orbSize/2) {
      xCoord = orbSize/2;
      speedX = speedX * -1;
    } else if (xCoord > width - orbSize/2) {
      xCoord = width - orbSize/2;
      speedX = speedY * -1;
    }

    if (yCoord > height - orbSize/2) {
      yCoord = height - orbSize/2;
      speedY = speedY * -1;
    } else if (yCoord < orbSize/2) {
      yCoord = orbSize/2;
      speedY = speedY * -1;
    }
  }


  //getter methods
  public float getXCoord()
  {
    return xCoord;
  }

  public float getYCoord()
  {
    return yCoord;
  }

  public int getOrbSize()
  {
    return orbSize;
  }

  public boolean getFloating()
  {
    return floating;
  }

  public int getSpawnOrbDirection()
  {
    return spawnOrbDirection;
  }

  public int getBottom()
  {
    return bottom;
  }

  public int getRight()
  {
    return right;
  }

  public int getTop()
  {
    return top;
  }

  public float getSpeed()
  {
    return speed;
  }

  public float getSpeedX()
  {
    return speedX;
  }

  public float getSpeedY()
  {
    return speedY;
  }

  //setter methods
  public void setXCoord(float xCoord)
  {
    this.xCoord = xCoord;
  }

  public void setYCoord(float yCoord)
  {
    this.yCoord = yCoord;
  }

  public void setFloating(boolean floating)
  {
    this.floating = floating;
  }

  public void setOrbSize(int orbSize)
  {
    //The orb size diameter must be between 20 and less than 40 in size
    if ((orbSize >= 20) && (orbSize <= 40)) {
      this.orbSize = orbSize;
    } else {
      //default size is 20
      this.orbSize = 20;
    }
  }

  public void setSpawnOrbDirection(int spawnOrbDirection)
  {
    this.spawnOrbDirection = spawnOrbDirection;
  }

  public void setBottom(int bottom)
  {
    this.bottom = bottom;
  }

  public void setRight(int right)
  {
    this.right = right;
  }

  public void setTop(int top)
  {
    this.top = top;
  }

  public void setSpeed(float speed)
  {
    this.speed = speed;
  }

  public void setSpeedX(float speedX)
  {
    this.speedX = speedX;
  }

  public void setSpeedY(float speedY)
  {
    this.speedY = speedY;
  }
}
