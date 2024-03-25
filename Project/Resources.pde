<<<<<<< Updated upstream
//Resources with file paths
PFont font;
Dataset data;
NavigationBar bar;
TableScreen mainscreen;
ArrayList<BarChart> currentChart;
ArrayList<BarChart> dateChart;
ArrayList<BarChart> carrierCodeChart;
ArrayList<BarChart> flightNumChart;
ArrayList<BarChart> originChart;
ArrayList<BarChart> airOriginChart;
ArrayList<BarChart> originStateChart;
ArrayList<BarChart> originWacChart;
ArrayList<BarChart> destChart;
ArrayList<BarChart>airDestChart;
ArrayList<BarChart> destStateChart;
ArrayList<BarChart> destWacChart;
ArrayList<BarChart> schDepTimeChart;
ArrayList<BarChart> depTimeChart;
ArrayList<BarChart> schArrTimeChart;
ArrayList<BarChart> arrTimeChart;
ArrayList<BarChart> cancelChart;
ArrayList<BarChart> divertedChart;
ArrayList<BarChart> distanceChart;
ArrayList<Button> allButtons;
pieChart cancelledChart;
Screen currentScreen;
BarChartScreen barChartScreen;
Button nextChart, prevChart;
Button nextPage, prevPage;
Button nextColor, prevColor;
Button flipAxes;
Screen graphScreen;
Screen cancelledPieScreen;
Button mainTab, barChartTab, pieTab, treemapTab;
TreeMapScreen treeMapScreen;

//Variable constants
final String DATA_PATH = "flights2k";

final int BARHEIGHT = 100;
final int BARWIDTH = 2000;
final color WHITE =  color(255);
final color BLACK = color(0);
final color RED = color(255, 0, 0);
final color GREEN = color(0, 255, 0);
final color BLUE = color(0, 0, 255);
final color YELLOW = color(255,255,0);
final color PURPLE = color(255, 0, 255);
final color CYAN = color(0, 255, 255);
final color ORANGE = color(255, 165, 0);
final color BARCOLOR = GREEN;
final int BARCHARTWIDTH = 1200;
final int BARCHARTHEIGHT = 800;
final int CHARTGAP = 150;
final int TABWIDTH = 200;
final int TABHEIGHT = 40;
final int TABGAP = 200;
final int BUTTON1_GAP = 300;
final int BUTTON2_GAP = 600;
final int BUTTONWIDTH = 200;
final int BUTTONHEIGHT = 50;
final int SCREENWIDTH = 2000;
final int SCREENHEIGHT = 1000;
final int TEXT_COLOUR = color(0, 0, 0);
final int HEADER_SIZE = 16;
final int TEXT_SIZE = 14;

