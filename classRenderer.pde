

class Renderer {
  PGraphics pg;
  float xMin;
  float xMax;
  float xExt;
  float yMin;
  float yMax;
  float yExt;
  float zMin;
  float zMax;
  float zExt;
  color bgColor;
  color stColor;
  color fiColor;
  float m2p;

  Renderer( PGraphics pgin ) {
    this.pg = pgin;
    this.xMin = -50;
    this.xMax = 50;
    this.yMin = -50;
    this.yMax = 50;
    this.zMin = -50;
    this.zMax = 50;
    this.xExt = xMax - xMin;
    this.yExt = yMax - yMin;
    this.zExt = zMax - zMin;
    this.bgColor = color( 0, 0, 0 );
    this.stColor = color( 255, 255, 255 );
    this.fiColor = color( 128, 128, 128 );
  }

  void drawBG() {
    float a = pg.height / yExt;
    pg.background( bgColor );
    pg.stroke( 255 );
    pg.strokeWeight(1);
    pg.noFill();
    pg.box( xExt*a, yExt*a, zExt*a );
  }

  void exportTree( Tree T, float amt ) {
    PrintWriter pw = createWriter( "treeCube.stl" );
    pw.println( "solid treeCube" );
    float d = xExt / float(T.dim - 1);
    float f = d*amt;
    println(d, f);

    // write out occupied centers
    for ( int xi = 0; xi < T.dim; xi++ ) {
      for ( int yi = 0; yi < T.dim; yi++ ) {
        for ( int zi = 0; zi < T.dim; zi++ ) {
          Node N = T.getNode( xi, yi, zi );
          float x1 = xMin + d*float(N.x);
          float y1 = yMin + d*float(N.y);
          float z1 = zMin + d*float(N.z);
          PVector[] v = new PVector[8];
          v[0] = new PVector( x1 + f, y1 + f, z1 - f );
          v[1] = new PVector( x1 + f, y1 + f, z1 + f );
          v[2] = new PVector( x1 - f, y1 + f, z1 + f );
          v[3] = new PVector( x1 - f, y1 + f, z1 - f );
          v[4] = new PVector( x1 + f, y1 - f, z1 - f );
          v[5] = new PVector( x1 + f, y1 - f, z1 + f );
          v[6] = new PVector( x1 - f, y1 - f, z1 + f );
          v[7] = new PVector( x1 - f, y1 - f, z1 - f );
          for ( int i = 0; i < 8; i++ ) {
            v[i] = tip( v[i] );
          }

          outputQuadSTL( v[4], v[0], v[1], v[5], pw );
          outputQuadSTL( v[7], v[3], v[0], v[4], pw );
          outputQuadSTL( v[3], v[2], v[1], v[0], pw );
          outputQuadSTL( v[6], v[2], v[3], v[7], pw );
          outputQuadSTL( v[5], v[1], v[2], v[6], pw );
          outputQuadSTL( v[4], v[5], v[6], v[7], pw );
        }
      }
    }

    // write out connections
    for ( int xi = 0; xi < T.dim; xi++ ) {
      for ( int yi = 0; yi < T.dim; yi++ ) {
        for ( int zi = 0; zi < T.dim; zi++ ) {
          Node N = T.getNode( xi, yi, zi );
          if ( N.cx ) {
            float x1 = xMin + d*float(N.x)+f;
            float y1 = yMin + d*float(N.y);
            float z1 = zMin + d*float(N.z);
            float x2 = xMin + d*float(N.x+1)-f;
            float y2 = yMin + d*float(N.y);
            float z2 = zMin + d*float(N.z);
            PVector[] v = new PVector[8];
            v[0] = new PVector( x2, y1 + f, z1 - f );
            v[1] = new PVector( x2, y1 + f, z1 + f );
            v[2] = new PVector( x1, y1 + f, z1 + f );
            v[3] = new PVector( x1, y1 + f, z1 - f );
            v[4] = new PVector( x2, y1 - f, z1 - f );
            v[5] = new PVector( x2, y1 - f, z1 + f );
            v[6] = new PVector( x1, y1 - f, z1 + f );
            v[7] = new PVector( x1, y1 - f, z1 - f );
            for ( int i = 0; i < 8; i++ ) {
              v[i] = tip( v[i] );
            }
            outputQuadSTL( v[4], v[0], v[1], v[5], pw );
            outputQuadSTL( v[7], v[3], v[0], v[4], pw );
            outputQuadSTL( v[3], v[2], v[1], v[0], pw );
            outputQuadSTL( v[6], v[2], v[3], v[7], pw );
            outputQuadSTL( v[5], v[1], v[2], v[6], pw );
            outputQuadSTL( v[4], v[5], v[6], v[7], pw );
          }

          if ( N.cy ) {
            float x1 = xMin + d*float(N.x);
            float y1 = yMin + d*float(N.y)+f;
            float z1 = zMin + d*float(N.z);
            float x2 = xMin + d*float(N.x);
            float y2 = yMin + d*float(N.y+1)-f;
            float z2 = zMin + d*float(N.z);
            PVector[] v = new PVector[8];
            v[0] = new PVector( x1 + f, y2, z1 - f );
            v[1] = new PVector( x1 + f, y2, z1 + f );
            v[2] = new PVector( x1 - f, y2, z1 + f );
            v[3] = new PVector( x1 - f, y2, z1 - f );
            v[4] = new PVector( x1 + f, y1, z1 - f );
            v[5] = new PVector( x1 + f, y1, z1 + f );
            v[6] = new PVector( x1 - f, y1, z1 + f );
            v[7] = new PVector( x1 - f, y1, z1 - f );
            for ( int i = 0; i < 8; i++ ) {
              v[i] = tip( v[i] );
            }
            outputQuadSTL( v[4], v[0], v[1], v[5], pw );
            outputQuadSTL( v[7], v[3], v[0], v[4], pw );
            outputQuadSTL( v[3], v[2], v[1], v[0], pw );
            outputQuadSTL( v[6], v[2], v[3], v[7], pw );
            outputQuadSTL( v[5], v[1], v[2], v[6], pw );
            outputQuadSTL( v[4], v[5], v[6], v[7], pw );
          }

          if ( N.cz ) {
            float x1 = xMin + d*float(N.x);
            float y1 = yMin + d*float(N.y);
            float z1 = zMin + d*float(N.z)+f;
            float x2 = xMin + d*float(N.x);
            float y2 = yMin + d*float(N.y);
            float z2 = zMin + d*float(N.z+1)-f;
            PVector[] v = new PVector[8];
            v[0] = new PVector( x1 + f, y1 + f, z1 );
            v[1] = new PVector( x1 + f, y1 + f, z2 );
            v[2] = new PVector( x1 - f, y1 + f, z2 );
            v[3] = new PVector( x1 - f, y1 + f, z1 );
            v[4] = new PVector( x1 + f, y1 - f, z1 );
            v[5] = new PVector( x1 + f, y1 - f, z2 );
            v[6] = new PVector( x1 - f, y1 - f, z2 );
            v[7] = new PVector( x1 - f, y1 - f, z1 );
            for ( int i = 0; i < 8; i++ ) {
              v[i] = tip( v[i] );
            }
            outputQuadSTL( v[4], v[0], v[1], v[5], pw );
            outputQuadSTL( v[7], v[3], v[0], v[4], pw );
            outputQuadSTL( v[3], v[2], v[1], v[0], pw );
            outputQuadSTL( v[6], v[2], v[3], v[7], pw );
            outputQuadSTL( v[5], v[1], v[2], v[6], pw );
            outputQuadSTL( v[4], v[5], v[6], v[7], pw );
          }
        }
      }
    }

    PVector c = new PVector( 0, 0, (zMin)*sqrt(3) + baseOffset );
    outputDisc( c, 10, 70, 200, pw );

    pw.println( "endsolid treeCube" );
    pw.flush();
    pw.close();
  }


