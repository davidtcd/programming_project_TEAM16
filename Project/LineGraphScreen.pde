
class LineGraphScreen extends Screen
{
  LineGraph lineGraph;
  ArrayList<Button> buttons;
  
    LineGraphScreen(LineGraph lineGraph)
  {
    super();
    this.lineGraph = lineGraph;
    buttons = new ArrayList<Button>();
  }
  void draw()
  {
   
    for(int i = 0; i < buttons.size(); i++)
    {
      buttons.get(i).draw();
    }
  }
  void addButton(Button button)
  {
    buttons.add(button);
  }
  void changeGraph(LineGraph newLineGraph)
  {
    newLineGraph = newLineGraph;
  }
}
