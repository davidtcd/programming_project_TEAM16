import java.util.*;

class SearchScreen extends Screen {
    // Lukas Maselsky, Created class, constructor, getters and setters, and a few methods 5pm 30/03/2024
    
    private ArrayList<Dropdown> dropdowns;
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
        
        // textboxes
        ArrayList<String> allLabels = new ArrayList<String>();
        for (int i = 0; i < this.colCount; i++) {
            allLabels.add(data.table.getColumnTitle(i));
        }
        
        for (int i = 0; i < this.colCount / 2; i++) {
            this.textboxes.add(new Textbox(50 + i * 205, 150, 200, 50, allLabels.get(i), WHITE, BLACK, BLACK, font, parent));
        }
        int j = 0;
        for (int i = this.colCount / 2; i < this.colCount; i++) {    
            this.textboxes.add(new Textbox(50 + j * 205, 250, 200, 50, allLabels.get(i),WHITE, BLACK, BLACK, font, parent));
            j++;
        }
        // get unique values in each column
        this.buildUniques();
        
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
    
    void buildUniques() {
        for (int i = 0; i < this.getTextboxes().size(); i++) {
            String[] labels = data.table.getStringColumn(i); 
            HashSet<String> unique = new HashSet<String>();
            for (String label : labels) {
                unique.add(label);
            }
            this.uniques.add(unique);
        }
    }
    
    HashSet<Integer> fillSet() {
        HashSet<Integer> set = new HashSet<Integer>();
        for (int i = 0; i < data.getNumberOfRows(); i++) {
            set.add(i);
        }
        return set;
    }
    
    boolean isSubstringPresent(String substring, HashSet<String> set) {
        for (String str : set) {
            if (str.contains(substring)) {
                return true;
            }
        }
        return false;
    }
    
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
    
    public void keyClick() {
        
        if (this.getSelectedTextbox() >= 0) {
            Textbox textbox = this.getTextboxes().get(this.getSelectedTextbox());
            textbox.keyClicked();
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
    
    public void isClicked(int mX, int mY) {
        ArrayList<Textbox> textboxes = this.getTextboxes();
        for (int i = 0; i < textboxes.size(); i++) {
            Textbox textbox = textboxes.get(i);
            if (textbox.isClicked(mX, mY)) {
                this.setSelectedTextbox(i);
                break;
            }
        }
    }
    
    void draw() {
        ArrayList<Textbox> textboxes = this.getTextboxes();
        for (int i = 0; i < textboxes.size(); i++) {
            Textbox textbox = textboxes.get(i);
            textbox.draw(this.getSelectedTextbox() == i);
        }
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
    }
    
}
