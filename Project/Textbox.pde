import org.gicentre.utils.gui.TextInput;
class Textbox extends Widget {
    private TextInput input;
    private int width, height;
    private color selectedColor;
    
    Textbox(int x, int y, int width, int height, color widgetColor, color borderColor, color labelColor, PFont font, PApplet parent) {
        super(x, y, "", widgetColor, borderColor, labelColor, font);
        this.input = new TextInput(parent, font, 20);
        this.selectedColor = RED;
        
    }
    
    public void keyClicked() {
        this.input.keyPressed();
    }
    
    public String getText() {
        return this.input.getText();
    }
    
    public color getSelectedColor() {
        return this.selectedColor;
    }
    
    public boolean isClicked(int mX, int mY) {  
        if (mX > this.getX() && mX < this.getX() + this.getWidth() && mY > this.getY() && mY < this.getY() + this.getHeight()) { 
            return true;
        }
        return false;
    }
    
    void draw() {
        
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
        
        
        stroke(isSelected ? sc : wc);
        strokeWeight(1);
        fill(wc);
        rect(cur_x, cur_y, w, h);
        noStroke();
        fill(lc);
        this.input.draw(cur_x, cur_y);
    }
}