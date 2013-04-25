class StudentModel{
    private String name;
    private int failCount [];
    private int totalFailCount;
    private int passCount;

    private int cmntCurrentError;
    private int cmntCurrentTest;

    StudentModel(String s){
        String line [] = split(s, ',');
        name = line[0];
        failCount = new int[line.length-1];
        totalFailCount = 0;
        cmntCurrentError = cmntCurrentTest = 0;
        for (int i = 1; i < line.length-1; i++){
            failCount[i-1] = int(line[i]);
            totalFailCount += failCount[i-1];
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

    int timesFailedTotal(){
        return totalFailCount;
    }

    void addComment(String [] comment){
        while (cmntCurrentTest >= timesFailed(cmntCurrentError)){
            cmntCurrentTest = 0;
            cmntCurrentError++;
        }
        data.getError(cmntCurrentError).addComment(comment);
        cmntCurrentTest++;
    }

}
