static final int DEFAULT_HEIGHT = 600;
static final int DEFAULT_WIDTH = 800;
static final float DEFAULT_TEXT_SIZE = 12;
static final float CANVAS_DIV = .6;
static final float MARGIN = .025;

ArrayList<CircleSprite> circles;
DataModel data;
Sprite selected = null;

void setup(){
    size(DEFAULT_WIDTH, DEFAULT_HEIGHT);
    textAlign(CENTER, CENTER);
    textSize(DEFAULT_TEXT_SIZE);

    data = new DataModel();

    circles = new ArrayList(data.getNumErrors());
    for (int i = 0; i < data.getNumErrors(); i++){
        circles.add(new CircleSprite(i));
    }

    //bubble sort by grade given error
    for (int i=0; i<circles.size(); i++) {
        for (int j=0; j<circles.size() -1; j++) {
            if (circles.get(j).sortKey() > circles.get(j+1).sortKey()){
                CircleSprite removed = circles.remove(j);
                circles.add(j+1, removed);
            }
        }
    }

    //assign Y values
    float keyMin = circles.get(0).sortKey();
    float keyMax = circles.get(circles.size() -1).sortKey();
    for (CircleSprite c : circles){
        c.setY(25.0, keyMin, height-50.0, keyMax);
    }

    //bubble sort shallow copy by descending circle radius
    ArrayList<CircleSprite> circlesBySize = new ArrayList(circles);
    for (int i=0; i<circlesBySize.size(); i++) {
        for (int j=0; j<circlesBySize.size() -1; j++) {
            if (circlesBySize.get(j).getRadius() < circlesBySize.get(j+1).getRadius()){
                CircleSprite removed = circlesBySize.remove(j);
                circlesBySize.add(j+1, removed);
            }
        }
    }

    //assign X values
    for (CircleSprite c : circlesBySize){
        c.setX(circlesBySize);
    }


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
        s.drawText();
    }

    // Drawing the hover text for circles separately, otherwise
    // if circles are too close to each other the text of one
    // will disappear behind another circle if that other circle
    // was drawn after the one being hovered over.
    for(Sprite s : circles)
    {
        s.drawHoverText();
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
