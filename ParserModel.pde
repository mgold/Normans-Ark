class ParserModel{

    ParserModel(){
    }

    //parses filename and places info into already-instantiated ArrayList args
    int parse(String filename, ArrayList<String> categories, ArrayList<ErrorModel> errors) {
        String lines[] = loadStrings(filename);
        String line [] = split(lines[0], ',');
        for (String cat : line){
            categories.add(cat);
        }

        for (int i=1; i<lines.length-1; i++){
            line = split(lines[i], ',');
            errors.add(new ErrorModel(line[0], line[1], float(line[2]),
                line.length-3));
        }
        return int(lines[lines.length-1]);
    }

}
