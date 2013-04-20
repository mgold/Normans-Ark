class CommentSprite extends Sprite {

    public CommentSprite() {
        super();
        x = width*MARGIN;
        y = (1-COMMENT_HEIGHT)*height;
        h = COMMENT_HEIGHT*height;
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

}
