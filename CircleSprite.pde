final float MAXCIRCLESIZE = 100;

class CircleSprite extends Sprite{
    ErrorModel model;

    CircleSprite(int id){
        super();
        model = data.getError(id);
        int numErrors = data.getNumErrors();
        x = (1+id)*width/(numErrors+1);
        y = height/2;
        h = w = MAXCIRCLESIZE*model.getNumFailers()/data.getNumStudents();
        f = #AAAAAA;
    }

    void update(){
        ;
    }

    void draw(){
        super.draw();
        ellipse(x,y,w,h);
    }

}
