//Resources with file paths
PFont font;
Dataset data;

//Variable constants

void loadResources()
{
  data = new Dataset("flights2k.csv", DataType.flights);
  font = loadFont("Verdana-Bold-48.vlw");
}
