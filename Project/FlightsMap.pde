import peasy.*;

class FlightsMapScreen extends Screen{
  
  FlightsMapScreen(){
    //Camera setup for "Flights Map"
    cam = new PeasyCam(parent, width/2, height/2, 0, 865);
    cam.setActive(false);
    cam.setYawRotationMode();
    cam.setResetOnDoubleClick(false);
    cam.setCenterDragHandler(null);
    cam.setRightDragHandler(null);
    cam.setWheelHandler(null);
  }
  
  //Override
  public void draw(){
    background(50);
  
    lightFalloff(1, 0, 0);
    lightSpecular(0, 0, 0);
    ambientLight(128, 128, 128);
    directionalLight(128, 128, 128, 0, 0, -1);
  
    pushMatrix();
    translate(width/2, height/2);
    rotateX(PI/3);
    scale(100);
    shape(usaMap);
    popMatrix();
  }
}
