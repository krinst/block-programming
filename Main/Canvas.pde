class Canvas {
  ArrayList<Sprite> sprites;

  
  //Canvas() {
  //  rect(10, 10, 640, 640);
  //}
  
  Canvas(ArrayList<Sprite> sprites) {
    this.sprites = sprites;
  }
  
  void update() {
    fill(255);
    rect(10, 10, 640, 640);
    createGrid(10, 10, 640, 640, 32);
    for (Sprite s : sprites) {
      s.display();
    }
  }
  
  void createGrid(int startX, int startY, int width, int length, int gap) {
    stroke(150);
    for (int i = startX + gap; i < startX + width + gap; i += gap) {
      line(i, startY, i, startY + length);
    }
    for (int i = startY + gap; i < startY + length + gap; i += gap) {
      line(startX, i, startX + width, i);
    }
  }
}
