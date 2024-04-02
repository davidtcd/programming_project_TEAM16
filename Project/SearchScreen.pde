import java.util.*;

class SearchScreen extends Screen {
    // Lukas Maselsky, Created class, constructor, getters and setters, and a few methods 5pm 30/03/2024
    
    /**
    * Creates a screen with a text box for each column in the dataset
    * On click of the search button, a query is run on the data and
    * a result is returned of each row that matches the text inputs
    * The results are then displayed, with buttons to toggle which
    * slice of the results are being drawn to the screen
    */
    
    
    private ArrayList<HashSet<String>> uniques;
    private ArrayList<Textbox> textboxes;
    private int colCount;
    private int selectedTextbox;
    private ArrayList<String> results;
    private int resultsCount;
    final int VISIBLE_ROWS = 10;
    private int startIndex;
    private int currentPage;
    
    SearchScreen(ArrayList<Dropdown> allDropdowns, ArrayList<Button> allButtons, PFont font, PApplet parent) {
        this.colCount = data.getNumberOfColumns();
        this.textboxes = new ArrayList<Textbox>();
        this.selectedTextbox = -1; // -1 = none selected
        this.uniques = new ArrayList<HashSet<String>>();
        this.results = new ArrayList<String>();
        this.startIndex = 0;
        this.currentPage = 1;
        this.resultsCount = 0;
        
        
        
        ArrayList<String> allLabels = new ArrayList<String>();
        for (int i = 0; i < this.colCount; i++) {
            allLabels.add(data.table.getColumnTitle(i));
        }
        
        // get unique values in each column
        this.buildUniques(this.colCount);
        
        // textboxes
        for (int i = 0; i < this.colCount / 2; i++) {
            this.textboxes.add(new Textbox(50 + i * 205, 150, 200, 50, allLabels.get(i), WHITE, BLACK, BLACK, font, parent, convertToArrayList(uniques.get(i)), allDropdowns));
        }
        int j = 0;
        for (int i = this.colCount / 2; i < this.colCount; i++) {    
            this.textboxes.add(new Textbox(50 + j * 205, 250, 200, 50, allLabels.get(i),WHITE, BLACK, BLACK, font, parent, convertToArrayList(uniques.get(i)), allDropdowns));
            j++;
        }
        
        // buttons
        Button sb = new Button(45, 300, 200, 50, "Search", color(230), BLACK, BLACK, font,() -> this.searchClick());
        this.getWidgets().add(sb);
        allButtons.add(sb);
        Button prev = new Button(270, 300, 50, 50, "<", color(230), BLACK, BLACK, font,() -> this.prevClick());
        this.getWidgets().add(prev);
        allButtons.add(prev);
        Button next = new Button(330, 300, 50, 50, ">", color(230), BLACK, BLACK, font,() -> this.nextClick());
        this.getWidgets().add(next);
        allButtons.add(next);
    }
    
    ArrayList<String> convertToArrayList(HashSet<String> set) {
        ArrayList<String> arr = new ArrayList<String>();
        for (String str : set) {
            arr.add(str);
        }
        return arr;
    }
    
    /**
    * Calls the buildTable function which returns a hashs set of all the indexes
    * that match the search query
    * The returns are iterated through and the row of the dataset that has each index 
    * is added to the results arraylist
    */
    void searchClick() {
        HashSet<Integer> indexes = buildTable(); 
        
        // first clear previous results
        this.startIndex = 0;
        this.currentPage = 1;
        this.results = new ArrayList<String>();
        for (Integer index : indexes) {
            this.results.add(data.getLine(index));  
        }
        this.resultsCount = this.results.size();
        
    }
    
    /**
    * Increases the start index of the results, which is used to then 
    * change which data is drawn on the screen
    */
    void nextClick() {
        int i = this.startIndex;
        if (i < resultsCount - this.VISIBLE_ROWS) {
            this.startIndex = i + this.VISIBLE_ROWS;
            this.currentPage = this.currentPage + 1;
        } else {
            this.startIndex = 0;
            this.currentPage = 1;
        }
    }
    
    /**
    * Decreases the start index of the results, which is used to then 
    * change which data is drawn on the screen
    */
    void prevClick() {
        int i = this.startIndex;
        if (i >= this.VISIBLE_ROWS) {
            this.startIndex = i - this.VISIBLE_ROWS;
            this.currentPage = this.currentPage - 1;
        } else {  
            this.currentPage = Math.round((float) this.resultsCount / (float) this.VISIBLE_ROWS);
            this.startIndex = this.resultsCount - (this.resultsCount % this.VISIBLE_ROWS);  
        }
    }
    
