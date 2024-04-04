import org.gicentre.utils.stat.*;

// class implemented by David Sietko
// class to implement a BarChartScreen, this scren displays a BarChart of a certain column of the data along with the mean, mode and median. Screen also draws buttons so that user
// can interact with the BarChart and change the data that is being displayed.
class BarChartScreen extends Screen
{
  PFont title = createFont("Arial", 20);
  Dropdown sortBy;
  color barColor;
  ArrayList<BarChart> currentChart= new ArrayList<BarChart>();
  ArrayList<ArrayList<BarChart>> fullCharts = new ArrayList<ArrayList<BarChart>>();
  ArrayList<String[]> allCategories = new ArrayList<String[]>();
  ArrayList<ArrayList<Float>> fullValues = new ArrayList<ArrayList<Float>>();
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
  float median;
  String medianName;
  int mode;
  String modeName;
  ArrayList<Integer> allMeans = new ArrayList<Integer>();
  ArrayList<Integer> allTotals = new ArrayList<Integer>();
  ArrayList<Float> allMedians = new ArrayList<Float>();
  ArrayList<Integer> allModes = new ArrayList<Integer>();
  ArrayList<String> allMedianNames = new ArrayList<String>();
  ArrayList<String> allModeNames = new ArrayList<String>();
  ArrayList<String> allTitles = new ArrayList<String>();
  boolean invertAxis = true;
  PApplet parent;
  
