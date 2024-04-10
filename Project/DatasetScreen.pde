//Starting screen to select and load a dataset.
//Designed and written by Mark Varghese.
final class DatasetScreen extends Screen {
  public boolean datasetSelected = false;
  public boolean isLoading = false;
  private ArrayList<Button> allButtons;

  private float theta = 0;
  private float sinOffset = 0;
  private float sinAngle = 0;
  private int amplitude = 25;
  private int period = 200;
  private float dx = (TWO_PI / period) * 20;

  DatasetScreen() {
    allButtons = new ArrayList<Button>();

    //Buttons for datasets
    Button slot1 = new Button(750, 300, 500, 100, "", color(0), BLACK, BLACK, font, () -> this.loadData("flights2k"));
    getWidgets().add(slot1);
    allButtons.add(slot1);
    Button slot2 = new Button(750, 450, 500, 100, "", color(0), BLACK, BLACK, font, () -> this.loadData("flights10k"));
    getWidgets().add(slot2);
    allButtons.add(slot2);
    Button slot3 = new Button(750, 600, 500, 100, "", color(0), BLACK, BLACK, font, () -> this.loadData("flights100k"));
    getWidgets().add(slot3);
    allButtons.add(slot3);
    Button slot4 = new Button(750, 750, 500, 100, "", color(0), BLACK, BLACK, font, () -> this.loadData("flights_full"));
    getWidgets().add(slot4);
    allButtons.add(slot4);
  }

  @Override
    public void draw() {
    //Draw loading screen
    if (isLoading) {
      background(50);
      textSize(150);
      textAlign(CENTER, CENTER);
      fill(255);
      text("Loading", 1000, 450);

      ellipseMode(BOTTOM);
      theta += 0.04;
      sinAngle = theta;
      sinOffset = constrain(sin(sinAngle)*amplitude, 0, Float.MAX_VALUE);
      circle(1375, 495-sinOffset, 30);
      sinAngle+=dx;
      sinOffset = constrain(sin(sinAngle)*amplitude, 0, Float.MAX_VALUE);
      circle(1325, 495-sinOffset, 30);
      sinAngle+=dx;
      sinOffset = constrain(sin(sinAngle)*amplitude, 0, Float.MAX_VALUE);
      circle(1275, 495-sinOffset, 30);
      if (theta>=period) theta = 0;

      return;
    }

    //Draw data select screen
    background(50);
    textSize(150);
    textAlign(CENTER, CENTER);
    fill(255);
    text("Select Dataset", 1000, 150);

    for (int i = 0; i < this.getWidgets().size(); i++) {
      this.getWidgets().get(i).draw();
    }
    for (int i = 0; i < allButtons.size(); i++) {
      if (mousePressed) allButtons.get(i).isClicked(mouseX, mouseY);
    }

    //Draw slot graphics
    textSize(50);
    for (int i=0; i<allButtons.size(); i++) {
      fill(allButtons.get(i).isHovering(mouseX, mouseY) ? 200 : 255);
      rect(760, 310+(i*150), 480, 80);
    }
    fill(0);
    text("Flights 2K", 1000, 340);
    text("Flights 10K", 1000, 490);
    text("Flights 100K", 1000, 640);
    text("Flights Full", 1000, 790);
  }

  /**
   * Load the data in a csv file in the data folder of the project.
   *
   * @param  dataPath  Name of csv file.
   */
  private void loadData(String dataPath) {
    isLoading = true;
    data = new Dataset(dataPath, DataType.flights);
  }
}
