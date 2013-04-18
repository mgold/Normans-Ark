class ColorModel {
  protected final color PASSING_COLOR = color( 0, 90, 0, 90 );
  protected final color ACTIVE_ERROR_COLOR = color( 225, 0, 0 );
  protected final color DETAIL_BKGD_COLOR = color(212, 216, 223, 100);
  protected final color c4 = color(1, 35, 38);
  protected final color c2 = color(23, 69, 92);
  protected final color c3 = color(225, 202, 171);
  protected final color c1 = color(254, 131, 51);
  protected final color c5 = color(150, 73, 19);
  protected final color t1 = color(0, 0, 0);
  protected final color t2 = color(255, 255, 255);
  protected final color[] colors = { c1, c2, c3, c4, c5 };
  protected final color[] text = { t2, t2, t1, t1, t2 };

  ColorModel() {
    ;
  }

  int getNumColors(){
      return colors.length;
  }
  
  color getColor(int colorID) {
    return colors[colorID%colors.length];
  }

  color getTextColor(int colorID) {
    return text[colorID%colors.length];
  }

  color getFaded(color c) {
    return color( c, 50 ); 
  }
  
  color getPassingColor() {
    return PASSING_COLOR; 
  }
  
  color getActiveErrorColor() {
    return ACTIVE_ERROR_COLOR; 
  }
  
  color getDetailBkgdColor() {
    return DETAIL_BKGD_COLOR;
  }
}
