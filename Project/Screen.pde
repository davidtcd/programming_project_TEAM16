//Hezamary Paul created Screen class to include drawing of widgets and all other constants on 14/03/2024 @ 10:07
//created dropdown and different menus
//can access rows separately
//can access columns separately allowing different queries. 
import java.util.Arrays;
 class Screen { //declaration of screen class
     
     ArrayList<Widget> widgets;

    boolean handleMouseClick = true;
    Screen() { //constructor for screen 
        widgets = new ArrayList<Widget>(); //add widgets 
    }

    // Method to add a widget to the screen
    public void addWidget(Widget widget) {
        widgets.add(widget);
    }

    public ArrayList<Widget> getWidgets() {
        return this.widgets;  
    }

    // Method to draw the screen
    public void draw() {
        // Code to draw the screen (e.g., drawing widgets)
    }

    void mouseClicked() {
        if (handleMouseClick) {
            if (currentScreen != null) {
            currentScreen.mouseClicked();
        }
        }
    }


}





class TableScreen extends Screen {
    int startX = 20; // X-coordinate where the table starts
    int startY = 200; // Y-coordinate where the table starts
    int rowHeight = 20; // Height of each row
    int padding = 10; // Padding for text within each cell

    int HEADERSIZE = 12;
    int TEXTSIZE = 10;

    boolean showOnlyTenRows = false; // Flag to toggle between showing 10 rows or all rows

   

    String[] menuOptions = {"10 ROWS", "20 ROWS", "30 ROWS"};

