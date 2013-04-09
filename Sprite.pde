class Sprite{
    float x, y;
    float h, w;
    color f, s;

    Sprite(float _x, float _y, float _h, float _w){
        x = bound(0, _x, width);
        y = bound(0, _y, height);
        h = _h;
        w = _w;
        f = #AAAAAA; // grey fill
        s = -1; // no stroke
    }

    void update(){
        ;
    }

    void draw(){
        if (f == -1){
            noFill();
        }else{
            fill(f);
        }
        if (s == -1){
            noStroke();
        }else{
            stroke(s);
        }
    }

}
