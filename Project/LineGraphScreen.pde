
class LineGraphScreen extends Screen
{
  String[] uniques ; // List to store dates for sorting
  int[] values;
  int currentCategory;
  ArrayList<Button> buttons;

  String heading;
  String[] headings = new String[]{"Flight Dates", "IATA CODE MARKETING AIRLINE", "FLIGHT NUMBER MARKETING AIRLINE", "ORIGIN", "ORIGIN CITY NAME", "ORIGIN AIPORT STATE", "ORIGIN AIRPORT WAC",
    "DESTINATION", "DESTINATION CITY NAME", "DESTINATION AIRPORT STATE", "DESTINATION ARIPORT WAC", "SCHEDULED DEPARTURE TIME", "ACTUAL DEPARTURE TIME", "SCHEDULED ARRIVAL TIME", "ACTUAL ARRIVAL TIME",
    "CANCELLED FLIGHT INDICATOR", "DISTANCE"};

  LineGraphScreen()
  {
    super();

    this.currentCategory = 0;
    buttons = new ArrayList<Button>();
    Button next = new Button(width -(BUTTON2_GAP - 150), 500, BUTTONWIDTH, BUTTONHEIGHT, "NEXT", BLUE, BLACK, WHITE, font, () -> nextGraph());
    getWidgets().add(next);
    allButtons.add(next);
    Button previous = new Button(width - (BUTTON2_GAP -150), 500 + (BUTTONHEIGHT*2), BUTTONWIDTH, BUTTONHEIGHT, "PREVIOUS", BLUE, BLACK, WHITE, font, () -> previousGraph());
    getWidgets().add(previous);
    allButtons.add(previous);
  }

  void updateGraph()
  {

    uniques = data.getUniqueValues(currentCategory);
    values = new int[uniques.length];
    for (int i = 0; i < uniques.length; i++ )
    {
      values[i] = data.getOccurrenceAmount(i, currentCategory);
    }
  }
 
  void draw()
  {
    updateGraph();
    stroke(0);
 
    int maxFlights = data.getNumberOfRows() / 2;

    // Set up graph dimensions
    int graphWidth = width - 400;
    int graphHeight = height - 400;

    // Calculate the width of each bar
    float xStep = (float)graphWidth / (uniques.length - 1);
    float yStep = (float)graphHeight / maxFlights;

    // Draw x-axis and y-axis
    line(50, height-50, width-50, height-50); // x-axis
    line(50, height-50, 50, 50); // y-axis

    // Draw data points and connect with lines
    for (int i = 0; i < uniques.length; i++) {
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
      //if statement and bottom else if
      if((uniques.length > 1000)  && (i % 900 == 0)) text(uniques[i], x, height - 30);
     else if((uniques.length > 100) && (i % 10 == 0)) text(uniques[i], x, height - 30);
     else if( uniques.length < 100) text(uniques[i], x, height - 30);
  
   } 
     
     
    // Label y-axis
    textAlign(RIGHT);
    for (int j = 0; j <= maxFlights; j += maxFlights / 5) {
      float y = height - 50 - j * yStep;
      text(j, 40, y);
      line(45, y, 50, y); // Draw tick marks on y-axis
    }
    //lineGraph.drawLineGraph();
    textSize(40);
    text(headings[currentCategory], 1000, 100);
    for (int i = 0; i < this.getWidgets().size(); i++) {
      this.getWidgets().get(i).draw();
    }
    
  }
  void addButton(Button button)
  {
    buttons.add(button);
  }
  void nextGraph()
  {
    if (++currentCategory == headings.length)
    {
      currentCategory = headings.length - 1 ;
      return;
    }
  }
  void previousGraph()
  {
    if (--currentCategory == headings.length)
    {
      currentCategory = 0 ;
      return;
    }
  }
}
