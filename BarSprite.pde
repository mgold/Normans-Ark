static final float DEFAULT_BAR_HEIGHT = 25;
static final float DEFAULT_BAR_WIDTH = .5;

class BarSprite extends Sprite {
  private StudentModel student;
  private ErrorModel error;
  private ArrayList<MiniBarSprite> parts;
  private float sortKey = -1;

    BarSprite( StudentModel studentModel, ErrorModel errorModel, float _x, float _y, float _w, float _h ){
        super();
        x = _x;
        y = _y;
        w = _w;
        h = _h;
        this.student = studentModel;
        this.error = errorModel;
        this.parts = new ArrayList<MiniBarSprite>();
        
        createParts();
    }
    
    public float sortKey() {
      return sortKey;
    }
    
    void setY(float inY) {
      super.setY(inY);
      
      for(MiniBarSprite part : parts) {
        part.setY(inY);
      }
    }
    
    private void createParts() {
        // count the tests failed per error
        int total = student.timesPassed();
        HashMap<Integer, Integer> errorCounts = new HashMap<Integer, Integer>();
        for ( int i = 0; i < data.getNumErrors(); i++ ) {
          ErrorModel e = data.getError( i );
          int timesFailed = student.timesFailed( i );
          if ( timesFailed > 0 ) {
            total += timesFailed;
            errorCounts.put( i, timesFailed );
          }
        }

        float barW = DEFAULT_BAR_WIDTH*w;
        float barX = x + w - barW - MARGIN*DEFAULT_WIDTH;

        // create the sub-sprites, grouped by category
        float usedW = 0;
        for ( int i = 0; i < data.getNumCategories(); i++ ) {
          String category = data.getCategory( i );

          for ( Integer errId : errorCounts.keySet() ) {
            ErrorModel e = data.getError( errId );
            if ( category.equals( e.getCategory() ) ) {
              float proportion = ( (float) errorCounts.get( errId ) ) / total;
              boolean highlighted = false;
              if ( e.equals( error ) ) { // special attributes for the highlighted error
                highlighted = true;
                sortKey = proportion; // this is for sorting by student experiencing this error most
              }

              parts.add( new MiniBarSprite( e, highlighted, barX + usedW, y, proportion*barW, h ) );
              usedW += proportion*barW + 2;
            }
          }
        }

        // draw the green part (passing)
        if ( student.timesPassed() > 0 ){
            ErrorModel e = new ErrorModel( "Passed", "", -1, -1 );
            parts.add( new MiniBarSprite( e, false, barX + usedW, y, barW-usedW, h ) );
        }
    }
    
    void draw(){
        super.draw();
        
        fill(tc);
        textAlign( LEFT, CENTER );
        float _w = w - DEFAULT_BAR_WIDTH*w - 2*MARGIN*DEFAULT_WIDTH;
        text( student.getName(), x, y, _w, h );

        for ( MiniBarSprite part : parts ) {
          part.draw(); 
        }

        for ( MiniBarSprite part: parts ) {
          if ( part.intersects( mouseX, mouseY ) ) {
            textAlign(LEFT, CENTER);
            // first the drop shadow
            fill(#000000);
            text( part.getError().getName(), mouseX+1, mouseY-9 );
            fill(#ffffff);
            text( part.getError().getName(), mouseX, mouseY-10 );
          } 
        }

    }

    void update(){
        ;
    }
    
    ErrorModel whichError( int _x, int _y ) {
      for ( MiniBarSprite part : parts ) {
        if ( part.intersects( _x, _y ) ) {
          return part.getError();
        } 
      }
      
      return null;
    }
    
    int whichTest( int _x, int _y ) {
      for ( MiniBarSprite part : parts ) {
        if ( part.intersects( _x, _y ) ) {
          return part.whichTest( _x, _y );
        }
      }
      
      return -1;
    }

    boolean intersects( int _x, int _y ) {
      for ( MiniBarSprite part : parts ) {
        if ( part.intersects( _x, _y ) ) {
            return true;
        } 
      }
      
      return false;
    }

    void mouseClick( int _x, int _y ) {
      for ( MiniBarSprite part : parts ) {
        if ( part.intersects( _x, _y ) ) {
          part.mouseClick( _x, _y );
        }
      }
    }
    
    void mouseOver( int _x, int _y ) {
      for ( MiniBarSprite part : parts ) {
        if ( part.intersects( _x, _y ) ) {
          print( "Mousing over test " + part.whichTest( _x, _y ) + " of " + part.getError().getName() + "\n" );
        }
      }
    }
    
    class MiniBarSprite extends Sprite {
      private ErrorModel error;
      private boolean highlighted;
      boolean isPassed = false;
      
      public MiniBarSprite( ErrorModel error, boolean highlighted, float _x, float _y, float _w, float _h ) {
        this.error = error;
        this.highlighted = highlighted;
        this.x = _x;
        this.y = _y;
        this.w = _w;
        this.h = _h;
        String cat = error.getCategory();
        if ( !cat.isEmpty() ) {
          this.fc = colorModel.getColor( data.colorIDForCategory( cat ) );
        } else {
          isPassed = true;
          this.fc = colorModel.getPassingColor();
        }
      }
      
      void draw() {
        super.draw(); 

        fill( fc );
        
        if ( highlighted ) {
          rect(x, y - 4, w, h + 8);
        } else {
          rect( x, y, w, h );
        }
      }
      
      ErrorModel getError() {
        return this.error; 
      }
      
      void mouseClick( int _x, int _y ) {
        if ( !isPassed ) { // if it's not "Passed"
          CircleSprite selected = data.getCircle( data.getErrorId( error ) );
          data.clearSelected();
          data.setSelected( selected );
          detail.setModel( selected.model );
        }
      }
      
      int whichTest( int _x, int _y ) {
        int numTests;
        if ( isPassed ) {
          numTests = student.timesPassed();
        } else {
          numTests = student.timesFailed( data.getErrorId( error ) );
        }

        float widthPerTest = w / (float) numTests;
        float offset = _x - x; // the offset from the start of this minibar
        
        int testNum = ceil( offset/widthPerTest );

        if ( testNum < 1 ) {
          return 1;
        } else if ( testNum > numTests ) {
          return numTests;
        } else {
          return testNum;
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

      void update(){
          ;
      }
    }
    
}