void loadResources()
{
  println("Loading resources...");
  data = new Dataset(DATA_PATH+".csv", DataType.flights);
  font = loadFont("Georgia-14.vlw");
  
  dateChart = setChart(0);
   median0 = median;  medianName0 = medianName;  mode0 = mode;  modeName0 = modeName;  categories0 = totalCategories;  mean0 = mean;
  carrierCodeChart = setChart(1);
   median1 = median; medianName1 = medianName; mode1 = mode; modeName1 = modeName; mean1 = mean; categories1 = totalCategories;
  flightNumChart = setChart(2);
   mean2 = mean;  median2 = median; medianName2 = medianName; mode2 = mode; modeName2 = modeName; categories2 = totalCategories;
  originChart = setChart(3);
   median3 = median; medianName3 = medianName; mode3 = mode; modeName3 = modeName; mean3 = mean; categories3 = totalCategories;
  airOriginChart = setChart(4);
  mean4 = mean; median4 = median; medianName4 = medianName; mode4 = mode; modeName4 = modeName; categories4 = totalCategories;
  originStateChart = setChart(5);
  mean5 = mean; median5 = median; medianName5 = medianName; mode5 = mode; modeName5 = modeName; categories5 = totalCategories;
  originWacChart = setChart(6);
  mean6 = mean; median6 = median; medianName6 = medianName; mode6 = mode; modeName6 = modeName; categories6 = totalCategories;
  destChart = setChart(7);
  mean7 = mean; median7 = median; medianName7 = medianName; mode7 = mode; modeName7 = modeName; categories7 = totalCategories;
  airDestChart = setChart(8);
  mean8 = mean; median8 = median; medianName8 = medianName; mode8 = mode; modeName8 = modeName; categories8 = totalCategories;
  destStateChart = setChart(9);
  mean9 = mean; median9 = median; medianName9 = medianName; mode9 = mode; modeName9 = modeName; categories9 = totalCategories;
  destWacChart = setChart(10);
  mean10 = mean; median10 = median; medianName10 = medianName; mode10 = mode; modeName10 = modeName; categories10 = totalCategories;
  schDepTimeChart = setChart(11);
  mean11 = mean; median11 = median; medianName11 = medianName; mode11 = mode; modeName11 = modeName; categories11 = totalCategories;
  depTimeChart = setChart(12);
  mean12 = mean; median12 = median; medianName12 = medianName; mode12 = mode; modeName12 = modeName; categories12 = totalCategories;
  schArrTimeChart = setChart(13);
  mean13 = mean; median13 = median; medianName13 = medianName; mode13 = mode; modeName13 = modeName; categories13 = totalCategories;
  arrTimeChart = setChart(14);
  mean14 = mean; median14 = median; medianName14 = medianName; mode14 = mode; modeName14 = modeName; categories14 = totalCategories;
  cancelChart = setChart(15);
  mean15 = mean; median15 = median; medianName15 = medianName; mode15 = mode; modeName15 = modeName; categories15 = totalCategories;
  divertedChart = setChart(16);
  mean16 = mean; median16 = median; medianName16 = medianName; mode16 = mode; modeName16 = modeName; categories16 = totalCategories;
  distanceChart = setChart(17);
  mean17 = mean; median17 = median; medianName17 = medianName; mode17 = mode; modeName17 = modeName; categories17 = totalCategories;
  currentChart = dateChart;
  cancelledChart = new pieChart(); 

  allButtons = new ArrayList<Button>();
  bar = new NavigationBar();
  mainscreen = new TableScreen();
  currentScreen = mainscreen;
  barChartScreen = new BarChartScreen(currentChart);
  cancelledPieScreen = new pieScreen(cancelledChart);
  treeMapScreen = new TreeMapScreen(allButtons);
  mainTab = new Button(50, BARHEIGHT/2 - TABHEIGHT/2, TABWIDTH, TABHEIGHT, "Main", RED, BLACK, WHITE, font, () ->bar.changeScreen(mainscreen)) ;
  barChartTab = new Button(50 + TABGAP * 2, BARHEIGHT/2 - TABHEIGHT/2, TABWIDTH, TABHEIGHT, "BarCharts", RED, BLACK, WHITE, font, () -> bar.changeScreen(barChartScreen));
  pieTab = new Button(50 + TABGAP * 4, BARHEIGHT /2 - TABHEIGHT / 2, TABWIDTH, TABHEIGHT, "Pie Chart", color(0,0,255), color(0), color(255), font, () ->bar.changeScreen(cancelledPieScreen));
  treemapTab = new Button(50 + TABGAP * 6, BARHEIGHT /2 - TABHEIGHT / 2, TABWIDTH, TABHEIGHT, "Treemap", color(0,0,255), color(0), color(255), font, () ->bar.changeScreen(treeMapScreen));
  flipAxes = new Button(width - (BUTTON2_GAP - 150), 140, BUTTONWIDTH, BUTTONHEIGHT, "Flip Chart", BLUE, BLACK, WHITE, font, () -> barChartScreen.flipChart());
  nextChart = new Button(width - BUTTON1_GAP, 200, BUTTONWIDTH, BUTTONHEIGHT, "Next Chart", BLUE, BLACK, WHITE, font, () -> barChartScreen.nextChart());
  prevChart = new Button(width - BUTTON2_GAP, 200, BUTTONWIDTH, BUTTONHEIGHT, "Previous Chart", BLUE, BLACK, WHITE, font, () -> barChartScreen.prevChart());
  nextPage = new Button(width - BUTTON1_GAP, 300, BUTTONWIDTH, BUTTONHEIGHT, "Next Page", BLUE, BLACK, WHITE, font, () -> barChartScreen.pageInc());
  prevPage = new Button(width - BUTTON2_GAP, 300, BUTTONWIDTH, BUTTONHEIGHT, "Previous Page", BLUE, BLACK, WHITE, font, () -> barChartScreen.pageDec());
  nextColor = new Button(width- BUTTON1_GAP,400, BUTTONWIDTH, BUTTONHEIGHT, "Next Colour", BLUE, BLACK, WHITE, font, () -> barChartScreen.nextColor());
  prevColor = new Button(width - BUTTON2_GAP, 400, BUTTONWIDTH, BUTTONHEIGHT, "Previous Colour", BLUE, BLACK, WHITE, font, () -> barChartScreen.prevColor());
  barChartScreen.addButton(nextChart); barChartScreen.addButton(prevChart); barChartScreen.addButton(nextPage); barChartScreen.addButton(prevPage); barChartScreen.addButton(nextColor); barChartScreen.addButton(prevColor); barChartScreen.addButton(flipAxes);
  bar.addTab(mainTab);  bar.addTab(barChartTab); bar.addTab(pieTab);bar.addTab(treemapTab);
  allButtons.add(mainTab); allButtons.add(barChartTab); allButtons.add(nextChart); allButtons.add(prevChart); allButtons.add(nextPage); allButtons.add(prevPage); allButtons.add(nextColor); allButtons.add(prevColor); allButtons.add(flipAxes);
  allButtons.add(pieTab);
  allButtons.add(treemapTab);
  currentScreen = mainscreen ;
}
=======
//Resources with file paths
PFont font;
Dataset data;
LineGraph lineGraph;
NavigationBar bar;
TableScreen mainscreen;
BarChart currentChart;
BarChart dateChart;
BarChart airDestChart;
BarChart airOriginChart;
Screen lineGraphScreen; 
Screen currentScreen;
Screen graphScreen;
Button lineGraphTab,graphTab, mainTab;
Button changeToDates, changeToOrigin, changeToDest;

