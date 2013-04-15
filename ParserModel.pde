class ParserModel{

    ParserModel(){
    }

    //parses filename and places info into already-instantiated ArrayList args
    void parse(String filename, ArrayList<String> categories,
    ArrayList<ErrorModel> errors, HashMap<String,StudentModel> students) {
        String lines[] = loadStrings(filename);
        String line [] = split(lines[0], ',');
        for (String cat : line){
            categories.add(cat);
        }

        int i = 1;
        while(true){
            line = split(lines[i], ',');
            if (line.length == 1){
                break;
            }
            errors.add(new ErrorModel(line[0], line[1], float(line[2]), int(line[3])));
            i++;
        }

        int numStudents = int(line[0]);
        for (i++; i < lines.length; i++){
            String name = split(lines[i], ',')[0];
            students.put(name, new StudentModel(lines[i]));
        }

    }

}
