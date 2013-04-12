class DataModel{
    private ArrayList<ErrorModel> errors;
    private int nCategories;

    DataModel(){
        errors = new ArrayList();
        ParserModel parser = new ParserModel();
        nCategories = parser.parse("data.csv", errors);
    }

    int getNumStudents(){
        return 5;
    }

    int getNumErrors(){
        return errors.size();
    }

    int getNumCategories(){
        return nCategories;
    }

    ErrorModel getError(int id){
        if(0 <= id && id < this.getNumErrors()){
            return errors.get(id);
        }else{
            return null;
        }
    }


}
