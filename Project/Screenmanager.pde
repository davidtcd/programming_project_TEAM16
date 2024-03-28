class Screenmanager {
  Screen currentScreen;

  void setScreen(Screen screen) {
    currentScreen = screen;
  }

  void draw() {
    if (currentScreen != null) {
      currentScreen.draw();
    }
  }

  void mouseClicked() {
    if (currentScreen != null) {
      currentScreen.mouseClicked();
    }
  }
}
