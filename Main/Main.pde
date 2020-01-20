// Libraries
import TUIO.*;

// Declarations & Variables
TuioProcessing tuioClient;
Canvas canvas;
ArrayList<Sprite> sprites;
//HashMap<String, Sprite> sprites2;
BlockManager bm;
ArrayList<Statement> statementsList;
final int PAUSE_TIME = 1000;

boolean running = false;
boolean testingMode = true;


/*
 * SETUP
 */
void setup(){
  fullScreen();
  
  // Create an array of sprites that will show in the canvas
  sprites = new ArrayList();
  //sprites2 = new HashMap();
  
  // Create the main character controlled by user
  Character mainCharacter = new Character("tile", 4);
  mainCharacter.setPos(298, 298);
  
  sprites.add(mainCharacter);
  //sprites2.put("main character", mainCharacter);
  
  // Create a goal character (cat)
  Character cat = new Character("cat", 1);
  cat.setPos(330, 330);
  
  sprites.add(cat);
  //sprites2.put("goal", cat);
  
  // Create a Canvas instance
  canvas = new Canvas(sprites);
  
  // Create BlockManager
  bm = new BlockManager();
  bm.character = (Character) sprites.get(0);
  bm.target = (Character) sprites.get(1);
  
  // Create a TuioProcessing client instance
  tuioClient = new TuioProcessing(this);
}


/*
 * DRAW
 */
void draw(){
  // Refresh background
  background(200);
  
  // Update canvas
  canvas.update();
  
  // Run programme if running is true
  //if (running) {
  //  bm.executeProgram();
  //  running = false;
  //}
  if (running) {
    if (statementsList.size() > 0) {
      executeFirst(statementsList);
    } else {
      running = false;
    }
  }
  
  // Only use in testing mode, shows the location of the blocks
  if (testingMode) {
    ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
    
    for (int i = 0; i < tuioObjectList.size(); i++) {
      TuioObject tobj = tuioObjectList.get(i);
      String displayText = "SymbolID: " + tobj.getSymbolID() + " - SessionID: " + tobj.getSessionID();
      
      fill(50);
      text(displayText, tobj.getScreenX(width), tobj.getScreenY(height));
    }
  }
}


/*
 * CALLBACK METHODS
 */
// When a TUIO Object is added
void addTuioObject(TuioObject tobj) {
  if (testingMode) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
  
  if (tobj.getSymbolID() == 35) {
    getStatementArray();
    running = true; //<>//
  } else {
    bm.add(tobj.getX(), tobj.getY(), tobj.getSessionID(), tobj.getSymbolID());
  }
}

// When a TUIO Object is moved
void updateTuioObject (TuioObject tobj) {
  /*if (testingMode) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());*/
  
  int val = bm.find(tobj.getSessionID());
  if (val != -1) {
    bm.update(val, tobj.getX(), tobj.getY());
  }
}

// When a TUIO Object is removed
void removeTuioObject(TuioObject tobj) {
  if (testingMode) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
  
  if (tobj.getSymbolID() == 35) {
    running = false;
  } else {
    int val = bm.find(tobj.getSessionID());
    if (val != -1) {
      bm.remove(val);
    }
  }
}

/*
 * EXECUTE PROGRAM STEP BY STEP
 */
// Execute and remove first statement from list
void executeFirst(ArrayList<Statement> sl) {
  Statement s = sl.get(0);
  //println("executing: " + s.toString());
  s.execute();
  canvas.update();
  sl.remove(0);
  int time = millis();
  while (millis() - time < PAUSE_TIME) {}
}

void getStatementArray() {
  bm.sort();
  if (bm.validate()) {
    statementsList = bm.createBlockStatement(bm.blocks).asArray();
  }
}
