class Button extends Widget {
    // Lukas Maselsky, Created class, constructor, getters and setters, 5pm 13/03/2024
    
    /**
    * A clickable rectangle that triggers an event
    */
    
    private int width;
    private int height;
    private Runnable onClick;
    
    Button(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont, Runnable onClick) {
        super(x, y, label, widgetColor, borderColor, labelColor, widgetFont);
        this.width = width; 
        this.height = height;
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
    
    public Runnable getOnClick() {
        return this.onClick;
    }
    
    public void setOnClick(Runnable onClick) {
        this.onClick = onClick;
    }
    
    /**
    * Checks if button has been clicked on each mouse click
    * if true, runs the event function
    * 
    * @param mX     mouse x position
    * @param mY     mouse y position  
    */
    public void isClicked(int mX, int mY) {  
        if (mX > this.getX() && mX < this.getX() + this.getWidth() && mY > this.getY() && mY < this.getY() + this.getHeight()) { 
            this.onClick.run();
        }
    }
    
    /**
    * Checks if button has been hovered on
    * 
    * @param mX     mouse x position
    * @param mY     mouse y position  
    */
    public boolean isHovering(int mX, int mY) {  
        if (mX > this.getX() && mX < this.getX() + this.getWidth() && mY > this.getY() && mY < this.getY() + this.getHeight()) { 
            return true;
        }
        return false;
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
        textAlign(CENTER, CENTER);
        text(l, cur_x + w / 2, cur_y + h / 2);
    }
} 