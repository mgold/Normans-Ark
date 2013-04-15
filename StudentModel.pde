class StudentModel{
    private String name;
    private int failCount [];

    StudentModel(String s){
        String line [] = split(s, ',');
        name = line[0];
        failCount = new int[line.length-1];
        for (int i = 1; i < line.length; i++){
            failCount[i-1] = int(line[i]);
        }
    }

    //the same errID as DataModel's getError(errID)
    int timesFailed(int errID){
        if (failCount == null){
            return 0;
        }
        if(0 <= errID && errID < failCount.length){
            return failCount[errID];
        }else{
            return -1;
        }
    }

    String getName(){
        return name;
    }

}
