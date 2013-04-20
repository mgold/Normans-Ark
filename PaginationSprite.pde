class PaginationSprite extends Sprite
{
  private final static int TRIANGLE_SPACING = 5;
  private final static int PAGE_TEXT_SPACING = 15;
  private final static int TRIANGLE_SIDE = 20;
  private final int TRIANGLE_HEIGHT = (int) ((sqrt(3)/2) * TRIANGLE_SIDE);
  
  Page pageListener = null;
  
  private LeftArrowSprite leftArrow = null;
  private RightArrowSprite rightArrow = null;
  
  public PaginationSprite(float inX, float inY)
  {
    super();
    
    setX(inX);
    setY(inY);
    
    leftArrow = new LeftArrowSprite(getX(), getY());
    rightArrow  = new RightArrowSprite(getX() + TRIANGLE_HEIGHT + TRIANGLE_SPACING, getY());
  }
  
  void setPageListener(Page listener)
  {
    pageListener = listener;
  }
  
  boolean intersects(int _x, int _y)
  {
    return leftArrow.intersects(_x, _y) || rightArrow.intersects(_x, _y);
  }
  
  void update()
  {
  }
  
  void draw()
  {
    leftArrow.draw();
    rightArrow.draw();
  }
  
  void drawPageNumber(int pageNumber)
  {
    textAlign(LEFT, BOTTOM);
    text("Page " + pageNumber, getX(), getY() + TRIANGLE_SIDE + PAGE_TEXT_SPACING);
  }
    
  void mouseClick(int inX, int inY)
  {
    leftArrow.mouseClick(inX, inY);
    rightArrow.mouseClick(inX, inY);
  }
  
  
  
  private class LeftArrowSprite extends Sprite
  {
    LeftArrowSprite(float inX, float inY)
    {
      setX(inX);
      setY(inY);
    }
    
    void mouseClick(int inX, int inY)
    {
      if(intersects(inX, inY) == true)
      {
        pageListener.pageBackward();
      }
    }
    
      
    boolean intersects( int _x, int _y ) {
      if ( _x >= x && _x <= x + TRIANGLE_HEIGHT &&
           _y >= y && _y <= y + TRIANGLE_SIDE ) {
         return true;
       } else {
         return false;
       } 
    }
      
    void update()
    {
    }
    void draw()
    {
      fill(#000000);
      triangle(x, y + (TRIANGLE_SIDE / 2), x + TRIANGLE_HEIGHT, y, x + TRIANGLE_HEIGHT, y + TRIANGLE_SIDE);
    }
  }
  
  private class RightArrowSprite extends Sprite
  {
    RightArrowSprite(float inX, float inY)
    {
      setX(inX);
      setY(inY);
    }
    
    boolean intersects( int _x, int _y ) {
      if ( _x >= x && _x <= x + TRIANGLE_HEIGHT &&
           _y >= y && _y <= y + TRIANGLE_SIDE ) {
         return true;
       } else {
         return false;
       } 
    }
    
    void mouseClick(int inX, int inY)
    {
      if(intersects(inX, inY) == true)
      {
        pageListener.pageForward();
      }
    }
    
    void update()
    {
    }
    
    void draw()
    {
      fill(#000000);
      triangle(x, y, x, y + TRIANGLE_SIDE, x + TRIANGLE_HEIGHT, y + (TRIANGLE_SIDE / 2));
    }
  }
}
