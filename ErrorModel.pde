class ErrorModel{
    private String name;
    private String category;
    private float gradeGivenError;
    private int nfailers;
    private String[][] comments;
    private int logicalCommentSize;

    ErrorModel(String n, String cat, float gge, int flrs){
        name = n;
        category = cat;
        gradeGivenError = gge;
        nfailers = flrs;
        logicalCommentSize = 0;
    }

    String getName(){
        return name;
    }

    String getCategory(){
        return category;
    }

    float getGradeGivenError(){
        return gradeGivenError;
    }

    int getNumFailers(){
        return nfailers;
    }

    void addComment(String [] newComment){
        if (logicalCommentSize < comments.length){
            comments[logicalCommentSize] = newComment;
            logicalCommentSize++;
        }
    }

    void setAsComment(int testNum){
        if (0 <= testNum && testNum < comments.length){
            comment.setLines(comments[testNum]);
        }
    }

}
