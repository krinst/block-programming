//class ConditionalStatement extends Statement{
//  String comparator;
//  Object[] args;
  
//  ConditionalStatement(String comparator, Object[] args) {
//    this.comparator = comparator;
//    this.args = args;
//  }
//  void execute() {}
//  String toString() {return "If: " + container + " " + args.toString();}
  
//  boolean isEquals() {
//    return args[0] == args[1];
//  }
  
//  boolean isOn() {
//    if (! (args[0] instanceof Sprite) ) {
//      return false;
//    }
    
//    Sprite[] sprites = new Sprite[2];
    
//    for (int i = 0; i < args.length; i++) {
//      sprites[i] = (Sprite) args[i];
//    }
    
//    int[] pos1 = sprites[0].getPos();
//    int[] pos2 = sprites[1].getPos();
    
//    if (pos1.length == pos2.length) {
//      for (int i = 0; i < pos1.length; i++) {
//        if (pos1[i] != pos2[i]) {
//          return false;
//        }
//      }
//      return true;
//    }
//    return true;
//  }
//}

//class LoopStatement extends Statement {
//  void execute() {}
//  String toString() {return "loop";}
//}

  //void execute() {
  //  if (container != null) {
  //    if (container instanceof LoopStatement) {
  //      boolean state = true;
  //      while (state) {
  //        executeAll();
  //      }
  //    } else {
  //      boolean state = true;
  //      if (state) {
  //        executeAll();
  //      }
  //    }
  //  } else {
  //    executeAll();
  //  }
  //}
  
  //void executeAll() {
  //  for (Statement s : statements) {
  //    s.execute();
      
  //    // update canvas
  //    // canvas.update();
      
  //    // pause between statements
  //    int time = millis();
  //    while (millis() - time < PAUSE_TIME) {};
  //  }
  //}
  
  //private BlockStatement createBlockStatement(ArrayList<Block> blockList) {
  //  BlockStatement bStatement = new BlockStatement();
  //  for (int i = 0; i < blockList.size(); i++) {
  //    Block block = blockList.get(i);
  //    if (block instanceof ClosingBlock) {
  //      return bStatement;
  //    }
      
  //    if (block instanceof ContainerBlock) {
  //      createBlockStatement( new ArrayList<Block>(blockList.subList(i + 1, blockList.size())) );
  //    } else {
        
  //    }
        
  //  }
  //}
