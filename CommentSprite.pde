class CommentSprite extends Sprite {
    int numLines;

    public CommentSprite(int nl) {
        super();
        numLines = nl;
        x = width*MARGIN;
        h = COMMENT_LINE_HEIGHT*numLines+COMMENT_LINE_MARGIN*(numLines+1);
        if (numLines == 0){
            h = 0;
        }
        y = height-h;
        w = width*(CANVAS_DIV-2*MARGIN);
    }

    void update(){
        ;
    }

    void draw() {
        super.draw();

        fill(colorModel.getDetailBkgdColor());
        rect( x, y, w, h );

    }

    boolean intersects( int _x, int _y ) {
      return _x >= x && _x <= x + w && _y >= y && _y <= y + h;
    }
    
    void mouseClick( int _x, int _y ) {
      ;
    }

}
