class Checkbox extends Widget {
    // Lukas Maselsky, Created class and methods 1pm 17/03/2024
    
    private int width;
    private int height;
    private boolean selected;
    
    Checkbox(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont, int event) {
        super(x, y, label, widgetColor, borderColor, labelColor, widgetFont, event);
        this.width = width; 
        this.height = height;
        this.selected = false;
        
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
    
    public boolean getSelected() {
        return this.selected;
    }
    
    public void setSelected(boolean selected) {
        this.selected = selected;
    }
    
    public void isClicked(int mX, int mY) {  
        if (mX > this.getX() && mX < this.getX() + this.getWidth() && mY > this.getY() && mY < this.getY() + this.getHeight()) { 
            this.setSelected(!this.getSelected());
        }
    }
    
    void draw() {
        color wc = this.getWidgetColor();
        color lc = this.getLabelColor();
        color bc = this.getBorderColor();
        int cur_x = this.getX();
        int cur_y = this.getY();
        int h = this.getHeight();
        int w = this.getWidth();
        String l = this.getLabel(); 
        
        noStroke();
        fill(wc); 
        rect(cur_x, cur_y, w, h);
        
        if (this.getSelected()) {
            int h = this.getHeight();
            int w = this.getWidth();
            // draw checkmark
            strokeWeight(2);
            stroke(0); // black
            line(cur_x + w / 10, cur_y + h / 2, cur_x + w / 2, cur_y + (h * 0.85));
            line(cur_x + w / 2, cur_y + (h * 0.85), cur_x + (w * 0.9), cur_y + h / 10);
        }
    }
}