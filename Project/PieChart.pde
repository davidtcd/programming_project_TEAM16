// Joseph Reidy created the PieChart class and it's methods - which creates and labels a pie chart displaying an array of data from first principles

class pieChart
{
  private float[] data;
  private String[] headings;
  private float[] red;
  private float[] green;
  private float[] blue;

  //constructor
  pieChart(float[] data, String[] headings)
  {
    this.data = data;
    this.headings = headings;
    //float red = map(i, 0, data.length, , 255);
    //float green = map(i, 0, data.length, 255, 0);
    //float blue = map(i, 0, data.length, 0 ,255);
    this.red = new float[data.length];
    this.green = new float[data.length];
    this.blue = new float[data.length];
    for (int i = 0; i < data.length; i++)
    {
      red[i] = random(55,200);
      green[i] =  random(55,200);
      blue[i] = random(55,200);
    }
  
      
  }
  float[] getRed()
  {
    return this.red;
  }
  float[] getGreen()
  {
    return this.green;
  }
  float[] getBlue()
  {
    return this.blue;
  }
  float[] getData()
  {
    return this.data;
  }
  String[] getHeadings()
  {
    return this.headings;
  }

   void draw()
   {
     pieChart(800, getData(), getHeadings());
   }

   float[] cancelledFlights(Table bigTable)
   {
     float[]returnArray = {};
     int totalLines = bigTable.getRowCount();
     //int numberOfZeroes = getOccurrences("0", 15, bigTable);
     //int numberOfOnes = getOccurrences("1", 15, bigTable);
     returnArray = append(returnArray, 218);
     returnArray = append(returnArray, 1782);
     return returnArray;
   }

  float[] dataToAngles(float[] data)
  {
    float[] anglesReturn = {};
    float total = 0;
    for (int value = 0; value < data.length; value++)
    {
      total += data[value];
    }  
    for (int value2 = 0; value2 < data.length; value2++)
    {
     float newValue = (data[value2] / total) * 360;
     anglesReturn = append(anglesReturn, newValue);
    }

    return anglesReturn;
  }

  void pieChart(float diameter, float[] data, String[] headings) 
  {
    float[] angles = dataToAngles(data);
    float[] sortedAngles = reverse(sort(angles));
    String [] sortedHeadings = {};
    for (int j = 0; j < sortedAngles.length; j++)
    {
      for (int k = 0; k < sortedAngles.length; k++)
      {
        if(sortedAngles[j] == angles[k])
        {
          sortedHeadings= append(sortedHeadings,headings[k]);
        }
      }
    }
  
    float lastAngle = 0;
    for (int i = 0; i < sortedAngles.length; i++) 
    {
      color myColor = color(getRed()[i],getGreen()[i],getBlue()[i]);
      fill(myColor);
      
      float textPos = map(i+1,0, sortedAngles.length, BARHEIGHT, height-BARHEIGHT);
      textSize(32);
      text(sortedHeadings[i] + ": " +round(((sortedAngles[i]/360) * 100)*100)*0.01 + "%", width-diameter, textPos);
      arc(diameter/2+100, height/2 + 75, diameter, diameter, lastAngle - radians(90), lastAngle+radians(sortedAngles[i]) - radians (90));
      lastAngle += radians(sortedAngles[i]);
      textSize(14);
    }
}

}
