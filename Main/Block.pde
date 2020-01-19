/*
 * BLOCK (superclass)
 */
class Block {
  float posX;
  float posY;
  long sessionID;
  int symbolID;
  
  Block(float x, float y, long sessId, int symbId) {
    posX = x;
    posY = y;
    sessionID = sessId;
    symbolID = symbId;
  }
  
  void updatePos(float x, float y) {
    posX = x;
    posY = y;
  }
}

/*
 * BLOCK (childclasses)
 */
class CommandBlock extends Block {
  CommandBlock(float x, float y, long sessId, int symbId) {
    super(x, y, sessId, symbId);
  }
}

class ContainerBlock extends Block {
  ContainerBlock(float x, float y, long sessId, int symbId) {
    super(x, y, sessId, symbId);
  }
}

class ClosingBlock extends Block {
  ClosingBlock(float x, float y, long sessId, int symbId) {
    super(x, y, sessId, symbId);
  }
}
