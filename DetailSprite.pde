class DetailSprite extends Sprite implements Page {
    private static final int MAX_STUDENTS_PER_PAGE = 10;
    private static final float DEFAULT_BAR_SEP = 40;
    ErrorModel errorModel;
    private ArrayList<BarSprite> bars;
    private ArrayList<StudentModel> students;
    
    private int currentPage = 0;
    
    PaginationSprite pagination = null;

    public DetailSprite( ErrorModel errorModel ) {
        super();
        x = width-(width*(1-CANVAS_DIV)); // TODO change this
        y = MARGIN; // TODO change this
        h = height - comment.getH() - (MARGIN*DEFAULT_HEIGHT);
        w = width*( 1-CANVAS_DIV );
        setModel(errorModel);
        this.bars = new ArrayList<BarSprite>();
        
        pagination = new PaginationSprite(getX() +  (w / 2), h - 40 );
        pagination.setPageListener(this);
    }

    public void setModel(ErrorModel errorModel){
        this.errorModel = errorModel;
        if (errorModel != null){
            this.bars = new ArrayList<BarSprite>();
            this.students = new ArrayList<StudentModel>();
            populateStudents();
            createBars();
            currentPage = 0;
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

      float _x = x+(MARGIN*DEFAULT_WIDTH);
      float _y = y+(4*MARGIN*DEFAULT_HEIGHT);
      float _w = w - (MARGIN*DEFAULT_WIDTH);
      float _h = DEFAULT_BAR_HEIGHT*(height/DEFAULT_HEIGHT);
      for ( int i = 0; i < students.size(); i++ ) {
        bars.add( new BarSprite( students.get( i ), errorModel, _x, _y+((i+1)*DEFAULT_BAR_SEP), _w, _h ) );
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
        if ( mouseX > CANVAS_DIV*width + DEFAULT_BAR_WIDTH*w) {
          mouseOver( mouseX, mouseY );
        }else{
            currentTest = "";
        }
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
            int colorId = data.colorIDForCategory( errorModel.getCategory() );
            fill( colorModel.getTextColor( colorId ), 125);
            text( errorModel.getCategory(), _x+1, _y/2+1, w-(2*MARGIN*DEFAULT_WIDTH), h );
            fill( colorModel.getColor( colorId ) );
            text( errorModel.getCategory(), _x, _y/2, w-(2*MARGIN*DEFAULT_WIDTH), h );

            // set it back to the defaults
            textSize( DEFAULT_TEXT_SIZE );
            textAlign(CENTER, CENTER);
            
            if(bars.size() > MAX_STUDENTS_PER_PAGE)
            {
              pagination.draw();
              pagination.drawPageNumber(currentPage + 1);
            }
          
            int firstBarIndex = currentPage * MAX_STUDENTS_PER_PAGE;
            int lastBarIndex = min(firstBarIndex + MAX_STUDENTS_PER_PAGE, bars.size());
            int pageBarCounter = 0;
            for(int i = 0; i < bars.size(); ++i) {
              BarSprite b = bars.get(i);

              if ( i >= firstBarIndex && i < lastBarIndex ) {
                b.setOnPage( true );
                b.setY(getY() + (3 * MARGIN * DEFAULT_HEIGHT) + (++pageBarCounter * DEFAULT_BAR_SEP));
                b.draw();
              } else {
                b.setOnPage( false );
              }
            }
        }
    }
    
    void mouseClick(int inX, int inY)
    {
      if ( pagination.intersects( inX, inY ) ) {
        pagination.mouseClick( inX, inY );
      } else {
        for ( BarSprite bar : bars ) {
          if ( bar.isOnPage() && bar.intersects( inX, inY ) ) {
            bar.mouseClick( inX, inY );
          }
        }
      }
    }
    
    void mouseOver( int _x, int _y ) {
      for ( BarSprite bar : bars ) {
        if ( bar.isOnPage() && bar.intersects( _x, _y ) ) {
          bar.mouseOver( _x, _y );
        }
      } 
    }

    boolean intersects( int _x, int _y ) {
      return _x >= x && _x <= x + w && _y >= y && _y <= y + h;
    }
    
    public void pageBackward()
    {
      if(currentPage == 0)
      {
        currentPage = (int) (bars.size() / MAX_STUDENTS_PER_PAGE);
      }
      else
      {
        --currentPage;
      }
    }
    
    public void pageForward()
    {
      if(currentPage == (int) (bars.size() / MAX_STUDENTS_PER_PAGE))
      {
        currentPage = 0;
      }
      else
      {
        ++currentPage;
      }
    }

}
