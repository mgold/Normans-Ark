final float MAXCIRCLESIZE = 100;

class CircleSprite extends Sprite{
    ErrorModel model;
    float velocityY = 0.0;

    CircleSprite(int errID){
        super();
        model = data.getError(errID);
        this.setColor(data.colorIDForCategory(model.getCategory()));
        int numErrors = data.getNumErrors();
        x = (1+errID)*width/(numErrors+1);
        y = height/2;
        h = w = MAXCIRCLESIZE*model.getNumFailers()/data.getNumStudents();
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

    float getEnergy()
    {
      return sq(velocityY) / 2;
    }

    void setVelocityY(float vY)
    {
      velocityY = vY;
    }

    float getVelocityY()
    {
      return velocityY;
    }

    void update(){
        ;
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
