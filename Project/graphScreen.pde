class GraphScreen extends Screen
{
  BarChart chart;
  ArrayList<Button> buttons;
  GraphScreen(BarChart chart)
  {
    super();
    this.chart = chart;
    buttons = new ArrayList<Button>();
  }
  void draw()
  {
    chart.draw(CHARTGAP, CHARTGAP, BARCHARTWIDTH, BARCHARTHEIGHT);
    for(int i = 0; i < buttons.size(); i++)
    {
      buttons.get(i).draw();
    }
  }
  void addButton(Button button)
  {
    buttons.add(button);
  }
  void changeChart(BarChart newChart)
  {
    chart = newChart;
  }
}
