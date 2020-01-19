/*
 * BLOCKMANAGER (Only create once)
 */
class BlockManager {
  ArrayList<Block> blocks = new ArrayList();
  HashMap<Integer, String> blockLabels = new HashMap<Integer, String>();
  Character character;
  
  BlockManager() {
    // Match blocks to its name
    // Command Blocks (0 - )
    blockLabels.put(0, "move");
    blockLabels.put(1, "turn right");
    blockLabels.put(2, "turn left");
    
    // Container Blocks (10 - )
    blockLabels.put(10, "loop forever");
    blockLabels.put(11, "loop until cat");
    blockLabels.put(12, "loop twice");
    
    // Closing Block
    blockLabels.put(34, "close");
    // Play Block
    blockLabels.put(35, "play");
  }
  
  void add(Block block) {blocks.add(block);}
  
  void add(float x, float y, long sessId, int symbId) {
    if (blockLabels.containsKey(symbId)) {
      if (symbId < 10) {
        add(new CommandBlock(x, y, sessId, symbId));
      }
      else if (symbId < 20) {
        add(new ContainerBlock(x, y, sessId, symbId));
      }
      else if (symbId == 34) {
        add(new ClosingBlock(x, y, sessId, symbId));
      }
    }
  }
  
  void remove(long id) {blocks.remove(find(id));}
  void remove(int ref) {blocks.remove(ref);}
  
  void update(int ref, float x, float y) {blocks.get(ref).updatePos(x, y);}
  
  int find(long id) {
    for (int i = 0; i < blocks.size(); i++) {
      Block block = blocks.get(i);
      if (block.sessionID == id) {
        return i;
      }
    }
    return -1;
  }
  
  void sort() {
    Block temp;
        for (int i = 1; i < blocks.size(); i++) {
            for(int j = i ; j > 0 ; j--){
                if(blocks.get(j).posY < blocks.get(j-1).posY){
                    temp = blocks.get(j);
                    blocks.set(j, blocks.get(j-1));
                    blocks.set(j-1, temp);
                }
            }
        }
  }
  
  boolean validate() { // Checks that all container blocks (conditionals, loops) are matched with a closing block
    int childLevel = 0;
    
    for (int i = 0; i < blocks.size(); i++) {
      if (blocks.get(i) instanceof ContainerBlock) {
        childLevel++;
      } else if (blocks.get(i) instanceof ClosingBlock) {
        childLevel--;
      }
      
      if (childLevel < 0) {
        return false;
      }
    }
    
    if (childLevel == 0) {
      return true;
    }
    return false;
  }
  
  void executeProgram() {
    sort();
    println("success sorting");
    
    if (validate()) {
      println("valid");
      BlockStatement commands = createBlockStatement(blocks);
      println("commands made");
      println(commands.toString());
      commands.execute();
      println("execution successful");
    }
  }
  
  private BlockStatement createBlockStatement(ArrayList<Block> blockList) {
    return createBlockStatement(blockList, new BlockStatement());
  }
  
  private BlockStatement createBlockStatement(ArrayList<Block> blockList, BlockStatement bs) {
    if (blockList.isEmpty()) {
      return bs;
    }
    Block block = blockList.get(0);
    if (block instanceof ClosingBlock) {
      return bs;
    }
    if (block instanceof ContainerBlock) {
      // if condition
      bs.add( new ConditionalStatement( "comparator", "arg1", "arg2", createBlockStatement( new ArrayList<Block>(blockList.subList(1, blockList.size())) ) ) );
      
      // loop
      bs.add( new LoopStatement( "comparator", "arg1", "arg2", createBlockStatement( new ArrayList<Block>(blockList.subList(1, blockList.size())) ) ) );
      
    }
    // switch to decide statement
    switch ( blockLabels.get(block.symbolID) ) { //<>//
      case "move": bs.add(new MoveStatement(character)); break;
      case "turn right": bs.add(new TurnStatement(character, "right")); break;
      case "turn left": bs.add(new TurnStatement(character, "left")); break;
    }
    //
    return createBlockStatement( new ArrayList<Block>(blockList.subList(1, blockList.size())), bs );
  }
}
