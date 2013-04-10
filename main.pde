ArrayList<Sprite> sprites;
DataModel data;

void setup(){
    size(800,600);
    textAlign(LEFT, TOP);
    textSize(24);

    data = new DataModel();

    sprites = new ArrayList();
    sprites.add(new CircleSprite(0));
    sprites.add(new CircleSprite(1));

}

void draw(){
    background(#FFFFFF);
    fill(#000000);

    for (Sprite s : sprites){
        s.update();
    }

    for (Sprite s : sprites){
        s.draw();
    }
}

void mouseClicked(){
    ;
}
