abstract class Sprite{
    ColorModel colorModel = new ColorModel();
    float x, y;
    float h, w;
    color fc, sc, dc, hc; // fill; stroke; default; highlight

    Sprite(){
        x = y = h = w = 0;
        sc = fc = -1;
    }
    
    Sprite(int id) {
      this();
      dc = colorModel.getColor( id );
      fc = dc;
      hc = colorModel.getHighlight( dc ); 
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
       fc = hc; // set the active color to the highlight value
    }
    
    void unsetHighlight() {
      fc = dc; // set the active color to the default fill value
    }

}
