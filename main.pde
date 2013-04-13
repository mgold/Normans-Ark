static final int DEFAULT_HEIGHT = 600;
static final int DEFAULT_WIDTH = 800;
ArrayList<Sprite> sprites;
DataModel data;
Sprite selected = null;

final float DAMPING = 0.7;
final float REPULSION = 200;
final float EDGE_REPULSION = 200;
final float TOTAL_ENERGY_FLOOR = 5.0;
final float TIMESTEP = 1;

float totalKineticEnergy = 6.0;
int placementCounter = 0;

void setup(){
    size(DEFAULT_WIDTH, DEFAULT_HEIGHT);
    textAlign(CENTER, CENTER);
    textSize(12);

    data = new DataModel();

    sprites = new ArrayList(data.getNumErrors());
    for (int i = 0; i < data.getNumErrors(); i++){
        sprites.add(new CircleSprite(i));
    }

    float keyMin = 100;
    float keyMax = -1;
    for (Sprite s : sprites){
        float sortKey = s.sortKey();
        if (sortKey < keyMin){
            keyMin = sortKey;
        }
        if (sortKey > keyMax){
            keyMax = sortKey;
        }
    }

    for (Sprite s : sprites){
        ((CircleSprite)s).setX(25.0, keyMin, width-50.0, keyMax);
    }

    //add more (non-circle) sprites here...

}

void draw(){
    background(#FFFFFF);
    fill(#000000);
    
    applyForces();
    
    for (Sprite s : sprites){
        s.update();
    }

    for (Sprite s : sprites){
        s.draw();
    }
}

void applyForces()
{
//  if(totalKineticEnergy >= TOTAL_ENERGY_FLOOR)
  if(++placementCounter < 50)
  {
    int i = 0;
    String t = "" + totalKineticEnergy;
    
    println(t);
    
    totalKineticEnergy = 0;
    
    for(Sprite s : sprites)
    {
      float netForceY = 0.0;
      
      for(Sprite sRepel : sprites)
      {
        if(s != sRepel)
        {
          netForceY += coulombRepulsionY(s, sRepel);
          
          
//          println("Net force right now is " + netForceY);
        }
      }
      
      netForceY += topRepulsion(s) + bottomRepulsion(s);
      
      ((CircleSprite) s).setVelocityY(((CircleSprite) s).getVelocityY() + (TIMESTEP * netForceY) * DAMPING);
      
//      println("Current kinetic energy is " + ((CircleSprite) s).getEnergy());
      
      totalKineticEnergy += ((CircleSprite) s).getEnergy();
    }
    
    for(Sprite s : sprites)
    {
      s.setY(s.getY() + (TIMESTEP * ((CircleSprite) s).getVelocityY()));
    }
  }
}

float coulombRepulsionY(Sprite s1, Sprite s2)
{
  float repulsionY = 0.0;
  
  float distY = -1;
  
  float distance = max(dist(s1.getX(), s1.getY(), s2.getX(), s2.getY()), 1);
  
  repulsionY = (distY / sq(distance)) * REPULSION;
  
  return repulsionY;
}

float topRepulsion(Sprite s)
{
  return (s.getY() / sq(s.getY())) * EDGE_REPULSION;
}

float bottomRepulsion(Sprite s)
{
  float distY = s.getY() - height;
  
return (distY / sq(distY)) * EDGE_REPULSION;
}

void mouseClicked(){
  Sprite prevSelected = selected;
  selected = null; 

  // determine if user is clicking on a sprite
  for ( Sprite s : sprites ) {
    if ( s.intersects( mouseX, mouseY ) ) {
      if ( prevSelected != null && prevSelected.equals( s ) ) {
        selected = null;
      } else {
        selected = s;
      }
    }
    s.focus(); // by default, everything should be in focus
  }

  // if user clicked on a sprite, fade the others
  if ( selected != null ) {
    for ( Sprite s : sprites ) {
      if ( !s.equals( selected ) ) {
        s.fade(); 
      }
    }
  }
}

void mouseMoved() {
  for ( Sprite s : sprites ) {
    if ( s.intersects( mouseX, mouseY ) ) {
      s.setHighlight();
    } else {
      s.unsetHighlight();
    }
  }
}