    /**
    * Creates an arraylist of hashsets that contain each unique
    * values in each column of the data, used in the query to check
    * if a text input matches anything in the column
    * @param labels    headers of each column
    */
    void buildUniques(int colCount) {
        for (int i = 0; i < colCount; i++) {
            String[] values = data.table.getStringColumn(i); 
            HashSet<String> unique = new HashSet<String>();
            for (String value : values) {
                unique.add(value);
            }
            this.uniques.add(unique);
        }
    }
    
    
    /**
    * Fills the a hash set of every index in the dataset
    *
    * @return HashSet<Integer>     hash set of each index
    */
    HashSet<Integer> fillSet() {
        HashSet<Integer> set = new HashSet<Integer>();
        for (int i = 0; i < data.getNumberOfRows(); i++) {
            set.add(i);
        }
        return set;
    }
    
    
    /**
    * Iterates through a hashset and checking if each value contains the substring
    * 
    * @param substring     string value
    * @param set           hash set of strings
    * @return              true if substring present in set           
    */
    boolean isSubstringPresent(String substring, HashSet<String> set) {
        for (String str : set) {
            if (str.contains(substring)) {
                return true;
            }
        }
        return false;
    }
    
    /**
    * Iterates through each column in the data
    * for each column, builds a hash set that contains every index
    * that matches the input for that column
    * On each iteration, checks the previous set for overlapping index, 
    * else it discards the index     
    * 
    * @return              hash set of indexes that match all inputs           
    */
    HashSet<Integer> buildTable() {
        HashSet<Integer> rowIndexes = new HashSet<Integer>();
        for (int i = 0; i < this.colCount; i++) {
            String textinput = this.getTextboxes().get(i).getText(); //<>//
            if (textinput.equals("")) {
                // if input string is empty
                if (i == 0) {
                    // first column has not text input, make hash set of every row
                    rowIndexes = fillSet();
                    continue;
                } else {
                    continue;  
                }
            }
            
            
            if (!(this.isSubstringPresent(textinput, this.uniques.get(i)))) {
                // if textinput is "invalid"
                break;  
            }
            
            
            String[] column = data.table.getStringColumn(i);
            HashSet<Integer> newIndexes = new HashSet<Integer>();
            for (int j = 0; j < column.length; j++) {
                String value = column[j];
                if (value.contains(textinput)) {
                    if (i == 0) {
                        //on first column, just populate set
                        newIndexes.add(j);
                    } else {
                        //on other columns, crosscheck with previous set and add only if also in previous set
                        if (rowIndexes.contains(j)) {
                            newIndexes.add(j);                  
                        }
                    }
                }
            }
            rowIndexes = newIndexes;
        }
        return rowIndexes;
    }
    
    /**
    * Calls the keyClicked method on the textbox that is selected
    * if a key is pressed          
    */
    public void keyClick() {
        if (this.getSelectedTextbox() >= 0) {
            int index = this.getSelectedTextbox();
            Textbox textbox = this.getTextboxes().get(index);
            
            textbox.keyClicked();
            if (textbox.getText().length() == 0) {
                // hide options
                textbox.hideOptions();
            } else if (textbox.getText().length() == 1) {
                // show options
                textbox.showOptions();
            } else {
                // update options
                textbox.updateOptions();
            }
            
        }
    }
    
    public ArrayList<Textbox> getTextboxes() {
        return this.textboxes;
    }
    
    public void setTextboxes(ArrayList<Textbox> textboxes) {
        this.textboxes = textboxes;
    }
    
    public int getSelectedTextbox() {
        return this.selectedTextbox;
    }
    
    public void setSelectedTextbox(int selectedTextbox) {
        this.selectedTextbox = selectedTextbox;
    }
    
    /**
    * Checks if a text box has been clicked on each mouse click
    * if true, sets the selected textbox integer to the textbox index   
    * 
    * @param mX     mouse x position
    * @param mY     mouse y position  
    */
    public void isClicked(int mX, int mY) {
        ArrayList<Textbox> textboxes = this.getTextboxes();
        for (int i = 0; i < textboxes.size(); i++) {
            Textbox textbox = textboxes.get(i);
            if (textbox.isClicked(mX, mY)) {
                if (this.getSelectedTextbox() == i) {
                    textbox.dropdown.setOpen(false);
                    this.setSelectedTextbox( -1);
                } else {
                    textbox.dropdown.setOpen(true);
                    this.setSelectedTextbox(i);
                }
                return;
            }
        }
    }
    
    void draw() {
        textSize(16);
        for (int i = 0; i < this.getWidgets().size(); i++) {
            this.getWidgets().get(i).draw();  
        }
        
        fill(BLACK);
        textAlign(LEFT);
        int totalPages = Math.round((float) this.resultsCount / (float) this.VISIBLE_ROWS);
        text("Page " + this.currentPage + (totalPages > 0 ? "/" + totalPages : ""), 400, 330);
        text("Returned " + this.resultsCount + " rows", 500, 330);
        textSize(12);
        
        ArrayList<String> res = this.results;
        textSize(30);
        int j = 0;
        for (int i = startIndex; i < this.results.size(); i++) {
            text(res.get(i), 50, 400 + j * 30);
            j++;
            if (j >= this.VISIBLE_ROWS) break;
        }
        textAlign(CENTER, CENTER);
        
        textSize(12);
        ArrayList<Textbox> textboxes = this.getTextboxes();
        int selected = this.getSelectedTextbox();
        for (int i = 0; i < textboxes.size(); i++) {
            if (!(selected == i)) {
                Textbox textbox = textboxes.get(i);
                textbox.draw(false);
            }
        }
        
        // draw selected textbox last
        if (selected != -1) {
            Textbox textbox = textboxes.get(selected);
            textbox.draw(true);
        }
    }
}
