static final int DEFAULT_HEIGHT = 600;
static final int DEFAULT_WIDTH = 800;

ArrayList<CircleSprite> circles;
DataModel data;
Sprite selected = null;

final float CIRCLESPACING = 5.0;
final float YACCEL = 2.0;

void setup(){
    size(DEFAULT_WIDTH, DEFAULT_HEIGHT);
    textAlign(CENTER, CENTER);
    textSize(12);

    data = new DataModel();

    circles = new ArrayList(data.getNumErrors());
    for (int i = 0; i < data.getNumErrors(); i++){
        circles.add(new CircleSprite(i));
    }

    float keyMin = 100;
    float keyMax = -1;
    for (CircleSprite s : circles){
        float sortKey = s.sortKey();
        if (sortKey < keyMin){
            keyMin = sortKey;
        }
        if (sortKey > keyMax){
            keyMax = sortKey;
        }
    }

    for (CircleSprite c : circles){
        c.setX(25.0, keyMin, width-50.0, keyMax);
    }

    //add more (non-circle) sprites here...

}

void draw(){
    background(#FFFFFF);
    fill(#000000);

    applyForces();

    for (Sprite s : circles){
        s.update();
    }

    for (Sprite s : circles){
        s.draw();
    }
}

void applyForces() {
    for(CircleSprite a : circles) {
        for(CircleSprite b : circles) {
            if(a != b) {
                a.repelFrom(b);
                b.repelFrom(a);
            }
        }
    }
}

void mouseClicked(){
  Sprite prevSelected = selected;
  selected = null; 

  // determine if user is clicking on a sprite
  for ( Sprite s : circles ) {
    if ( s.intersects( mouseX, mouseY ) ) {
      if ( prevSelected != null && prevSelected.equals( s ) ) {
        selected = null;
      } else {
        selected = s;
        println(s);
      }
    }
    s.focus(); // by default, everything should be in focus
  }

  // if user clicked on a sprite, fade the others
  if ( selected != null ) {
    for ( Sprite s : circles ) {
      if ( !s.equals( selected ) ) {
        s.fade(); 
      }
    }
  }
}

void mouseMoved() {
  for ( Sprite s : circles ) {
    if ( s.intersects( mouseX, mouseY ) ) {
      s.setHighlight();
    } else {
      s.unsetHighlight();
    }
  }
}
