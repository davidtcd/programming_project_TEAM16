class NavigationBar
{
  private int x, y;
  private int barHeight, barWidth;
  private color barColor;
  private ArrayList<Button> tabs;
  
  NavigationBar()
  {
    this.x = 0;
    this.y = 0;
    this.barHeight = NAVBAR_HEIGHT;
    this.barWidth = NAVBAR_WIDTH;
    this.barColor = NAVBAR_COLOR;
    tabs = new ArrayList<Button>();
  }
  void drawBar()
  {
    fill(barColor);
    rect(x, y, barWidth, barHeight);
    for(int i = 0; i < tabs.size(); i++)
    {
      textFont(font);
      textSize(20);
      tabs.get(i).draw();
      textSize(12);
    }
  }
  void addTab(Button button)
  {
    tabs.add(button);
  }
  void changeScreen(Screen screen)
  {
    currentScreen.onFocusChanged(false);
    currentScreen = screen;
    currentScreen.onFocusChanged(true);
  }
}
