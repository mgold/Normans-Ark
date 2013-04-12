abstract class Sprite{
    final int DEFAULT_STROKE_WEIGHT = 3;
    final int NO_STROKE_COLOR = -1;
    final int STROKE_COLOR = 100;
    ColorModel colorModel = new ColorModel();
    float x, y;
    float h, w;
    color fc, sc, dc, hc, tc; // fill; stroke; default; highlight; text

    Sprite(){
        x = y = h = w = 0;
        sc = NO_STROKE_COLOR;
        strokeWeight( DEFAULT_STROKE_WEIGHT*(width/main.DEFAULT_WIDTH) );
    }
    
    Sprite(int id) {
      this();
      dc = colorModel.getColor( id );
      hc = colorModel.getFaded( dc ); 
      tc = colorModel.getTextColor( id );
      fc = dc;
    }

    Sprite(float _x, float _y, float _h, float _w){
        x = bound(0, _x, width);
        y = bound(0, _y, height);
        h = _h;
        w = _w;
        fc = #AAAAAA; // grey fill
        sc = -1; // no stroke
    }

    void update(){
        ;
    }

    void draw(){
        if (fc == -1){
            noFill();
        }else{
            fill(fc);
        }
        if (sc == -1){
            noStroke();
        }else{
            stroke(sc);
        }
    }
    
    abstract boolean intersects(int _x, int _y);
    
    
    void setHighlight() {
      sc = STROKE_COLOR;
    }
    
    void unsetHighlight() {
      sc = NO_STROKE_COLOR;
    }
    
    void fade() {
       fc = hc; // set the active color to the highlight value
    }
    
    void focus() {
      fc = dc; // set the active color to the default fill value
    }
    
    boolean isFocused() {
      return fc == dc; 
    }

}
