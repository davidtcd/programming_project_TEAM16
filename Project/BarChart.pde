import org.gicentre.utils.stat.*;
// David Sietko implemented method to set up a bar chart

void setChart(BarChart chart, String header, int startIndex, int endIndex)
{
  int numOfBars = endIndex - startIndex;
  int startCopy = startIndex;
  int rowCount = data.table.getRowCount();
  ArrayList<String> copy = new ArrayList<String>();
  ArrayList<Float> numbers = new ArrayList<Float>();
  String[] fullColumn = data.table.getStringColumn(header);
  // loops to get all the different titles for the bars in chart
  for(int i = 0; i < fullColumn.length - 1; i++)
  {
    String title = fullColumn[i];
    boolean newTitle = true;
    for(int index = 0; index < copy.size(); index++)
    {
     String titleOther = copy.get(index);
     if(titleOther.equals(title))
     {
       newTitle = false;
     }
    }
    if(newTitle == true)
    {
      copy.add(title);
    }
  }
  // changing ArrayList of the titles into normal array
  String[] categories = new String[copy.size()];
  for(int i = 0; i < categories.length; i++)
  {
    categories[i] = copy.get(i);
  }
  // loop to choose which categories to be displayed
  String[] realCategories = new String[numOfBars];
  for(int i = 0; i < realCategories.length; i++)
  {
    realCategories[i] = categories[startCopy];
    startCopy++;
  }
  // loop to initialize values
   for(int i = 0; i < categories.length; i++)
 {
   float amount = 0;
   String title = categories[i];
   for(int index = 0; index < fullColumn.length; index++)
   {
     String titleOther = fullColumn[index];
     if(titleOther.equals(title))
     {
       amount++;
     }
   }
   numbers.add(amount);
 }
 // changing ArrayList of the values into normal array
 float[] values = new float[numbers.size()];
 for(int i = 0; i < values.length; i++)
 {
   values[i] = numbers.get(i);
 }
 for(int i = 0; i < values.length; i++)
 {
   values[i] = values[i] / 1000;
 }
 // loop to choose range of values to be displayed
 startCopy = startIndex;
 float[] realValues = new float[numOfBars];
 for(int i = 0; i < realValues.length; i++)
 {
   realValues[i] = values[startCopy];
   startCopy++;
 }
  chart.setMaxValue(1);
  chart.setMinValue(0);
  chart.setData(realValues);
  chart.setBarLabels(realCategories);
  chart.showCategoryAxis(true);
  chart.showValueAxis(true);
  chart.transposeAxes(INVERTAXIS);
}
