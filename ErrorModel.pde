class ErrorModel{
    private String name;
    private int failers;

    ErrorModel(String n, int flrs){
        name = n;
        failers = flrs;
    }

    String getName(){
        return name;
    }

    int getNumFailers(){
        return failers;
    }

}
