// controls how many vertices on each face
int treeDim = 5;
// controls base offset (so you don't have a corner sticking out of the bottom)
float baseOffset = 1;
// controls the height of the base (mm)
float baseHeight = 50;
// controls how thick the paths are
float pathThickness = 0.2;

PGraphics pg;
Renderer R;


Tree T;

void setup() {
  size( 800, 800, P3D );
  pg = createGraphics( 800, 800, P3D );
  
  R = new Renderer( pg );
  T = new Tree( treeDim );
  T.crawl3();
  R.exportTree(T , pathThickness );
}

void draw() {
  float ang = acos( sqrt(2) / sqrt(3) );
  
  pg.beginDraw();
  pg.background(0);
  pg.stroke(255);
  pg.pushMatrix();
  pg.translate( 0.5*width , 0.5*height , -2*height );
  
  //pg.rotateZ(0.5*PI);
  pg.rotateY(mouseX*0.01);
  
  //pg.rotateZ(PI+ang);
  //pg.rotateX(-PI/4);
  
  R.drawTree( T );
  
  pg.popMatrix();
  pg.endDraw();
  image( pg, 0, 0 );
  
  
}