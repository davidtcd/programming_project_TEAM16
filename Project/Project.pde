void settings()
{
  size(2000,1000); //Esosa did this
  
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
}
void mousePressed()
{
    pieTab.isClicked(mouseX, mouseY);
    mainTab.isClicked(mouseX, mouseY);
    graphTab.isClicked(mouseX, mouseY);
    changeToDates.isClicked(mouseX, mouseY);
    changeToOrigin.isClicked(mouseX, mouseY);
    changeToDest.isClicked(mouseX, mouseY);
}
