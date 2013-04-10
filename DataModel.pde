class DataModel{
    ArrayList<ErrorModel> errors;

    DataModel(){
        errors = new ArrayList();
        errors.add(new ErrorModel("no executable", 1));
        errors.add(new ErrorModel("unexpected output on stderr", 3));
    }

    int getNumStudents(){
        return 5;
    }

    int getNumErrors(){
        return 2;
    }

    ErrorModel getError(int id){
        if(0 <= id && id < this.getNumErrors()){
            return errors.get(id);
        }else{
            return null;
        }
    }


}
