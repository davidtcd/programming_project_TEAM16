//Hezamary Paul created Screen class to include drawing of widgets and all other constants on 14/03/2024 @ 10:07


 class Screen { //declaration of screen class
    ArrayList<Widget> widgets;

    Screen() { //constructor for screen 
        widgets = new ArrayList<Widget>(); //add widgets 
    }

    // Method to add a widget to the screen
    public void addWidget(Widget widget) {
        widgets.add(widget);
    }


    // Method to draw the screen
    public void draw() {
        // Code to draw the screen (e.g., drawing widgets)
    }
    

}


class TableScreen extends Screen {
    int startX = 20; // X-coordinate where the table starts
    int startY = 50; // Y-coordinate where the table starts
    int rowHeight = 20; // Height of each row
    int padding = 10; // Padding for text within each cell

    // Constructor
    TableScreen() {
        super(); // Call to the parent class's constructor
    }
    

    // Method to display the table
    @Override
    void draw() {
        background(200); // Set a light grey background
        displayTable();
    }

    //display the dataset as a table
    void displayTable() {
        fill(TEXT_COLOUR); // Set text color to black
        textAlign(LEFT, CENTER);

        int numColumns = data.getNumberOfColumns();

    // Array to store the starting x positions of each column
    float[] columnStartXPositions = new float[numColumns];
    float totalHeaderWidth = 0;
    // Initial x position for the first column
    float xPosition = startX;

    // Calculate x positions for each column based on header width and padding
    for (int i = 0; i < numColumns; i++) {
        columnStartXPositions[i] = xPosition;
        float columnWidth = textWidth(data.table.getColumnTitle(i)) + 90;
        // Adjust xPosition for the next column based on current header width and additional space
        xPosition += textWidth(data.table.getColumnTitle(i)) + 90; // 90 includes padding for the box
        totalHeaderWidth += columnWidth;
  }
  
  // Draw continuous header background
    fill(255); // White background
    stroke(0); // Black border
    float headerBackgroundHeight = rowHeight + padding * 2; 
    rect(startX, startY - headerBackgroundHeight, totalHeaderWidth, headerBackgroundHeight); //drawing the header


    // Style for headers
      textFont(font);
      textSize(HEADER_SIZE); // Slightly larger text for headers
      fill(TEXT_COLOUR);  //black
    // Draw column titles at calculated positions
    for (int i = 0; i < numColumns; i++) {
        text(data.table.getColumnTitle(i), columnStartXPositions[i], startY - rowHeight);
    }

    

      //Style for data text
      textFont(font);
      textSize(TEXT_SIZE); // Slightly smaller text for data
      fill(TEXT_COLOUR); // black
    // Draw the data rows, aligning each cell with its header
    for (int i = 0; i < 100; i++) {
        for (int j = 0; j < numColumns; j++) {
            String value = data.getValue(i, j, false); // Get the value from the dataset
            if (value != null) {
                // Use the stored x position for alignment
                text(value, columnStartXPositions[j] + padding, startY + i * rowHeight+15);
            }
        }
    }
    }
}
