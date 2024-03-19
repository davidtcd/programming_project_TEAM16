//Resources with file paths
PFont font;
Dataset data;
NavigationBar bar;
TableScreen mainscreen;

//Variable constants
final String DATA_PATH = "flights_full";

final int BARHEIGHT = 50;
final int BARWIDTH = width;
final int BARCOLOR = color(255, 255, 255);


void loadResources()
{
  data = new Dataset(DATA_PATH+".csv", DataType.flights);
  font = loadFont("Verdana-Bold-48.vlw");

  bar = new NavigationBar();
  mainscreen = new TableScreen();

}
