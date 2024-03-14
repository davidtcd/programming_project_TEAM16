class Dropdown extends Widget {
    // Lukas Maselsky, Created class, constructor, getters and setters, and a few methods 5pm 14/03/2024
    
    private int width;
    private int height;
    private boolean open;
    private int selected; // index of selected option, starting at 0
    private ArrayList<String> options; // array of options
    
    Dropdown(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont, ArrayList<String> options, int event) {
        super(x, y, label, widgetColor, borderColor, labelColor, widgetFont, event);
        this.width = width; 
        this.height = height;
        this.open = false;
        this.selected = 0;
        this.options = options;
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
    
    
    void draw() {
        
    }
    
}
