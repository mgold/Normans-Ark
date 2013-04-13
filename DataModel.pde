class DataModel{
    private ArrayList<ErrorModel> errors;
    private ArrayList<String> categories;

    DataModel(){
        errors = new ArrayList();
        categories = new ArrayList();
        ParserModel parser = new ParserModel();
        parser.parse("data.csv", categories, errors);
    }

    int getNumStudents(){
        return 5;
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

    int colorIDForCategory(String cat){
        return categories.indexOf(cat);
    }

}
