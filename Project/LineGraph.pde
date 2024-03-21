import java.util.Collections;
String[] lines; // Array to store each line of the file
HashMap<String, Integer> flightsPerDate = new HashMap<String, Integer>(); // Map to store flight counts for each date
ArrayList<String> dates = new ArrayList<String>(); // List to store dates for sorting

void setup() {
  size(800, 600);
  background(255);
  
  // Load the data file
  lines = loadStrings("flights2k(1).csv"); // Replace "data.txt" with your file name
  
  // Count the total number of flights for each date
  for (int i = 1; i < lines.length; i++) {
    String line = lines[i];
    String[] parts = split(line, ',');
    String date = parts[0].split(" ")[0]; // Extract only the date part
    
    if (flightsPerDate.containsKey(date)) {
      int currentCount = flightsPerDate.get(date);
      flightsPerDate.put(date, currentCount + 1); // Increment cochatunt if date already exists
    } else {
      flightsPerDate.put(date, 1); // Add new date to the map with count 1
      dates.add(date); // Add the date to the list of dates
    }
  }
  
  // Sort the list of dates
  Collections.sort(dates);
  
  // Draw the line graph
  drawLineGraph();
}

void drawLineGraph() {
  // Determine the maximum number of flights
  int maxFlights = Collections.max(flightsPerDate.values());
  
  // Set up graph dimensions
  int graphWidth = width - 100;
  int graphHeight = height - 100;
  
  // Calculate the width of each bar
  float xStep = (float)graphWidth / (dates.size() - 1);
  float yStep = (float)graphHeight / maxFlights;
  
  // Draw x-axis and y-axis
  line(50, height-50, width-50, height-50); // x-axis
  line(50, height-50, 50, 50); // y-axis
  
  // Draw data points and connect with lines
  for (int i = 0; i < dates.size(); i++) {
    float x = 50 + i * xStep;
    float y = height - 50 - flightsPerDate.get(dates.get(i)) * yStep;
    
    // Draw data points
    fill(255, 0, 0); // Red color for data points
    ellipse(x, y, 5, 5);
    
    // Connect data points with lines
    if (i > 0) {
      float prevX = 50 + (i - 1) * xStep;
      float prevY = height - 50 - flightsPerDate.get(dates.get(i - 1)) * yStep;
      line(prevX, prevY, x, y);
    }
    
    // Display date below x-axis
    textAlign(CENTER);
    text(dates.get(i), x, height - 30);
  }
  
  // Label y-axis
  textAlign(RIGHT);
  for (int j = 0; j <= maxFlights; j += maxFlights / 5) {
    float y = height - 50 - j * yStep;
    text(j, 40, y);
    line(45, y, 50, y); // Draw tick marks on y-axis
  }
}
