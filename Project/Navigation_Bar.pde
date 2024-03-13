class NavigationBar
{
  private int x, y;
  private int barHeight, barWidth;
  private color barColor;
  private ArrayList<Button> tabs;
  
  NavigationBar(int x, int y, int barHeight, int barWidth, color barColor)
  {
    this.x = x;
    this.y = y;
    this.barHeight = barHeight;
    this.barWidth = barWidth;
    this.barColor = barColor;
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
}
