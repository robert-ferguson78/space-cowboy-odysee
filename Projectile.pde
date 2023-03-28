// Projectile Class
class Projectile {
  //propertys
  private float projectileX, projectileY, projectileDiam, vertXPos, vertYPos, startingX, startingY;
  private float speed = 8;
  private boolean inMotion;
  private String directionFired;

  /*constructor
   set up starting and firing position of projectile and check for projectile moving*/
  public Projectile() {
  }

  public Projectile(float currentXPos, float currentYPos) {
    startingX = currentXPos;
    startingY = currentYPos;
    projectileX = currentXPos;
    projectileY = currentYPos;
    projectileDiam = 10;
    vertXPos = 0;
    vertYPos  = 0;
    inMotion = false;
    setProjectileDirection(directionFired);
  }//end constructor

  /*methords
   projectile direction with check for edge of game area*/
  public void update() {
    projectileX += vertXPos;
    projectileY += vertYPos;
    checkBounds();
  }//end update

  //display projectile
  public void display() {
    fill(000, 255, 000);
    circle(projectileX, projectileY, projectileDiam);
  }//end display

  //set direction of projectile ready for fireing
  public void fire(float newProjectileX, float newProjectileY, String directionFired) {
    projectileX = newProjectileX;
    projectileY = newProjectileY;
    if (inMotion == false) {
      if (directionFired == "left") {
        vertXPos = -speed;
        vertYPos  = 0;
      }
      if (directionFired == "right") {
        vertXPos = speed;
        vertYPos  = 0;
      }
      if (directionFired == "up") {
        vertXPos = 0;
        vertYPos  = -speed;
      }
      if (directionFired == "down") {
        vertXPos = 0;
        vertYPos  = speed;
      }
      if (directionFired == "down-left") {
        vertXPos = -speed;
        vertYPos  = speed;
      }
      if (directionFired == "down-right") {
        vertXPos = speed;
        vertYPos  = speed;
      }
      if (directionFired == "up-left") {
        vertXPos = -speed;
        vertYPos = -speed;
      }
      if (directionFired == "up-right") {
        vertXPos = speed;
        vertYPos = -speed;
      }
    }
    inMotion = true;
  }//end fire

  //reset the projectile and stop movement
  private void reset() {
    projectileX = startingX;
    projectileY = startingY;
    vertXPos = 0;
    vertYPos = 0;
    inMotion = false;
  }//end reset

  //check if proejctile has left game area and reset
  private void checkBounds() {
    if (projectileX < 0 || projectileX > width || projectileY < 0 || projectileY > height) {
      reset();
    }
  }//end checkbounds

  //getters
  public float getProjectileX()
  {
    return projectileX;
  }

  public float getProjectileY()
  {
    return projectileY;
  }

  public float getProjectileDiam()
  {
    return projectileDiam;
  }

  public float getVertXPos()
  {
    return vertXPos;
  }

  public float getVertYPos()
  {
    return vertYPos;
  }

  public float getStartingX()
  {
    return startingX;
  }

  public float getStartingY()
  {
    return startingY;
  }

  public float getSpeed()
  {
    return speed;
  }

  public boolean getInMotion()
  {
    return inMotion;
  }

  public String getDirectionFired()
  {
    return directionFired;
  }//end getters

  //setters
  public void setProjectileDirection(String directionFired)
  {
    this.directionFired = directionFired;
  }//end setters
}
