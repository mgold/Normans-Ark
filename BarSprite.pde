class BarSprite extends Sprite {
  private static final float DEFAULT_HEIGHT = 40;
  private static final float DEFAULT_WIDTH = 200;

    BarSprite(){
        super();
        x = width/2; // TODO change this
        y = height/2; // TODO change this
        h = DEFAULT_HEIGHT*(height/main.DEFAULT_HEIGHT);
        w = DEFAULT_WIDTH*(width/main.DEFAULT_WIDTH);
    }
    
    void draw(){
        super.draw();
        fill(fc);
        rect(x,y,w,h);
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
