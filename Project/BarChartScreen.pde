import org.gicentre.utils.stat.*;

class BarChartScreen extends Screen
{
  PFont title = createFont("Arial", 20);
  color barColor;
  ArrayList<BarChart> currentChart= new ArrayList<BarChart>();
  BarChart chart;
  ArrayList<Button> buttons;
  int pageNum = 0;
  int chartNum = 0;
  int currentColor = 0;
  int currentCol = 0;
  int colCount;
  String chartTitle;
  int totalCategories;
  int mean;
  int median;
  String medianName;
  int mode;
  String modeName;
  boolean invertAxis = true;
  PApplet parent;
  
  BarChartScreen(PApplet parent)
  {
    super();
    buttons = new ArrayList<Button>();
    colCount = data.getNumberOfColumns();
    this.parent = parent;
    currentChart = setChart(currentCol);
  }
  void drawTitle()
  {
    stroke(BLACK);
    rect(1450, 500, 400, 400);
    fill(BLACK);
    text(chartTitle, 700, 140);
    text(pageNum, 80, 950);
    textAlign(CENTER);
    text("MEAN: " + mean, 1650, 600);
    text("MODE: " + modeName + ", AMOUNT: " + mode, 1650, 650);
    text("MEDIAN: " + medianName + ", AMOUNT: " + median, 1650, 700);
    text("TOTAL CATEGORIES: " + totalCategories, 1650, 750);
  }
  void draw()
  {
    if(pageNum < currentChart.size())
    {
    currentChart.get(pageNum).setBarColour(barColor);
    currentChart.get(pageNum).transposeAxes(invertAxis);
    currentChart.get(pageNum).draw(CHARTGAP, CHARTGAP, BARCHARTWIDTH, BARCHARTHEIGHT);
    }
    else
    {
      currentChart.get(0).setBarColour(barColor);
      currentChart.get(0).transposeAxes(invertAxis);
      currentChart.get(0).draw(CHARTGAP, CHARTGAP, BARCHARTWIDTH, BARCHARTHEIGHT);
    }
    for(int i = 0; i < buttons.size(); i++)
    {
      buttons.get(i).draw();
    }
    drawTitle();
  }
  void addButton(Button button)
  {
    buttons.add(button);
  }
  ArrayList<BarChart> setChart(int columnNumber)
{
    int maxBars = 50;
    int modeIndex = 0;
    ArrayList<BarChart> allCharts = new ArrayList<BarChart>();
    String[] categories = data.getUniqueValues(columnNumber);
    totalCategories = categories.length;
    int numOfPages = ceil(categories.length / maxBars);
    if(maxBars > categories.length)
    {
      maxBars = categories.length;
    }
   // loop to initialize values
   float[] values = new float[categories.length];
   for(int i = 0; i < values.length; i++) 
   {
    Table occurrenceAmount = data.getOccurrences(i, columnNumber);
    float amount = occurrenceAmount.getRowCount();
     values[i] = amount;
   }
   mean = data.table.getRowCount() / categories.length;
   if(values.length % 2 == 0)
   {
   median = (int)values[values.length / 2];
   medianName = categories[categories.length / 2];
   }
   else
   {
     median = (int)(values[values.length / 2] + values[values.length / 2 + 1]) / 2;
     medianName = categories[categories.length / 2] + " + " + categories[categories.length / 2 + 1];
   }
    // loop to set each chart for each page
    for(int i = 0; i <= numOfPages; i++)
    {
      if(i < numOfPages)
      {
        chart = new BarChart(parent);
        int barNum = maxBars * i;
        String[] realCategories = new String[maxBars];
        float[] realValues = new float[maxBars];
        for(int in = 0; in < realCategories.length; in++)
        {
          realCategories[in] = categories[barNum];
          realValues[in] = values[barNum];
          barNum++;
        }
        float currentValue = realValues[0];
        for(int ind = 1; ind < realValues.length; ind++)
         {
           float newValue = realValues[ind];
           if(newValue > currentValue)
           {
             currentValue = newValue;
           }
         }
         chart.setMaxValue(currentValue+20);
         chart.setMinValue(0);
         chart.setData(realValues);
         chart.setBarLabels(realCategories);
         chart.showCategoryAxis(true);
         chart.showValueAxis(true);
         allCharts.add(chart);
      }
      else
      {
        chart = new BarChart(parent);
        int barNum = maxBars * i;
        String[] realCategories = new String[categories.length - barNum];
        float[] realValues = new float[categories.length - barNum];
        for(int in = 0; in < realCategories.length; in++)
        {
          if(barNum >= categories.length - 1)
          {
            barNum = categories.length - 1;
          }
          realCategories[in] = categories[barNum];
          realValues[in] = values[barNum];
          barNum++;
        }
        float currentValue = realValues[0];
        for(int ind = 1; ind < realValues.length; ind++)
         {
           float newValue = realValues[ind];
           if(newValue > currentValue)
           {
             currentValue = newValue;
           }
         }
         chart.setMaxValue(currentValue+20);
         chart.setMinValue(0);
         chart.setData(realValues);
         chart.setBarLabels(realCategories);
         chart.showCategoryAxis(true);
         chart.showValueAxis(true);
         allCharts.add(chart);
         mode = (int)currentValue;
         for(int index = 0; index < values.length; index++)
         {
           if(currentValue == values[index])
           {
             modeIndex = index;
           }
         }
         modeName = categories[modeIndex];
      }
    }
    chartTitle = data.table.getColumnTitle(columnNumber);
    return allCharts;
}
  void pageInc()
  {
    pageNum++;
    if(pageNum >= currentChart.size() - 1)
    {
      pageNum = currentChart.size() - 1;
    }
  }
    void pageDec()
  {
    pageNum--;
    if(pageNum <= 0)
    {
      pageNum = 0;
    }
  }
  void nextChart()
  {
    pageNum = 0;
    if(currentCol < colCount - 1)
    {
      currentCol++;
      currentChart = setChart(currentCol);
    }
    else if(currentCol >= colCount - 1)
    {
      currentCol = colCount - 1;
      currentChart = setChart(currentCol);
    }
  }
  void prevChart()
  {
    pageNum = 0;
    if(currentCol > 0)
    {
      currentCol--;
      currentChart = setChart(currentCol);
    }
    else
    {
      currentCol = 0;
      currentChart = setChart(currentCol);
    }
  }
  void changeBarColor()
  {
    switch(currentColor)
    {
      case(0):
        barColor = BLACK;
        break;
      case(1):
        barColor = RED;
        break;
      case(2):
        barColor = GREEN;
        break;
      case(3):
        barColor = BLUE;
        break;
      case(4):
        barColor = YELLOW;
        break;
      case(5):
        barColor = PURPLE;
        break;
      case(6):
        barColor = CYAN;
        break;
      case(7):
        barColor = ORANGE;
        break;
    }
  }
  void nextColor()
  {
    currentColor++;
    if(currentColor >= 7)
    {
      currentColor = 7;
    }
  }
  void prevColor()
  {
    currentColor--;
    if(barColor <= 0)
    {
      barColor = 0;
    }
  }
  boolean flipChart()
  {
    boolean flip = true;
    if(invertAxis == true)
    {
      invertAxis = false;
      return false;
    }
    if(invertAxis == false)
    {
      invertAxis = true;
      return false;
    }
    return flip;
  }
}
