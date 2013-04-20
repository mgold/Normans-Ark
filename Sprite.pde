abstract class Sprite{
    final int DEFAULT_STROKE_WEIGHT = 3;
    final int NO_STROKE_COLOR = -1;
    final int STROKE_COLOR = 100;
    float x, y;
    float h, w;
    color fc, sc, dc, hc, tc; // fill; stroke; default; highlight; text; dropshadow
    boolean displayMouseover = false;
    boolean isSelected = false;
    ColorModel colorModel = new ColorModel();

    Sprite(){
        x = y = h = w = 0;
        sc = NO_STROKE_COLOR;
        strokeWeight( DEFAULT_STROKE_WEIGHT*(width/main.DEFAULT_WIDTH) );
    }

    Sprite(float _x, float _y, float _h, float _w){
        setX(_x);
        setY(_y);
        h = _h;
        w = _w;
        fc = #AAAAAA; // grey fill
        sc = NO_STROKE_COLOR;
    }
    
    void setX(float inX)
    {
      x = bound(0, inX, width);
    }
    
    void setY(float inY)
    {
        y = bound(0, inY, height);
    }

    float getX()
    {
      return x;
    }

    float getY()
    {
      return y;
    }

    abstract void update();

    void draw(){
        if (fc == -1){
            noFill();
        } else{
            fill(fc);
        }
        if (sc == -1){
            noStroke();
        } else{
            stroke(sc);
        }
    }
    
    void drawText()
    {
    }
    
    void drawHoverText()
    {
    }

    abstract boolean intersects(int _x, int _y);

    float sortKey(){
        return 0;
    }

    void setColor(int colorID) {
      dc = colorModel.getColor(colorID);
      hc = colorModel.getFaded(dc);
      tc = colorModel.getTextColor(colorID);
      fc = dc;
    }

    void setHighlight() {
      sc = STROKE_COLOR;
      displayMouseover = true;
    }

    void unsetHighlight() {
      sc = NO_STROKE_COLOR;
      displayMouseover = false;
    }

    void fade() {
      fc = hc; // set the active color to the highlight value
      this.isSelected = false;
    }

    void focus() {
      fc = dc; // set the active color to the default fill value
    }

    boolean isFocused() {
      return fc == dc; 
    }
    
    boolean isHighlighted() {
      return sc == STROKE_COLOR;
    }
    
    boolean isSelected() {
      return isSelected; 
    }
    
    void deselect() {
      this.isSelected = false; 
    }
    
    void select() {
      this.isSelected = true; 
    }

}
