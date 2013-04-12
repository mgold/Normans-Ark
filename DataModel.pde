class DataModel{
    ArrayList<ErrorModel> errors;

    DataModel(){
        errors = new ArrayList();
        ParserModel parser = new ParserModel();
        parser.parse("data.csv", errors);
        if (errors == null){
            println("errors is still null!");
        }
    }

    int getNumStudents(){
        return 5;
    }

    int getNumErrors(){
        return errors.size();
    }

    ErrorModel getError(int id){
        if(0 <= id && id < this.getNumErrors()){
            return errors.get(id);
        }else{
            return null;
        }
    }


}
