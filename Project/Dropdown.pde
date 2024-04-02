import java.util.function.Consumer;

class Dropdown extends Widget {
    // Lukas Maselsky, Created class, constructor, getters and setters, and a few methods 5pm 14/03/2024
    // Lukas Maselsky, Created more methods for openening and selecting options 1pm 17/03/2024
    // Lukas Maselsky, Created consumer 12pm 26/03/2024
    
    // HOW TO OPERATE: you pass in a function int this format when constructing a dropdown: 
    // new Dropdown(x, y, whatever...., index -> myFunc(index));
    // myFunc is a function that take an Integer like this:
    // void myFunc(Integer index) {}, so when you click an option the function is called with the option index, so option 1 is 0, option 2 is 1 and so on
    // the function then does whatever you want based on the index
    
    private int width;
    private int height;
    private boolean open;
    private int selected; // index of selected option, starting at 0
    private ArrayList<String> options; // array of options
    private Scrollbar scrollbar;
    final int OPTION_VISIBLE_COUNT = 3;
    private int offset; 
    private String[] visibleOptions;
    Consumer<Integer> optionClick;
    private boolean isNormal;
    private int scrollbarWidth;
    private int scrollbarHeight;
    private int scrollbarX;
    private int scrollbarY;
    
    Dropdown(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont, ArrayList<String> options, Consumer<Integer> optionClick, boolean isNormal) {
        super(x, y, label, widgetColor, borderColor, labelColor, widgetFont);
        this.width = width; 
        this.height = height;
        this.open = false;
        this.selected = 0;
        this.offset = 0;
        this.options = options;
        this.optionClick = optionClick;
        this.isNormal = isNormal;
        // initialise label as first option
        this.setLabel(options.size() > 0 ? options.get(0) : "");
        
        this.visibleOptions = new String[OPTION_VISIBLE_COUNT];
        for (int i = 0; i < (this.isNormal ? OPTION_VISIBLE_COUNT : 0); i++) {
            this.visibleOptions[i] = options.get(i); 
        }
        
        // scrollbar
        this.scrollbarWidth = width / 10; //! not concrete 
        this.scrollbarHeight = height * (OPTION_VISIBLE_COUNT); 
        this.scrollbarX = x + width - scrollbarWidth;
        this.scrollbarY = y + height + 1; // + 1 for border bottom
        
        this.setupScrollbar();
    }
    