//Variable constants
final String DATA_PATH = "flights2k";
final int BARHEIGHT = 100;
final int BARWIDTH = 2000;
final color BARCOLOR = color(0, 255, 0);
final color WHITE =  color(255);
final color BLACK = color(0);
boolean invertAxis = true;
final int BARCHARTWIDTH = 1000;
final int BARCHARTHEIGHT = 850;
final int CHARTGAP = 100;
final int TABWIDTH = 100;
final int TABHEIGHT = 40;
final int TABGAP = 100;


void loadResources()
{
  println("Loading resources...");
  data = new Dataset(DATA_PATH+".csv", DataType.flights);
  font = loadFont("Verdana-Bold-48.vlw");
  dateChart = new BarChart(this);
  airDestChart = new BarChart(this);
  airOriginChart = new BarChart(this);
  setChart(dateChart, 0, 0, 6);
  setChart(airOriginChart, 4, 0, 50);
  setChart(airDestChart, 8, 0, 50);
  currentChart =airDestChart;
  //lineGraph.setupLineGraph(DATA_PATH);

  bar = new NavigationBar();
  mainscreen = new TableScreen();
  currentScreen = mainscreen;
  graphScreen = new GraphScreen(currentChart);
  lineGraphScreen = new LineGraphScreen(lineGraph);
  mainTab = new Button(50, BARHEIGHT/2 - TABHEIGHT/2, TABWIDTH, TABHEIGHT, "Main", color(255, 0, 0), color(0), color(255), font, () ->bar.changeScreen(mainscreen)) ;
  graphTab = new Button(50 + TABGAP * 3, BARHEIGHT/2 - TABHEIGHT/2, TABWIDTH, TABHEIGHT, "Graphs", color(255, 0, 0), color(0), color(255), font, () -> bar.changeScreen(graphScreen));
  lineGraphTab = new Button(50 + TABGAP * 3, BARHEIGHT/2 - TABHEIGHT/2, TABWIDTH, TABHEIGHT, "Line Graphs", color(255,0,0), color(0), color(255), font, () -> bar.changeScreen(lineGraphScreen));
  changeToDates = new Button(width - 300, 300, 200, 50, "showDates", color(0, 0, 255), BLACK, WHITE, font, () ->graphScreen.changeChart(dateChart));
  changeToOrigin = new Button(width - 600, 300, 200, 50, "showOriginAirports", color(0, 0, 255), BLACK, WHITE, font, () -> graphScreen.changeChart(airOriginChart));
  changeToDest = new Button(width - 300, 400, 200, 50, "showDestAirports", color(0, 0, 255), BLACK, WHITE, font, () -> graphScreen.changeChart(airDestChart));
  graphScreen.addButton(changeToDates); graphScreen.addButton(changeToOrigin); graphScreen.addButton(changeToDest);
  bar.addTab(mainTab);  bar.addTab(graphTab); bar.addTab(lineGraphTab);
}
>>>>>>> Stashed changes
