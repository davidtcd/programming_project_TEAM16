import squarify.library.*;
import java.util.HashSet;
import java.util.Set;

public class TreeMapScreen extends Screen {
    // Lukas Maselsky, Created class, constructor, getters and setters, and a few methods 5pm 24/03/2024
    
    /**
    * Diagram that renders rectangles with sizes based on frequency of 
    * of item in dataset
    */
    
    private int tmX, tmY;
    private int tmW, tmH;
    private String[] labels;
    private ArrayList<SquarifyRect> rects;
    private color[] bgColors;
    private boolean isCreating;
    private int currentColumn;
    private int colCount;
    private String colName;
    private Dialog dialog;
    private int hovering; 
    Dropdown dropdown;
    
    TreeMapScreen(ArrayList<Button> allButtons, ArrayList<Dropdown> allDropdowns) {
        super();
        this.tmW = (int)(SCREENWIDTH * (0.75));
        this.tmH = (int)(SCREENHEIGHT * (0.75));
        this.tmX = (int)(SCREENWIDTH * 0.01);
        this.tmY = BARHEIGHT + 25;
        
        this.currentColumn = 0;
        this.colCount = data.getNumberOfColumns();
        createTreeMap(this.currentColumn);
        Button nextButton = new Button(this.tmW + this.tmX + 25, BARHEIGHT + 25, 150, 50, "Next", BLACK, BLACK, WHITE, font,() -> nextClick());
        Button prevButton = new Button(this.tmW + this.tmX + 25, BARHEIGHT + 95, 150, 50, "Prev", BLACK, BLACK, WHITE, font,() -> prevClick());
        allButtons.add(nextButton);
        allButtons.add(prevButton);
        this.addWidget(nextButton);
        this.addWidget(prevButton);
        this.hovering = -1;
        
        this.dialog = new Dialog(0, 0, SCREENHEIGHT / 4, SCREENHEIGHT / 4, "", WHITE, BLACK, BLACK, font);
        ArrayList<String> allLabels = new ArrayList<String>();
        
        for (int i = 0; i < this.colCount; i++) {
            allLabels.add(data.table.getColumnTitle(i));
        }
        
        this.dropdown = new Dropdown(this.tmW + this.tmX + 25, BARHEIGHT + 165, 250, 50, "", color(220), BLACK, BLACK, font, allLabels, index -> dropdownOptionChange(index), true, 6);
        this.addWidget(dropdown);
        allDropdowns.add(this.dropdown);
    }
    
    /**
    * Switches data rendered to the next column
    */
    public void nextClick() {
        int col = this.getCurrentColumn();
        if (col < this.getColCount() - 1) {
            this.setCurrentColumn(col + 1);
            this.createTreeMap(col + 1);
            this.getDropdown().setClicked(col + 1);
        } else {
            // wrap to col 0
            this.setCurrentColumn(0);
            this.createTreeMap(0);
            this.getDropdown().setClicked(0);
        }
    }
    
    /**
    * Switches data rendered to the previous column
    */
    public void prevClick() {
        int col = this.getCurrentColumn();
        if (col > 0) {
            this.setCurrentColumn(col - 1);
            this.createTreeMap(col - 1);
            this.getDropdown().setClicked(col - 1);
        } else {
            // wrap to last col
            int cols = this.getColCount() - 1;
            this.setCurrentColumn(cols);
            this.createTreeMap(cols);
            this.getDropdown().setClicked(cols);
        }  
    }
    
    /**
    * Function triggered when dropdown changes,
    * recreates treemap with new data
    * 
    * @param index      index of option in dropdown
    */
    public void dropdownOptionChange(Integer index) {
        this.setCurrentColumn(index);
        this.createTreeMap(index);
    }
    
    public int getTmX() {
        return this.tmX;
    }
    
    public void setTmX(int tmX) {
        this.tmX = tmX;
    }
    
    public int getTmY() {
        return this.tmY;
    }
    
    public void setTmY(int tmY) {
        this.tmY = tmY;
    }
    
    public int getTmW() {
        return this.tmW;
    }
    
    public void setTmW(int tmW) {
        this.tmW = tmW;
    }
    
    public int getTmH() {
        return this.tmH;
    }
    
    public void setTmH(int tmH) {
        this.tmH = tmH;
    }
    
    public boolean getIsCreating() {
        return this.isCreating;
    }
    
    public void setIsCreating(boolean isCreating) {
        this.isCreating = isCreating;
    }
    
    public int getCurrentColumn() {
        return this.currentColumn;
    }
    
    public void setCurrentColumn(int currentColumn) {
        this.currentColumn = currentColumn;
    }
    
    public String[] getLabels() {
        return this.labels;
    }
    
    public int getColCount() {
        return this.colCount;
    }
    
    public String getColName() {
        return this.colName;
    }
    
