class Checkbox extends Widget {
    // Lukas Maselsky, Created class and methods 1pm 17/03/2024
    // Lukas Maselsky, fixed label centering and position 1pm 22/03/2024
    
    private int width;
    private int height;
    private boolean selected;
    private Runnable onClick;
    
    Checkbox(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont, Runnable onClick) {
        super(x, y, label, widgetColor, borderColor, labelColor, widgetFont);
        this.width = width; 
        this.height = height;
        this.selected = false;
        this.onClick = onClick;
        
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
    
    public Runnable getOnClick() {
        return this.onClick;
    }
    
    public void setOnClick(Runnable onClick) {
        this.onClick = onClick;
    }
    
    public void isClicked(int mX, int mY) {  
        if (mX > this.getX() && mX < this.getX() + this.getWidth() && mY > this.getY() && mY < this.getY() + this.getHeight()) { 
            this.setSelected(!this.getSelected());
            this.onClick.run();
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
        fill(lc);
        textAlign(LEFT, CENTER);
        text(l, cur_x + w + (w / 5), cur_y + h / 2);
        
        if (this.getSelected()) {
            
            // draw checkmark
            strokeWeight(2);
            stroke(0); // black
            line(cur_x + w / 10, cur_y + h / 2, cur_x + (w * 0.45), cur_y + (h * 0.85));
            line(cur_x + (w * 0.45), cur_y + (h * 0.85), cur_x + (w * 0.9), cur_y + h / 10);
        }
    }
}