//Resources with file paths
PFont font;
PFont tableFont;
volatile Dataset data;

//UI
ArrayList<Button> allButtons;
ArrayList<Dropdown> allDropdowns;

//Nav bar
NavigationBar navBar;
Button tableTab, barChartTab, pieTab, treemapTab, lineGraphTab, searchTab, flightsMapTab;

//Screens
Screen currentScreen;
volatile DatasetScreen datasetScreen;
TableScreen tableScreen;
BarChartScreen barChartScreen;
Screen graphScreen;
PieScreen pieScreen;
TreeMapScreen treeMapScreen;
SearchScreen searchScreen;
LineGraphScreen lineGraphScreen;
FlightsMapScreen flightsMapScreen;

PApplet parent = this;

//Variable constants
final int SCREENWIDTH = 2000;
final int SCREENHEIGHT = 1000;

final color WHITE =  color(255);
final color BLACK = color(0);
final color RED = color(255, 0, 0);
final color GREEN = color(0, 255, 0);
final color BLUE = color(0, 0, 255);
final color YELLOW = color(255,255,0);
final color PURPLE = color(255, 0, 255);
final color CYAN = color(0, 255, 255);
final color ORANGE = color(255, 165, 0);

final int NAVBAR_HEIGHT = SCREENHEIGHT / 15;
final int NAVBAR_WIDTH = SCREENWIDTH;
final color NAVBAR_COLOR = WHITE;
final int NUMOFTABS = 7;
final int TABWIDTH = (int)(NAVBAR_WIDTH / NUMOFTABS);
final int TABHEIGHT = NAVBAR_HEIGHT;
final int TABGAP = 200;

final int BUTTONWIDTH = 200;
final int BUTTONHEIGHT = 50;
final int BUTTON1_GAP = 300;
final int BUTTON2_GAP = 600;

void loadResources()
{
  println("Loading resources...");
  font = loadFont("Verdana-Bold-48.vlw");
  tableFont = loadFont("Georgia-14.vlw");
  
  allButtons = new ArrayList<Button>();
  allDropdowns = new ArrayList<Dropdown>();
  
  tableScreen = new TableScreen();
  barChartScreen = new BarChartScreen(parent);
  pieScreen = new PieScreen();
  treeMapScreen = new TreeMapScreen(allButtons, allDropdowns);
  searchScreen = new SearchScreen(allDropdowns, allButtons, font, parent);
  lineGraphScreen = new LineGraphScreen();
  flightsMapScreen = new FlightsMapScreen();
  currentScreen = tableScreen;
  
  navBar = new NavigationBar();
  tableTab = new Button(0, 0, TABWIDTH, TABHEIGHT, "Main", BLUE, BLACK, WHITE, font,() -> navBar.changeScreen(tableScreen));
  barChartTab = new Button(0 + TABWIDTH + 1, 0, TABWIDTH, TABHEIGHT, "BarCharts", BLUE, BLACK, WHITE, font,() -> navBar.changeScreen(barChartScreen));
  pieTab = new Button(0 + TABWIDTH * 2 + 2, 0, TABWIDTH, TABHEIGHT, "Pie Chart", color(0,0,255), color(0), color(255), font,() -> navBar.changeScreen(pieScreen));
  treemapTab = new Button(0 + TABWIDTH * 3 + 3, 0, TABWIDTH, TABHEIGHT, "Treemap", color(0,0,255), color(0), color(255), font,() -> navBar.changeScreen(treeMapScreen));
  lineGraphTab = new Button(0 + TABWIDTH * 4 + 4, 0, TABWIDTH, TABHEIGHT, "Line graph", color(0,0,255), color(0), color(255), font,() -> navBar.changeScreen(lineGraphScreen));
  searchTab = new Button(0 + TABWIDTH * 5 + 5, 0, TABWIDTH, TABHEIGHT, "Search", color(0,0,255), color(0), color(255), font,() -> navBar.changeScreen(searchScreen));
  flightsMapTab = new Button(0 + TABWIDTH * 6 + 6, 0, TABWIDTH, TABHEIGHT, "Flights Map", color(0,0,255), color(0), color(255), font,() -> navBar.changeScreen(flightsMapScreen));
  
  navBar.addTab(tableTab);
  navBar.addTab(barChartTab);
  navBar.addTab(pieTab);
  navBar.addTab(treemapTab);
  navBar.addTab(lineGraphTab);
  navBar.addTab(searchTab);
  navBar.addTab(flightsMapTab);
  
  allButtons.add(tableTab);
  allButtons.add(barChartTab);
  allButtons.add(pieTab);
  allButtons.add(treemapTab);
  allButtons.add(lineGraphTab);
  allButtons.add(searchTab);
  allButtons.add(flightsMapTab);
  println("Resources loaded!");
}