    String[] columnNames = {"FL_DATE", "MKT_CARRIER", "MKT_CARRIER_FL_NUM", 
                            "ORIGIN", "ORIGIN_CITY_NAME", "ORIGIN_STATE_ABR", 
                            "ORIGIN_WAC", "DEST", "DEST_CITY_NAME", "DEST_STATE_ABR", 
                            "DEST_WAC", "CRS_DEP_TIME", "DEP_TIME", "CRS_ARR_TIME", 
                            "ARR_TIME", "CANCELLED", "DIVERTED", "DISTANCE"};
    int selectedItemIndex = -1;
    int selectedColumnIndex = -1;
    ArrayList<String> columnValues = new ArrayList<>();
    boolean dropdownOpen = false;
    boolean dropdown1Open = false;
    boolean dropdown2Open = false;
    boolean dropdown3Open = false;
    boolean dropdown4Open = false;
    boolean onlyrows = false;
    boolean onlycolumns = false;
    boolean sortColumns = false;
    boolean lowestCol = false;
    String highestValueRow;
    String lowestValueRow;
    TableScreen() {
        super(); // Call to the parent class's constructor
    }
  
    
    // Method to display the dropdown menu and handle its interaction
  void displayDropdownMenu() {
      fill(240); // Light grey background for the dropdown menu button
      stroke(0); // Black border
      rect(20, 130, MENU_WIDTH, MENU_HEIGHT); // Rectangle for the dropdown button
  
      // Draw dropdown button label
      fill(0); // Set text color to black

      textSize(HEADERSIZE); // Slightly larger text for headers

      textAlign(LEFT, CENTER);
      text("SHOW DEFAULT",  20 + 10, 130 + MENU_HEIGHT / 2); // Position the text inside the dropdown button
      
      // Draw dropdown button
      fill(240); // Light grey background for the dropdown menu button
      stroke(0); // Black border
      rect(140, 130, MENU_WIDTH, MENU_HEIGHT); // Rectangle for the dropdown button
  
      // Draw dropdown button label
      fill(0); // Set text color to black


      textSize(HEADERSIZE); // Slightly larger text for headers

      textAlign(LEFT, CENTER);
      text("CHOOSE ROWS",  140 + 10, 130 + MENU_HEIGHT / 2); // Position the text inside the dropdown button
      
      // If dropdown menu is open, draw menu items
      if (dropdownOpen) {
          for (int i = 0; i < menuOptions.length; i++) {
              fill(240); // Light grey background for menu item
              stroke(0); // Black border
              rect(140, 130 + MENU_HEIGHT + i * ITEM_HEIGHT, MENU_WIDTH, ITEM_HEIGHT); // Rectangle for menu item
  
              // Draw menu item label
              fill(0); // Set text color to black

              textSize(TEXT_SIZE); // Slightly larger text for headers

              textSize(TEXTSIZE); // Slightly larger text for headers

              textAlign(LEFT, CENTER);
              text(menuOptions[i], 140 + 10, 130 + MENU_HEIGHT + i * ITEM_HEIGHT + ITEM_HEIGHT / 2); // Position the text inside the menu item
  
              // Check if mouse is over menu item
              if (mouseX >= 140 && mouseX <= 140 + MENU_WIDTH && mouseY >= 130 + MENU_HEIGHT + i * ITEM_HEIGHT && mouseY <= 130 + MENU_HEIGHT + (i + 1) * ITEM_HEIGHT) {
                  if (mousePressed) {
                      //System.out.println("Mouse is over");
                      selectedItemIndex = i; // Set selected item index
                      //System.out.println(selectedItemIndex);
                      onlyrows = true;
                      onlycolumns = false;
                      sortColumns = false;
                      lowestCol = false;
                      dropdownOpen = false; // Close dropdown menu
                  }
              }
          }
      }
      
      fill(240); // Light grey background for the dropdown menu button
      stroke(0); // Black border
      rect(260, 130, MENU_WIDTH, MENU_HEIGHT); // Rectangle for the dropdown button
  
      // Draw dropdown button label
      fill(0); // Set text color to black

      textSize(HEADERSIZE); // Slightly larger text for headers

      textAlign(LEFT, CENTER);
      text("CHOOSE COLUMNS",  260 + 6, 130 + MENU_HEIGHT / 2); // Position the text inside the dropdown button
      
      // If dropdown menu is open, draw menu items
      if (dropdown2Open) {
          for (int i = 0; i < columnNames.length; i++) {
              fill(240); // Light grey background for menu item
              stroke(0); // Black border
              rect(260, 130 + MENU_HEIGHT + i * ITEM_HEIGHT, MENU_WIDTH, ITEM_HEIGHT); // Rectangle for menu item
  
              // Draw menu item label
              fill(0); // Set text color to black

              textSize(TEXT_SIZE); // Slightly larger text for headers

              textSize(TEXTSIZE); // Slightly larger text for headers

              textAlign(LEFT, CENTER);
              text(columnNames[i], 260 + 10, 130 + MENU_HEIGHT + i * ITEM_HEIGHT + ITEM_HEIGHT / 2); // Position the text inside the menu item
  
              // Check if mouse is over menu item
              if (mouseX >= 260 && mouseX <= 260 + MENU_WIDTH && mouseY >= 130 + MENU_HEIGHT + i * ITEM_HEIGHT && mouseY <= 130 + MENU_HEIGHT + (i + 1) * ITEM_HEIGHT) {
                  if (mousePressed) {
                      selectedColumnIndex = i; // Set selected item index
                      onlyrows = false;
                      onlycolumns = true;
                      sortColumns = false;
                      lowestCol = false;
                      printColumnByName(selectedColumnIndex);
                      displayTable2();
                      dropdown2Open = false; // Close dropdown menu
                  }
              }
          }
      }
      
      //CHOOSE HIGHEST BASED ON COLUMN
      fill(240); // Light grey background for the dropdown menu button
      stroke(0); // Black border
      rect(380, 130, MENU_WIDTH, MENU_HEIGHT); // Rectangle for the dropdown button
  
      // Draw dropdown button label
      fill(0); // Set text color to black

      textSize(HEADERSIZE); // Slightly larger text for headers

      textAlign(LEFT, CENTER);
      text("SELECT HIGHEST",  380 + 10, 130 + MENU_HEIGHT / 2); // Position the text inside the dropdown button
      
       if (dropdown3Open) {
          for (int i = 0; i < columnNames.length; i++) {
              fill(240); // Light grey background for menu item
              stroke(0); // Black border
              rect(380, 130 + MENU_HEIGHT + i * ITEM_HEIGHT, MENU_WIDTH, ITEM_HEIGHT); // Rectangle for menu item
  
              // Draw menu item label
              fill(0); // Set text color to black

              textSize(TEXTSIZE); // Slightly larger text for headers

              textAlign(LEFT, CENTER);
              text(columnNames[i], 380 + 10, 130 + MENU_HEIGHT + i * ITEM_HEIGHT + ITEM_HEIGHT / 2); // Position the text inside the menu item
  
              // Check if mouse is over menu item
              if (mouseX >= 380 && mouseX <= 380 + MENU_WIDTH && mouseY >= 130 + MENU_HEIGHT + i * ITEM_HEIGHT && mouseY <= 130 + MENU_HEIGHT + (i + 1) * ITEM_HEIGHT) {
                  if (mousePressed) {
                      selectedColumnIndex = i; // Set selected item index
                      onlyrows = false;
                      onlycolumns = false;
                      sortColumns = true;
                      lowestCol = false;
                      displayTable3();
                      dropdown3Open = false; // Close dropdown menu
                  }
                
            }
              }
          }
          
          //CHOOSE LOWEST
          fill(240); // Light grey background for the dropdown menu button
        stroke(0); // Black border
        rect(500, 130, MENU_WIDTH, MENU_HEIGHT); // Rectangle for the dropdown button
    
        // Draw dropdown button label
        fill(0); // Set text color to black
  
        textSize(HEADERSIZE); // Slightly larger text for headers
  
        textAlign(LEFT, CENTER);
        text("SELECT LOWEST",  500 + 10, 130 + MENU_HEIGHT / 2); // Position the text inside the dropdown button
        
         if (dropdown4Open) {
            for (int i = 0; i < columnNames.length; i++) {
                fill(240); // Light grey background for menu item
                stroke(0); // Black border
                rect(500, 130 + MENU_HEIGHT + i * ITEM_HEIGHT, MENU_WIDTH, ITEM_HEIGHT); // Rectangle for menu item
    
                // Draw menu item label
                fill(0); // Set text color to black
  
                textSize(TEXT_SIZE); // Slightly larger text for headers
  
                textSize(TEXTSIZE); // Slightly larger text for headers
  
                textAlign(LEFT, CENTER);
                text(columnNames[i], 500 + 10, 130 + MENU_HEIGHT + i * ITEM_HEIGHT + ITEM_HEIGHT / 2); // Position the text inside the menu item
    
                // Check if mouse is over menu item
                if (mouseX >= 500 && mouseX <= 500 + MENU_WIDTH && mouseY >= 130 + MENU_HEIGHT + i * ITEM_HEIGHT && mouseY <= 130 + MENU_HEIGHT + (i + 1) * ITEM_HEIGHT) {
                    if (mousePressed) {
                        selectedColumnIndex = i; // Set selected item index
                        onlyrows = false;
                        onlycolumns = false;
                        sortColumns = false;
                        lowestCol = true;
                        displayTable4();
                        dropdown4Open = false; // Close dropdown menu
                    }
                  
              }
                }
            }
      }

  

