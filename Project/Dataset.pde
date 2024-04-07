//Designed and written by Mark Varghese //<>//
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
    Thread mainDataThread = new DataMainThread(this, path, dataType, datasetScreen);
    mainDataThread.start();
  }

  int getNumberOfRows() {
    return rowCount;
  }

  int getNumberOfColumns() {
    return columnCount;
  }

  String getValue(int index, int column, boolean isSorted) {
    try {
      if (isSorted) return table.getString(sortedKeys[column].getInt(index, 0), column);
      return table.getString(index, column);
    }
    catch (Exception e) {
      println(e);
      return null;
    }
  }

  String[] getUniqueValues(int column) {
    try {
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
    catch (Exception e) {
      println(e);
      return null;
    }
  }

  String getLine(int index) {
    return join(table.getStringRow(index), ", ");
  }

  String getLineSorted(int index, int column) {
    try {
      return join(table.getStringRow(sortedKeys[column].getInt(index, 0)), ", ");
    }
    catch (Exception e) {
      println(e);
      return null;
    }
  }

  String[] getAllLines(Table _table) {
    try {
      String[] rows = new String[_table.getRowCount()];
      for (int i=0; i<rows.length; i++) {
        rows[i] = join(_table.getStringRow(i), ", ");
      }
      return rows;
    }
    catch (Exception e) {
      println(e);
      return null;
    }
  }

  int getOccurrenceAmount(int value, int column) {
    try {
      int min = sortedKeys[column].getInt(value, 1);
      int max = sortedKeys[column].getInt(value+1, 1);
      return max-min;
    }
    catch(Exception e) {
      println(e);
      return 0;
    }
  }

  Table getOccurrences(int value, int column) {
    return getOccurrences(value, column, table);
  }

  Table getOccurrences(int value, int column, Table table) {
    if (value<0) return null;
    Table occurrences = new Table();
    int min = sortedKeys[column].getInt(value, 1);
    int max = sortedKeys[column].getInt(value+1, 1);

    for (int i=min; i<max; i++) {
      occurrences.addRow(table.getRow(sortedKeys[column].getInt(i, 0)));
    }
    return occurrences;
  }

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

  //This is pretty slow for the full data set, I'm working on a better solution
  Table getOccurrences(String value, int column, Table _table) {
    try {
      Table occurrences = new Table();
      Iterable<TableRow> rows = _table.findRows(value, column);
      for (TableRow row : rows) {
        occurrences.addRow(row);
      }
      return occurrences;
    }
    catch(Exception e) {
      println(e);
      return null;
    }
  }
}

class DataMainThread extends Thread {
  Dataset data;
  String path;
  DataType dataType;
  DatasetScreen screen;

  DataMainThread(Dataset data, String path, DataType dataType, DatasetScreen screen) {
    this.data = data;
    this.path = path;
    this.dataType = dataType;
    this.screen = screen;
  }

  void run() {
    data.table = loadTable(path+".csv", "header");
    data.sortedKeys = new Table[data.table.getColumnCount()];
    data.rowCount = data.table.getRowCount();
    data.columnCount = data.table.getColumnCount();
    data.sortedPath = dataPath(path+"_Sorted");

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

    File f = new File(data.sortedPath);
    if (!f.mkdir()) {
      println("Loading data...");
      for (int i=0; i<data.getNumberOfColumns(); i++) {
        data.sortedKeys[i] = loadTable(data.sortedPath+"/"+data.table.getColumnTitle(i)+".csv", "header");
      }
      loadResources();
      screen.datasetSelected = true;
      println("Data loaded!");
      return;
    }
    println("Sorting data...");
    Table sortedTable = data.table.copy();
    sortedTable.addColumn("INDEX");
    for (int j=0; j<sortedTable.getRowCount(); j++) {
      sortedTable.setInt(j, "INDEX", j);
    }
    ThreadGroup dataTG = new ThreadGroup("dtg");
    for (int i=0; i<data.getNumberOfColumns(); i++) {
      new Thread(dataTG, new DataSortThread(i, data, sortedTable), ""+i).start();
    }
    while (dataTG.activeCount() != 0) {
    }
    loadResources();
    screen.datasetSelected = true;
    println("Data sorted!");
  }
}

class DataSortThread extends Thread {
  int i;
  Dataset data;
  Table sortedTable;
  DataSortThread(int i, Dataset data, Table sortedTable) {
    this.i = i;
    this.data = data;
    this.sortedTable = sortedTable.copy();
    println("Thread created: "+i);
  }

  public void run() {
    sortedTable.sort(i);
    Table savedTable = new Table();
    savedTable.addColumn("INDEX");
    savedTable.addColumn("UNIQUE_INDEX");
    String prevValue = "";
    int k = 0;
    for (int j=0; j<data.rowCount; j++) {
      int indexValue = sortedTable.getInt(j, "INDEX");
      savedTable.setInt(j, 0, indexValue);
      String value = data.table.getString(indexValue, i);
      if (!prevValue.equals(value)) {
        savedTable.setInt(k++, 1, j);
        prevValue = value;
      }
    }
    savedTable.setInt(k, 1, data.rowCount-1);
    saveTable(savedTable, data.sortedPath+"/"+data.table.getColumnTitle(i)+".csv");
    data.sortedKeys[i] = savedTable;
    println("Column: "+i+" sorted.");
  }
}

class DatasetScreen extends Screen {
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

  //Override
  public void draw() {
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
      circle(1375, 480-sinOffset, 30);
      sinAngle+=dx;
      sinOffset = constrain(sin(sinAngle)*amplitude, 0, Float.MAX_VALUE);
      circle(1325, 480-sinOffset, 30);
      sinAngle+=dx;
      sinOffset = constrain(sin(sinAngle)*amplitude, 0, Float.MAX_VALUE);
      circle(1275, 480-sinOffset, 30);
      if (theta>=period) theta = 0;

      return;
    }
    background(50);
    textSize(150);
    textAlign(CENTER, CENTER);
    fill(255);
    text("Select Dataset", 1000, 150);

    for (int i = 0; i < this.getWidgets().size(); i++) {
      this.getWidgets().get(i).draw();
    }
    if (mousePressed) {
      for (int i = 0; i < allButtons.size(); i++) {
        allButtons.get(i).isClicked(mouseX, mouseY);
      }
    }

    //Draw button appearance
    textSize(50);
    fill(255);
    rect(760, 310, 480, 80);
    rect(760, 460, 480, 80);
    rect(760, 610, 480, 80);
    rect(760, 760, 480, 80);
    fill(0);
    text("Flights 2K", 1000, 350);
    text("Flights 10K", 1000, 500);
    text("Flights 100K", 1000, 650);
    text("Flights Full", 1000, 800);
  }

  void loadData(String dataPath) {
    isLoading = true;
    data = new Dataset(dataPath, DataType.flights);
  }
}
