class CommentSprite extends Sprite {
    private int numLines;
    private int maxNumLines;
    private String lines [];

    public CommentSprite(int mnl) {
        super();
        maxNumLines = mnl;
        clearLines();
        x = 0;
        h = COMMENT_LINE_HEIGHT*maxNumLines+COMMENT_LINE_MARGIN*(maxNumLines+1);
        if (maxNumLines == 0){
            h = 0;
        }
        y = height-h;
        w = width;
    }

    void update(){
        clearLines();
    }

    void draw() {
        super.draw();

        fill(colorModel.getDetailBkgdColor());
        rect( x, y, w, h );

        textSize(COMMENT_LINE_HEIGHT);
        textAlign(LEFT, CENTER);
        fill(#000000);
        stroke(#000000);
        for (int i = 0; i<numLines; i++){
            String line = lines[i];
            String[] tokens = splitTokens(line, COMMENT_BOLD_TOKEN);
            float xoffset = 0.;
            boolean bold = false;
            for (String token : tokens){
                textSize(bold ? COMMENT_LINE_HEIGHT * 1.2 : COMMENT_LINE_HEIGHT);
                fill(bold ? #000000 : #222222);
                bold = !bold;
                text(token, x+(MARGIN*DEFAULT_WIDTH)+xoffset, y+4+COMMENT_LINE_HEIGHT*i+COMMENT_LINE_MARGIN*(i+1));
                xoffset += textWidth(token);
            }
        }

    }

    boolean intersects( int _x, int _y ) {
      return _x >= x && _x <= x + w && _y >= y && _y <= y + h;
    }

    void mouseClick( int _x, int _y ) {
      ;
    }

    void clearLines(){
        lines = null;
        numLines = 0;
    }

    void setLines(String newlines []){
        lines = newlines;
        numLines = min(maxNumLines, lines.length);
    }

}
