class Timer {
  //properties
  private int startTime, timeInterval;

  //constructor
  public Timer() {
  }

  public Timer(int timeInterval) {
    setTimeInterval(timeInterval);
  }

  //methods
  private void start() {
    startTime = millis();
  }
  boolean complete() {
    int elapsedTime = millis() - startTime;
    if (elapsedTime > timeInterval) {
      return true;
    } else {
      return false;
    }
  }

  //getters
  public float getstartTime()
  {
    return startTime;
  }

  public float getTimeInterval()
  {
    return timeInterval;
  }//end getters

  //setters
  public void setTimeInterval(int timeInterval)
  {
    this.timeInterval = timeInterval;
  }//end setters
}
