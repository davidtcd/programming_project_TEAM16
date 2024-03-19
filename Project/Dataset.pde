//Designed and written by Mark Varghese
import java.io.*;

enum DataType
{
  flights
}

class Dataset
{
  Table table;
  Table[] sortedKeys;
  DataType dataType;
  
  Dataset(String path, DataType dataType){
    table = loadTable(path, "header");
    sortedKeys = new Table[table.getColumnCount()];
    this.dataType = dataType;
    
    switch (dataType){
      case flights:
        table.setColumnType(0, "string");
        table.setColumnType(1, "string");
        table.setColumnType(2, "int");
        table.setColumnType(3, "string");
        table.setColumnType(4, "string");
        table.setColumnType(5, "string");
        table.setColumnType(6, "string");
        table.setColumnType(7, "int");
        table.setColumnType(8, "string");
        table.setColumnType(9, "string");
        table.setColumnType(10, "string");
        table.setColumnType(11, "string");
        table.setColumnType(12, "int");
        table.setColumnType(13, "int");
        table.setColumnType(14, "int");
        table.setColumnType(15, "int");
        table.setColumnType(16, "int");
        table.setColumnType(17, "int");
        break;
    }
  }
  
  int getNumberOfRows(){
    return table.getRowCount();
  }
  
  int getNumberOfColumns(){
    return table.getColumnCount();
  }
  
  void sortData(){
    String sortedPath = dataPath(DATA_PATH+"_Sorted");
    File f = new File(sortedPath);
    if(!f.mkdir()){
      for(int i=0; i<table.getColumnCount(); i++){
        sortedKeys[i] = loadTable(sortedPath+"/"+table.getColumnTitle(i)+".csv", "header");
      }
      return;
    }
    
    for(int i=0; i<table.getColumnCount(); i++){
      Table sortedTable = table.copy();
      sortedTable.addColumn("INDEX");
      for(int j=0; j<sortedTable.getRowCount(); j++){
        sortedTable.setInt(j, "INDEX", j);
      }
      sortedTable.sort(i);
      int columns = sortedTable.getColumnCount()-1;
      for(int j=0; j<columns; j++){
        sortedTable.removeColumn(0);
      }
      saveTable(sortedTable, sortedPath+"/"+table.getColumnTitle(i)+".csv");
      sortedKeys[i] = sortedTable;
    }
  }
  
  String getValue(int index, int column){
    try{
      return table.getString(index, column);
    } 
    catch (Exception e){
      println(e);
      return null;
    }
  }
  
  String getLine(int index){
    try{
      return join(table.getStringRow(index), ", ");
    } 
    catch (Exception e){
      println(e);
      return null;
    }
  }
  
  String getSortedValue(int index, int column){
    try{
      return table.getString(sortedKeys[column].getInt(index, 0), column);
    } 
    catch (Exception e){
      println(e);
      return null;
    }
  }
  
  String getSortedLine(int index, int column){
    try{
      return join(table.getStringRow(sortedKeys[column].getInt(index, 0)), ", ");
    } 
    catch (Exception e){
      println(e);
      return null;
    }
  }
  
  //println(join(sort(data.getUniqueValues(0)), "\n")); //Can be used to print all unique values in a column
  String[] getUniqueValues(int column){
    return table.getUnique(column);
  }
}
