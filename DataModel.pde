class DataModel{
    private ArrayList<ErrorModel> errors;
    private ArrayList<String> categories;
    private HashMap<String, StudentModel> students;

    DataModel(){
        errors = new ArrayList();
        categories = new ArrayList();
        students = new HashMap();
        ParserModel parser = new ParserModel();
        parser.parse("data.csv", categories, errors, students);
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

    ErrorModel getError(int errID){
        if(0 <= errID && errID < this.getNumErrors()){
            return errors.get(errID);
        }else{
            return null;
        }
    }

    StudentModel getStudent(String name){
        return students.get(name);
    }

    int colorIDForCategory(String cat){
        return categories.indexOf(cat);
    }

}
