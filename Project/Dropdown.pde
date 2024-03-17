class Dropdown extends Widget {
    // Lukas Maselsky, Created class, constructor, getters and setters, and a few methods 5pm 14/03/2024
    // Lukas Maselsky, Created more methods for openening and selecting options 1pm 17/03/2024
    
    // each option is same height as dropdown button
    private int width;
    private int height;
    private boolean open;
    private int selected; // index of selected option, starting at 0
    private ArrayList<String> options; // array of options
    private Scrollbar scrollbar;
    final int OPTION_VISIBLE_COUNT = 3;
    private int offset; 
    private String[] visibleOptions;
    
    
    Dropdown(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont, ArrayList<String> options, int event, int scrollbarEvent) {
        super(x, y, label, widgetColor, borderColor, labelColor, widgetFont, event);
        this.width = width; 
        this.height = height;
        this.open = false;
        this.selected = 0;
        this.offset = 0;
        this.options = options;
        // initialise label as first option
        this.setLabel(options.get(0));
        
        this.visibleOptions = new String[OPTION_VISIBLE_COUNT];
        for (int i = 0; i < OPTION_VISIBLE_COUNT; i++) {
            this.visibleOptions[i] = options.get(i); 
        }
        
        // scrollbar
        int scrollbarWidth = width / 10; //! not concrete 
        int scrollbarHeight = height * (OPTION_VISIBLE_COUNT); 
        int scrollbarX = x + width - scrollbarWidth;
        int scrollbarY = y + height;
        
        double fraction = (double) OPTION_VISIBLE_COUNT / (double) options.size();
        this.scrollbar = new Scrollbar(scrollbarX, scrollbarY, scrollbarWidth, scrollbarHeight, "", widgetColor, color(0, 0 , 0), widgetFont, scrollbarEvent, fraction);
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
    
    public boolean isClicked(int mX, int mY) {  
        if (mX > this.getX() && mX < this.getX() + this.getWidth() && mY > this.getY() && mY < this.getY() + this.getHeight()) { 
            return true;
        }
        return false;
    }
    
    public void optionIsClicked(int index, int mX, int mY) {
        // prevent clicking scrollbar from being registered as selecting option
        if (this.getOpen()) {
            int margin;
            if (this.getOptions().size() > OPTION_VISIBLE_COUNT) {
                // scrollbar open
                margin = this.getScrollbar().getWidth();
            } else {
                margin = 0;
            }
            
            if (mX > this.getX() && mX < this.getX() + this.getWidth() - margin && mY > (this.getY() + (index + 1) * this.getHeight()) && mY < this.getY() + ((index + 2) * this.getHeight())) {
                this.setSelected(index + this.getOffset());
                // update label
                this.setLabel(this.getVisibleOptions()[index]);
            }
        }
    }
    
    public void toggleDropdown(int mX, int mY) {
        if (this.isClicked(mX, mY)) {
            this.setOpen(!(this.getOpen()));
        }
    }
    
    public int getOffset() {
        return this.offset;
    }
    
    public void setOffset(int offset) {
        this.offset = offset;
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
        fill(wc); 
        rect(cur_x, cur_y, w, h);
        fill(lc);
        text(l, cur_x + 10, cur_y + h - 10);
        
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
                    fill(color(245));
                } else {
                    fill(wc);
                }
                
                rect(cur_x, cur_y + (h * (i + 1) + 1), w, h);
                fill(lc);
                text(this.getVisibleOptions()[i], cur_x + 10, cur_y + h - 10 + (h * (i + 1) + 1));
            }
            
            // draw scrollbar
            if (opts.size() > OPTION_VISIBLE_COUNT) {
                scrollbar.draw();
                this.updateVisibleOptions();
            }
        }
    }
    
}