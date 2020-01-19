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
}