    // Method to display the table
   
    void draw() {
        background(200); // Set a light grey background
       if (onlycolumns == true){
          displayTable2();
        } 
        else if (sortColumns == true){
          displayTable3();
        }
        else if (onlyrows == true){
        // Display the second table (table2) if a column is selected
        displayTable();
        }
        else if (lowestCol == true){
        // Display the second table (table4) if a column is selected
        displayTable4();
        }
        else{
          displayTable1();
        }
        displayDropdownMenu(); // Display the dropdown menu 
    }
        @Override
        void mouseClicked() {
        // Check if the mouse click is within the dropdown button area
        
        if (mouseX >= 20 && mouseX <= 20 + MENU_WIDTH && mouseY >= 130 && mouseY <= 130 + MENU_HEIGHT) {
            selectedItemIndex = -1;
            selectedColumnIndex = -1;
            onlyrows = false;
            onlycolumns = false;
            sortColumns = false;
            lowestCol = false;
        } 
        
        if (mouseX >= 140 && mouseX <= 140 + MENU_WIDTH && mouseY >= 130 && mouseY <= 130 + MENU_HEIGHT) {
            dropdownOpen = !dropdownOpen; // Toggle dropdown state
        } 
    
        // If the dropdown is open and the user clicks outside, close the dropdown
        if (dropdownOpen && (mouseX < 140 || mouseX > 140 + MENU_WIDTH || mouseY < 130 || mouseY > 130 + MENU_HEIGHT + menuOptions.length * ITEM_HEIGHT)) {
            dropdownOpen = false;
        }
        
        if (dropdownOpen) {
        for (int i = 0; i < menuOptions.length; i++) {
            if (mouseX >= 140 && mouseX <= 140 + MENU_WIDTH && mouseY >= 130 + MENU_HEIGHT + i * ITEM_HEIGHT && mouseY <= 130 + MENU_HEIGHT + (i + 1) * ITEM_HEIGHT) {
                dropdownOpen = false; // Close dropdown menu
            }
        }
    }
        
        if (mouseX >= 260 && mouseX <= 260 + MENU_WIDTH && mouseY >= 130 && mouseY <= 130 + MENU_HEIGHT) {
            dropdown2Open = !dropdown2Open; // Toggle dropdown state
        } 
    
        // If the dropdown is open and the user clicks outside, close the dropdown
        if (dropdown2Open && (mouseX < 260 || mouseX > 260 + MENU_WIDTH || mouseY < 130 || mouseY > 130 + MENU_HEIGHT + columnNames.length * ITEM_HEIGHT)) {
            dropdown2Open = false;
        }
        
        // If dropdown2 is open and the user clicks on a column name, redraw the table with only that column
        if (dropdown2Open) {
            
            for (int i = 0; i < columnNames.length; i++) {
                if (mouseX >= 260 && mouseX <= 260 + MENU_WIDTH && mouseY >= 130 + MENU_HEIGHT + i * ITEM_HEIGHT && mouseY <= 130 + MENU_HEIGHT + (i + 1) * ITEM_HEIGHT) {
                    // Set selected column index
                    selectedColumnIndex = i; 
                    // Redraw the table with only the selected column
                    dropdown2Open = false; // Close dropdown menu
                }
            }
        }
        
        if (mouseX >= 380 && mouseX <= 380 + MENU_WIDTH && mouseY >= 130 && mouseY <= 130 + MENU_HEIGHT) {
            dropdown3Open = !dropdown3Open; // Toggle dropdown state
            
        } 
    
        // If the dropdown is open and the user clicks outside, close the dropdown
        if (dropdown3Open && (mouseX < 380 || mouseX > 380 + MENU_WIDTH || mouseY < 130 || mouseY > 130 + MENU_HEIGHT + columnNames.length * ITEM_HEIGHT)) {
            dropdown3Open = false;
        }
        
        if (dropdown3Open) {
            
            for (int i = 0; i < columnNames.length; i++) {
                if (mouseX >= 380 && mouseX <= 380 + MENU_WIDTH && mouseY >= 130 + MENU_HEIGHT + i * ITEM_HEIGHT && mouseY <= 130 + MENU_HEIGHT + (i + 1) * ITEM_HEIGHT) {
                    // Set selected column index
                    selectedColumnIndex = i; 
                    displayTable3();
                    // Redraw the table with only the selected column
                    dropdown3Open = false; // Close dropdown menu
                }
            }
        }
        
         if (mouseX >= 500 && mouseX <= 500 + MENU_WIDTH && mouseY >= 130 && mouseY <= 130 + MENU_HEIGHT) {
            dropdown4Open = !dropdown4Open; // Toggle dropdown state
            
        } 
    
        // If the dropdown is open and the user clicks outside, close the dropdown
        if (dropdown4Open && (mouseX < 500 || mouseX > 500 + MENU_WIDTH || mouseY < 130 || mouseY > 130 + MENU_HEIGHT + columnNames.length * ITEM_HEIGHT)) {
            dropdown4Open = false;
        }
        
        if (dropdown4Open) {
            
            for (int i = 0; i < columnNames.length; i++) {
                if (mouseX >= 500 && mouseX <= 500 + MENU_WIDTH && mouseY >= 130 + MENU_HEIGHT + i * ITEM_HEIGHT && mouseY <= 130 + MENU_HEIGHT + (i + 1) * ITEM_HEIGHT) {
                    // Set selected column index
                    selectedColumnIndex = i; 
                    displayTable4();
                    // Redraw the table with only the selected column
                    dropdown4Open = false; // Close dropdown menu
                }
            }
        }
        
        
        
    }
    
// Method to redraw the table with only the selected column
void printColumnByName(int index) {
    columnValues.clear();
    // Check if the index is within the bounds of the columnNames array
    if (index >= 0 && index < columnNames.length) {
        String columnName = columnNames[index]; // Get the column name at the specified index

        // Iterate through the column titles in the dataset
        for (int i = 0; i < data.getNumberOfColumns(); i++) {
            String columnTitle = data.table.getColumnTitle(i); // Get the column title at index i
            // Check if the column title matches the desired column name
            if (columnName.equals(columnTitle)) {
                // Print the column title
                columnValues.add(columnTitle);
                
                
                // Print the values of the column
                int numRows = data.getNumberOfRows();
                for (int j = 0; j < numRows; j++) {
                    String value = data.getValue(j, i, false); // Get the value from the dataset for the current column and row
                    if (value != null) {
                        columnValues.add(value);
                    }
                }
                
            }
        }
        
        
}}

void displayTable2() {
    fill(TEXT_COLOUR); // Set text color to black
    textAlign(LEFT, CENTER);


    // Array to store the starting x position of the column
    float columnStartXPosition = startX;

    // Calculate x position for the column based on padding
    String ColumnName = columnValues.get(0);
    float totalHeaderWidth = textWidth((ColumnName) + 80); // Width of the column header

    // Draw continuous header background
    fill(255); // White background
    stroke(0); // Black border
    float headerBackgroundHeight = rowHeight + padding; 
    rect(startX, startY - headerBackgroundHeight, totalHeaderWidth, headerBackgroundHeight); // Drawing the header

    // Style for headers
    textFont(font);


    textSize(HEADERSIZE); // Slightly larger text for headers

    fill(TEXT_COLOUR);  // Black
    
    // Draw column title at calculated position
    text(ColumnName, columnStartXPosition, startY - rowHeight);

    // Style for data text
    textFont(font);

    textSize(TEXTSIZE); // Slightly smaller text for data

    fill(TEXT_COLOUR); // Black

    // Draw the data rows, aligning each cell with its header
    int numRowsToDisplay = columnValues.size(); // Number of rows to display is equal to the size of columnValues array

    for (int i = 1; i < numRowsToDisplay; i++) {
        // Use the stored x position for alignment
        text(columnValues.get(i), columnStartXPosition + padding, startY + i * rowHeight + 15);
    }
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
        float columnWidth = textWidth(data.table.getColumnTitle(i)) + 80;
        // Adjust xPosition for the next column based on current header width and additional space
        xPosition += textWidth(data.table.getColumnTitle(i)) + 35; // 90 includes padding for the box
        totalHeaderWidth += columnWidth;
    }
  
