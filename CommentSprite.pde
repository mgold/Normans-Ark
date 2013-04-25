class CommentSprite extends Sprite {
    private int numLines;
    private int maxNumLines;
    private String lines [];

    public CommentSprite(int mnl) {
        super();
        maxNumLines = mnl;
        clearLines();
        x = width*MARGIN;
        h = COMMENT_LINE_HEIGHT*maxNumLines+COMMENT_LINE_MARGIN*(maxNumLines+1);
        if (maxNumLines == 0){
            h = 0;
        }
        y = height-h;
        w = width*(CANVAS_DIV-2*MARGIN);
    }

    void update(){
        clearLines();
    }

    void draw() {
        super.draw();

        fill(colorModel.getDetailBkgdColor());
        rect( x, y, w, h );

        for (int i = 0; i<numLines; i++){
            String line = lines[i];
            textSize(COMMENT_LINE_HEIGHT);
            textAlign(LEFT, TOP);
            fill(#000000);
            text(line, x+MARGIN, y+COMMENT_LINE_HEIGHT*i+COMMENT_LINE_MARGIN*(i+1), w, COMMENT_LINE_HEIGHT*2);
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
