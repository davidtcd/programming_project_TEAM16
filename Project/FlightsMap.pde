import peasy.*;

class FlightsMapScreen extends Screen{
  PeasyCam cam;
  PShape usaMap;
  HashMap<String, Vector2D> airports;
  String selectedAirport;
  
  FlightsMapScreen(){
    usaMap = loadShape("usamap.obj");
    
    //Camera setup for "Flights Map"
    cam = new PeasyCam(parent, width/2, height/2, 0, 865);
    cam.setActive(false);
    cam.setYawRotationMode();
    cam.setResetOnDoubleClick(false);
    cam.setCenterDragHandler(null);
    cam.setRightDragHandler(null);
    cam.setWheelHandler(null);
    
    //Setup Airport-Point pairs
    airports = new HashMap<String, Vector2D>();
    airports.put("AL", new Vector2D(125, 245));
    airports.put("AK", new Vector2D(-225, 300));
    airports.put("AZ", new Vector2D(-180, 200));
    airports.put("AR", new Vector2D(55, 215));
    airports.put("CA", new Vector2D(-275, 150));
    airports.put("CO", new Vector2D(-110, 150));
    airports.put("CT", new Vector2D(258, 78));
    airports.put("DE", new Vector2D(240, 125));
    airports.put("FL", new Vector2D(195, 300));
    airports.put("GA", new Vector2D(170, 245));
    airports.put("HI", new Vector2D(-110, 320));
    airports.put("IA", new Vector2D(50, 100));
    airports.put("ID", new Vector2D(-200, 75));
    airports.put("IL", new Vector2D(80, 120));
    airports.put("IN", new Vector2D(115, 130));
    airports.put("KS", new Vector2D(-25, 150));
    airports.put("KY", new Vector2D(130, 160));
    airports.put("LA", new Vector2D(55, 265));
    airports.put("MA", new Vector2D(270, 65));
    airports.put("MD", new Vector2D(230, 125));
    airports.put("ME", new Vector2D(280, 15));
    airports.put("MI", new Vector2D(130, 75));
    airports.put("MN", new Vector2D(30, 45));
    airports.put("MO", new Vector2D(25, 145));
    airports.put("MS", new Vector2D(85, 245));
    airports.put("MT", new Vector2D(-150, 15));
    airports.put("NC", new Vector2D(210, 170));
    airports.put("ND", new Vector2D(-50, 15));
    airports.put("NE", new Vector2D(-50, 100));
    airports.put("NH", new Vector2D(270, 50));
    airports.put("NJ", new Vector2D(242, 110));
    airports.put("NM", new Vector2D(-115, 215));
    airports.put("NV", new Vector2D(-225, 115));
    airports.put("NY", new Vector2D(230, 60));
    airports.put("OH", new Vector2D(150, 125));
    airports.put("OK", new Vector2D(-10, 200));
    airports.put("OR", new Vector2D(-260, 50));
    airports.put("PA", new Vector2D(225, 95));
    airports.put("RI", new Vector2D(268, 72));
    airports.put("SC", new Vector2D(205, 205));
    airports.put("SD", new Vector2D(-50, 55));
    airports.put("TN", new Vector2D(120, 180));
    airports.put("TX", new Vector2D(-25, 275));
    airports.put("UT", new Vector2D(-170, 140));
    airports.put("VA", new Vector2D(210, 150));
    airports.put("VT", new Vector2D(255, 40));
    airports.put("WA", new Vector2D(-240, 0));
    airports.put("WI", new Vector2D(70, 75));
    airports.put("WV", new Vector2D(180, 140));
    airports.put("WY", new Vector2D(-120, 75));
    
    selectedAirport = "KS";
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
    
    stroke(0);
    noFill();
    Vector2D ov = ((Vector2D)airports.get(selectedAirport));
    for (Map.Entry airport : airports.entrySet()) {
      if(airport.getKey().equals(selectedAirport)) continue;
      Vector2D dv = ((Vector2D)airport.getValue());
      curve(ov.x, ov.y, -500, ov.x, ov.y, 0, dv.x, dv.y, 0, dv.x, dv.y, -500);
    }
    
    scale(100);
    shape(usaMap);
    popMatrix();
  }
  
  //Override
  public void onFocusChanged(boolean isInFocus){
    if(isInFocus) cam.setActive(true);
    else {
      cam.setActive(false);
      cam.reset(0);
    }
  }
}

class Vector2D{
  float x;
  float y;
  Vector2D(float x, float y){
    this.x = x;
    this.y = y;
  }
}
