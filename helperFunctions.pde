PVector rotX( PVector v , float a ) {
  float x =  v.x*1      + v.y*0      + v.z*0;
  float y =  v.x*0      + v.y*cos(a) - v.z*sin(a);
  float z =  v.x*0      + v.y*sin(a) + v.z*cos(a);
  return new PVector( x , y , z );
}

PVector rotY( PVector v , float a ) {
  float x =  v.x*cos(a) + v.y*0      + v.z*sin(a);
  float y =  v.x*0      + v.y*1      + v.z*0;
  float z = -v.x*sin(a) + v.y*0      + v.z*cos(a);
  return new PVector( x , y , z );
}

PVector rotZ( PVector v , float a ) {
  float x =  v.x*cos(a) - v.y*sin(a) + v.z*0;
  float y =  v.x*sin(a) + v.y*cos(a) + v.z*0;
  float z =  v.x*0      + v.y*0      + v.z*1;
  return new PVector( x , y , z );
}

PVector tip( PVector v ) {
  float ang = acos( sqrt(2) / sqrt(3) );
  PVector out = v.copy();
  
  out = rotX( out , PI*0.25 );
  out = rotY( out , -ang );
  return out;
}

// writes triangle to .STL file
void outputTriangleSTL( PVector v0 , PVector v1 , PVector v2 , PrintWriter fileText ) {
    PVector x1 = PVector.sub( v1 , v0 );
    PVector x2 = PVector.sub( v2 , v0 );
    PVector n = new PVector(0,0,0);
    x1.cross( x2 , n );
    n.normalize();
    fileText.println("facet normal " + n.x + " " + n.y + " " + n.z );
    fileText.println( "\touter loop" );
    fileText.println( "\t\tvertex " + v0.x + " " + v0.y + " " + v0.z );
    fileText.println( "\t\tvertex " + v1.x + " " + v1.y + " " + v1.z );
    fileText.println( "\t\tvertex " + v2.x + " " + v2.y + " " + v2.z );
    fileText.println( "\tendloop" );
    fileText.println( "endfacet" );
}

void outputQuadSTL( PVector v0 , PVector v1 , PVector v2 , PVector v3 , PrintWriter fileText ) {
    PVector v4 = new PVector( 0.25*( v0.x + v1.x + v2.x + v3.x ) , 
                 0.25*( v0.y + v1.y + v2.y + v3.y ) , 
                 0.25*( v0.z + v1.z + v2.z + v3.z ) );
    outputTriangleSTL( v4 , v0 , v1 , fileText );
    outputTriangleSTL( v4 , v1 , v2 , fileText );
    outputTriangleSTL( v4 , v2 , v3 , fileText );
    outputTriangleSTL( v4 , v3 , v0 , fileText );
}

// writes disc to .STL file
void outputDisc( PVector c , float h , float r , int n  , PrintWriter fileText ) {
    PVector ud = new PVector( 0 , 0 , 1 );
    // get initial vertices
    float ang = 0;
    PVector rd = new PVector( cos( ang ) , sin( ang ) , 0 );
    PVector c0 = PVector.add( c , PVector.mult( ud , 0 ) );
    PVector c1 = PVector.add( c , PVector.mult( ud , -h ) );
    PVector u0 = PVector.add( c0 , PVector.mult( rd , r ) );
    PVector u1 = PVector.add( c1 , PVector.mult( rd , r ) );
    // for each division
    for( int i = 1 ; i < n+1 ; i++ ) {
      // get new vertices
      ang = i/float(n)*2*PI;
      rd = new PVector( cos( ang ) , sin( ang ) , 0 );
      PVector v0 = PVector.add( c0 , PVector.mult( rd , r ) );
      PVector v1 = PVector.add( c1 , PVector.mult( rd , r ) );
      // write out triangles and quad
      outputQuadSTL( u0 , u1 , v1 , v0 , fileText );
      //outputQuadSTL( v0 , v1 , u1 , u0 , fileText );
      outputTriangleSTL( u1 , c1 , v1 , fileText );
      outputTriangleSTL( v0 , c0 , u0 , fileText );
      // set initial vertices
      u0 = new PVector( v0.x , v0.y , v0.z );
      u1 = new PVector( v1.x , v1.y , v1.z );
    }
}