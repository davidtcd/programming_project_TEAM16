//A robust dataset system that can handle any form of csv data.
//Designed and written by Mark Varghese.
import java.io.*;

enum DataType
{
  flights
}

class Dataset
{
  private Table table;
  private Table[] sortedKeys;
  private int rowCount;
  private int columnCount;
  private String sortedPath;

  Dataset(String path, DataType dataType) {
    //Move loading of data to sperate thread to stop animation thread from freezing
    Thread mainDataThread = new DataMainThread(path, dataType);
    mainDataThread.start();
  }

  int getNumberOfRows() {
    return rowCount;
  }

  int getNumberOfColumns() {
    return columnCount;
  }

  /**
   * Finds the value at a specific row and column in the dataset.
   *
   * @param  index     Row of the dataset the value is in.
   * @param  column    Column of the datset the value is in.
   * @param  isSorted  Wether the dataset should be sorted by the column.
   * @return           value as a string at a specific row and column in the dataset.
   */
  String getValue(int index, int column, boolean isSorted) {
    if (isSorted) return table.getString(sortedKeys[column].getInt(index, 0), column);
    return table.getString(index, column);
  }

  /**
   * Finds all the unique values present in a column of the dataset.
   * Note that the index of values in the returned array is the int id of the value in a column.
   * i.e the first value of the first column is the 0th value of getUniqueValues(0);
   *
   * @param  column    Column of the dataset to be searched.
   * @returns          String array of unique values present in a column of the dataset.
   */
  String[] getUniqueValues(int column) {
    ArrayList<String> values = new ArrayList<String>();
    String value = table.getString(sortedKeys[column].getInt(sortedKeys[column].getInt(0, 1), 0), column);
    int uniqueIndex = sortedKeys[column].getInt(0, 1);
    values.add(value);
    uniqueIndex = sortedKeys[column].getInt(1, 1);
    int i=1;
    while (uniqueIndex != 0) {
      value = table.getString(sortedKeys[column].getInt(uniqueIndex, 0), column);
      values.add(value);
      i++;
      uniqueIndex = sortedKeys[column].getInt(i, 1);
    }
    values.remove(values.size()-1);
    return values.toArray(new String[0]);
  }

  /**
   * Gets the specified row of the dataset.
   *
   * @param  index     Row of the dataset to be joined.
   * @returns          The specified row as a string.
   */
  String getLine(int index) {
    return join(table.getStringRow(index), ", ");
  }

  /**
   * Gets the specified row of the dataset sorted by the column.
   *
   * @param  index     Row of the dataset to be joined.
   * @param  column    Column of the dataset should be sorted by.
   * @returns          The specified row as a string.
   */
  String getLineSorted(int index, int column) {
    return join(table.getStringRow(sortedKeys[column].getInt(index, 0)), ", ");
  }

  /**
   * Gets amount of times a value appears in a column in the dataset.
   *
   * @param  value     The value id to be counted.
   * @param  column    Column of the dataset the value is present it.
   * @returns          The amount of times a value appears in a column in the dataset.
   */
  int getOccurrenceAmount(int value, int column) {
    int min = sortedKeys[column].getInt(value, 1);
    int max = sortedKeys[column].getInt(value+1, 1);
    return max-min;
  }

  /**
   * Gets the rows that contain the value in a cloumn of the dataset.
   *
   * @param  value     The value id to be searched.
   * @param  column    Column of the dataset the value is present it.
   * @returns          An arraylist of rows as strings which contain the value given.
   */
  ArrayList<String> getOccurrencesList(int value, int column) {
    if (value<0) return null;
    ArrayList<String> occurrences = new ArrayList<String>();
    int min = sortedKeys[column].getInt(value, 1);
    int max = sortedKeys[column].getInt(value+1, 1);

    for (int i=min; i<max; i++) {
      occurrences.add(getLine(sortedKeys[column].getInt(i, 0)));
    }
    return occurrences;
  }
}

