class ErrorModel{
    private String name;
    private String category;
    private float gradeGivenError;
    private int nfailers;
    private ArrayList<String[]> comments;
    private ArrayList<String> bolded;
    private int logicalCommentSize;

    ErrorModel(String n, String cat, float gge, int flrs){
        name = n;
        category = cat;
        gradeGivenError = gge;
        nfailers = flrs;
        comments = new ArrayList();
        bolded = new ArrayList();
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
        for (String commentLine : newComment){
            if (commentLine.indexOf(COMMENT_BOLD_TOKEN) != -1){
                bolded.add("t"); //Because Boolean wrappers don't exist in p.js
                return;
            }
        }
        bolded.add("f");
    }

    void setAsComment(int testNum){
        if (0 <= testNum && testNum < comments.size()){
            comment.setLines(comments.get(testNum));
        }
    }

    String getTestName(int testNum){
        if (0 <= testNum && testNum < bolded.size()){
            return comments.get(testNum)[0];
        }
        return "";
    }

    boolean hasBoldComment(int testNum){
        if (0 <= testNum && testNum < bolded.size()){
            return bolded.get(testNum).equals("t");
        }
        return false;
    }

}
