//Hezamary Paul created Screen class to include drawing of widgets and all other constants on 14/03/2024 @ 10:07


 class Screen { //declaration of screen class
    private ArrayList<Widget> widgets;

    Screen() { //constructor for screen 
        widgets = new ArrayList<Widget>(); //add widgets 
    }

    // Method to add a widget to the screen
    public void addWidget(Widget widget) {
        widgets.add(widget);
    }


    // Method to draw the screen
    public void draw() {
        // Code to draw the screen (e.g., drawing widgets)
    }
    void addButton(Button button){}
    void changeChart(BarChart newChart){}
    

}


class TableScreen extends Screen {
  TableScreen() {
    super();
  }
  
  void draw() {
    for(int i=0; i<20; i++){
      textFont(font);
      textSize(12);
      text(data.getLine(i), 0, i*25+30);
    }
  }
}
