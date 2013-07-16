static final float DEFAULT_BAR_HEIGHT = 25;
static final float DEFAULT_BAR_WIDTH = .5;

class BarSprite extends Sprite {
  private StudentModel student;
  private ErrorModel error;
  private ArrayList<MiniBarSprite> parts;
  private float proportion = -1;
  private boolean onPage = false;

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
      return proportion;
    }
    
    boolean isOnPage() {
      return this.onPage; 
    }
    
    void setOnPage( boolean onPage ) {
      this.onPage = onPage; 
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
              proportion = ( (float) errorCounts.get( errId ) ) / total;
              boolean highlighted = false;
              if ( e.equals( error ) ) { // special attributes for the highlighted error
                highlighted = true;
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
            float textX = min(mouseX+1, width-textWidth(part.getError().getName()));
            // first the drop shadow
            fill(#000000);
            text( part.getError().getName(), textX, mouseY-9 );
            fill(#ffffff);
            text( part.getError().getName(), textX-1, mouseY-10 );
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
      if ( !this.onPage ) return false;

      for ( MiniBarSprite part : parts ) {
        if ( part.intersects( _x, _y ) ) {
            return true;
        } 
      }
      
      return false;
    }

    void mouseClick( int _x, int _y ) {
      if ( !this.onPage ) return;

      for ( MiniBarSprite part : parts ) {
        if ( part.intersects( _x, _y ) ) {
          part.mouseClick( _x, _y );
        }
      }
    }
    
    void mouseOver( int _x, int _y ) {
      if ( !this.onPage ) return;
      
      for ( MiniBarSprite part : parts ) {
        if ( part.intersects( _x, _y ) ) {
          part.mouseOver( _x, _y );
        }
      }
    }
    
    class MiniBarSprite extends Sprite {
      private ErrorModel error;
      private boolean highlighted;
      boolean isPassed = false;
      int numTests;
      float widthPerTest;
      
      public MiniBarSprite( ErrorModel error, boolean highlighted, float _x, float _y, float _w, float _h ) {
        this.error = error;
        this.highlighted = highlighted;
        setY( _y );
        setX( _x );
        this.w = _w;
        this.h = _h;
        if ( highlighted ) this.h += 8;
        String cat = error.getCategory();
        if (cat != "") {
          this.fc = colorModel.getColor( data.colorIDForCategory( cat ) );
          this.numTests = student.timesFailed( data.getErrorId( error ) );
        } else {
          isPassed = true;
          this.fc = colorModel.getPassingColor();
          this.numTests = student.timesPassed();
        }
        this.widthPerTest = w / (float) numTests;
      }
      
      void draw() {
          super.draw();
          fill( fc );
          rect( x, y, w, h );
          for (int i = 0; i < numTests; i++){
              if (i > 0){
                  fill(colorModel.getDetailBkgdColor());
                  rect(x+widthPerTest*i-1, y, 2, 5);
                  rect(x+widthPerTest*i-1, y+h-5, 2, 5);
              }
              if (! isPassed && error.hasBoldComment(i+1)){
                  fill(#000000);
                  ellipse(x+widthPerTest*i+widthPerTest/2-1, y+h/2, 3, 3);
              }
          }
      }

      ErrorModel getError() {
        return this.error; 
      }
      
      void mouseOver( int _x, int _y ) {
        this.error.setAsComment( whichTest( _x, _y ) ); 
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
        if (_y < y || _y > y+h || _x < x){
            return -1;
        }
        float offset = _x - x; // the offset from the start of this minibar
        
        int testNum = ceil( offset/widthPerTest );

        return (int) bound( (float) 1, (float) testNum,  (float) numTests );
      }
      
      // @Override
      void setY(float inY) {
        if ( highlighted ) {
          inY = inY - 4;
        }
        y = bound(0, inY, height);
      }
      
      boolean intersects( int _x, int _y ) {
            return ( _x >= x && _x <= x + w &&
                     _y >= y && _y <= y + h );
      }

      void update(){
          ;
      }
    }
    
}
