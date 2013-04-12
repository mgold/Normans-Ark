static final int DEFAULT_HEIGHT = 600;
static final int DEFAULT_WIDTH = 800;
ArrayList<Sprite> sprites;
DataModel data;

void setup(){
    size(DEFAULT_WIDTH, DEFAULT_HEIGHT);
    textAlign(CENTER, CENTER);
    textSize(12);

    data = new DataModel();

    sprites = new ArrayList(data.getNumErrors());
    for (int i = 0; i < data.getNumErrors(); i++){
        sprites.add(new CircleSprite(i));
    }

}

void draw(){
    background(#FFFFFF);
    fill(#000000);

    for (Sprite s : sprites){
        s.update();
    }

    for (Sprite s : sprites){
        s.draw();
    }
}

void mouseClicked(){
    ;
}

void mouseMoved() {
  for ( Sprite s : sprites ) {
    if ( s.intersects( mouseX, mouseY ) ) {
      s.setHighlight();
    } else {
      s.unsetHighlight();
    }
  }
}
