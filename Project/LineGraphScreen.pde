// Created and written by Esosa Johnny
class LineGraphScreen extends Screen
{
  // Implemented a line graph which includes methods and functions
  String[] uniques ; // List to store types of data for sorting
  int[] values;
  int currentCategory;
  ArrayList<Button> buttons;
  String[] headings = new String[]{"Flight Dates", "IATA CODE MARKETING AIRLINE", "FLIGHT NUMBER MARKETING AIRLINE", "ORIGIN", "ORIGIN CITY NAME", "ORIGIN AIPORT STATE", "ORIGIN AIRPORT WAC",
    "DESTINATION", "DESTINATION CITY NAME", "DESTINATION AIRPORT STATE", "DESTINATION ARIPORT WAC", "SCHEDULED DEPARTURE TIME", "ACTUAL DEPARTURE TIME", "SCHEDULED ARRIVAL TIME", "ACTUAL ARRIVAL TIME",
    "CANCELLED FLIGHT INDICATOR", "DISTANCE"};

  //Initializes the currentCategory variable to 0.
  //Creates a new ArrayList buttons to store Button objects.
  //Creates "NEXT" and "PREVIOUS" buttons and adds them to the buttons ArrayList
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
  
  /* Updates the graph retrieving unique values and their corresponding occurences,from the Data class, through a for-loop
   *  Method returns the number of occurences of the unique value at index 'i' in the current category
   *  These values are stored in the 'values' array at corresponding indices
   */
  void updateGraph()
  {
    uniques = data.getUniqueValues(currentCategory);
    values = new int[uniques.length];
    for (int i = 0; i < uniques.length; i++ )
    {
      values[i] = data.getOccurrenceAmount(i, currentCategory);
    }
  }
  
  /* Method 'updateGraph()' is called to ensure the data displayed on the graph is up-to-date
   *  Graph dimensions are set up by calculating maximum number of occurrences and sets up dimensions of graph
   *  Step sizes for the x - axis and y -axis are calculated to scale data points within graph
   *  X - axis and y - axis drawn using 'line()' function
   *  Data points and lines are drawn with the use of a for - loop which iterates each uniqye value and corresponing value in data
   *  Calculate x and y position for each data point within the graph based on the step sizes calculated earlier
   *  Red data point at each positon usin ellipse function and connected by 'line()' function
   *  X-axis labels are displayed below x-axis with use ('textAlign(CENTER)')
   *  Y-axis labels displayed with use ('textAlign(RIGHT)'), iterates over maximum number of categories and labels y-axis with values at appropriate intervals
   *  Category Heading displayed according to the current category displayed
   *  Buttons are drawn on the screen through the Button object
   */
  void draw()
  {
    updateGraph();
    stroke(0);

    int maxOccurences = data.getNumberOfRows();

    // Set up graph dimensions
    int graphWidth = width - 150;
    int graphHeight = height - 150;

    // Calculate the width of each bar
    float xStep = (float)graphWidth / (uniques.length - 1);
    float yStep = (float)graphHeight / maxOccurences;

    // Draw x-axis and y-axis
    line(50, height-50, width-50, height-50); // x-axis
    line(50, height-50, 50, 50); // y-axis

    // Draw data points and connect with lines
    for (int i = 0; i < uniques.length; i++) {
      float x = 50 + i * xStep;
      float y = height - 50 - values[i]* yStep;

      // Draw data points
      fill(0); // Black color for data points
      ellipseMode(CENTER);
      ellipse(x, y, 5, 5);
      fill(255, 0, 0);

      // Connect data points with lines
      if (i > 0) {
        float prevX = 50 + (i - 1) * xStep;
        float prevY = height - 50 - values[i-1]* yStep;
        line(prevX, prevY, x, y);
      }

      // Display date below x-axis
      textAlign(CENTER);
      if ((uniques.length >= 1000)  && (i % 250 == 0)) text(uniques[i], x, height - 30);
      else if ((uniques.length >= 500 && uniques.length < 1000) && (i % 50 == 0)) text(uniques[i], x, height - 30);
      else if ((uniques.length >= 100 && uniques.length < 500) && (i % 10 == 0)) text(uniques[i], x, height - 30);
      else if ( uniques.length < 100) text(uniques[i], x, height - 30);
    }
    // Label y-axis
    textAlign(RIGHT, CENTER);
    for (int j = 0; j <= maxOccurences; j += maxOccurences / 20) {
      float y = height - 50 - j * yStep;
      text(j, 45, y);
      line(45, y, 50, y); // Draw tick marks on y-axis
    }

    textAlign(CENTER);
    textSize(30);
    text(headings[currentCategory], width/2, 100);
    for (int i = 0; i < this.getWidgets().size(); i++) {
      this.getWidgets().get(i).draw();
    }
  }
  // Adds a Button object to the 'buttons' ArrayList
  void addButton(Button button)
  {
    buttons.add(button);
  }

  //Increments the 'currentCategory' index to display the next category of data
  //Prevents 'currentCategory' from exceeding the length of 'headings'
  void nextGraph()
  {
    if (++currentCategory == headings.length)
    {
      currentCategory = headings.length - 1 ;
      return;
    }
  }
  //Decrements the 'currentCategory' index to display the previous category
  //Resets 'currentCategory' to 0 if it goes below 0.
  void previousGraph()
  {
    if (--currentCategory < 0)
    {
      currentCategory = 0 ;
      return;
    }
  }
}
