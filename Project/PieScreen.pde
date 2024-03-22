// 21/03/2024 - pieScreen class created by Joseph Reidy as an extenstion of the Screen class

class pieScreen extends Screen
{
  pieChart cancelled;
  ArrayList<Button> pieButtons;
  
  pieScreen(pieChart cancelled)
  {
    super();
    this.cancelled = cancelled;
    pieButtons = new ArrayList<Button>();
  }
  void addButton(Button button)
  {
    pieButtons.add(button);
  }
  void draw()
  {
    cancelled.draw();
    for(int i = 0; i < pieButtons.size(); i++)
    {
      pieButtons.get(i).draw();
    }
  }
  
}
