static final float DEFAULT_BAR_HEIGHT = 25;
private static final float DEFAULT_BAR_WIDTH = 150;
static final float DEFAULT_TEXT_WIDTH = 75;

class BarSprite extends Sprite {
  private StudentModel student;

    BarSprite( StudentModel studentModel, float _x, float _y, float _w, float _h ){
        super();
        x = _x;
        y = _y;
        w = _w;
        h = _h;
        this.student = studentModel;
    }
    
    void draw(){
        super.draw();
        
        fill(tc);
        textAlign( LEFT, CENTER );
        text( "Little Timmy", x, y+(.5*h) );
        //text( student.getName(), x, y );

        fill(fc);
        float _x = width-(MARGIN*DEFAULT_WIDTH)-w;
        rect(_x,y,w,h);
    }

    void update(){
        ;
    }

    boolean intersects( int _x, int _y ) {
      if ( _x >= x && _x <= x + w &&
           _y >= y && _y <= y + h ) {
         return true;
       } else {
         return false;
       } 
    }
    
}
