final float MAXCIRCLESIZE = 100;

class CircleSprite extends Sprite{
    ErrorModel model;

    CircleSprite(int id){
        super(id);
        model = data.getError(id);
        int numErrors = data.getNumErrors();
        x = (1+id)*width/(numErrors+1);
        y = height/2;
        h = w = MAXCIRCLESIZE*model.getNumFailers()/data.getNumStudents();
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
