class StudentModel{
    String name;
    int failCount [];

    StudentModel(String n){
        name = n;
        failCount = new int[data.getNumErrors()];
        for (int i = 0; i < data.getNumErrors(); i++){
            failCount[i] = floor(random(0, 4));
        }
    }

    //the same errID as DataModel's getError(errID)
    int timesFailed(int errID){
        if(0 <= errID && errID < failCount.length){
            return failCount[errID];
        }else{
            return -1;
        }
    }


}
