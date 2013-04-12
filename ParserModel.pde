class ParserModel{

    ParserModel(){
    }

    void parse(String filename, ArrayList<ErrorModel> errors) {
        String lines[] = loadStrings(filename);
        String line [] = split(lines[0], ',');
        ArrayList<String> categories = new ArrayList(line.length);
        for (String cat : line){
            categories.add(cat);
        }

        for (int i=1; i<lines.length; i++){
            line = split(lines[i], ',');
            errors.add(new ErrorModel(line[0], line[1], line.length-2));
        }
        /*
        String line [] = split(lines[0], ',');
        numSeries = lines.length-1;
        seriesLen = line.length-1;

        xLabel = line[0];
        xLabels = new String [seriesLen];
        seriesLabels = new String [numSeries];
        series = new float [numSeries] [seriesLen];
        for (int i=1; i<line.length; i++){
            xLabels[i-1] = line[i];
        }

        for (int i=1; i<lines.length; i++) {
            line = split(lines[i], ',');
            if(line.length != seriesLen+1){
                println("Wrong number of data on line "+i);
                return false;
            }
            seriesLabels[i-1] = line[0];
            for (int j=1; j<line.length; j++){
                if (isNumeric(line[j])){
                    series[i-1][j-1] = float(line[j]);
                    if (series[i-1][j-1] < 0){
                        println("Negative input on line "+i);
                        return false;
                    }
                }else{
                    println("Non-numeric input on line "+i);
                    return false;
                }
            }
        }
        */
    }

}
