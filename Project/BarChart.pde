import org.gicentre.utils.stat.*;
// David Sietko implemented method to set up a bar chart
String medianName;
String modeName;
int median;
int mode;
int mean;
int totalCategories;
ArrayList<BarChart> setChart(int columnNumber)
{
    int maxBars = 50;
    int modeIndex = 0;
    ArrayList<BarChart> allCharts = new ArrayList<BarChart>();
    String[] categories =  sort(data.getUniqueValues(columnNumber));
    totalCategories = categories.length;
    int numOfPages = ceil(categories.length / maxBars);
    if(maxBars > categories.length)
    {
      maxBars = categories.length;
    }
   // loop to initialize values
   float[] values = new float[categories.length];
   for(int i = 0; i < values.length; i++) 
   {
    Table occurrenceAmount = data.getOccurrences(i, columnNumber);
    float amount = occurrenceAmount.getRowCount();
     values[i] = amount;
   }
   mean = data.table.getRowCount() / categories.length;
   if(values.length % 2 == 0)
   {
   median = (int)values[values.length / 2];
   medianName = categories[categories.length / 2];
   }
   else
   {
     median = (int)(values[values.length / 2] + values[values.length / 2 + 1]) / 2;
     medianName = categories[categories.length / 2] + " + " + categories[categories.length / 2 + 1];
   }
    // loop to set each chart for each page
    for(int i = 0; i <= numOfPages; i++)
    {
      BarChart chart = new BarChart(this);
      if(i < numOfPages)
      {
        int barNum = maxBars * i;
        String[] realCategories = new String[maxBars];
        float[] realValues = new float[maxBars];
        for(int in = 0; in < realCategories.length; in++)
        {
          realCategories[in] = categories[barNum];
          realValues[in] = values[barNum];
          barNum++;
        }
        float currentValue = realValues[0];
        for(int ind = 1; ind < realValues.length; ind++)
         {
           float newValue = realValues[ind];
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
         allCharts.add(chart);
      }
      else
      {
        int barNum = maxBars * i;
        String[] realCategories = new String[categories.length - barNum];
        float[] realValues = new float[categories.length - barNum];
        for(int in = 0; in < realCategories.length; in++)
        {
          if(barNum >= categories.length - 1)
          {
            barNum = categories.length - 1;
          }
          realCategories[in] = categories[barNum];
          realValues[in] = values[barNum];
          barNum++;
        }
        float currentValue = realValues[0];
        for(int ind = 1; ind < realValues.length; ind++)
         {
           float newValue = realValues[ind];
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
         allCharts.add(chart);
         mode = (int)currentValue;
         for(int index = 0; index < values.length; index++)
         {
           if(currentValue == values[index])
           {
             modeIndex = index;
           }
         }
         modeName = categories[modeIndex];
      }
    }
    return allCharts;
}
String medianName0;
String modeName0;
int median0;
int mode0;
int mean0;
int categories0;
String medianName1;
String modeName1;
int median1;
int mode1;
int mean1;
int categories1;
String medianName2;
String modeName2;
int median2;
int mode2;
int mean2;
int categories2;
String medianName3;
String modeName3;
int median3;
int mode3;
int mean3;
int categories3;
String medianName4;
String modeName4;
int median4;
int mode4;
int mean4;
int categories4;
String medianName5;
String modeName5;
int median5;
int mode5;
int mean5;
int categories5;
String medianName6;
String modeName6;
int median6;
int mode6;
int mean6;
int categories6;
String medianName7;
String modeName7;
int median7;
int mode7;
int mean7;
int categories7;
String medianName8;
String modeName8;
int median8;
int mode8;
int mean8;
int categories8;
String medianName9;
String modeName9;
int median9;
int mode9;
int mean9;
int categories9;
String medianName10;
String modeName10;
int median10;
int mode10;
int mean10;
int categories10;
String medianName11;
String modeName11;
int median11;
int mode11;
int mean11;
int categories11;
String medianName12;
String modeName12;
int median12;
int mode12;
int mean12;
int categories12;
String medianName13;
String modeName13;
int median13;
int mode13;
int mean13;
int categories13;
String medianName14;
String modeName14;
int median14;
int mode14;
int mean14;
int categories14;
String medianName15;
String modeName15;
int median15;
int mode15;
int mean15;
int categories15;
String medianName16;
String modeName16;
int median16;
int mode16;
int mean16;
int categories16;
String medianName17;
String modeName17;
int median17;
int mode17;
int mean17;
int categories17;
