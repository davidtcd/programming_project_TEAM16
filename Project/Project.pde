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
}
void mouseMoved() {
  treeMapScreen.isHovering(mouseX, mouseY);
}

void mouseClicked() {
  // Handle mouse click events for the current active screen
  currentScreen.mouseClicked();
}
