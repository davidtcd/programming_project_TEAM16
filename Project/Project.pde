void settings() {
  size(SCREENWIDTH, SCREENHEIGHT, P3D); 
}

void setup() {
  datasetScreen = new DatasetScreen();
}

void draw() {
  if (!datasetScreen.datasetSelected) {
    datasetScreen.draw();
    return;
  }
  background(255);
  currentScreen.draw();
  
  //Draw navBar as a HUD element
  flightsMapScreen.cam.beginHUD();
  navBar.drawBar();
  flightsMapScreen.cam.endHUD();
  
  barChartScreen.changeBarColor();
}

void mousePressed() {
  if (currentScreen==null) return;
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
  if (currentScreen==searchScreen) searchScreen.isClicked(mouseX, mouseY);
}

void mouseMoved() {
  if (currentScreen==null) return;
  treeMapScreen.isHovering(mouseX, mouseY);
}

void keyPressed() {
  if (currentScreen==null) return;
  if (currentScreen==searchScreen) searchScreen.keyClick();
  if (currentScreen==flightsMapScreen) flightsMapScreen.keyClick();
}

void mouseReleased() {
  if (currentScreen==null) return;
  for (int i = 0; i < allDropdowns.size(); i++)
  {
    Dropdown dropdown = allDropdowns.get(i);
    dropdown.getScrollbar().getReleased();
  }
}

void mouseDragged() {
  if (currentScreen==null) return;
  for (int i = 0; i < allDropdowns.size(); i++)
  {
    Dropdown dropdown = allDropdowns.get(i);
    dropdown.getScrollbar().getDragged(mouseY, pmouseY);
  }
}

void mouseClicked() {
  if (currentScreen==null) return;
  if (currentScreen==tableScreen) tableScreen.onMouseClicked();
}
