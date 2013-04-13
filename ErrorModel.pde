class ErrorModel{
    private String name;
    private String category;
    private float gradeGivenError;
    private int nfailers;

    ErrorModel(String n, String cat, float gge, int flrs){
        name = n;
        category = cat;
        gradeGivenError = gge;
        nfailers = flrs;
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

}
