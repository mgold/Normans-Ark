static final int DEFAULT_HEIGHT = 600;
static final int DEFAULT_WIDTH = 800;
static final float DEFAULT_TEXT_SIZE = 12;
static final float CANVAS_DIV = .6;
static final float MARGIN = .0125;
static final float COMMENT_LINE_HEIGHT = 30;
static final float COMMENT_LINE_MARGIN = 10;
static final float MAXCIRCLESIZE = 0.4 * DEFAULT_HEIGHT;
static final float CIRCLESPACING = 5.0;

DataModel data;
ArrayList<CircleSprite> circles;
DetailSprite detail;
CommentSprite comment;
ScaleSprite scale;

void setup(){
    size(DEFAULT_WIDTH, DEFAULT_HEIGHT);
    textAlign(CENTER, CENTER);
    textSize(DEFAULT_TEXT_SIZE);

    data = new DataModel();
    detail = new DetailSprite(null);
    comment = new CommentSprite(data.getNumCommentLines());

    circles = new ArrayList();
    for (int i = 0; i < data.getNumErrors(); i++){
        CircleSprite c = new CircleSprite(i);
        circles.add( c );
        data.addCircle( c, i );
    }

    //bubble sort by grade given error
    for (int i=0; i<circles.size(); i++){
        for (int j=0; j<circles.size()-1; j++){
            if (circles.get(j).sortKey()> circles.get(j+1).sortKey()){
                CircleSprite removed = circles.remove(j);
                circles.add(j+1, removed);
            }
        }
    }

    //save important values
    float rMax=0;
    for (CircleSprite c : circles){
        if (c.getRadius() > rMax){
            rMax = c.getRadius();
        }
    }
    rMax += CIRCLESPACING;
    float yMax   = height-comment.getH()-rMax;
    float keyMin = circles.get(0).sortKey();
    float keyMax = circles.get(circles.size()-1).sortKey();

    //bubble sort by radius
    for (int i=0; i<circles.size(); i++){
        for (int j=0; j<circles.size()-1; j++){
            if (circles.get(j).getRadius() < circles.get(j+1).getRadius()){
                CircleSprite removed = circles.remove(j);
                circles.add(j+1, removed);
            }
        }
    }

    //assign Y values
    for (CircleSprite c : circles){
        c.setY(rMax, keyMin, yMax, keyMax);
    }

    //assign X values
    for (CircleSprite c : circles){
        c.setX(circles);
    }

    scale = new ScaleSprite(keyMin, keyMax, yMax, rMax);

}

void draw(){
    background(#FFFFFF);
    fill(#000000);

    for (Sprite s : circles){
        s.update();
    }
    detail.update();
    comment.update();

    for (Sprite s : circles){
        s.draw();
        s.drawText();
    }

    for(Sprite s : circles)
    {
        s.drawHoverText();
    }

    detail.draw();
    comment.draw();
    scale.draw();
}

void mouseClicked(){
    boolean newSelection = false;
    for ( CircleSprite s : circles ){
        if ( s.intersects( mouseX, mouseY ) ) {
            if ( data.getSelected() == s ) {
                data.clearSelected();
                detail.setModel(null);
            } else {
                data.setSelected(s);
                detail.setModel(s.model);
            }
            newSelection = true;
            break;
        } else if ( detail.intersects( mouseX, mouseY ) ) {
          newSelection = true; 
        }
    }

    if ( data.getSelected() != null ) {
      if ( mouseX < CANVAS_DIV*width ) {
          if ( !newSelection ) {
            data.clearSelected();
            detail.setModel( null );
            newSelection = true;
          }
      } else {
        detail.mouseClick( mouseX, mouseY );
      }
    }

    if ( newSelection ){
        if ( data.getSelected() != null ){
            for ( CircleSprite s : circles ){
                s.fade();
            }
            data.getSelected().focus();
        } else {
            for ( CircleSprite s : circles ){
                s.focus();
            }
        }
    }
}

void mouseMoved(){
    for (Sprite s : circles ){
        if (s.intersects(mouseX, mouseY )){
            s.setHighlight();
        } else {
            s.unsetHighlight();
        }
    }
    
    if ( mouseX > CANVAS_DIV*width ) {
      detail.mouseOver( mouseX, mouseY );
    }
}
