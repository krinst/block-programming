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
    for (Sprite s : sprites) {
      s.display();
    }
  }
}