    // Draw continuous header background
    fill(255); // White background
    stroke(0); // Black border
    float headerBackgroundHeight = rowHeight + padding; 
    rect(startX, startY - headerBackgroundHeight, totalHeaderWidth, headerBackgroundHeight); //drawing the header

    // Style for headers
    textFont(font);

    textSize(HEADER_SIZE); // Slightly larger text for headers

    textSize(HEADERSIZE); // Slightly larger text for headers

    fill(TEXT_COLOUR);  //black
    
    // Draw column titles at calculated positions
    for (int i = 0; i < numColumns; i++) {
        text(data.table.getColumnTitle(i), columnStartXPositions[i], startY - rowHeight);
    }

    // Style for data text
    textFont(font);

    textSize(TEXTSIZE); // Slightly smaller text for data

    fill(TEXT_COLOUR); // black

    // Draw the data rows, aligning each cell with its header
    int numRowsToDisplay = selectedItemIndex >= 0 && selectedItemIndex < menuOptions.length ? 
                        Integer.parseInt(menuOptions[selectedItemIndex].split(" ")[0]) : 
                        100;

    for (int i = 0; i < numRowsToDisplay; i++) {
        for (int j = 0; j < numColumns; j++) {
            String value = data.getValue(i, j, false); // Get the value from the dataset
            if (value != null) {
                // Use the stored x position for alignment
                text(value, columnStartXPositions[j] + padding, startY + i * rowHeight + 15);
            }
        }
    }}


