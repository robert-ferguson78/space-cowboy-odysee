// PlayerStats Class
public class PlayerStats
{
  //propertys
  private int score;
  private int lives;
  private int boxXCoord;
  private int boxYCoord;
  private int statsBoxWidth = 250;
  private int statsBoxheight = 30;
  private color livesTextColor;
  private boolean gameOver;

  //constructor
  public PlayerStats() {
  }

  public PlayerStats(int score) {
    score = score;
    livesTextColor = #000000;
    boxXCoord = (width/2) - statsBoxWidth / 2;
    boxYCoord = 10;
    gameOver = false;
  }

  //methords
  public void display() //draw space cowboy
  {
    fill(#ffffff);
    rect(boxXCoord, boxYCoord, statsBoxWidth, statsBoxheight);
    fill(livesTextColor);
    textSize(14);
    text(("Your Score:" + str(score)), boxXCoord + 10, boxYCoord + 20);
    if (lives == 1) {
      text(("Last life:" + str(lives)), boxXCoord + statsBoxWidth - 120, boxYCoord + 20);
    } else if (lives == 0) {
      text("Your DEAD :(", boxXCoord + statsBoxWidth - 120, boxYCoord + 20);
      gameOver = true;
    } else {
      text(("Lives Left:" + str(lives)), boxXCoord + statsBoxWidth - 120, boxYCoord + 20);
    }
  }

  //getter methods
  public boolean getGameOver()
  {
    return gameOver;
  }

  public int getScore()
  {
    return score;
  }

  public color getLivesTextColor()
  {
    return livesTextColor;
  }

  public int getStatsBoxheight()
  {
    return statsBoxheight;
  }

  public int getStatsBoxWidth()
  {
    return statsBoxWidth;
  }

  public int getBoxYCoord()
  {
    return boxYCoord;
  }

  public int getBoxXCoord()
  {
    return boxXCoord;
  }

  public int getLives()
  {
    return lives;
  }


  //setter methods
  public void setGameOver(boolean gameOver)
  {
    this.gameOver = gameOver;
  }

  public void setScore(int score)
  {
    this.score = score;
  }

  public void setLives(int lives)
  {
    this.lives = lives;
  }

  public void setLivesTextColor(color livesTextColor)
  {
    this.livesTextColor = livesTextColor;
  }

  public void setBoxXCoord(color boxXCoord)
  {
    this.boxXCoord = boxXCoord;
  }

  public void setBoxYCoord(color boxYCoord)
  {
    this.boxYCoord = boxYCoord;
  }

  public void setStatsBoxWidth(color statsBoxWidth)
  {
    this.statsBoxWidth = statsBoxWidth;
  }

  public void setStatsBoxHeight(color statsBoxHeight)
  {
    this.statsBoxheight = statsBoxHeight;
  }
}