  // the constructor for a BarChartScren
  // @param a PApplet (given sketch), this is so we can initialize BarChart objects within the class as this is the parameter we need to pass 
  //        to a BarChart constructor to create a BarChart object.
  BarChartScreen(PApplet parent)
  {
    super();
    buttons = new ArrayList<Button>();
    colCount = data.getNumberOfColumns();
    this.parent = parent;
    currentChart = setChart(currentCol);
    fullCharts.add(currentChart);
    ArrayList<String> options = new ArrayList<String>();
    options.add("low->high"); options.add("high->low"); options.add("default");
    sortBy = new Dropdown(0, TABHEIGHT, BUTTONWIDTH, BUTTONHEIGHT, "Sort By", color(220), BLACK, BLACK, font, options, index -> changeDropdownOption(index), true, 40);
    allDropdowns.add(sortBy);
  }
  // drawTitle() draws the title, mean, mode, median and page number for a BarChartScreen object
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
    text("MODE: " + allModeNames.get(currentCol), 1650, 650);
    text("AMOUNT: " + allModes.get(currentCol), 1650, 700);
    text("MEDIAN: " + allMedianNames.get(currentCol), 1650, 750);
    text("AMOUNT: " + allMedians.get(currentCol), 1650, 800);
    text("TOTAL CATEGORIES: " + allTotals.get(currentCol), 1650, 850);
    textFont(font);
    textSize(14);
  }
  // draws all of the objects that should be on a BarChartScreen
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
    sortBy.draw();
    noStroke();
    fill(color(220));
    rect(0, TABHEIGHT, BUTTONWIDTH, BUTTONHEIGHT);
    fill(BLACK);
    textAlign(CENTER);
    textSize(20);
    text("SORT BY", 0, TABHEIGHT + (BUTTONHEIGHT / 2), BUTTONWIDTH, BUTTONHEIGHT);
    textSize(14);
  }
  void addButton(Button button)
  {
    buttons.add(button);
  }
  // creates and returns an ArrayList of BarChart objects for a specified column, it returns an ArrayList instead of a single object
  // as each index in the ArrayList corresponds to a page for the whole column of the data. On top of that, this method calculates
  // the mean, mode and median for a given column and then adds all of these values to an arrayList for each of those values. e.g
  // we calculate the mode and then add it to an ArrayList called allModes (can see all of the ArrayLists above the constructor).
  // @param columnNumber the columnNumber that we want to create a BarChart of
  // @return ArrayList<BarChart> returns an ArrayList of BarChart objects with each index corresponding to a page number
  ArrayList<BarChart> setChart(int columnNumber)
{
    int maxBars = 50;
    int modeIndex = 0;
    ArrayList<BarChart> allCharts = new ArrayList<BarChart>();
    String[] categories = data.getUniqueValues(columnNumber);
    allCategories.add(categories);
    totalCategories = categories.length;
    int numOfPages = 0;
    if(categories.length % maxBars != 0)
    {
      numOfPages = ceil(categories.length / maxBars);
    }
    else
    {
      numOfPages = 0;
    }
    if(maxBars > categories.length)
    {
      maxBars = categories.length;
    }
   // loop to initialize values
   ArrayList<Float> values = new ArrayList<Float>();
   for(int i = 0; i < categories.length; i++) 
   {
    float amount = data.getOccurrenceAmount(i, columnNumber);
     values.add(amount);
   }
   fullValues.add(values);
   mean = data.table.getRowCount() / categories.length;
   if(values.size() % 2 == 0)
   {
   median = values.get(values.size() / 2);
   medianName = categories[categories.length / 2];
   }
   else
   {
     median = (values.get(values.size() / 2) + values.get((values.size() / 2) + 1)) / 2;
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
          realValues[in] = values.get(barNum);
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
          realValues[in] = values.get(barNum);
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
         for(int index = 0; index < values.size(); index++)
         {
           if(currentValue == values.get(index))
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
  // method to increment the pageNumber, if the pageNumber is the last Page it stays as the last page
  void pageInc()
  {
    pageNum++;
    if(pageNum >= currentChart.size() - 1)
    {
      pageNum = currentChart.size() - 1;
    }
  }
  // method to decrement pageNumber, if pageNumber is first page it stays as the first page
    void pageDec()
  {
    pageNum--;
    if(pageNum <= 0)
    {
      pageNum = 0;
    }
  }
  // method to go to the next BarChart.Do this by incrementing the current column integer, if we are at the last Chart we stay at that chart, method resets pageNumber back to 0
  // we also check to see if we have initialized a barChart for the current columnNumber, if we havent then we create it and if we have already created one before we just set the 
  // currentChart to be that BarChart from an ArrayList made of ArrayLists of BarChart objects( as 1 ArrayList Of BarCharts = a single BarChart).
  // method also sets the currentChart to the chart for the currentColumn that we want to display
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
  // same as nextChart except we do the reverse process, we go backwards, also sets the currentChart to the BarChart that we want to display.
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
  // use a switch statement to switch in between a variety of colours that we can set the bar as, each number corresponds to a certain colour, these colours defined as constans.
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
  // go to next colour, this method goes hand in hand with changeBarColor, nextColor increments the integer used in the switch statement to choose a barColor.
  void nextColor()
  {
    currentColor++;
    if(currentColor >= 7)
    {
      currentColor = 7;
    }
  }
  // this method decrements the integer used in the changeBarColor method to change colours.
  void prevColor()
  {
    currentColor--;
    if(barColor <= 0)
    {
      barColor = 0;
    }
  }
  // switches a boolean value to determine whether the axes of the BarChart should be flipped, true = flipped, false = default(default means categories on x-axis and values on y-axis
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
  // sorts the currentChart that is being displayed from low to high and then sets the currentChart to be the sorted chart.
  void SortLowToHigh()
  {
    int maxBars = 50;
    String[] current = allCategories.get(currentCol);
    ArrayList<String> currentC = new ArrayList<String>();
    for(int i = 0; i < current.length; i++)
    {
      String currentTitle = current[i];
      currentC.add(currentTitle);
    }
    ArrayList<Float> currentValues = new ArrayList<Float>(fullValues.get(currentCol));
    String[] sortedC = new String[currentC.size()];
    float[] sortedValues = new float[currentValues.size()];
    ArrayList<BarChart> sortedCharts = new ArrayList<BarChart>();
    BarChart sortedChart;
    for(int i = 0; i < sortedC.length; i++)
    {
      int index = 0;
      float currentValue = currentValues.get(0);
      for(int in = 0; in < currentValues.size(); in++)
      {
        float newValue = currentValues.get(in);
        if(newValue < currentValue)
        {
          currentValue = newValue;
          index = in;
        }
      }
      sortedC[i] = currentC.get(index);
      sortedValues[i] = currentValues.get(index);
      currentValues.remove(index);
      currentC.remove(index);
    }
    int numOfPages = 0;
    if(sortedC.length % maxBars != 0)
    {
     numOfPages = ceil(sortedC.length / maxBars);
    }
    for(int i = 0; i <= numOfPages; i++)
    {
      if(i < numOfPages)
      {
        sortedChart = new BarChart(parent);
        int barNum = maxBars * i;
        String[] realCategories = new String[maxBars];
        float[] realValues = new float[maxBars];
        for(int in = 0; in < realCategories.length; in++)
        {
          realCategories[in] = sortedC[barNum];
          realValues[in] = sortedValues[barNum];
          barNum++;
        }
        float currentValue = sortedValues[0];
        for(int ind = 1; ind < realValues.length; ind++)
         {
           float newValue = realValues[ind];
           if(newValue > currentValue)
           {
             currentValue = newValue;
           }
         }
         sortedChart.setMaxValue(currentValue+20);
         sortedChart.setMinValue(0);
         sortedChart.setData(realValues);
         sortedChart.setBarLabels(realCategories);
         sortedChart.showCategoryAxis(true);
         sortedChart.showValueAxis(true);
         sortedCharts.add(sortedChart);
      }
      else
      {
        sortedChart = new BarChart(parent);
        int barNum = maxBars * i;
        String[] realCategories = new String[sortedC.length - barNum];
        float[] realValues = new float[sortedC.length - barNum];
        for(int in = 0; in < realCategories.length; in++)
        {
          if(barNum >= sortedC.length - 1)
          {
            barNum = sortedC.length - 1;
          }
          realCategories[in] = sortedC[barNum];
          realValues[in] = sortedValues[barNum];
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
         sortedChart.setMaxValue(currentValue+20);
         sortedChart.setMinValue(0);
         sortedChart.setData(realValues);
         sortedChart.setBarLabels(realCategories);
         sortedChart.showCategoryAxis(true);
         sortedChart.showValueAxis(true);
         sortedCharts.add(sortedChart);
      }
   }
   currentChart = sortedCharts;
  }
  // sorts the currentChart thats being displayed from high to low and then sets the currentChart to be the sortedChart
    void SortHighToLow()
  {
    int maxBars = 50;
    String[] current = allCategories.get(currentCol);
    ArrayList<String> currentC = new ArrayList<String>();
    for(int i = 0; i < current.length; i++)
    {
      String currentTitle = current[i];
      currentC.add(currentTitle);
    }
    ArrayList<Float> currentValues = new ArrayList<Float>(fullValues.get(currentCol));
    String[] sortedC = new String[currentC.size()];
    float[] sortedValues = new float[currentValues.size()];
    ArrayList<BarChart> sortedCharts = new ArrayList<BarChart>();
    BarChart sortedChart;
    for(int i = 0; i < sortedC.length; i++)
    {
      int index = 0;
      float currentValue = currentValues.get(0);
      for(int in = 0; in < currentValues.size(); in++)
      {
        float newValue = currentValues.get(in);
        if(newValue > currentValue)
        {
          currentValue = newValue;
          index = in;
        }
      }
      sortedC[i] = currentC.get(index);
      sortedValues[i] = currentValues.get(index);
      currentValues.remove(index);
      currentC.remove(index);
    }
    int numOfPages = 0;
    if(sortedC.length % maxBars != 0)
    {
     numOfPages = ceil(sortedC.length / maxBars);
    }
    for(int i = 0; i <= numOfPages; i++)
    {
      if(i < numOfPages)
      {
        sortedChart = new BarChart(parent);
        int barNum = maxBars * i;
        String[] realCategories = new String[maxBars];
        float[] realValues = new float[maxBars];
        for(int in = 0; in < realCategories.length; in++)
        {
          realCategories[in] = sortedC[barNum];
          realValues[in] = sortedValues[barNum];
          barNum++;
        }
        float currentValue = sortedValues[0];
        for(int ind = 1; ind < realValues.length; ind++)
         {
           float newValue = realValues[ind];
           if(newValue > currentValue)
           {
             currentValue = newValue;
           }
         }
         sortedChart.setMaxValue(currentValue+20);
         sortedChart.setMinValue(0);
         sortedChart.setData(realValues);
         sortedChart.setBarLabels(realCategories);
         sortedChart.showCategoryAxis(true);
         sortedChart.showValueAxis(true);
         sortedCharts.add(sortedChart);
      }
      else
      {
        sortedChart = new BarChart(parent);
        int barNum = maxBars * i;
        String[] realCategories = new String[sortedC.length - barNum];
        float[] realValues = new float[sortedC.length - barNum];
        for(int in = 0; in < realCategories.length; in++)
        {
          if(barNum >= sortedC.length - 1)
          {
            barNum = sortedC.length - 1;
          }
          realCategories[in] = sortedC[barNum];
          realValues[in] = sortedValues[barNum];
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
         sortedChart.setMaxValue(currentValue+20);
         sortedChart.setMinValue(0);
         sortedChart.setData(realValues);
         sortedChart.setBarLabels(realCategories);
         sortedChart.showCategoryAxis(true);
         sortedChart.showValueAxis(true);
         sortedCharts.add(sortedChart);
      }
   }
   currentChart = sortedCharts;
  }
  // used to decide which method is to be called when a user selects a dropDown option, ,the integer correspond to a certain method
  void changeDropdownOption(int index)
  {
    switch(index)
    {
      case(0):
        SortLowToHigh();
        break;
      case(1):
        SortHighToLow();
        break;
      case(2):
        showDefault();
        break;
    }
  }
  // changes the currentChart thats being displayed back to the original chart before any sorting was done.
  void showDefault()
  {
    currentChart = fullCharts.get(currentCol);
  }
}
