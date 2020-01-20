abstract class Statement {
  Character c;
  
  abstract void execute();
  abstract String toString();
}

/*
 *
 * BLOCK STATEMENT
 *
 */
class BlockStatement extends Statement {
  
  ArrayList<Statement> statements = new ArrayList();
  final int PAUSE_TIME = 1000;
  
  BlockStatement() {}
  
  void add(Statement s) {statements.add(s);}
  
  void execute() {
    for (Statement s : statements) {
      s.execute();
      
      // update canvas
      // canvas.update();
      
      // pause between statements
      int time = millis();
      while (millis() - time < PAUSE_TIME) {};
    }
  }
  
  String toString() {
    String str = "Blocks: (\n";
    for (Statement s : statements) {
      str += s.toString() + "\n";
    }
    str += ")";
    
    return str;
  }
  
  ArrayList<Statement> asArray() {
    println(recursionPrint(statements, "["));
    return statements; //<>//
  }
  
  String recursionPrint(ArrayList<Statement> arr,String str) {
    //terminate
    if (arr.size() == 0)
      return str + "]";
    
    Statement current = arr.get(0);
    if (current instanceof BlockStatement) {
      BlockStatement newcurr = (BlockStatement) current;
      return recursionPrint(new ArrayList<Statement>(arr.subList(1, arr.size())), recursionPrint(newcurr.statements, "["));
    }

    return recursionPrint(new ArrayList<Statement> (arr.subList(1, arr.size())), str + current.toString());
  }
}



/*
 *
 * CONTROL STATEMENTS
 *
 */
// Move Character forward (in correlation to where it's facing)
class MoveStatement extends Statement {
  
  MoveStatement(Character c) {this.c = c;}
  
  void execute() {
    int curX = c.posX;
    int curY = c.posY;
    // if character has 4 states (v<>^)
    switch (c.state) {
      case 0:
        curY += 32;
        break;
      case 1:
        curX -= 32;
        break;
      case 2:
        curY -= 32;
        break;
      case 3:
        curX += 32;
        break;
    }
    c.setPos(curX, curY);
    c.display();
  }
  
  String toString() {return "move";}
}

// Turn Character
class TurnStatement extends Statement {
  String direction;
  TurnStatement(Character c, String direction) {
    this.c = c;
    this.direction = direction;
  }
  
  void execute() {
    if (direction.equals("right")) {
      c.turn(1);
    } else if (direction.equals("left")) {
      c.turn(-1);
    }
    
    c.display();
  }
  
  String toString() {return "turn";}
}

/*
 *
 * CONTAINER STATEMENTS
 *
 */

class ConditionalStatement extends Statement {
  BlockStatement statements;
  boolean value;
  
  ConditionalStatement(String comparator, Object arg1, Object arg2, BlockStatement statements) {
    this.statements = statements;
  }
  
  void execute() {
    if (value) {
      statements.execute();
    }
  }
  String toString() {return "if statement";}
}

class LoopStatement extends Statement {
  BlockStatement statements;
  boolean value;
  String condition;
  Object[] args;
  
  LoopStatement(String condition, String[] args, BlockStatement statements) {
    this.statements = statements;
    this.condition = condition;
    this.args = args;
  }
  
  LoopStatement(String condition, Sprite[] args, BlockStatement statements) {
    this.statements = statements;
    this.condition = condition;
    this.args = args;
  }
  
  void execute() {
    checkCondition();
    while (value) { //<>//
      statements.execute();
      // update value
      checkCondition();
    }
  }
  
  void checkCondition() {
    switch (condition) {
      case "loopUntilGoal": value = !isOnGoal(); break;
    }
  }
  
  boolean isOnGoal() {
    Sprite sprite = (Sprite) args[0];
    Sprite target = (Sprite) args[1];
    
    if (sprite.posX == target.posX &&
        sprite.posY == target.posY)
        return true;
    return false;
  }
  
  String toString() {return "loop - " + statements.toString();}
}
