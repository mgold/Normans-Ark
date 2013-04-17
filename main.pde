static final int DEFAULT_HEIGHT = 600;
static final int DEFAULT_WIDTH = 800;
static final float DEFAULT_TEXT_SIZE = 12;
static final float CANVAS_DIV = .6;
static final float MARGIN = .025;

ArrayList<CircleSprite> circles;
DataModel data;
Sprite selected = null;

final float CIRCLESPACING = 5.0;
final float XACCEL = 1.0;
final int MAXFORCEITERS = 800;

void setup(){
    size(DEFAULT_WIDTH, DEFAULT_HEIGHT);
    textAlign(CENTER, CENTER);
    textSize(DEFAULT_TEXT_SIZE);

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
        c.setY(25.0, keyMin, height-50.0, keyMax);
    }

    applyForces();

    //add more (non-circle) sprites here...

}

void draw(){
    background(#FFFFFF);
    fill(#000000);

    for (Sprite s : circles){
        s.update();
    }

    for (Sprite s : circles){
        s.draw();
    }
    
    // Drawing the text for circles separately, otherwise
    // if circles are too close to each other the text of one
    // will disappear behind another circle if that other circle
    // was drawn after the one being hovered over.
    for(Sprite s : circles)
    {
        s.drawText();
    }
}

void applyForces() {
    boolean moved = true;
    int i = 0;
    while(i < MAXFORCEITERS){
        moved = false;
        for(CircleSprite a : circles) {
            for(CircleSprite b : circles) {
                if(a != b) {
                    moved |= a.repelFrom(b);
                }
            }
        }
        i++;
        println(i);
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
    s.deselect(); // and not selected
  }

  // if user clicked on a sprite, fade the others
  if ( selected != null ) {
    selected.select();
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
