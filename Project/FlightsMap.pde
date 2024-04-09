//A 3D view of flight paths from an origin state to destination states.
//US model found at: https://www.cgtrader.com/items/850887/download-page.
//Note the model used in the project has been modified (decimated) using Blender.
//Designed and written by Mark Varghese
import peasy.*;

class FlightsMapScreen extends Screen {
  PShape usaMap;
  PeasyCam cam;
  HashMap<String, Vector2D> stateLocations;
  ArrayList<String> allStates;
  String[] availableStates;
  Textbox originStateInput;
  String originState;
  IntDict destStates;
  int totalDest;

  FlightsMapScreen() {
    //Load 3D model
    usaMap = loadShape("usamap.obj");
    usaMap.setFill(color(#35934F));

    //Camera setup
    cam = new PeasyCam(parent, width/2, height/2, 0, 865);
    cam.setActive(false);
    cam.setYawRotationMode();
    cam.setResetOnDoubleClick(false);
    cam.setCenterDragHandler(null);
    cam.setRightDragHandler(null);
    cam.setWheelHandler(null);

    //Setup state postions on map
    stateLocations = new HashMap<String, Vector2D>();
    stateLocations.put("AL", new Vector2D(125, 245));
    stateLocations.put("AK", new Vector2D(-225, 300));
    stateLocations.put("AZ", new Vector2D(-180, 200));
    stateLocations.put("AR", new Vector2D(55, 215));
    stateLocations.put("CA", new Vector2D(-275, 150));
    stateLocations.put("CO", new Vector2D(-110, 150));
    stateLocations.put("CT", new Vector2D(258, 78));
    stateLocations.put("DE", new Vector2D(240, 125));
    stateLocations.put("FL", new Vector2D(195, 300));
    stateLocations.put("GA", new Vector2D(170, 245));
    stateLocations.put("HI", new Vector2D(-110, 320));
    stateLocations.put("IA", new Vector2D(50, 100));
    stateLocations.put("ID", new Vector2D(-200, 75));
    stateLocations.put("IL", new Vector2D(80, 120));
    stateLocations.put("IN", new Vector2D(115, 130));
    stateLocations.put("KS", new Vector2D(-25, 150));
    stateLocations.put("KY", new Vector2D(130, 160));
    stateLocations.put("LA", new Vector2D(55, 265));
    stateLocations.put("MA", new Vector2D(270, 65));
    stateLocations.put("MD", new Vector2D(230, 125));
    stateLocations.put("ME", new Vector2D(280, 15));
    stateLocations.put("MI", new Vector2D(130, 75));
    stateLocations.put("MN", new Vector2D(30, 45));
    stateLocations.put("MO", new Vector2D(25, 145));
    stateLocations.put("MS", new Vector2D(85, 245));
    stateLocations.put("MT", new Vector2D(-150, 15));
    stateLocations.put("NC", new Vector2D(210, 170));
    stateLocations.put("ND", new Vector2D(-50, 15));
    stateLocations.put("NE", new Vector2D(-50, 100));
    stateLocations.put("NH", new Vector2D(270, 50));
    stateLocations.put("NJ", new Vector2D(242, 110));
    stateLocations.put("NM", new Vector2D(-115, 215));
    stateLocations.put("NV", new Vector2D(-225, 115));
    stateLocations.put("NY", new Vector2D(230, 60));
    stateLocations.put("OH", new Vector2D(150, 125));
    stateLocations.put("OK", new Vector2D(-10, 200));
    stateLocations.put("OR", new Vector2D(-260, 50));
    stateLocations.put("PA", new Vector2D(225, 95));
    stateLocations.put("RI", new Vector2D(268, 72));
    stateLocations.put("SC", new Vector2D(205, 205));
    stateLocations.put("SD", new Vector2D(-50, 55));
    stateLocations.put("TN", new Vector2D(120, 180));
    stateLocations.put("TX", new Vector2D(-25, 275));
    stateLocations.put("UT", new Vector2D(-170, 140));
    stateLocations.put("VA", new Vector2D(210, 150));
    stateLocations.put("VT", new Vector2D(255, 40));
    stateLocations.put("WA", new Vector2D(-240, 0));
    stateLocations.put("WI", new Vector2D(70, 75));
    stateLocations.put("WV", new Vector2D(180, 140));
    stateLocations.put("WY", new Vector2D(-120, 75));

    destStates = new IntDict();
    availableStates = data.getUniqueValues(5);
    allStates = new ArrayList<String>();
    for (String state : stateLocations.keySet()) allStates.add(state);
    Collections.sort(allStates);
    originStateInput = new Textbox(width-500, TABHEIGHT+135, 200, 50, "Origin State", WHITE, BLACK, BLACK, font, parent, allStates, allDropdowns);

    setOriginState("AL");
  }

  @Override
    public void draw() {
    background(color(#73C5F7));

    //Lighting settings
    lightFalloff(1, 0, 0);
    lightSpecular(0, 0, 0);
    ambientLight(128, 128, 128);
    directionalLight(128, 128, 128, 0, 0, -1);

    pushMatrix();
    translate(width/2, height/2);
    rotateX(PI/3);

    //Draw flight paths
    colorMode(RGB);
    noFill();
    Vector2D ov = ((Vector2D)stateLocations.get(originState));
    for (Map.Entry state : stateLocations.entrySet()) {
      if (destStates.get((String)state.getKey()) == 0) continue;
      if (state.getKey().equals(originState)) continue;

      Vector2D dv = ((Vector2D)state.getValue());
      float frac = (float)destStates.get((String)state.getKey())/totalDest;
      int dist = (int)sqrt(pow(dv.x-ov.x, 2) + pow(dv.y-ov.y, 2));

      stroke(lerpColor(GREEN, RED, frac));
      curve(ov.x, ov.y, -1000+dist, ov.x, ov.y, 0, dv.x, dv.y, 0, dv.x, dv.y, -1000+dist);
    }

    //Draw 3D model
    scale(100);
    shape(usaMap);
    popMatrix();

    //Draw UI
    cam.beginHUD();
    originStateInput.draw(false);

    //Draw destination states table
    text("Destination States", width-150, 185);
    int i=0, j=0;
    for (String airport : destStates.keys()) {
      float frac = (float)destStates.get(airport)/totalDest;
      stroke(0);
      if (i<destStates.size()/2) {
        if (frac!=0) fill(lerpColor(GREEN, RED, frac));
        else fill(100);
        rect(width-250, 200+(i*25), 100, 25);

        fill(0);
        text(airport+" : "+destStates.get(airport), width-200, 215+(i*25));
        i++;
      } else {
        if (frac!=0) fill(lerpColor(GREEN, RED, frac));
        else fill(100);
        rect(width-150, 200+(j*25), 100, 25);

        fill(0);
        text(airport+" : "+destStates.get(airport), width-100, 215+(j*25));
        j++;
      }
    }
    cam.endHUD();
  }

  @Override
    public void onFocusChanged(boolean isInFocus) {
    if (isInFocus) cam.setActive(true);
    else {
      cam.setActive(false);
      cam.reset(0);
    }
  }

  /**
   * Updates textbox with keyboard input.
   */
  public void keyClick() {
    originStateInput.keyClicked();

    if (originStateInput.getText().length() == 0) originStateInput.hideOptions();
    else if (originStateInput.getText().length() == 1) originStateInput.showOptions();
    else originStateInput.updateOptions();

    if (stateLocations.containsKey(originStateInput.getText().toUpperCase())) setOriginState(originStateInput.getText().toUpperCase());
  }

  /**
   * Sets the origin state to the given state and updates the destination states.
   *
   * @param  newState  The name of the new origin state.
   */
  void setOriginState(String newState) {
    originState = newState;
    ArrayList<String> originOccurrence = data.getOccurrencesList(Arrays.binarySearch(availableStates, newState), 5);
    totalDest = originOccurrence==null ? 1 : originOccurrence.size();

    for (String state : allStates) {
      if (state.equals(newState)) {
        destStates.set(state, 0);
        continue;
      }
      if (originOccurrence==null) destStates.set(state, 0);
      else {
        int optionFreq = 0;
        for (String line : originOccurrence) if (line.contains(state)) optionFreq++;
        destStates.set(state, optionFreq);
      }
    }
  }
}

class Vector2D {
  float x;
  float y;
  Vector2D(float x, float y) {
    this.x = x;
    this.y = y;
  }
}