class DataMainThread extends Thread {
  String path;
  DataType dataType;

  DataMainThread(String path, DataType dataType) {
    this.path = path;
    this.dataType = dataType;
  }

  //Load or sort data
  void run() {
    data.table = loadTable(path+".csv", "header");
    data.sortedKeys = new Table[data.table.getColumnCount()];
    data.rowCount = data.table.getRowCount();
    data.columnCount = data.table.getColumnCount();
    data.sortedPath = dataPath(path+"_Sorted");

    //Setup column types for specific datasets
    switch (dataType) {
    case flights:
      data.table.setColumnType(0, "string");
      data.table.setColumnType(1, "string");
      data.table.setColumnType(2, "int");
      data.table.setColumnType(3, "string");
      data.table.setColumnType(4, "string");
      data.table.setColumnType(5, "string");
      data.table.setColumnType(6, "int");
      data.table.setColumnType(7, "string");
      data.table.setColumnType(8, "string");
      data.table.setColumnType(9, "string");
      data.table.setColumnType(10, "int");
      data.table.setColumnType(11, "int");
      data.table.setColumnType(12, "int");
      data.table.setColumnType(13, "int");
      data.table.setColumnType(14, "int");
      data.table.setColumnType(15, "int");
      data.table.setColumnType(16, "int");
      data.table.setColumnType(17, "int");
      break;
    }

    //Try create folder for sorted data, if already exists load data else sort
    File f = new File(data.sortedPath);
    if (!f.mkdir()) {
      println("Loading data...");
      for (int i=0; i<data.getNumberOfColumns(); i++) {
        data.sortedKeys[i] = loadTable(data.sortedPath+"/"+data.table.getColumnTitle(i)+".csv", "header");
      }
      loadResources();
      datasetScreen.datasetSelected = true;
      println("Data loaded!");
      return;
    }

    println("Sorting data...");


    //Divide sorting of columns between threads
    ThreadGroup dataTG = new ThreadGroup("dtg");
    for (int i=0; i<data.getNumberOfColumns(); i++) {
      new Thread(dataTG, new DataSortThread(i), ""+i).start();
    }
    while (dataTG.activeCount() != 0) {
      //Wait for sorting to finish
    }

    loadResources();
    datasetScreen.datasetSelected = true;
    println("Data sorted!");
  }
}

final class DataSortThread extends Thread {
  int threadIndex;
  Table sortedTable;

  DataSortThread(int i) {
    this.threadIndex = i;

    sortedTable = data.table.copy();
    sortedTable.addColumn("INDEX");
    for (int j=0; j<data.getNumberOfRows(); j++) {
      sortedTable.setInt(j, "INDEX", j);
    }

    println("Thread created: "+i);
  }

  //Sort column
  public void run() {
    sortedTable.sort(threadIndex);

    Table savedTable = new Table();
    savedTable.addColumn("INDEX");
    savedTable.addColumn("UNIQUE_INDEX");
    String prevValue = "";
    int k = 0;
    for (int j=0; j<data.rowCount; j++) {
      int indexValue = sortedTable.getInt(j, "INDEX");
      savedTable.setInt(j, 0, indexValue);
      String value = data.table.getString(indexValue, threadIndex);
      if (!prevValue.equals(value)) {
        savedTable.setInt(k++, 1, j);
        prevValue = value;
      }
    }

    savedTable.setInt(k, 1, data.rowCount-1);
    saveTable(savedTable, data.sortedPath+"/"+data.table.getColumnTitle(threadIndex)+".csv");
    data.sortedKeys[threadIndex] = savedTable;
    println("Column: "+threadIndex+" sorted.");
  }
}

final class DatasetScreen extends Screen {
  boolean datasetSelected = false;
  boolean isLoading = false;
  ArrayList<Button> allButtons;

  float theta = 0;
  float sinOffset = 0;
  float sinAngle = 0;
  int amplitude = 25;
  int period = 200;
  float dx = (TWO_PI / period) * 20;

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
