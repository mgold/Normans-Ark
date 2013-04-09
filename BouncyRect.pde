//An example subclass of Sprite.
//Won't be part of the final product.

class BouncyRect extends Sprite{
    int dx, dy;

    BouncyRect(float _x, float _y, float _w, float _h){
        super(_x, _y, _w, _h);
        dx = dy = 3;
    }

    void update(){
        x += dx;
        y += dy;
        if (x < 0){
            x = 0;
            dx *= -1;
        }
        if (x+w > width){
            x = width - w;
            dx *= -1;
        }
        if (y < 0){
            y = 0;
            dy *= -1;
        }
        if (y+h > height){
            y = height - h;
            dy *= -1;
        }
    }

    void draw(){
        super.draw();
        rect(x,y,w,h);
    }

}
