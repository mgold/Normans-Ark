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
    
    private void createParts() {
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
        HashMap<Integer, Float> proportions = new HashMap<Integer, Float>();
        for ( Integer errId : errorCounts.keySet() ) {
          float proportion = ( (float) errorCounts.get( errId ) ) / total;
          proportions.put( errId, proportion );
          print( "\t" + errId + ": " + proportion + "\n" );
        }
      
        float _w = w - DEFAULT_BAR_WIDTH*w - 2*MARGIN*DEFAULT_WIDTH;      
        float barX = x + MARGIN*DEFAULT_WIDTH + _w;
        float barW = DEFAULT_BAR_WIDTH*w;

        //rect(barX, y, barW, h);

        float usedW = 0;
        for ( int i = 0; i < data.getNumCategories(); i++ ) {
          String category = data.getCategory( i );

          for ( Integer errId : proportions.keySet() ) {
            ErrorModel e = data.getError( errId );
            if ( category.equals( e.getCategory() ) ) {
              float proportion = proportions.get( errId );
              boolean highlighted = false;
              if ( e.equals( error ) ) {
                highlighted = true;
                sortKey = proportion;
              }

              parts.add( new MiniBarSprite( e, highlighted, barX + usedW, y, proportion*barW, h ) );
              usedW += proportion*barW + 2;
            }
          }
        }
        // draw the green part (passing)
        fill( colorModel.getPassingColor() );
        ErrorModel e = new ErrorModel( "Passed", "", -1, -1 );
        parts.add( new MiniBarSprite( e, false, barX + usedW, y, barW-usedW, h ) );
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

    boolean intersects( int _x, int _y ) {
      for ( MiniBarSprite part: parts ) {
        if ( part.intersects( _x, _y ) ) {
            return true;
        } 
      }
      
      return false;
    }
    
    
    class MiniBarSprite extends Sprite {
      private ErrorModel error;
      private boolean highlighted;
      
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
          this.fc = colorModel.getPassingColor();
        }
      }
      
      void draw() {
        super.draw(); 

        fill( fc );
        
        if ( highlighted ) {
//          stroke( colorModel.getActiveErrorColor() );
          
          rect(x, y - 4, w, h + 8);
//          strokeWeight( 1 );
//          line( x, y+h+2, x, y+h+6 );
//          line( x, y+h+4, x+w, y+h+4 );
//          line( x+w, y+h+2, x+w, y+h+6 );
          //strokeWeight( 1.5 );
          //noFill();
          //rect( x, y-2, w, h+3 );
        }
        else
        {
          rect( x, y, w, h );
        }
      }
      
      ErrorModel getError() {
        return this.error; 
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
