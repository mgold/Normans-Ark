class StudentModel{
    private String name;
    private int failCount [];
    private int passCount;

    StudentModel(String s){
        String line [] = split(s, ',');
        name = line[0];
        failCount = new int[line.length-1];
        for (int i = 1; i < line.length-1; i++){
            failCount[i-1] = int(line[i]);
        }

        passCount = int(line[line.length-1]);
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

    int timesPassed(){
        return passCount;
    }

}
