class ParserModel{

    ParserModel(){
    }

    //parses filename and places info into already-instantiated ArrayList args
    //returns lines of comments
    int parse(String filename, ArrayList<String> categories,
    ArrayList<ErrorModel> errors, HashMap<String,StudentModel> students) {
        String lines[] = loadStrings(filename);
        int commentLines = int(lines[0]);
        String line [] = split(lines[1], ',');
        for (String cat : line){
            categories.add(cat);
        }

        int i = 2;
        while(true){
            line = split(lines[i], ',');
            if (line.length == 1){
                break;
            }
                errors.add(new ErrorModel(line[0], line[1], float(line[2]), int(line[3])));
                i++;
        }

        int numStudents = int(line[0]);
        StudentModel mostRecent = null;
        for (i++; i < lines.length; i++){
            String fullline = lines[i];
            if (fullline.startsWith("|")){
                String onetoomany [] = split(fullline, '|');
                String actual [] = new String [onetoomany.length -1];
                for (int j = 1; j < onetoomany.length; j++){
                    actual[j-1] = onetoomany[j];
                }
                mostRecent.addComment(actual);
            }else{
                mostRecent = new StudentModel(fullline);
                students.put(split(fullline, ',')[0], mostRecent);
            }
        }

        return commentLines;
    }

}
