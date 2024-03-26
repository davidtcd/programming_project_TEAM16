import org.gicentre.utils.stat.*;

class BarChartScreen extends Screen
{
  PFont title = createFont("Arial", 20);
  color barColor;
  ArrayList<BarChart> currentChart= new ArrayList<BarChart>();
  ArrayList<ArrayList<BarChart>> fullCharts = new ArrayList<ArrayList<BarChart>>();
  BarChart chart;
  ArrayList<Button> buttons;
  String[] categories;
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
  ArrayList<Integer> allMeans = new ArrayList<Integer>();
  ArrayList<Integer> allTotals = new ArrayList<Integer>();
  ArrayList<Integer> allMedians = new ArrayList<Integer>();
  ArrayList<Integer> allModes = new ArrayList<Integer>();
  ArrayList<String> allMedianNames = new ArrayList<String>();
  ArrayList<String> allModeNames = new ArrayList<String>();
  ArrayList<String> allTitles = new ArrayList<String>();
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
    textFont(title);
    textSize(24);
    stroke(BLACK);
    rect(1400, 500, 500, 400);
    fill(BLACK);
    text(allTitles.get(currentCol), 700, 140);
    text(pageNum, 80, 950);
    textAlign(CENTER);
    textSize(20);
    text("MEAN: " + allMeans.get(currentCol), 1650, 600);
    text("MODE: " + allModeNames.get(currentCol) + ", AMOUNT: " + allModes.get(currentCol), 1650, 650);
    text("MEDIAN: " + allMedianNames.get(currentCol) + ", AMOUNT: " + allMedians.get(currentCol), 1650, 700);
    text("TOTAL CATEGORIES: " + allTotals.get(currentCol), 1650, 750);
    textFont(font);
    textSize(12);
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
    categories = data.getUniqueValues(columnNumber);
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
    float amount = data.getOccurrenceAmount(i, columnNumber);
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
    allMeans.add(mean); allModes.add(mode); allMedians.add(median); allMedianNames.add(medianName); allModeNames.add(modeName); allTotals.add(totalCategories); allTitles.add(chartTitle);
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
      if(currentCol >= fullCharts.size())
      {
      currentChart = setChart(currentCol);
      fullCharts.add(currentChart);
      }
      else
      {
      currentChart = fullCharts.get(currentCol);
      }
    }
    else if(currentCol >= colCount - 1)
    {
      currentCol = colCount - 1;
      if(currentCol >= fullCharts.size())
      {
        currentChart = setChart(currentCol);
        fullCharts.add(currentChart);
      }
      currentChart = fullCharts.get(currentCol);
    }
  }
  void prevChart()
  {
    pageNum = 0;
    if(currentCol > 0)
    {
      currentCol--;
      currentChart = fullCharts.get(currentCol);
    }
    else
    {
      currentCol = 0;
      currentChart = fullCharts.get(currentCol);
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
  void flipChart()
  {
    if(invertAxis == true)
    {
      invertAxis = false;
    }
    else
    {
      invertAxis = true;
    }
  }
}
