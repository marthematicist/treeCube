class Node {
  int x;
  int y;
  int z;
  boolean free;
  boolean cx;
  boolean cy;
  boolean cz;
  
  Node( int xIn , int yIn , int zIn ) {
    this.x = xIn;
    this.y = yIn;
    this.z = zIn;
    this.free = true;
    this.cx = false;
    this.cy = false;
    this.cz = false;
  }
  
  
}