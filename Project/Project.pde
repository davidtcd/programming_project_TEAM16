void settings()
{
  size(SCREENWIDTH, SCREENHEIGHT); //Esosa did this
}

void setup()
{
  datasetScreen = new DatasetScreen();
  currentScreen = new TableScreen();
}

void draw()
{
  if (!datasetScreen.datasetSelected) {
    datasetScreen.draw();
    return;
  }
  background(255);
  currentScreen.draw();
  flightsMapScreen.cam.beginHUD();
  bar.drawBar();
  flightsMapScreen.cam.endHUD();
  barChartScreen.changeBarColor();
}

void mousePressed()
{
  try {
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
  catch(Exception e) {
  }
}
void mouseMoved() {
  try {
    treeMapScreen.isHovering(mouseX, mouseY);
  }
  catch(Exception e) {
  }
}

void keyPressed() {
  try {
    searchScreen.keyClick();
    flightsMapScreen.keyClick();
  }
  catch(Exception e) {
  }
}


void mouseReleased() {
  try {
    for (int i = 0; i < allDropdowns.size(); i++)
    {
      Dropdown dropdown = allDropdowns.get(i);
      dropdown.getScrollbar().getReleased();
    }
  }
  catch(Exception e) {
  }
}

void mouseDragged() {
  try {
    for (int i = 0; i < allDropdowns.size(); i++)
    {
      Dropdown dropdown = allDropdowns.get(i);
      dropdown.getScrollbar().getDragged(mouseY, pmouseY);
    }
  }
  catch(Exception e) {
  }
}

void mouseClicked() {
    currentScreen.handleMouseClick = false;
    currentScreen.mouseClicked();
    currentScreen.handleMouseClick = true;
}
