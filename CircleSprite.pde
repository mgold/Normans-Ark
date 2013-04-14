final float MAXCIRCLESIZE = 100;

class CircleSprite extends Sprite{
    ErrorModel model;
    float dy;

    CircleSprite(int errID){
        super();
        model = data.getError(errID);
        this.setColor(data.colorIDForCategory(model.getCategory()));
        int numErrors = data.getNumErrors();
        x = (1+errID)*width/(numErrors+1);
        y = height*random(.2, .8);
        h = w = MAXCIRCLESIZE*model.getNumFailers()/data.getNumStudents();
        dy = 0.0;
    }

    float sortKey(){
        return model.getGradeGivenError();
    }

    void setX(float xMin, float keyMin, float xMax, float keyMax){
        float keyRange = keyMax - keyMin;
        float frac = (this.sortKey() - keyMin)/keyRange;
        float xRange = xMax - xMin;
        x = xRange*frac + xMin;
    }

    String toString(){
        return (model.getName()+" ("+model.getCategory()+
            ") "+str(model.getNumFailers())+" failers get "+
            str(model.getGradeGivenError()));
    }


    void repelFrom(CircleSprite other){
      float distance = dist(x, y, other.getX(), other.getY());
      float theta = atan2(other.getY()-y, other.getX()-x);
      if (distance < this.getRadius()+ other.getRadius()+CIRCLESPACING){
          if (selected == this){
              println(distance+" "+this.getRadius()+" "+other.getRadius());
          }
          dy += YACCEL*sin(theta);
      }
    }

    float getRadius(){
        return h;
    }

    void update(){
        y += dy;
        y = bound(h, y, height-h);
    }

    void draw(){
        super.draw();
        fill(fc);
        ellipse(x,y,w,h);
        fill(tc);
        text(model.getName(), x, y);
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
