//Hezamary Paul created Screen class to include drawing of widgets and all other constants on 14/03/2024 @ 10:07

import java.util.ArrayList; //import to include multiple widgets

public class Screen { //declaration of screen class
    private ArrayList<Widget> widgets;
    private int WIDTH = 2000;
    private int HEIGHT = 1000;
    private int DATA_SIZE_537K = 537000;
    private int DATA_SIZE_10K = 10000;
    private int DATA_SIZE_2K = 2000;
    private String FILE_PATH = "flights.csv";

    public Screen() { //constructor for screen 
        widgets = new ArrayList<>(); //add widgets 
    }

    // Method to add a widget to the screen
    public void addWidget(Widget widget) {
        widgets.add(widget);
    }


    // Method to draw the screen
    public void draw() {
        // Code to draw the screen (e.g., drawing widgets)
    }
}
