class DataModel{
    private ArrayList<ErrorModel> errors;
    private ArrayList<String> categories;
    private HashMap<String, StudentModel> students;
    private HashMap<Integer, CircleSprite> circles;
    private CircleSprite selected;
    private int numCommentLines;

    DataModel(){
        errors = new ArrayList();
        categories = new ArrayList();
        students = new HashMap();
        circles = new HashMap();
        numCommentLines = 0;
        clearSelected();
    }

    void parse(){
        ParserModel parser = new ParserModel();
        numCommentLines = parser.parse("data.csv", categories, errors, students);
    }

    int getNumStudents(){
        return students.size();
    }

    int getNumErrors(){
        return errors.size();
    }

    int getNumCategories(){
        return categories.size();
    }

    int getNumCommentLines(){
        return numCommentLines;
    }

    ErrorModel getError(int errID){
        if(0 <= errID && errID < this.getNumErrors()){
            return errors.get(errID);
        }else{
            return null;
        }
    }
    
    int getErrorId( ErrorModel error ) {
      for ( int i = 0; i < errors.size(); i++ ) {
        ErrorModel e = errors.get( i );
        if ( e.equals( error ) ) {
          return i;
        }
      }
      return -1;
    }

    StudentModel getStudent(String name){
        return students.get(name);
    }

    StudentModel[] getStudents() {
        return students.values().toArray( new StudentModel[0] ); 
    }

    int colorIDForCategory(String cat){
        return categories.indexOf(cat);
    }

    String getCategory( int catId ) {
        return categories.get( catId ); 
    }

    CircleSprite getSelected(){
        return selected;
    }

    void setSelected (CircleSprite newbie){
        selected = newbie;
    }

    void clearSelected(){
        selected = null;
    }
    
    void addCircle( CircleSprite c, int errId ) {
      circles.put( errId, c );
    }
    
    CircleSprite getCircle( int errId ) {
      return circles.get( errId ); 
    }

}
