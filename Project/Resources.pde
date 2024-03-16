//Resources with file paths
PFont font;
Dataset data;
NavigationBar bar;
TableScreen mainscreen;

//Variable constants
final int BARHEIGHT = 50;
final int BARWIDTH = width;
final int BARCOLOR = color(255, 255, 255);
final boolean INVERTAXIS = true;
final int BARCHARTWIDTH = 1000;
final int BARCHARTHEIGHT = 950;


void loadResources()
{
  data = new Dataset("flights2k.csv", DataType.flights);
  font = loadFont("Verdana-Bold-48.vlw");

  bar = new NavigationBar();
  mainscreen = new TableScreen();
}