//display the dataset as a table
    void displayTable1() {
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
        float columnWidth = textWidth(data.table.getColumnTitle(i)) + 80;
        // Adjust xPosition for the next column based on current header width and additional space
        xPosition += textWidth(data.table.getColumnTitle(i)) + 35; // 90 includes padding for the box
        totalHeaderWidth += columnWidth;
    }
  
    // Draw continuous header background
    fill(255); // White background
    stroke(0); // Black border
    float headerBackgroundHeight = rowHeight + padding; 
    rect(startX, startY - headerBackgroundHeight, totalHeaderWidth, headerBackgroundHeight); //drawing the header

    // Style for headers


    textSize(HEADERSIZE); // Slightly larger text for headers

    fill(TEXT_COLOUR);  //black
    
    // Draw column titles at calculated positions
    for (int i = 0; i < numColumns; i++) {
        text(data.table.getColumnTitle(i), columnStartXPositions[i], startY - rowHeight);
    }

    // Style for data text
    textFont(font);

    textSize(TEXTSIZE); // Slightly smaller text for data

    fill(TEXT_COLOUR); // black

    // Draw the data rows, aligning each cell with its header
    int numRowsToDisplay = 100;

    for (int i = 0; i < numRowsToDisplay; i++) {
        for (int j = 0; j < numColumns; j++) {

            String value = data.getValue(i, j, false); // Get the value from the dataset

            if (value != null) {
                // Use the stored x position for alignment
                text(value, columnStartXPositions[j] + padding, startY + i * rowHeight + 15);
            }
        }
    }}   

 void displayTable3() {
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
        float columnWidth = textWidth(data.table.getColumnTitle(i)) + 80;
        // Adjust xPosition for the next column based on current header width and additional space
        xPosition += textWidth(data.table.getColumnTitle(i)) + 35; // 90 includes padding for the box
        totalHeaderWidth += columnWidth;
    }
  
    // Draw continuous header background
    fill(255); // White background
    stroke(0); // Black border
    float headerBackgroundHeight = rowHeight + padding; 
    rect(startX, startY - headerBackgroundHeight, totalHeaderWidth, headerBackgroundHeight); //drawing the header

    // Style for headers


    textSize(HEADERSIZE); // Slightly larger text for headers

    fill(TEXT_COLOUR);  //black
    
    // Draw column titles at calculated positions
    for (int i = 0; i < numColumns; i++) {
        text(data.table.getColumnTitle(i), columnStartXPositions[i], startY - rowHeight);
    }
    
    textSize(TEXTSIZE); // Slightly smaller text for data
    
    displayTable3Content(columnStartXPositions);
    
 }
 
  void displayTable4() {
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
        float columnWidth = textWidth(data.table.getColumnTitle(i)) + 80;
        // Adjust xPosition for the next column based on current header width and additional space
        xPosition += textWidth(data.table.getColumnTitle(i)) + 35; // 90 includes padding for the box
        totalHeaderWidth += columnWidth;
    }
  
    // Draw continuous header background
    fill(255); // White background
    stroke(0); // Black border
    float headerBackgroundHeight = rowHeight + padding; 
    rect(startX, startY - headerBackgroundHeight, totalHeaderWidth, headerBackgroundHeight); //drawing the header

    // Style for headers


    textSize(HEADERSIZE); // Slightly larger text for headers

    fill(TEXT_COLOUR);  //black
    
    // Draw column titles at calculated positions
    for (int i = 0; i < numColumns; i++) {
        text(data.table.getColumnTitle(i), columnStartXPositions[i], startY - rowHeight);
    }
    
    textSize(TEXTSIZE); // Slightly smaller text for data
    
    displayTable4Content(columnStartXPositions);
    
 }
      // Method to retrieve the line with the highest value in the selected column
      String getHighestValueLine(int selectedColumnIndex) {
             columnValues.clear();
          for (int i = 0; i < data.getNumberOfRows(); i++) {
          // Retrieve the value from the specified column in the current row
          String value = data.getValue(i, selectedColumnIndex, false); // Assuming 'false' for not considering header
          // Add the value to the ArrayList
          columnValues.add(value);
      }
        // Find the highest value in the columnValues ArrayList
      String highestValue = "";
      int maxIndex = -1;
      for (int i = 0; i < columnValues.size(); i++) {
          String currentValue = columnValues.get(i);
          if (highestValue.isEmpty() || currentValue.compareTo(highestValue) > 0) {
              highestValue = currentValue;
              maxIndex = i;
          }
      }
      
      // If maxIndex is -1, the columnValues ArrayList is empty or contains only null values
      if (maxIndex != -1) {
          // Retrieve the entire corresponding row using the maxIndex
          highestValueRow = data.getLine(maxIndex);
      } 
          return highestValueRow;
      }
