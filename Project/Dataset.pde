//Designed and written by Mark Varghese
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

class FlightColumnTitles{
  final static String flightDate = "FL_DATE";
  final static String carrierCode = "MKT_CARRIER";
  final static String flightNumber = "MKT_CARRIER_FL_NUM";
  final static String originAirport = "ORIGIN";
  final static String originCity = "ORIGIN_CITY_NAME";
  final static String originStateCode = "ORIGIN_STATE_ABR";
  final static String worldAreaCode = "ORIGIN_WAC";
  final static String destinationAirport = "DEST";
  final static String destinationCity = "DEST_CITY_NAME";
  final static String destinationStateCode = "DEST_STATE_ABR";
  final static String destinationWorldAreaCode = "DEST_WAC";
  final static String scheduledDepartureTime = "CRS_DEP_TIME";
  final static String departureTime = "DEP_TIME";
  final static String scheduledArrivalTime = "CRS_ARR_TIME";
  final static String arrivalTime = "ARR_TIME";
  final static String cancelled = "CANCELLED";
  final static String diverted = "DIVERTED";
  final static String distance = "DISTANCE";
}
