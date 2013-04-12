class ParserModel{

    ParserModel(){
    }

    int parse(String filename, ArrayList<ErrorModel> errors) {
        String lines[] = loadStrings(filename);
        String line [] = split(lines[0], ',');
        int nCategories = line.length;

        for (int i=1; i<lines.length; i++){
            line = split(lines[i], ',');
            errors.add(new ErrorModel(line[0], line[1], line.length-2));
        }
        return nCategories;
    }

}
