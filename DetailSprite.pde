class DetailSprite extends Sprite {
    private static final float DEFAULT_BAR_SEP = 40;
    ErrorModel errorModel;
    private ArrayList<BarSprite> bars;
    private ArrayList<StudentModel> students;

    public DetailSprite( ErrorModel errorModel ) {
        super();
        x = width-(width*(1-CANVAS_DIV)); // TODO change this
        y = MARGIN; // TODO change this
        h = height;
        w = width*( 1-CANVAS_DIV );
        setModel(errorModel);
    }

    public void setModel(ErrorModel errorModel){
        this.errorModel = errorModel;
        if (errorModel != null){
            this.bars = new ArrayList<BarSprite>();
            this.students = new ArrayList<StudentModel>();
            populateStudents();
            createBars();
        }
    }

    private void populateStudents() {
        for ( int i = 0; i < data.getStudents().length; i++ ) {
          StudentModel s = data.getStudents()[i];
          int errId = data.getErrorId( errorModel );
          if ( s.timesFailed( errId ) > 0 ) {
            students.add( s );
          }
        }
    }

    private void createBars() { // TODO: using dummy student data
      sortStudents(); 

      for ( int i = 0; i < students.size(); i++ ) {
        float _x = x+(MARGIN*DEFAULT_WIDTH);
        float _y = y+(2*MARGIN*DEFAULT_HEIGHT)+((i+1)*DEFAULT_BAR_SEP);
        float _w = w - (MARGIN*DEFAULT_WIDTH);
        float _h = DEFAULT_BAR_HEIGHT*(height/main.DEFAULT_HEIGHT);
        //float _w = DEFAULT_BAR_WIDTH*(width/main.DEFAULT_WIDTH);
        bars.add( new BarSprite( students.get( i ), errorModel, _x, _y, _w, _h ) );
      }
    }

    private void sortStudents() {
      int errId = data.getErrorId( errorModel );

      for (int i=0; i < students.size(); i++) {
        for (int j=i+1; j < students.size(); j++) {
          StudentModel current = students.get( i );
          StudentModel test = students.get( j );

          if ( current.timesFailed( errId ) < test.timesFailed( errId ) ) {
            StudentModel temp = current; // swap
            students.set(i, test);
            students.set(j, temp);
          }
        }
      }
    }

    void update(){
        x = bound(w, x, width-( width*( 1-CANVAS_DIV ) ) ); // TODO change this
    }

    void draw() {
        super.draw();

        fill( colorModel.getDetailBkgdColor() );
        rect( x, y, w, h ); 

        if (errorModel != null){
            fill( tc );
            textSize( DEFAULT_TEXT_SIZE*1.5 );
            textAlign( RIGHT, TOP );
            float _x = x+(MARGIN*DEFAULT_WIDTH);
            float _y = y+(2*MARGIN*DEFAULT_HEIGHT);
            text( errorModel.getName(), _x, _y/2, w-(2*MARGIN*DEFAULT_WIDTH), h );
            _y = y+(8*MARGIN*DEFAULT_HEIGHT);
            textSize( DEFAULT_TEXT_SIZE*1.2 );
            fill(colorModel.getColor(data.colorIDForCategory(errorModel.getCategory())));
            text( errorModel.getCategory(), _x, _y/2, w-(2*MARGIN*DEFAULT_WIDTH), h );

            // set it back to the defaults
            textSize( DEFAULT_TEXT_SIZE );
            textAlign(CENTER, CENTER);

            for ( BarSprite bar : bars ) {
              bar.draw();
            }
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