    public void setColName(String colName) {
        this.colName = colName;
    }
    
    public Dialog getDialog() {
        return this.dialog;
    }
    
    public int getHovering() {
        return this.hovering;
    }
    
    public void setHovering(int hovering) {
        this.hovering = hovering;
    }
    
    public Dropdown getDropdown() {
        return this.dropdown;
    }
    
    public void setDropdown(Dropdown dropdown) {
        this.dropdown = dropdown;
    }
    
    /**
    * Extracts rgb from color
    * 
    * @param c      color value
    * @return       float array of rgb values
    */
    public float[] extractRGB(color c) {
        int r = (c >> 16) & 0xFF;
        int g = (c >> 8) & 0xFF;
        int b = c & 0xFF;
        
        return new float[] {r, g, b};
    }
    
    
    /**
    * Creates a treemap using the Squarify library by,
    * calculating data frequency values 
    * 
    * @param columnNumber      index of column in dataset
    */
    public void createTreeMap(int columnNumber) {
        // set col name
        this.setColName(data.table.getColumnTitle(columnNumber));
        
        this.setIsCreating(true);
        
        String[] labels = data.table.getStringColumn(columnNumber);
        
        HashMap<String, Integer> freq = new HashMap<String, Integer>();
        for (String label : labels) {
            freq.compute(label,(k, v) -> (v == null) ? 1 : v + 1);
        }
        
        // get unique labels
        Set<String> keys = freq.keySet();
        this.labels = keys.toArray(new String[keys.size()]);
        
        ArrayList<Float> values = new ArrayList<Float>();
        color[] bgColors = new color[labels.length];
        int i = 0;
        for (Integer value : freq.values()) {
            float floatValue = value.floatValue(); // Convert Integer to float
            values.add(floatValue);
            bgColors[i] = color((int) random(0, 255),(int) random(0, 255),(int) random(0, 255));
            i++;
        }
        this.bgColors = bgColors;
        
        Squarify square = new Squarify(values, this.tmX, this.tmY, this.tmW, this.tmH);
        this.rects = square.getRects();
        this.setIsCreating(false);
        
    }
    
    /**
    * Checks if mouse is over a rectangle in 
    * treemap when mouse moves and displays dialog
    * 
    * @param mX     mouse x position
    * @param mY     mouse y position  
    */
    public void isHovering(int mX, int mY) {
        if (!this.getIsCreating()) {
            for (int i = 0; i < rects.size(); i++) {
                SquarifyRect r = rects.get(i);
                float rx = r.getX();
                float ry = r.getY();
                float rw = r.getDx();
                float rh = r.getDy();
                if (mX > rx && mX < rx + rw && mY > ry && mY < ry + rh) { 
                    // is hovering on this rect
                    this.setHovering(i);
                    return;
                }
            }
            // no rect being hovered
            this.setHovering( -1);
        }
    }
    
    void draw() {
        // column name
        fill(BLACK);
        textAlign(LEFT);
        textSize(20);
        text(this.getColName(), this.tmW + this.tmX + 25, BARHEIGHT + 250);
        textSize(12);
        textAlign(CENTER);
        
        // draw widgets
        textSize(16);
        for (int i = 0; i < this.getWidgets().size(); i++) {
            this.getWidgets().get(i).draw();  
        }
        textSize(12);
        
        // draw treemap
        stroke(0);
        
        
        if (!this.getIsCreating()) { // don't draw when recreating treemap
            for (int i = 0; i < rects.size(); i++) {
                SquarifyRect r = rects.get(i);
                
                fill(this.bgColors[i]); // rectangle color
                
                rect(r.getX(), r.getY(), r.getDx(), r.getDy());
                float[] rgb = extractRGB(this.bgColors[i]);
                
                int brightness = Math.round((((int) rgb[0]) * 299 + ((int) rgb[1]) * 587 + ((int) rgb[2]) * 114) / 1000);
                color textColor = brightness > 125 ? color(0) : color(255);
                
                if (r.getDx() > (SCREENWIDTH * 0.03)) {
                    textAlign(CENTER, CENTER);
                    fill(textColor); // label color
                    text(this.getLabels()[r.getId()] + ": " + round(r.getValue()), r.getX() + r.getDx() / 2, r.getY() + r.getDy() / 2);
                }
            }
        }
        
        // hovering
        
        int hoveringRectIndex = this.getHovering();
        
        if (hoveringRectIndex >= 0) {
            Dialog d = this.getDialog();
            SquarifyRect rect = rects.get(hoveringRectIndex);
            d.setX((int)(mouseX - (d.getWidth() / 2)));
            d.setY((int)(mouseY - d.getHeight()));
            d.setLabel("" + this.getLabels()[rect.getId()] + ": " + round(rect.getValue()));
            d.draw();
        }
    }
}
