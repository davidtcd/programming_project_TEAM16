class SearchScreen extends Screen {
    private ArrayList<Dropdown> dropdowns;
    private ArrayList<String[]> uniques;
    private ArrayList<Textbox> textboxes;
    private int colCount;
    private int selectedTextbox;
    
    SearchScreen(ArrayList<Dropdown> allDropdowns, PFont font, PApplet parent) {
        this.colCount = data.getNumberOfColumns();
        this.textboxes = new ArrayList<Textbox>();
        this.selectedTextbox = -1; // -1 = none selected
        
        for (int i = 0; i < this.colCount; i++) {
            this.textboxes.add(new Textbox(100, 200 + i * 100, 50, 200, WHITE, BLACK, BLACK, font, parent));
        }
        
    }
    
    public void buildTable() {
        
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
    }
    
}