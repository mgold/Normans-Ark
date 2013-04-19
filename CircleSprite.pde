class CircleSprite extends Sprite{
    ErrorModel model;
    DetailSprite detail;
    float dx;
    boolean textDrawn = false;

    CircleSprite(int errID){
        super();
        model = data.getError(errID);
        detail = new DetailSprite( model );
        this.setColor(data.colorIDForCategory(model.getCategory()));
        int numErrors = data.getNumErrors();
        x = 0;
        y = 0;
        h = w = MAXCIRCLESIZE*model.getNumFailers()/data.getNumStudents();
        dx = 0.0;
    }

    float sortKey(){
        return model.getGradeGivenError();
    }

    void setY(float yMin, float keyMin, float yMax, float keyMax){
        float keyRange = keyMax - keyMin;
        float frac = (this.sortKey() - keyMin)/keyRange;
        float yRange = yMax - yMin;
        y = yRange*(1-frac) + yMin;
    }

    //call setY() first
    void setX(ArrayList<CircleSprite> otherCircles){
        float x0 = x = CANVAS_DIV*width/2.;
        float offset = 1;
        while (intersectsAny(otherCircles, CIRCLESPACING)){
            x = x0 + offset;
            if (offset > 0){
                offset += 1;
            }else{
                offset -= 1;
            }
            offset *= -1.;
        }
        x = bound(w, x, CANVAS_DIV*width-w);
    }

    boolean intersectsAny(ArrayList<CircleSprite> otherCircles, float spacing){
        for (CircleSprite other : otherCircles){
            if (this == other){
                return false;
            }else if (intersects(other, spacing)){
                return true;
            }
        }
        return false;
    }


    String toString(){
        return (model.getName()+" ("+model.getCategory()+
            ") "+str(model.getNumFailers())+" failers get "+
            str(model.getGradeGivenError()));
    }

    float getRadius(){
        return h/2;
    }

    void update(){
        ;
    }

    void draw(){
        super.draw();
        fill(fc);
        ellipse(x,y,w,h);

        if ( this.isSelected() ) {
          detail.draw();
        }
    }

    void drawText()
    {
        // Only draw the text in the circle if the text width
        // will fit in the circle.
        if ( textWidth(model.getName()) < (w * 2) ) {
          textAlign( CENTER, CENTER );
          fill(tc);
          text(model.getName(), x-.5*w, y-.5*h, w, h);
          textDrawn = true;
        }
        else
        {
          textDrawn = false;
        }
    }

    void drawHoverText()
    {
      if(textDrawn == false)
      {
        if (displayMouseover) {
          textAlign(LEFT, CENTER);
          // first the drop shadow
          fill(#ffffff);
          text( model.getName(), mouseX-1, mouseY-11 );
          fill(#000000);
          text( model.getName(), mouseX, mouseY-10 );
          textDrawn = true;
        }
        else
        {
          textDrawn = false;
        }
      }
    }

    boolean intersects(CircleSprite other){
        return intersects(other, 0);
    }

    boolean intersects(CircleSprite other, float spacing){
        float d = dist(x, y, other.getX(), other.getY());
        return d <= getRadius() + other.getRadius() + spacing;
    }

    boolean intersects(int _x, int _y) {
      float d = dist(x, y, _x, _y);
      return d <= getRadius();
    }
}
