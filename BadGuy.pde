// BadGuy Class
public class BadGuy
{
  //propertys
  private int xCoord, yCoord;
  private float speed = 1;
  private int badGuySize;
  private int top, right, bottom, spawnDirection;
  private boolean inMotion;

  //constructor
  public BadGuy()
  {
  }

  public BadGuy(int badGuySize)
  {
    setBadGuySize(badGuySize);
    inMotion = false;
  }

  /*methords
   Badguy (aliens) moves towards the GoodGuy to catch him*/
  public void update()
  {
    inMotion = true;

    if (xCoord < goodGuy.getXCoord()) {
      xCoord += speed;
    }
    if (xCoord > goodGuy.getXCoord()) {
      xCoord -= speed;
    }
    if (yCoord < goodGuy.getYCoord()) {
      yCoord += speed;
    }
    if (yCoord > goodGuy.getYCoord()) {
      yCoord -= speed;
    }
  }

  // Draw badGuy to the display window
  public void display()
  {
    fill(000);
    noStroke();
    circle(xCoord, yCoord, badGuySize);
    image(badGuyImage, xCoord - badGuySize/2, yCoord - badGuySize/2);
  }

  //BadGuy entering/spawning from offscreen in random directions and locations
  public void spawning()
  {
    if (inMotion == true) {
      top = 1;
      right = 2;
      bottom = 3;
      spawnDirection = int(random(1, 5));

      if (spawnDirection == top) {
        xCoord = int(random(0, width));
        yCoord = -50;
      } else if (spawnDirection == right) {
        xCoord = width + 50;
        yCoord = int(random(0, height));
      } else if (spawnDirection == bottom) {
        xCoord = int(random(0, width));
        yCoord = height + 50;
      } else {
        xCoord = -50;
        yCoord = int(random(0, height));
      }
    }
  }//end spawning

  //reset all bad guys
  public void reset()
  {
    top = 1;
    right = 2;
    bottom = 3;
    spawnDirection = int(random(1, 5));

    if (spawnDirection == top) {
      xCoord = int(random(0, width));
      yCoord = -50;
    } else if (spawnDirection == right) {
      xCoord = width + 50;
      yCoord = int(random(0, height));
    } else if (spawnDirection == bottom) {
      xCoord = int(random(0, width));
      yCoord = height + 50;
    } else {
      xCoord = -50;
      yCoord = int(random(0, height));
    }
  }//end reset


  //getter methods
  public int getXCoord()
  {
    return xCoord;
  }

  public int getYCoord()
  {
    return yCoord;
  }

  public int getBadGuySize()
  {
    return badGuySize;
  }

  public int getSpawnDirection()
  {
    return spawnDirection;
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

  public boolean getInMotion()
  {
    return inMotion;
  }

  //setter methods
  public void setBadGuySize(int badGuySize)
  {
    //The goodGuy diameter must be between 20 and less than 40 in size
    if ((badGuySize >= 20) && (badGuySize <= 40)) {
      this.badGuySize = badGuySize;
    } else {
      //default size is 20
      this.badGuySize = 20;
    }
  }

  public void setInMotion(boolean inMotion)
  {
    this.inMotion = inMotion;
  }

  public void setSpeed(float speed)
  {
    this.speed = speed;
  }

  public void setTop(int top)
  {
    this.top = top;
  }

  public void setRight(int right)
  {
    this.right = right;
  }

  public void setBottom(int bottom)
  {
    this.bottom = bottom;
  }

  public void setSpawnDirection(int spawnDirection)
  {
    this.spawnDirection = spawnDirection;
  }
}
