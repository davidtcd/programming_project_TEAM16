//Resources with file paths
PFont font;
Dataset data;
NavigationBar bar;
TableScreen mainscreen;
ArrayList<Button> allButtons;
ArrayList<Dropdown> allDropdowns;
pieChart cancelledChart;
pieChart carrierChart;
pieChart dateChart;
Button cancelledButton;
Button carrierButton;
Button dateButton;
Screen currentScreen;
BarChartScreen barChartScreen;
Button nextChart, prevChart;
Button nextPage, prevPage;
Button nextColor, prevColor;
Button flipAxes;
Screen graphScreen;
pieScreen currentPieScreen;
Button mainTab, barChartTab, pieTab, treemapTab, lineGraphTab;
TreeMapScreen treeMapScreen;
LineGraphScreen lineGraphScreen;
PApplet parent = this;
Table carrierTable;

//Variable constants
final String DATA_PATH = "flights100k";

final int SCREENWIDTH = 2000;
final int SCREENHEIGHT = 1000;
final int BARHEIGHT = SCREENHEIGHT / 15;
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
final int NUMOFTABS = 5;
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
final int MENU_WIDTH = 150;
final int MENU_HEIGHT = 30;
final int ITEM_HEIGHT = 30;

void loadResources()
{
  println("Loading resources...");
  data = new Dataset(DATA_PATH + ".csv", DataType.flights);
  font = loadFont("Verdana-Bold-48.vlw");
  font = loadFont("Georgia-14.vlw");
  String[] dateHeadings = data.getUniqueValues(0);
  float[] dateData = new float[dateHeadings.length];
  for (int i = 0; i < dateHeadings.length; i++)
  {
    dateData[i] = data.getOccurrenceAmount(i,0);
  }
  String[] carrierHeadings = data.getUniqueValues(1);
  float[] carrierData = new float[carrierHeadings.length];
  for (int i = 0; i < carrierHeadings.length; i++)
  {
    carrierData[i] = data.getOccurrenceAmount(i,1);
  }
  float[] cancelledData = {data.getOccurrenceAmount(1,15),data.getOccurrenceAmount(0,15)};
  String[] cancelledHeadings = {"cancelled", "not cancelled"};
  cancelledChart = new pieChart(cancelledData, cancelledHeadings); 
  carrierChart = new pieChart(carrierData, carrierHeadings);
  dateChart = new pieChart(dateData, dateHeadings);
  allButtons = new ArrayList<Button>();
  allDropdowns = new ArrayList<Dropdown>();
  bar = new NavigationBar();
  mainscreen = new TableScreen();
  currentScreen = mainscreen;
  barChartScreen = new BarChartScreen(parent);
  currentPieScreen = new pieScreen(cancelledChart);
  treeMapScreen = new TreeMapScreen(allButtons, allDropdowns);
  lineGraphScreen = new LineGraphScreen();
  treeMapScreen = new TreeMapScreen(allButtons, allDropdowns);
  mainTab = new Button(0, 0, TABWIDTH, TABHEIGHT, "Main", BLUE, BLACK, WHITE, font,() -> bar.changeScreen(mainscreen));
  barChartTab = new Button(0 + TABWIDTH + 1, 0, TABWIDTH, TABHEIGHT, "BarCharts", BLUE, BLACK, WHITE, font,() -> bar.changeScreen(barChartScreen));
  pieTab = new Button(0 + TABWIDTH * 2 + 2, 0, TABWIDTH, TABHEIGHT, "Pie Chart", color(0,0,255), color(0), color(255), font,() -> bar.changeScreen(currentPieScreen));
  treemapTab = new Button(0 + TABWIDTH * 3 + 3, 0, TABWIDTH, TABHEIGHT, "Treemap", color(0,0,255), color(0), color(255), font,() -> bar.changeScreen(treeMapScreen));
  lineGraphTab = new Button(0 + TABWIDTH * 4 + 4, 0, TABWIDTH, TABHEIGHT, "Line graph", color(0,0,255), color(0), color(255), font,() -> bar.changeScreen(lineGraphScreen)); 
  cancelledButton = new Button(width - (BUTTON2_GAP - 150), 140, BUTTONWIDTH, BUTTONHEIGHT, "Cancelled Flights", BLUE, BLACK, WHITE, font, () ->currentPieScreen.changeChart(cancelledChart));
  dateButton = new Button(width - (BUTTON2_GAP -150), 140 + (BUTTONHEIGHT*4), BUTTONWIDTH, BUTTONHEIGHT, "Flight Dates", BLUE, BLACK, WHITE, font, () ->currentPieScreen.changeChart(dateChart));
  carrierButton = new Button(width - (BUTTON2_GAP -150), 140 + (BUTTONHEIGHT*2), BUTTONWIDTH, BUTTONHEIGHT, "Airline Carriers", BLUE, BLACK, WHITE, font, () ->currentPieScreen.changeChart(carrierChart));
  flipAxes = new Button(width - (BUTTON2_GAP - 150), 140, BUTTONWIDTH, BUTTONHEIGHT, "Flip Chart", BLUE, BLACK, WHITE, font,() -> barChartScreen.flipChart());
  nextChart = new Button(width - BUTTON1_GAP, 200, BUTTONWIDTH, BUTTONHEIGHT, "Next Chart", BLUE, BLACK, WHITE, font,() -> barChartScreen.nextChart());
  prevChart = new Button(width - BUTTON2_GAP, 200, BUTTONWIDTH, BUTTONHEIGHT, "Previous Chart", BLUE, BLACK, WHITE, font,() -> barChartScreen.prevChart());
  nextPage = new Button(width - BUTTON1_GAP, 300, BUTTONWIDTH, BUTTONHEIGHT, "Next Page", BLUE, BLACK, WHITE, font,() -> barChartScreen.pageInc());
  prevPage = new Button(width - BUTTON2_GAP, 300, BUTTONWIDTH, BUTTONHEIGHT, "Previous Page", BLUE, BLACK, WHITE, font,() -> barChartScreen.pageDec());
  nextColor = new Button(width - BUTTON1_GAP,400, BUTTONWIDTH, BUTTONHEIGHT, "Next Colour", BLUE, BLACK, WHITE, font,() -> barChartScreen.nextColor());
  prevColor = new Button(width - BUTTON2_GAP, 400, BUTTONWIDTH, BUTTONHEIGHT, "Previous Colour", BLUE, BLACK, WHITE, font,() -> barChartScreen.prevColor());
  barChartScreen.addButton(nextChart); barChartScreen.addButton(prevChart); barChartScreen.addButton(nextPage); barChartScreen.addButton(prevPage); barChartScreen.addButton(nextColor); barChartScreen.addButton(prevColor); barChartScreen.addButton(flipAxes);
  bar.addTab(mainTab);  bar.addTab(barChartTab); bar.addTab(pieTab);bar.addTab(treemapTab); bar.addTab(lineGraphTab);
  currentPieScreen.addButton(cancelledButton);
  currentPieScreen.addButton(carrierButton);
  currentPieScreen.addButton(dateButton);
  allButtons.add(mainTab); allButtons.add(barChartTab); allButtons.add(nextChart); allButtons.add(prevChart); allButtons.add(nextPage); allButtons.add(prevPage); allButtons.add(nextColor); allButtons.add(prevColor); allButtons.add(flipAxes);
  allButtons.add(pieTab);
  allButtons.add(lineGraphTab);
  allButtons.add(treemapTab);
  allButtons.add(cancelledButton);
  allButtons.add(carrierButton);
  allButtons.add(dateButton);
  currentScreen = mainscreen;
}
