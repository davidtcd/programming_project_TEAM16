//Hezamary Paul created Screen class to include drawing of widgets and all other constants on 14/03/2024 @ 10:07
//created dropdown and different menus
//can access rows separately
//can access columns separately allowing different queries.
abstract class Screen { //declaration of screen class

  ArrayList<Widget> widgets;

  Screen() { //constructor for screen
    widgets = new ArrayList<Widget>(); //add widgets
  }

  // Method to add a widget to the screen
  public void addWidget(Widget widget) {
    widgets.add(widget);
  }

  public ArrayList<Widget> getWidgets() {
    return this.widgets;
  }

  // Method to draw the screen
  public void draw() {
    // Code to draw the screen (e.g., drawing widgets)
  }

  //Informs a screen wether it has been been selected or deselected
  public void onFocusChanged(boolean isInFocus) {
  }
}