    void setupScrollbar() {
        double fraction = (double) this.OPTION_VISIBLE_COUNT / (double) this.getOptions().size();
        this.scrollbar = new Scrollbar(this.scrollbarX, this.scrollbarY, this.scrollbarWidth, this.scrollbarHeight, "", this.getWidgetColor(), color(0, 0 , 0), this.getWidgetFont(), fraction);
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
    
    public boolean getOpen() {
        return this.open;
    }
    
    public void setOpen(boolean open) {
        this.open = open;
    }
    
    public void toggleOpen(boolean open) {
        // only needed for textbox class
        this.visibleOptions = new String[OPTION_VISIBLE_COUNT];
        if (this.getOptions().size() != 0) {
            for (int i = 0; i < OPTION_VISIBLE_COUNT; i++) {
                this.visibleOptions[i] = this.getOptions().get(i); 
            }
        }
        
        this.setupScrollbar();
        this.setOpen(open);
    }
    
    public String[] getVisibleOptions() {
        return this.visibleOptions;
    }
    
    public void setVisibleOptions(String[] visibleOptions) {
        this.visibleOptions = visibleOptions;
    }
    
    public int getSelected() {
        return this.selected;
    }
    
    public void setSelected(int selected) {
        this.selected = selected;
    }
    
    public ArrayList<String> getOptions() {
        return this.options;
    }
    
    public void setOptions(ArrayList<String> options) {
        this.options = options;
    }
    
    public String getOption(String text) {
        for (String option : options) {
            if (option.equals(text)) {
                return option;
            }
        }
        return "";
    } 
    
    public void addOption(String option) {
        this.options.add(option);
    }
    
    public void removeOption(String opt) {
        for (int i = 0; i < this.options.size(); i++) {
            if (this.options.get(i).equals(opt)) {
                this.options.remove(i);
                break;
            }
        }
    }
    
    public void removeOption(int index) {
        if (index < this.options.size()) {
            this.options.remove(index);
        }
    }
    
    public Scrollbar getScrollbar() {
        return this.scrollbar;
    }
    
    public boolean getIsNormal() {
        return this.isNormal;
    }
    
    public void setNormal(boolean isNormal) {
        this.isNormal = isNormal;
    }
    
    public void isClicked(int mX, int mY) { 
        if (this.getIsNormal()) { 
            if (mX > this.getX() && mX < this.getX() + this.getWidth() && mY > this.getY() && mY < this.getY() + this.getHeight()) { 
                this.setOpen(!(this.getOpen()));
            }
        }
    }
    
    public void optionIsClicked(int index, int mX, int mY) {
        // prevent clicking scrollbar from being registered as selecting option
        if (this.getOpen()) {
            int margin = this.getOptions().size() > OPTION_VISIBLE_COUNT ? this.getScrollbar().getWidth() : 0;
            
            if (mX > this.getX() && mX < this.getX() + this.getWidth() - margin && mY > (this.getY() + (index + 1) * this.getHeight()) && mY < this.getY() + ((index + 2) * this.getHeight())) {
                this.setSelected(index + this.getOffset());
                // update label
                this.setLabel(this.getVisibleOptions()[index]);
                // call consumer function
                this.optionClick.accept(index + this.getOffset());
            }
        }
    }
    
    public void setClicked(Integer index) {
        this.setSelected(index + this.getOffset());
        // update label
        this.setLabel(this.getOptions().get(index));
        // call consumer function
        this.optionClick.accept(index);
    }
    
    public int getOffset() {
        return this.offset;
    }
    
    public void setOffset(int offset) {
        this.offset = offset;
    }
    
    public color getLighterColor(color c, float increase) {
        // increase lightness of colour, 0 < increase < 100
        float[] rgb = extractRGB(c);
        float[] hsv = rgbTohsv(rgb[0], rgb[1], rgb[2]);
        float s = hsv[1];
        float v = hsv[2];
        v = v * (float) 100;
        s = s * (float) 100;
        
        // first increase lightness, then saturation if maxed
        float newV;
        float newS = s;
        if (v + increase < 100) {
            newV = v + increase;
        } else {
            
            newV = 100;
            float diff = (float) 100 - v;
            diff = increase - diff;
            newS = s - diff > 0 ? s - diff : 0; 
            newS = newS / (float) 100;
        }
        newV = newV / (float) 100;
        
        float[] newrgb = hsvTorgb(hsv[0], newS, newV);
        color rgbCol = color(Math.round(newrgb[0]), Math.round(newrgb[1]), Math.round(newrgb[2]));
        return rgbCol;
    }
    
    public float[] extractRGB(color c) {
        int r = (c >> 16) & 0xFF;
        int g = (c >> 8) & 0xFF;
        int b = c & 0xFF;
        
        return new float[] {r, g, b};
    }
    
    public float[] rgbTohsv(float r, float g, float b) {
        float rDash = (float) r / (float) 255;
        float gDash = (float) g / (float) 255;
        float bDash = (float) b / (float) 255;
        float Cmax = bDash > (rDash > gDash ? rDash : gDash) ? bDash : ((rDash > gDash) ? rDash : gDash);
        float Cmin = bDash < (rDash < gDash ? rDash : gDash) ? bDash : ((rDash < gDash) ? rDash : gDash);
        float delta = Cmax - Cmin;
        
        float h;
        
        if (delta == 0) {
            h = 0;  
        } else {
            if (Cmax == rDash) {
                h = 60 * (((gDash - bDash) / delta) % 6);  
            } else if (Cmax == gDash) {
                h = 60 * (((bDash - rDash) / delta) + 2);                
            } else {
                h = 60 * (((rDash - gDash) / delta) + 4); 
            }
        }
        
        float s = Cmax == 0.0 ? 0 : (delta / Cmax);
        float v = Cmax;
        
        return new float[] {h, s, v};
    }
    
    public float[] hsvTorgb(float h, float s, float v) {
        float c = v * s;
        float x = c * (1 - Math.abs(((h / 60.0) % 2) - 1));
        float m = v - c;
        
        float rDash, gDash, bDash;
        if (h >= 0 && h < 60) {
            rDash = c;
            gDash = x;
            bDash = 0;
        } else if (h >= 60 && h < 120) {
            rDash = x;
            gDash = c;
            bDash = 0;
        } else if (h >= 120 && h < 180) {
            rDash = 0;
            gDash = c;
            bDash = x;
        } else if (h >= 180 && h < 240) {
            rDash = 0;
            gDash = x;
            bDash = c; 
        } else if (h >= 240 && h < 300) {
            rDash = x;
            gDash = 0;
            bDash = c;
        } else {
            rDash = c;
            gDash = 0;
            bDash = x;
        }  
        
        float r = (rDash + m) * (float) 255;
        float g = (gDash + m) * (float) 255;
        float b = (bDash + m) * (float) 255;
        
        return new float[] {r, g, b};  
    }  
    
    public void updateVisibleOptions() {
        int value = this.getScrollbar().getValue();
        int diff = this.getOptions().size() - OPTION_VISIBLE_COUNT; // will be >= 1
        
        int divisions = 100 / (diff + 1); // e.g for 5 options => 2 offscreen => divisions are at 50 and 100
        
        for (int i = 0; i < diff + 1; i++) {
            if (value > divisions * i && value <= divisions * (i + 1)) {
                this.setOffset(i);
                for (int j = 0; j < OPTION_VISIBLE_COUNT; j++) {
                    this.visibleOptions[j] = options.get(i + j); 
                }
            }
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
        ArrayList<String> opts = this.getOptions();
        
        // main dropdown button
        noStroke();
        textAlign(CENTER, CENTER);
        if (this.getIsNormal()) {
            fill(wc); 
            rect(cur_x, cur_y, w, h);
            fill(lc);
            text(l, cur_x + w / 2, cur_y + h / 2);
        }
        
        // check if open
        if (this.getOpen()) {
            // black border bottom
            fill(color(0));
            rect(cur_x, cur_y + h, w, 1);
            
            // limit to X options visible at a time
            int limit = opts.size() < OPTION_VISIBLE_COUNT ? opts.size() : OPTION_VISIBLE_COUNT;
            
            for (int i = 0; i < limit; i++) {
                // draw each visible option
                
                // draw stroke if selected
                if (this.getSelected() == i + this.getOffset()) {
                    fill(getLighterColor(wc, 40));
                } else {
                    fill(wc);
                }
                
                rect(cur_x, cur_y + (h * (i + 1) + 1), w, h);
                fill(lc);
                textAlign(CENTER, CENTER);
                text(this.getVisibleOptions()[i], cur_x + w / 2, cur_y + (h / 2) + (h * (i + 1) + 1));
            }
            
            // draw scrollbar
            if (opts.size() > OPTION_VISIBLE_COUNT) {
                scrollbar.draw();
                this.updateVisibleOptions();
            }
        }
    }
    
}
