//Resources with file paths
PFont font;
Dataset data;
NavigationBar bar;
TableScreen mainscreen;
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
PApplet parent = this;

//Variable constants
final String DATA_PATH = "flights2k";

final int SCREENWIDTH = 2000;
final int SCREENHEIGHT = 1000;
final int BARHEIGHT = SCREENHEIGHT / 10;
final int BARWIDTH = SCREENWIDTH;
final color WHITE =  color(255);
final color BLACK = color(0);
final color RED = color(255, 0, 0);
final color GREEN = color(0, 255, 0);
final color BLUE = color(0, 0, 255);
final color YELLOW = color(255,255,0);
final color PURPLE = color(255, 0, 255);
final color CYAN = color(0, 255, 255);
final color ORANGE = color(255, 165, 0);
final color BARCOLOR = WHITE;
final int BARCHARTWIDTH = 1200;
final int BARCHARTHEIGHT = 800;
final int CHARTGAP = 150;
final int NUMOFTABS = 4;
final int TABWIDTH = (int)(BARWIDTH / NUMOFTABS) - NUMOFTABS;
final int TABHEIGHT = BARHEIGHT;
final int TABGAP = 200;
final int BUTTON1_GAP = 300;
final int BUTTON2_GAP = 600;
final int BUTTONWIDTH = 200;
final int BUTTONHEIGHT = 50;
final int TEXT_COLOUR = color(0, 0, 0);
final int HEADER_SIZE = 16;
final int TEXT_SIZE = 14;

void loadResources()
{
  println("Loading resources...");
  data = new Dataset(DATA_PATH + ".csv", DataType.flights);
  font = loadFont("Verdana-Bold-48.vlw");
  font = loadFont("Georgia-14.vlw");
  float[] sampleData = {218,1782};
  String[] sampleHeadings = {"cancelled", "not cancelled"};
  cancelledChart = new pieChart(sampleData, sampleHeadings); 
  
  allButtons = new ArrayList<Button>();
  bar = new NavigationBar();
  mainscreen = new TableScreen();
  currentScreen = mainscreen;
  barChartScreen = new BarChartScreen(parent);
  cancelledPieScreen = new pieScreen(cancelledChart);
  treeMapScreen = new TreeMapScreen(allButtons);
  mainTab = new Button(0, 0, TABWIDTH, TABHEIGHT, "Main", BLUE, BLACK, WHITE, font,() -> bar.changeScreen(mainscreen));
  barChartTab = new Button(0 + TABWIDTH + 1, 0, TABWIDTH, TABHEIGHT, "BarCharts", BLUE, BLACK, WHITE, font,() -> bar.changeScreen(barChartScreen));
  pieTab = new Button(0 + TABWIDTH * 2 + 2, 0, TABWIDTH, TABHEIGHT, "Pie Chart", color(0,0,255), color(0), color(255), font,() -> bar.changeScreen(cancelledPieScreen));
  treemapTab = new Button(0 + TABWIDTH * 3 + 3, 0, TABWIDTH, TABHEIGHT, "Treemap", color(0,0,255), color(0), color(255), font,() -> bar.changeScreen(treeMapScreen));
  flipAxes = new Button(width - (BUTTON2_GAP - 150), 140, BUTTONWIDTH, BUTTONHEIGHT, "Flip Chart", BLUE, BLACK, WHITE, font,() -> barChartScreen.flipChart());
  nextChart = new Button(width - BUTTON1_GAP, 200, BUTTONWIDTH, BUTTONHEIGHT, "Next Chart", BLUE, BLACK, WHITE, font,() -> barChartScreen.nextChart());
  prevChart = new Button(width - BUTTON2_GAP, 200, BUTTONWIDTH, BUTTONHEIGHT, "Previous Chart", BLUE, BLACK, WHITE, font,() -> barChartScreen.prevChart());
  nextPage = new Button(width - BUTTON1_GAP, 300, BUTTONWIDTH, BUTTONHEIGHT, "Next Page", BLUE, BLACK, WHITE, font,() -> barChartScreen.pageInc());
  prevPage = new Button(width - BUTTON2_GAP, 300, BUTTONWIDTH, BUTTONHEIGHT, "Previous Page", BLUE, BLACK, WHITE, font,() -> barChartScreen.pageDec());
  nextColor = new Button(width - BUTTON1_GAP,400, BUTTONWIDTH, BUTTONHEIGHT, "Next Colour", BLUE, BLACK, WHITE, font,() -> barChartScreen.nextColor());
  prevColor = new Button(width - BUTTON2_GAP, 400, BUTTONWIDTH, BUTTONHEIGHT, "Previous Colour", BLUE, BLACK, WHITE, font,() -> barChartScreen.prevColor());
  barChartScreen.addButton(nextChart); barChartScreen.addButton(prevChart); barChartScreen.addButton(nextPage); barChartScreen.addButton(prevPage); barChartScreen.addButton(nextColor); barChartScreen.addButton(prevColor); barChartScreen.addButton(flipAxes);
  bar.addTab(mainTab);  bar.addTab(barChartTab); bar.addTab(pieTab);bar.addTab(treemapTab);
  allButtons.add(mainTab); allButtons.add(barChartTab); allButtons.add(nextChart); allButtons.add(prevChart); allButtons.add(nextPage); allButtons.add(prevPage); allButtons.add(nextColor); allButtons.add(prevColor); allButtons.add(flipAxes);
  allButtons.add(pieTab);
  allButtons.add(treemapTab);
  currentScreen = mainscreen;
}
