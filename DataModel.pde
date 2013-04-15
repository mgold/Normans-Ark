class DataModel{
    private ArrayList<ErrorModel> errors;
    private ArrayList<String> categories;
    private ArrayList<StudentModel> students;
    private int numStudents;

    DataModel(){
        errors = new ArrayList();
        categories = new ArrayList();
        ParserModel parser = new ParserModel();
        numStudents = parser.parse("data.csv", categories, errors);
        students = new ArrayList(numStudents);
    }

    int getNumStudents(){
        //return students.size();
        return numStudents;
    }

    int getNumErrors(){
        return errors.size();
    }

    int getNumCategories(){
        return categories.size();
    }

    ErrorModel getError(int errID){
        if(0 <= errID && errID < this.getNumErrors()){
            return errors.get(errID);
        }else{
            return null;
        }
    }

    //stub: return randomized StudentModel
    StudentModel getStudent(){
        return new StudentModel("Ralph Wiggins");
    }

    int colorIDForCategory(String cat){
        return categories.indexOf(cat);
    }

}
