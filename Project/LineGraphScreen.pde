
class LineGraphScreen extends Screen
{
  String[] dates; // List to store dates for sorting
  int[] values;
  int currentCategory = 0;
  ArrayList<Button> buttons;
  Dataset data;
  String heading;
  String[] headings;
    LineGraphScreen(int currentCategory, Dataset data)
  {
    super();
    this.data = data;
    this.currentCategory = currentCategory;
    heading = data.getLine(1);
}
  String[] arrayHeadings(String words) // function that takes in the line and splits by 1
  {
     words = data.getLine(1);
    String[] headings = words.split("\\s*, \\s*");
    return headings;
  }
  String getHeading(String[] headings,int currentCategory)
  {
    String title = headings[currentCategory];
    return title;
  }

  void updateGraph()
  {
    buttons = new ArrayList<Button>();
    dates = data.getUniqueValues(currentCategory);
    values = new int[dates.length];
    for(int i = 0; i < dates.length; i++ )
    {
      values[i] = data.getOccurrenceAmount(i, currentCategory);
    }  
  }
  void drawTitle()
  {
    stroke(BLACK);
    rect(1450, 500, 400, 400);
    fill(BLACK);
   
    textAlign(CENTER);
  //  text("Number of Flights per date" + mean, 1650, 600);
  }
  void draw()
  {
      stroke(0);
      int maxFlights = data.getNumberOfRows() / 2;
    
    // CheckList
    /* scale the graph, make it look cute , add variables to easily change it
      keep in the class/file
      find highest value in the array, check if there is function for that, else loop through each function 
      once you find the highest value, use that to set up the steps
      have an x - offset, wherever you use an x, you use an x offset 
      check the width, rename dates to categories
      check the amount of categories and add it by a certain amount of space
    */
    // Set up graph dimensions
    int graphWidth = width - 400;
    int graphHeight = height - 400;

    // Calculate the width of each bar
    float xStep = (float)graphWidth / (dates.length - 1);
    float yStep = (float)graphHeight / maxFlights;

    // Draw x-axis and y-axis
    line(50, height-50, width-50, height-50); // x-axis
    line(50, height-50, 50, 50); // y-axis

    // Draw data points and connect with lines
    for (int i = 0; i < dates.length; i++) {
      float x = 50 + i * xStep;
      float y = height - 50 - values[i]* yStep;

      // Draw data points
      fill(255, 0, 0); // Red color for data points
      ellipse(x, y, 5, 5);

      // Connect data points with lines
      if (i > 0) {
        float prevX = 50 + (i - 1) * xStep;
        float prevY = height - 50 - values[i-1]* yStep;
        line(prevX, prevY, x, y);
      }

      // Display date below x-axis
      textAlign(CENTER);
      text(dates[i], x, height - 30);
    }

    // Label y-axis
    textAlign(RIGHT);
    for (int j = 0; j <= maxFlights; j += maxFlights / 5) {
      float y = height - 50 - j * yStep;
      text(j, 40, y);
      line(45, y, 50, y); // Draw tick marks on y-axis
    }
   //lineGraph.drawLineGraph();
    for(int i = 0; i < buttons.size(); i++)
    {
      buttons.get(i).draw();
    }
    text("Flights", 1000, 100);
  }
  void addButton(Button button)
  {
    buttons.add(button);
  }
  void changeGraph(int currentCategory)
  {
   this.currentCategory = currentCategory;
    updateGraph();
 //   newLineGraph = newLineGraph;
  }
}
