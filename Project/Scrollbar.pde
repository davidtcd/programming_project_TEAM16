class Scrollbar extends Widget {
    // Lukas Maselsky, Created class, constructor, getters and setters, and a few methods 5pm 14/03/2024
    // Lukas Maselsky, Added variable scroll slider height 1pm 17/03/2024
    
    /**
    * Bar that can be dragged and tracks position relative to start
    */
    
    private int value;
    private int initialX; 
    private int initialY;
    private int width; 
    private int height;
    private color sliderColor;
    private boolean selected;
    private int sliderHeight;
    private double fraction;
    
    
    Scrollbar(int x, int y, int width, int height, String label, color widgetColor, color sliderColor, PFont widgetFont, double fraction) 
    {
        super(x, y, label, widgetColor, color(0,0,0), color(0, 0, 0), widgetFont);
        
        this.selected = false;
        this.width = width;
        this.height = height;
        this.initialX = x;
        this.initialY = y;
        this.sliderColor = sliderColor;
        
        
        this.fraction = fraction;
        this.sliderHeight = (int)(height * this.fraction);
    }
    
    public int getValue() {
        return this.value;
    }
    
    public void setValue(int value) {
        this.value = value;
    }
    
    public int getInitialX() {
        return this.initialX;
    }
    
    public void setInitialX(int initialX) {
        this.initialX = initialX;
    }
    
    public int getInitialY() {
        return this.initialY;
    }
    
    public void setInitialY(int initialY) {
        this.initialY = initialY;
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
    
    public color getSliderColor() {
        return this.sliderColor;
    }
    
    public void setSliderColor(color sliderColor) {
        this.sliderColor = sliderColor;
    }
    
    public boolean isSelected() {
        return this.selected;
    }
    
    public boolean getSelected() {
        return this.selected;
    }
    
    public void setSelected(boolean selected) {
        this.selected = selected;
    }
    
    public int getSliderHeight() {
        return this.sliderHeight;
    }
    
    public void setSliderHeight(int sliderHeight) {
        this.sliderHeight = sliderHeight;
    }
    
    public double getFraction() {
        return this.fraction;
    }
    
    void draw() {
        noStroke();
        fill(this.getWidgetColor());
        rect(this.getInitialX(), this.getInitialY(), this.getWidth(), this.getHeight());
        
        fill(this.getSliderColor());
        rect(this.getX(), this.getY(), this.getWidth(), this.getSliderHeight()); 
    }
    
    /**
    * Toggles if bar is selected to opposite value
    */
    public void toggleSelected() {
        this.setSelected(!this.getSelected());
    }
    
    /**
    * Toggles selection if bar is clicked
    *
    * @param mX     mouse x position
    * @param mY     mouse y position  
    */
    public void getClicked(int mX, int mY) {       
        if (mX > this.getX() && mX < this.getX() + this.getWidth() && mY > this.getY() && mY < this.getY() + this.getSliderHeight()) {
            toggleSelected();
        }
    }
    
    /**
    * Toggles selection if bar is released
    *
    */
    public void getReleased() {
        if (this.getSelected()) {
            toggleSelected();
        }
    }
    
    /**
    * Calculates position change of scrollbar on mouse drag and updates value
    *
    * @param mX     mouse x position
    * @param mY     mouse y position  
    */
    public void getDragged(int mY, int pY) {
        if (this.getSelected()) {
            int change = mY - pY;
            if (this.getY() + change > this.getInitialY() + this.getHeight() - this.getSliderHeight()) {
                this.setY(this.getInitialY() + this.getHeight() - this.getSliderHeight());
            } else if (this.getY() + change < this.getInitialY()) {
                this.setY(this.getInitialY());
            } else {
                this.setY(this.getY() + change);
            }
            // calculate value
            double pos = this.getY() - this.getInitialY();
            double val = (pos / (this.getHeight() - this.getSliderHeight())) * 100;
            this.setValue((int) val);
        }
    }
}