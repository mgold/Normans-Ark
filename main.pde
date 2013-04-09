ArrayList<Sprite> sprites;

void setup(){
    size(800,600);
    textAlign(LEFT, TOP);
    textSize(24);

    sprites = new ArrayList();
    sprites.add(new BouncyRect(10,10,50,30));
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
