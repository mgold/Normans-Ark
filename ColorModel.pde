class ColorModel {
  protected final color c1 = color(1, 35, 38);
  protected final color c2 = color(23, 69, 92);
  protected final color c3 = color(225, 202, 171);
  protected final color c4 = color(254, 131, 51);
  protected final color c5 = color(150, 73, 19);
  protected final color[] all = { c1, c2, c3, c4, c5 };
  
  ColorModel() {
    
  }
  
  color[] getColors() {
    return this.all;
  }
  
  color getColor1() {
    return c1; 
  }
  
  color getColor2() {
    return c2;
  }
  
  color getColor3() {
    return c3; 
  }
  
  color getColor4() {
    return c4;
  }
  
  color getColor5() {
    return c5;
  }
  
  color getColor( int id ) {
    return all[id%5]; 
  }
  
  color getHighlight( color c ) {
    return color( c, 100 ); 
  }
}
