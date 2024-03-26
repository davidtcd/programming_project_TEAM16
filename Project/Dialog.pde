class Dialog extends Widget {
    private int width, height;
    
    Dialog(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont) {
        super(x, y, label, widgetColor, borderColor, labelColor, widgetFont);
        this.width = width; 
        this.height = height;
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
    
    void draw() {
        color wc = this.getWidgetColor();
        color lc = this.getLabelColor();
        color bc = this.getBorderColor();
        int cur_x = this.getX();
        int cur_y = this.getY();
        int h = this.getHeight();
        int w = this.getWidth();
        String l = this.getLabel();
        
        fill(wc);
        rect(cur_x, cur_y, w, h);
        textAlign(CENTER, CENTER);
        fill(lc);
        textSize(w / 15);
        text(l, cur_x + w / 2, cur_y + h / 2);
        textSize(12);
    }
}
