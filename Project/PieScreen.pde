// 21/03/2024 - pieScreen class created by Joseph Reidy as an extenstion of the Screen class

class pieScreen extends Screen
{
  public pieChart currentChart;
  ArrayList<Button> pieButtons;
  
  pieScreen(pieChart currentChart)
  {
    super();
    this.currentChart = currentChart;
    pieButtons = new ArrayList<Button>();
    println("exists");
  }
  void addButton(Button button)
  {
    pieButtons.add(button);
  }
  void changeChart(pieChart newChart)
  {
    currentChart = newChart;
  }
  
  void draw()
  {
    currentChart.draw();
    for(int i = 0; i < pieButtons.size(); i++)
    {
      pieButtons.get(i).draw();
    }
  }
  
  
}
