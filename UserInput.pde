public class UserInput
{
  //properties
  //variable to store text currently being typed
  private String typing = "";
  //variable to store saved text when return is hit
  private String saved = "";
  //set lenght of name
  private int nameLenght = names.length - 1;

  //constructor
  public UserInput() {
  }

  //methords
  void display() {
    background(255);
    fill(0);
    /*Game controls for controlling character and firing
     with instructions for entering name fo player*/
    text("To move player \n\n \u25B2 move up \n \u25BC move down \n \u25C0 move left \n \u25B6 move right \n \u25AC spacebar to fire (hold down for RAPID FIRE)", textStartX - 200, 100);
    text("Enter your name and \u232b BACKSPACE to delete (Max 6 Characters) \nHit 9 to save and START GAME. ", textStartX - 200, 250);
    text("Your Name: " + typing, textStartX - 200, 310);
    //text("Saved Name: " + saved, textStartX, 390);
  }

  void keyLogging() {
    // If the return key is pressed, save the String and clear it and start the game
    if (key == '9' && nameTypeActive == true) {
      saved = typing;
      typing = "";
      intro = false;
      nameTypeActive = false;
    } else if (nameTypeActive == true && key != BACKSPACE && key != '\n') {
      //building up the String variable from keys typed
      if (typing.length() <= nameLenght) {
        typing = typing + key;
      }
    }
    //creating a substring with last character removed on each Backspace key
    if (key == BACKSPACE && typing.length() > 0) {
      typing = typing.substring( 0, typing.length()-1 );
    }
  }

  //getter methods
  public String getUsertyping()
  {
    return typing;
  }

  public String getUserInputName()
  {
    return saved;
  }

  public int getnameLenght()
  {
    return nameLenght;
  }

  //setters methods
  public void setUsertyping(String typing)
  {
    this.typing = typing;
  }

  public void setUserInputName(String saved)
  {
    this.saved = saved;
  }

  public void setnameLenght(int nameLenght)
  {
    this.nameLenght = nameLenght;
  }
}
