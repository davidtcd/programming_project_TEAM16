enum DataType
{
  flights
}

class Dataset
{
  Table table;
  DataType dataType;
  
  Dataset(String path, DataType dataType)
  {
    table = loadTable(path, "header");
    this.dataType = dataType;
  }
  
  String getLine(int index)
  {
    try
    {
      return join(table.getStringRow(index), ", ");
    } 
    catch (Exception e)
    {
      println(e);
      return null;
    }
  }
}
