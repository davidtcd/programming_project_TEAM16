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
    this.barHeight = BARHEIGHT;
    this.barWidth = BARWIDTH;
    this.barColor = BARCOLOR;
    tabs = new ArrayList<Button>();
  }
  void drawBar()
  {
    fill(barColor);
    rect(x, y, barWidth, barHeight);
    for(int i = 0; i < tabs.size(); i++)
    {
      tabs.get(i).draw();
    }
  }
  void addTab(Button button)
  {
    tabs.add(button);
  }
  void changeScreen(Screen screen)
  {
    currentScreen = screen;
  }
}
