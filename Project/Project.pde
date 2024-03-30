void settings()
{
  size(SCREENWIDTH, SCREENHEIGHT); //Esosa did this
}

void setup()
{
  loadResources();
}

void draw()
{
  background(255);
  currentScreen.draw();
  bar.drawBar();
  barChartScreen.changeBarColor();
}

void mousePressed()
{
  for (int i = 0; i < allButtons.size(); i++)
  {
    allButtons.get(i).isClicked(mouseX, mouseY);
  }
  
  for (int i = 0; i < allDropdowns.size(); i++)
  {
    Dropdown dropdown = allDropdowns.get(i);
    dropdown.isClicked(mouseX, mouseY); 
    dropdown.getScrollbar().getClicked(mouseX, mouseY);
    for (int j = 0; j < dropdown.OPTION_VISIBLE_COUNT; j++) {
        dropdown.optionIsClicked(j, mouseX, mouseY);
    }
  }
  searchScreen.isClicked(mouseX, mouseY);
}
void mouseMoved() {
  treeMapScreen.isHovering(mouseX, mouseY);
}

void keyPressed() {
  searchScreen.keyClick();
}

void mouseClicked() {
  // Handle mouse click events for the current active screen
  currentScreen.mouseClicked();
}

void mouseReleased() {
  for (int i = 0; i < allDropdowns.size(); i++)
  {
    Dropdown dropdown = allDropdowns.get(i);
    dropdown.getScrollbar().getReleased();
  }
}

void mouseDragged() {
  for (int i = 0; i < allDropdowns.size(); i++)
  {
    Dropdown dropdown = allDropdowns.get(i);
    dropdown.getScrollbar().getDragged(mouseY, pmouseY);
  }
}
