<<<<<<< Updated upstream
class BarChartScreen extends Screen
=======
 class GraphScreen extends Screen
>>>>>>> Stashed changes
{
  PFont title = createFont("Arial", 20);
  color barColor;
  ArrayList<BarChart> chart;
  ArrayList<Button> buttons;
  int pageNum = 0;
  int chartNum = 0;
  int currentColor = 0;
  String chartTitle;
  int mean;
  int median;
  String medianName;
  int mode;
  String modeName;
  int total;
  boolean invertAxis = true;
  BarChartScreen(ArrayList<BarChart> chart)
  {
    super();
    this.chart = chart;
    buttons = new ArrayList<Button>();
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
    text("TOTAL CATEGORIES: " + total, 1650, 750);
  }
  void draw()
  {
    if(pageNum < chart.size())
    {
    chart.get(pageNum).setBarColour(barColor);
    chart.get(pageNum).transposeAxes(invertAxis);
    chart.get(pageNum).draw(CHARTGAP, CHARTGAP, BARCHARTWIDTH, BARCHARTHEIGHT);
    }
    else
    {
      chart.get(0).setBarColour(barColor);
      chart.get(0).transposeAxes(invertAxis);
      chart.get(0).draw(CHARTGAP, CHARTGAP, BARCHARTWIDTH, BARCHARTHEIGHT);
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
  void changeChart()
  {
    switch(chartNum)
    {
    case(0):
      chart = dateChart;
      chartTitle = "DATES";
      mean = mean0;
      median = median0;
      medianName = medianName0;
      mode = mode0;
      modeName = modeName0;
      total = categories0;
      break;
    case(1):
      chart = carrierCodeChart;
      chartTitle = "CARRIER CODES";
      mean = mean1;
      median = median1;
      medianName = medianName1;
      mode = mode1;
      modeName = modeName1;
      total = categories1;
      break;
    case(2):
      chart = flightNumChart;
      chartTitle = " FLIGHT NUMBERS";
      mean = mean2;
      median = median2;
      medianName = medianName2;
      mode = mode2;
      modeName = modeName2;
      total = categories2;
      break;
    case(3):
      chart = originChart;
      chartTitle = "ORIGIN AIRPORTS";
      mean = mean3;
      median = median3;
      medianName = medianName3;
      mode = mode3;
      modeName = modeName3;
      total = categories3;
      break;
    case(4):
      chart = airOriginChart;
      chartTitle = " ORIGIN AIRPORT CITY NAMES";
      mean = mean4;
      median = median4;
      medianName = medianName4;
      mode = mode4;
      modeName = modeName4;
      total = categories4;
      break;
    case(5):
      chart = originStateChart;
      chartTitle = "ORIGIN AIRPORT STATE CODES";
      mean = mean5;
      median = median5;
      medianName = medianName5;
      mode = mode5;
      modeName = modeName5;
      total = categories5;
      break;
    case(6):
      chart = originWacChart;
      chartTitle = "ORIGIN AIRPORT WORLD AREA CODES";
      mean = mean6;
      median = median6;
      medianName = medianName6;
      mode = mode6;
      modeName = modeName6;
      total = categories6;
      break;
    case(7):
      chart = destChart;
      chartTitle = " DESTINATION AIRPORTS";
      mean = mean7;
      median = median7;
      medianName = medianName7;
      mode = mode7;
      modeName = modeName7;
      total = categories7;
      break;
    case(8):
      chart = airDestChart;
      chartTitle = "DESTINATION AIRPORT CITY NAMES";
      mean = mean8;
      median = median8;
      medianName = medianName8;
      mode = mode8;
      modeName = modeName8;
      total = categories8;
      break;
    case(9):
      chart = destStateChart;
      chartTitle = "DESTINATION AIRPORT STATE CODES";
      mean = mean9;
      median = median9;
      medianName = medianName9;
      mode = mode9;
      modeName = modeName9;
      total = categories9;
      break;
    case(10):
      chart = destWacChart;
      chartTitle = "DESTINATION AIRPORT WORLD AREA CODES";
      mean = mean10;
      median = median10;
      medianName = medianName10;
      mode = mode10;
      modeName = modeName10;
      total = categories10;
      break;
    case(11):
      chart = schDepTimeChart;
      chartTitle = "SCHEDULED DEPART TIMES (HHMM)";
      mean = mean11;
      median = median11;
      medianName = medianName11;
      mode = mode11;
      modeName = modeName11;
      total = categories11;
      break;
    case(12):
      chart = depTimeChart;
      chartTitle = "ACTUAL DEPART TIMES (HHMM)";
      mean = mean12;
      median = median12;
      medianName = medianName12;
      mode = mode12;
      modeName = modeName12;
      total = categories12;
      break;
    case(13):
      chart = schArrTimeChart;
      chartTitle = " SCHEDULED ARRIVAL TIMES (HHMM)";
      mean = mean13;
      median = median13;
      medianName = medianName13;
      mode = mode13;
      modeName = modeName13;
      total = categories13;
      break;
    case(14):
      chart = arrTimeChart;
      chartTitle = " ACTUAL ARRIVAL TIME (HHMM)";
      mean = mean14;
      median = median14;
      medianName = medianName14;
      mode = mode14;
      modeName = modeName14;
      total = categories14;
      break;
    case(15):
      chart = cancelChart;
      chartTitle = " CANCELLED FLIGHT INDICATOR (1 = YES";
      mean = mean15;
      median = median15;
      medianName = medianName15;
      mode = mode15;
      modeName = modeName15;
      total = categories15;
      break;
    case(16):
      chart = divertedChart;
      chartTitle = "DIVERTED FLIGHT INDICATOR (1 = YES)";
      mean = mean16;
      median = median16;
      medianName = medianName16;
      mode = mode16;
      modeName = modeName16;
      total = categories16;
      break;
    case(17):
      chart = distanceChart;
      chartTitle = "DISTANCE BETWEEN AIRPORTS (IN MILES)";
      mean = mean17;
      median = median17;
      medianName = medianName17;
      mode = mode17;
      modeName = modeName17;
      total = categories17;
      break;
    }
  }
  void pageInc()
  {
    pageNum++;
    if(pageNum > chart.size() - 1)
    {
      pageNum = chart.size() - 1;
    }
  }
    void pageDec()
  {
    pageNum--;
    if(pageNum < 0)
    {
      pageNum = 0;
    }
  }
  void nextChart()
  {
    pageNum = 0;
    chartNum++;
    if(chartNum >= 17)
    {
      chartNum = 17;
    }
  }
  void prevChart()
  {
    pageNum = 0;
    chartNum--;
    if(chartNum <= 0)
    {
      chartNum = 0;
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
