void settings()
{
  size(2000,1000); //Esosa did this
  
}

void setup()
{
  int time = millis();
  loadResources();
  println(millis()-time);
  //mainscreen.draw();
  
  String[] occurrences = data.getAllLines(data.getOccurrences(0, 1));
  for(int i=0; i<occurrences.length; i++){
    println(occurrences[i]);
  }
  
  //for(int i=0; i<data.getUniqueValues(1).length; i++){
  //  println(data.getLine(data.sortedKeys[1].getInt(data.sortedKeys[1].getInt(i, 1), 0)));
  //}
}

void draw()
{
  
}
