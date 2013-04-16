final float MAXCIRCLESIZE = 0.4 * DEFAULT_HEIGHT;

class CircleSprite extends Sprite{
    ErrorModel model;
    float dx;

    CircleSprite(int errID){
        super();
        model = data.getError(errID);
        this.setColor(data.colorIDForCategory(model.getCategory()));
        int numErrors = data.getNumErrors();
        x = width*random(.3, .7);
        y = (1+errID)*height/(numErrors+1);
        h = w = MAXCIRCLESIZE*model.getNumFailers()/data.getNumStudents();
        dx = 0.0;
    }

    float sortKey(){
        return model.getGradeGivenError();
    }

    void setY(float yMin, float keyMin, float yMax, float keyMax){
        float keyRange = keyMax - keyMin;
        float frac = (this.sortKey() - keyMin)/keyRange;
        float yRange = yMax - yMin;
        y = yRange*(1-frac) + yMin;
    }

    String toString(){
        return (model.getName()+" ("+model.getCategory()+
            ") "+str(model.getNumFailers())+" failers get "+
            str(model.getGradeGivenError()));
    }

    boolean repelFrom(CircleSprite other){
      float distance = dist(x, y, other.getX(), other.getY());
      float theta = atan2(y - other.getY(), x - other.getX());
      if (distance < this.getRadius()+ other.getRadius()+CIRCLESPACING){
          println("repelling "+model.getName()+" from "+other.model.getName()+" at "+distance);
          dx += XACCEL*cos(theta);
          return true;
      }
      return false;
    }

    float getRadius(){
        return h/2;
    }

    void update(){
        x += dx;
        x = bound(w, x, width*CANVAS_DIV);
        dx = 0;
    }

    void draw(){
        super.draw();
        fill(fc);
        ellipse(x,y,w,h);
        if ( w > 50 ) { // TODO replace this with better test
          textAlign( CENTER, CENTER );
          fill(tc);
          text(model.getName(), x-.5*w, y-.5*h, w, h);
        } else if (displayMouseover) {
          textAlign(LEFT, CENTER);
          // first the drop shadow
          fill(#ffffff);
          text( model.getName(), mouseX-1, mouseY-11 );
          fill(#000000);
          text( model.getName(), mouseX, mouseY-10 );
        }
    }

    boolean intersects(int _x, int _y) {
      float dist = sqrt( (_x - x) * (_x - x) + (_y - y) * (_y - y) );

      if (dist > w/2) {
        return false;
      } else {
        return true;
      }
    }

}
