class Dropdown extends Widget {
    // Lukas Maselsky, Created class, constructor, getters and setters, and a few methods 5pm 14/03/2024
    
    // each option is same height as dropdown button
    private int width;
    private int height;
    private boolean open;
    private int selected; // index of selected option, starting at 0
    private ArrayList<String> options; // array of options
    private Scrollbar scrollbar;
    private final int OPTION_VISIBLE_COUNT = 3;
    
    
    Dropdown(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont, ArrayList<String> options, int event, int scrollbarEvent) {
        super(x, y, label, widgetColor, borderColor, labelColor, widgetFont, event);
        this.width = width; 
        this.height = height;
        this.open = false;
        this.selected = 0;
        this.options = options;
        
        // scrollbar
        int scrollbarWidth = width / 10; //! not concrete 
        int scrollbarHeight = height * (OPTION_VISIBLE_COUNT); //! 3 options visible, not concrete
        int scrollbarX = x + width - scrollbarWidth;
        int scrollbarY = y + height;
        this.scrollbar = new Scrollbar(scrollbarX, scrollbarY, scrollbarWidth, scrollbarHeight, "", widgetColor, color(0, 0 , 0), widgetFont, scrollbarEvent);
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
    
    
    public void toggleDropdown(int mX, int mY) {
        if (this.isClicked(mX, mY)) {
            this.setOpen(!(this.getOpen()));
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
        
        fill(wc);
        // main dropdown button
        rect(cur_x, cur_y, w, h);
        fill(lc);
        text(l, cur_x + 10, cur_y + h - 10);
        
        // check if open
        if (this.getOpen()) {
            for (int i = 0; i < opts.size(); i++) {
                fill(wc);
                rect(cur_x, cur_y + (h * (i + 1)), w, h);
                fill(lc);
                text(opts.get(i), cur_x + 10, cur_y + h - 10 + (h * (i + 1)));
            }
            scrollbar.draw();
        }
    }
    
}
