ArrayList<Sprite> sprites;
DataModel data;

void setup(){
    size(800,600);
    textAlign(CENTER, CENTER);
    textSize(12);

    data = new DataModel();

    sprites = new ArrayList(data.getNumErrors());
    for (int i = 0; i < data.getNumErrors(); i++){
        sprites.add(new CircleSprite(i));
    }

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
