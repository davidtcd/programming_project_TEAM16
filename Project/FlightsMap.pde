import peasy.*;

class FlightsMapScreen extends Screen{
  
  //Override
  public void draw(){
    background(50);
  
    lightFalloff(1, 0, 0);
    lightSpecular(0, 0, 0);
    ambientLight(128, 128, 128);
    directionalLight(128, 128, 128, 0, 0, -1);
  
    pushMatrix();
    translate(width/2, height/2);
    scale(100);
    shape(usaMap);
    popMatrix();
  }
}
