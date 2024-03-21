//Resources with file paths
PFont font;
Dataset data;
NavigationBar bar;
TableScreen mainscreen;
BarChart currentChart;
BarChart dateChart;
BarChart airDestChart;
BarChart airOriginChart;
Screen currentScreen;
Screen graphScreen;
Button graphTab, mainTab;
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

  bar = new NavigationBar();
  mainscreen = new TableScreen();
  currentScreen = mainscreen;
  graphScreen = new GraphScreen(currentChart);
  mainTab = new Button(50, BARHEIGHT/2 - TABHEIGHT/2, TABWIDTH, TABHEIGHT, "Main", color(255, 0, 0), color(0), color(255), font, () ->bar.changeScreen(mainscreen)) ;
  graphTab = new Button(50 + TABGAP * 3, BARHEIGHT/2 - TABHEIGHT/2, TABWIDTH, TABHEIGHT, "Graphs", color(255, 0, 0), color(0), color(255), font, () -> bar.changeScreen(graphScreen));
  changeToDates = new Button(width - 300, 300, 200, 50, "showDates", color(0, 0, 255), BLACK, WHITE, font, () ->graphScreen.changeChart(dateChart));
  changeToOrigin = new Button(width - 600, 300, 200, 50, "showOriginAirports", color(0, 0, 255), BLACK, WHITE, font, () -> graphScreen.changeChart(airOriginChart));
  changeToDest = new Button(width - 300, 400, 200, 50, "showDestAirports", color(0, 0, 255), BLACK, WHITE, font, () -> graphScreen.changeChart(airDestChart));
  graphScreen.addButton(changeToDates); graphScreen.addButton(changeToOrigin); graphScreen.addButton(changeToDest);
  bar.addTab(mainTab);  bar.addTab(graphTab);
}