  void exportTree2( Tree T, float amt ) {
    PrintWriter pw = createWriter( "treeCube.stl" );
    pw.println( "solid treeCube" );
    float d = xExt / float(T.dim - 1);
    float f = d*amt;
    println(d, f);



    PVector c = new PVector( 0, 0, zMin );
    outputDisc( c, 20, baseHeight, 20, pw );

    pw.println( "endsolid treeCube" );
    pw.flush();
    pw.close();
  }

  void drawTree( Tree T ) {
    float d = xExt / float(T.dim - 1);
    for ( int xi = 0; xi < T.dim; xi++ ) {
      for ( int yi = 0; yi < T.dim; yi++ ) {
        for ( int zi = 0; zi < T.dim; zi++ ) {
          Node N = T.getNode( xi, yi, zi );
          float x1 = xMin + d*float(N.x);
          float y1 = yMin + d*float(N.y);
          float z1 = zMin + d*float(N.z);
          PVector v1 = new PVector( x1, y1, z1 );
          if ( N.cx ) {
            PVector v2 = new PVector( v1.x+d, v1.y, v1.z );
            PVector vr1 = m2p(tip( v1 ));
            PVector vr2 = m2p(tip( v2 ));
            pg.line( vr1.x, vr1.y, vr1.z, vr2.x, vr2.y, vr2.z );
          }
          if ( N.cy ) {
            PVector v2 = new PVector( v1.x, v1.y+d, v1.z );
            PVector vr1 = m2p(tip( v1 ));
            PVector vr2 = m2p(tip( v2 ));
            pg.line( vr1.x, vr1.y, vr1.z, vr2.x, vr2.y, vr2.z );
          }
          if ( N.cz ) {
            PVector v2 = new PVector( v1.x, v1.y, v1.z+d );
            PVector vr1 = m2p(tip( v1 ));
            PVector vr2 = m2p(tip( v2 ));
            pg.line( vr1.x, vr1.y, vr1.z, vr2.x, vr2.y, vr2.z );
          }
        }
      }
    }
  }

  void drawTree2( Tree T ) {
    float d = pg.height / float(T.dim - 1);
    for ( int xi = 0; xi < T.dim; xi++ ) {
      for ( int yi = 0; yi < T.dim; yi++ ) {
        for ( int zi = 0; zi < T.dim; zi++ ) {
          Node N = T.getNode( xi, yi, zi );
          float x = xMin + d*float(N.x);
          float y = yMin + d*float(N.y);
          float z = zMin + d*float(N.z);
          if ( N.cx ) { 
            pg.line( x, y, z, x+d, y, z );
          }
          if ( N.cy ) { 
            pg.line( x, y, z, x, y+d, z );
          }
          if ( N.cz ) { 
            pg.line( x, y, z, x, y, z+d );
          }
        }
      }
    }
  }


  PVector m2p( PVector v ) {
    float a = pg.height / xExt;
    PVector pOut = new PVector( v.x*a, v.y*a, v.z*a );
    return pOut;
  }
}