abstract class Sprite {
  int posX;
  int posY;
  
  abstract void display();
  
  void setPos(int x, int y) {
    posX = x;
    posY = y;
  }
  
  int[] getPos() {
    int[] pos = {posX, posY};
    return pos;
  }
}

class Character extends Sprite {
  PImage[] cModel;
  int state = 0;
  
  Character(String imgFile, int count) {
    cModel = new PImage[count];
    for (int i = 0; i < count; i++) {
      String fileName = imgFile + nf(i, 3) + ".png";
      cModel[i] = loadImage(fileName);
    }
  }
  
  void display() {
    image(cModel[state], posX, posY);
  }
  
  void turn(int val) {
    state += val;
    if (state == -1) {
      state = cModel.length - 1;
    } else if (state >= cModel.length) {
      state = 0;
    }
  }
  
  String getDirection() {
    switch (state) {
      case 0: return "down";
      case 1: return "right";
      case 2: return "up";
      case 3: return "left";
      default: return "ERROR";
    }
  }
  
  boolean isOn(Character c) {
    if (this.posX == c.posX &&
        this.posY == c.posY)
        return true;
    return false;
  }
  
  void placeAtRandom() {
    float tileX = random(0, 20);
    float tileY = random(0, 20);
    
    int x = 10 + ((int) tileX * 32);
    int y = 10 + ((int) tileY * 32);
    
    setPos(x, y);
    
    //float x = random(10, rangeX - 22);
    //float y = random(10, rangeY - 22);
    //setPos( (int) x, (int) y );
  }
}
