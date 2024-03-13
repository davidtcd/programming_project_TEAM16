class Widget {
    // Lukas Maselsky, Created class, constructor, getters and setters, 5pm 13/03/2024
    
    private int x, y;
    private String label; 
    private int event;
    private color widgetColor, labelColor, borderColor;
    private PFont widgetFont;
    
    Widget(int x, int y, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont, int event) {
        this.x = x; 
        this.y = y; 
        this.label = label; 
        this.event = event; 
        this.widgetColor = widgetColor; 
        this.widgetFont = widgetFont;
        this.borderColor = borderColor;
        this.labelColor = labelColor;
    }
    
    public int getX() {
        return this.x;
    }
    
    public void setX(int x) {
        this.x = x;
    }
    
    public int getY() {
        return this.y;
    }
    
    public void setY(int y) {
        this.y = y;
    }
    
    public String getLabel() {
        return this.label;
    }
    
    public void setLabel(String label) {
        this.label = label;
    }
    
    public int getEvent() {
        return this.event;
    }
    
    public void setEvent(int event) {
        this.event = event;
    }
    
    public color getWidgetColor() {
        return this.widgetColor;
    }
    
    public void setWidgetColor(color widgetColor) {
        this.widgetColor = widgetColor;
    }
    
    public color getLabelColor() {
        return this.labelColor;
    }
    
    public void setLabelColor(color labelColor) {
        this.labelColor = labelColor;
    }
    
    public color getBorderColor() {
        return this.borderColor;
    }
    
    public void setBorderColor(color borderColor) {
        this.borderColor = borderColor;
    }
    
    public PFont getWidgetFont() {
        return this.widgetFont;
    }
    
    public void setWidgetFont(PFont widgetFont) {
        this.widgetFont = widgetFont;
    }
    
    void draw() {}
    
}