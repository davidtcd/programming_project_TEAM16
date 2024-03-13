class Button extends Widget {
    // Lukas Maselsky, Created class, constructor, getters and setters, 5pm 13/03/2024
    
    private int width;
    private int height;
    
    Button(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont, int event) {
        super(x, y, label, widgetColor, borderColor, labelColor, widgetFont, event);
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
    
    void draw() {}
} 