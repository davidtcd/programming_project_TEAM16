// 21/03/2024 - pieScreen class created by Joseph Reidy as an extenstion of the Screen class

class PieScreen extends Screen
{
  pieChart cancelledChart;
  pieChart carrierChart;
  pieChart dateChart;
  public pieChart currentChart;
  ArrayList<Button> pieButtons;

  PieScreen()
  {
    String[] dateHeadings = data.getUniqueValues(0);
    float[] dateData = new float[dateHeadings.length];
    for (int i = 0; i < dateHeadings.length; i++)
    {
      dateData[i] = data.getOccurrenceAmount(i, 0);
    }
    
    String[] carrierHeadings = data.getUniqueValues(1);
    float[] carrierData = new float[carrierHeadings.length];
    for (int i = 0; i < carrierHeadings.length; i++)
    {
      carrierData[i] = data.getOccurrenceAmount(i, 1);
    }
    
    float[] cancelledData = {data.getOccurrenceAmount(1, 15), data.getOccurrenceAmount(0, 15)};
    String[] cancelledHeadings = {"cancelled", "not cancelled"};
    
    cancelledChart = new pieChart(cancelledData, cancelledHeadings);
    carrierChart = new pieChart(carrierData, carrierHeadings);
    dateChart = new pieChart(dateData, dateHeadings);
    this.currentChart = cancelledChart;
    
    pieButtons = new ArrayList<Button>();
    addButton(new Button(width - (BUTTON2_GAP - 150), 140, BUTTONWIDTH, BUTTONHEIGHT, "Cancelled Flights", BLUE, BLACK, WHITE, font, () ->changeChart(cancelledChart)));
    addButton(new Button(width - (BUTTON2_GAP -150), 140 + (BUTTONHEIGHT*4), BUTTONWIDTH, BUTTONHEIGHT, "Flight Dates", BLUE, BLACK, WHITE, font, () ->changeChart(dateChart)));
    addButton(new Button(width - (BUTTON2_GAP -150), 140 + (BUTTONHEIGHT*2), BUTTONWIDTH, BUTTONHEIGHT, "Airline Carriers", BLUE, BLACK, WHITE, font, () ->changeChart(carrierChart)));
  }
  void addButton(Button button)
  {
    pieButtons.add(button);
    allButtons.add(button);
  }
  void changeChart(pieChart newChart)
  {
    currentChart = newChart;
  }

  void draw()
  {
    currentChart.draw();
    for (int i = 0; i < pieButtons.size(); i++)
    {
      pieButtons.get(i).draw();
    }
  }
}
