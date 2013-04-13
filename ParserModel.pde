class ParserModel{

    ParserModel(){
    }

    //parses filename and places info into already-instantiated ArrayList args
    void parse(String filename, ArrayList<String> categories, ArrayList<ErrorModel> errors) {
        String lines[] = loadStrings(filename);
        String line [] = split(lines[0], ',');
        for (String cat : line){
            categories.add(cat);
        }

        for (int i=1; i<lines.length; i++){
            line = split(lines[i], ',');
            errors.add(new ErrorModel(line[0], line[1], line.length-2));
        }
    }

}
