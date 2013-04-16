class DetailSprite extends Sprite {
    private static final float DEFAULT_BAR_SEP = 40;
    final color DEFAULT_BKGD = color(212, 216, 223, 100);
    ErrorModel errorModel;
    BarSprite[] bars;

    public DetailSprite( ErrorModel errorModel ) {
        this.errorModel = errorModel;
        this.bars = new BarSprite[errorModel.getNumFailers()];
        x = width-(width*(1-CANVAS_DIV)); // TODO change this
        y = MARGIN; // TODO change this
        h = height;
        w = width*( 1-CANVAS_DIV );
        
        createBars();
    }
    
    private void createBars() { // TODO: using dummy student data
      for ( int i = 0; i < bars.length; i++ ) {
        float _x = x+(MARGIN*DEFAULT_WIDTH);
        float _y = y+(2*MARGIN*DEFAULT_HEIGHT)+((i+1)*DEFAULT_BAR_SEP);
        float _h = DEFAULT_BAR_HEIGHT*(height/main.DEFAULT_HEIGHT);
        float _w = DEFAULT_BAR_WIDTH*(width/main.DEFAULT_WIDTH);
        bars[i] = new BarSprite( null, _x, _y, _w, _h );
      } 
    }
  
    void update(){
        x = bound(w, x, width-( width*( 1-CANVAS_DIV ) ) ); // TODO change this
    }
    
    void draw() {
        super.draw();
      
        fill( DEFAULT_BKGD );
        rect( x, y, w, h ); 
        
        fill( tc );
        textSize( DEFAULT_TEXT_SIZE*1.5 );
        textAlign( RIGHT, TOP );
        float _x = x+(MARGIN*DEFAULT_WIDTH);
        float _y = y+(2*MARGIN*DEFAULT_HEIGHT);
        text( errorModel.getName(), _x, _y/2, w-(2*MARGIN*DEFAULT_WIDTH), h );
        
        // set it back to the defaults
        textSize( DEFAULT_TEXT_SIZE );
        textAlign(CENTER, CENTER);
        
        for ( BarSprite bar : bars ) {
          bar.draw();
        }
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
