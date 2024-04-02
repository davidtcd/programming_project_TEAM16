import org.gicentre.utils.gui.TextInput;
class Textbox extends Widget {
    private TextInput input;
    private int width, height;
    private color selectedColor;
    private ArrayList<String> options;
    private Dropdown dropdown;
    
    Textbox(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont font, PApplet parent, ArrayList<String> set, ArrayList<Dropdown> allDropdowns) {
        super(x, y, label, widgetColor, borderColor, labelColor, font);
        this.input = new TextInput(parent, font, 20);
        this.selectedColor = RED;
        this.width = width;
        this.height = height;
        this.options = set;
        
     //   Dropdown dropdown = new Dropdown(x, y, width, height, "", color(235), BLACK, BLACK, font, new ArrayList<String>(), index -> this.dropdownOptionChange(index), false);
        allDropdowns.add(dropdown);
        this.dropdown = dropdown;
    }
    
    public void dropdownOptionChange(Integer index) {
        if (this.dropdown.getOptions().size() > 0) {
            this.setText(this.dropdown.getOptions().get(index));
        }
    }
    
    public int getWidth() {
        return this.width;
    }
    
    public void setWidth(int width) {
        this.width = width;
    }
    
    public int getHeight() {
        return this.height;
    }
    
    public void setHeight(int height) {
        this.height = height;
    }
    
    public void keyClicked() {
        if (keyCode == BACKSPACE) {
            this.input.keyPressed();
        } else if (textWidth(this.input.getText()) < (this.getWidth() / 2) && keyCode != RETURN) {
            this.input.keyPressed();
        }
    }
    
    public String getText() {
        return this.input.getText();
    }
    
    public void setText(String text) {
        this.input.setText(text);
    }
    
    public color getSelectedColor() {
        return this.selectedColor;
    }
    
    public Dropdown getDropdown() {
        return this.dropdown;  
    }
    
    public boolean isClicked(int mX, int mY) {  
        if (mX > this.getX() && mX < this.getX() + this.getWidth() && mY > this.getY() && mY < this.getY() + this.getHeight()) {   
            return true;
        }
        return false;
    }
    
    
    ArrayList<String> getMatches(String substring, ArrayList<String> set) {
        ArrayList<String> matches = new ArrayList<String>();
        for (String str : set) {
            if (str.contains(substring)) {
                matches.add(str);
            }
        }
        return matches;
    }
    
    public void showOptions() {
        println("here0");
        // update
        this.updateOptions();
        // then show
    //    this.dropdown.toggleOpen(true);
    }
    
    public void updateOptions() {
        String text = this.getText();
        ArrayList<String> matches = this.getMatches(text, this.options);
        if (matches.size() == 0) {
            matches.add("No matches");  
        }
        
     //   this.dropdown.setOptions(matches);
    }
    
    public void hideOptions() {
        // clear options back to empty
     //   this.dropdown.setOptions(new ArrayList<String>());
       // this.dropdown.toggleOpen(false);
    }
    
    void draw(boolean isSelected) {
        color wc = this.getWidgetColor();
        color lc = this.getLabelColor();
        color bc = this.getBorderColor();
        int cur_x = this.getX();
        int cur_y = this.getY();
        int h = this.getHeight();
        int w = this.getWidth();
        color sc = this.getSelectedColor();
        String l = this.getLabel();
        
        fill(wc);
        stroke(isSelected ? sc : bc);
        strokeWeight(1);
        fill(wc);
        rect(cur_x, cur_y, w, h);
        noStroke();
        fill(lc);
        textAlign(LEFT);
        text(l, cur_x, cur_y - h / 2);
        textAlign(CENTER, CENTER);
        this.input.draw(cur_x + 5, cur_y + h / 4);
        this.dropdown.draw();
    }
}