// Method to retrieve and return the remaining lines in descending order based on the values in the selected column
      String getLowestValueLine(int selectedColumnIndex) {
    columnValues.clear();
    for (int i = 0; i < data.getNumberOfRows(); i++) {
        // Retrieve the value from the specified column in the current row
        String value = data.getValue(i, selectedColumnIndex, false); // Assuming 'false' for not considering header
        // Add the value to the ArrayList
        columnValues.add(value);
    }
    // Find the lowest value in the columnValues ArrayList
    String lowestValue = "";
    int minIndex = -1;
    for (int i = 0; i < columnValues.size(); i++) {
        String currentValue = columnValues.get(i);
        if (lowestValue.isEmpty() || currentValue.compareTo(lowestValue) < 0) {
            lowestValue = currentValue;
            minIndex = i;
        }
    }
    // If minIndex is -1, the columnValues ArrayList is empty or contains only null values
    if (minIndex != -1) {
        // Retrieve the entire corresponding row using the minIndex
        lowestValueRow = data.getLine(minIndex);
    }
    return lowestValueRow;
}


void displayTable3Content(float[] columnStartXPositions) {
    // Get the highest value line
    String highestValueLine = getHighestValueLine(selectedColumnIndex);
    int numColumns = data.getNumberOfColumns();

    // Store the maximum width for each column
    float[] columnWidths = new float[numColumns];
    for (int i = 0; i < numColumns; i++) {
        columnWidths[i] = textWidth(data.table.getColumnTitle(i)) + 80;
    }

    // Display the highest value row
    String[] highestValueRowValues = highestValueLine.split(","); // Assuming CSV format
    for (int i = 0; i < numColumns; i++) {
        // Pad each value to match the maximum width of its column
        String paddedValue = padValue(highestValueRowValues[i], columnWidths[i]);
        // Use the stored x position for alignment
        text(paddedValue, columnStartXPositions[i] + padding, startY + rowHeight + 15);
    }
    
}

