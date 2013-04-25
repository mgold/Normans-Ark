class ErrorModel{
    private String name;
    private String category;
    private float gradeGivenError;
    private int nfailers;
    private ArrayList<String[]> comments;
    private int logicalCommentSize;

    ErrorModel(String n, String cat, float gge, int flrs){
        name = n;
        category = cat;
        gradeGivenError = gge;
        nfailers = flrs;
        comments = new ArrayList();
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
        comments.add(newComment);
    }

    void setAsComment(int testNum){
        if (0 <= testNum && testNum < comments.size()){
            comment.setLines(comments.get(testNum));
        }
    }

}
