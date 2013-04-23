class ScaleSprite extends Sprite
{
  private final float X_OFFSET = width * MARGIN;
  private final float HASH_LENGTH = 4;
  private final float TEXT_OFFSET = 6;
  private final float TEXT_POS = X_OFFSET + HASH_LENGTH + TEXT_OFFSET;
  private float scaleMin;
  private float scaleMax;
  private float scalePosMin;
  private float scalePosMax;
  
  public ScaleSprite(float sMin, float sMax, float sPosMin, float sPosMax)
  {
    scaleMin = sMin;
    scaleMax = sMax;
    scalePosMin = sPosMin;
    scalePosMax = sPosMax;
  }

  void update()
  {
  }
  
  boolean intersects(int _x, int _y)
  {
    return true;
  }
  
  void mouseClick(int _x, int _y) {
    ;
  }
  
  void draw()
  {
    stroke(#000000);
    line(X_OFFSET, scalePosMin, X_OFFSET + HASH_LENGTH, scalePosMin);
    line(X_OFFSET, scalePosMax, X_OFFSET + HASH_LENGTH, scalePosMax);
    float midPoint = (scalePosMin + scalePosMax) / 2.0;
    line(X_OFFSET, midPoint, X_OFFSET + HASH_LENGTH, midPoint);
    
    fill(#000000);
    textAlign(LEFT, CENTER);
    textSize(14);
    text("" + (int) (scaleMin * 100) + "%", TEXT_POS, scalePosMin);
    text("" + (int) (scaleMax * 100) + "%", TEXT_POS, scalePosMax);
    float midValue = (scaleMax - scaleMin) / 2;
    text("" + (int) (midValue * 100) + "%", TEXT_POS, midPoint);
    
    line(X_OFFSET, scalePosMin, X_OFFSET, scalePosMax);
  }
}