void displayTable4Content(float[] columnStartXPositions) {
    // Get the highest value line
    String lowestValueLine = getLowestValueLine(selectedColumnIndex);
    int numColumns = data.getNumberOfColumns();

    // Store the maximum width for each column
    float[] columnWidths = new float[numColumns];
    for (int i = 0; i < numColumns; i++) {
        columnWidths[i] = textWidth(data.table.getColumnTitle(i)) + 80;
    }

    // Display the highest value row
    String[] highestValueRowValues = lowestValueLine.split(","); // Assuming CSV format
    for (int i = 0; i < numColumns; i++) {
        // Pad each value to match the maximum width of its column
        String paddedValue = padValue(highestValueRowValues[i], columnWidths[i]);
        // Use the stored x position for alignment
        text(paddedValue, columnStartXPositions[i] + padding, startY + rowHeight + 15);
    }
    
}
// Method to pad a value to match the specified width
String padValue(String value, float width) {
    StringBuilder paddedValue = new StringBuilder(value);
    // Calculate the number of spaces needed to pad the value
    int numSpaces = (int) ((width - textWidth(value)) / textWidth(" "));
    // Append the required number of spaces to the value
    for (int i = 0; i < numSpaces; i++) {
        paddedValue.append(" ");
    }
    return paddedValue.toString();
}}
    
