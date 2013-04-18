static final float DEFAULT_BAR_HEIGHT = 25;
static final float DEFAULT_BAR_WIDTH = .5;

class BarSprite extends Sprite {
  private StudentModel student;
  private HashMap<Integer, Float> proportionMap;

    BarSprite( StudentModel studentModel, float _x, float _y, float _w, float _h ){
        super();
        x = _x;
        y = _y;
        w = _w;
        h = _h;
        this.student = studentModel;
        this.proportionMap = new HashMap<Integer, Float>();
        
        computeProportions();
    }
    
    private void computeProportions() {
      int total = student.timesPassed();
      HashMap<Integer, Integer> errorCounts = new HashMap<Integer, Integer>();
      for ( int i = 0; i < data.getNumErrors(); i++ ) {
        ErrorModel e = data.getError( i );
        int timesFailed = student.timesFailed( i );
        if ( timesFailed > 0 ) {
          total += timesFailed;
          Integer prevTally = errorCounts.get( i );
          if ( prevTally == null ) {
            errorCounts.put( i, timesFailed );
          } else {
            errorCounts.put( i, prevTally + timesFailed ); 
          }
        }
      }
    
      print( student.getName() + ":\n" );
      for ( Integer errId : errorCounts.keySet() ) {
        float proportion = ( (float) errorCounts.get( errId ) ) / total;
        proportionMap.put( errId, proportion );
        print( "\t" + errId + ": " + proportion + "\n" );
      }
    }
    
    void draw(){
        super.draw();
        
        fill(tc);
        textAlign( LEFT, CENTER );
        float _w = w - DEFAULT_BAR_WIDTH*w - 2*MARGIN*DEFAULT_WIDTH;
        text( student.getName(), x, y, _w, h );

        fill(fc);
        float barX = x + MARGIN*DEFAULT_WIDTH + _w;
        float barW = DEFAULT_BAR_WIDTH*w;

        //rect(barX, y, barW, h);

        float usedW = 0;
        for ( int i = 0; i < data.getNumCategories(); i++ ) {
          String category = data.getCategory( i );

          for ( Integer errId : proportionMap.keySet() ) {
            String cat = data.getError( errId ).getCategory();
            if ( category.equals( cat ) ) {
              float proportion = proportionMap.get( errId );
              color c = colorModel.getColor( data.colorIDForCategory( category ) );
              fill( c );
              rect( barX + usedW, y, proportion*barW, h );
              usedW += proportion*barW + 2;
            }
          }
        }
        // draw the green part (passing)
        fill( colorModel.getPassingColor() );
        rect( barX + usedW, y, barW-usedW, h );
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
