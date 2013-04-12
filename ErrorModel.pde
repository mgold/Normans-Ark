class ErrorModel{
    private String name;
    private String category;
    private int nfailers;

    ErrorModel(String n, String cat, int flrs){
        name = n;
        category = cat;
        nfailers = flrs;
    }

    String getName(){
        return name;
    }

    String getCategory(){
        return category;
    }

    int getNumFailers(){
        return nfailers;
    }

}
