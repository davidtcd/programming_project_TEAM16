
void settings()
{
  size(SCREENWIDTH,SCREENHEIGHT); //Esosa did this
  
}

void setup()
{
  loadResources();
  LineGraph linegraph = new LineGraph();
  linegraph.setupLineGraph();
}

void draw()
{
 background(255);
  bar.drawBar();
  currentScreen.draw();
<<<<<<< Updated upstream
  barChartScreen.changeChart();
  barChartScreen.changeBarColor();
}
void mousePressed()
{
  for(int i = 0; i < allButtons.size(); i++)
  {
    allButtons.get(i).isClicked(mouseX, mouseY);
  }
=======
  
  
}
void mousePressed()
{
    mainTab.isClicked(mouseX, mouseY);
    graphTab.isClicked(mouseX, mouseY);
    lineGraphTab.isClicked(mouseX, mouseY);
    changeToDates.isClicked(mouseX, mouseY);
    changeToOrigin.isClicked(mouseX, mouseY);
    changeToDest.isClicked(mouseX, mouseY);
    
>>>>>>> Stashed changes
}
