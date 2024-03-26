
void settings()
{
  size(SCREENWIDTH,SCREENHEIGHT); //Esosa did this
  
}

void setup()
{
  loadResources();
}

void draw()
{
  background(255);
  bar.drawBar();
  currentScreen.draw();
  barChartScreen.changeChart();
  barChartScreen.changeBarColor();
}
void mousePressed()
{
  for(int i = 0; i < allButtons.size(); i++)
  {
    allButtons.get(i).isClicked(mouseX, mouseY);
  }
}

void mouseMoved() {
  treeMapScreen.isHovering(mouseX, mouseY);  
  
}
