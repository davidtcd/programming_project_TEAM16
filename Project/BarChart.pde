import org.gicentre.utils.stat.*;
// David Sietko implemented method to set up a bar chart

void setChart(BarChart chart, int columnNumber, int startIndex, int endIndex)
{
  int numOfBars = endIndex - startIndex;
  int startCopy = startIndex;
  String[] categories = data.getUniqueValues(columnNumber);
  // loop to choose which categories to be displayed
  String[] realCategories = new String[numOfBars];
  for(int i = 0; i < realCategories.length; i++)
  {
    realCategories[i] = categories[startCopy];
    startCopy++;
  }
  // loop to initialize values
  float[] values = new float[categories.length];
   for(int i = 0; i < values.length; i++)
 {
   String title = categories[i];
  Table occurrenceAmount = data.getOccurrences(title, columnNumber, data.table);
  float amount = occurrenceAmount.getRowCount();
   values[i] = amount;
 }
 // loop to choose range of values to be displayed
 startCopy = startIndex;
 float[] realValues = new float[numOfBars];
 for(int i = 0; i < realValues.length; i++)
 {
   realValues[i] = values[startCopy];
   startCopy++;
 }
 float currentValue = realValues[0];
 for(int i = 1; i < realValues.length; i++)
 {
   float newValue = realValues[i];
   if(newValue > currentValue)
   {
     currentValue = newValue;
   }
 }
  chart.setMaxValue(currentValue+20);
  chart.setMinValue(0);
  chart.setData(realValues);
  chart.setBarLabels(realCategories);
  chart.showCategoryAxis(true);
  chart.showValueAxis(true);
  chart.transposeAxes(invertAxis);
}
