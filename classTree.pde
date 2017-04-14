class Tree {
  int dim;
  Node[] nodes;
  
  Tree( int dimIn ) {
    this.dim = dimIn;
    this.nodes = new Node[dim*dim*dim];
    for( int xi = 0 ; xi < dim ; xi++ ) {
      for( int yi = 0 ; yi < dim ; yi++ ) {
        for( int zi = 0 ; zi < dim ; zi++ ) {
          nodes[zi*dim*dim + yi*dim + xi] = new Node( xi , yi , zi );
        }
      }
    }
  }
  
  Node getNode( int x , int y , int z ) {
    return nodes[z*dim*dim + y*dim + x];
  }
  
  ArrayList<Node> freeMoves( Node n ) {
    ArrayList out = new ArrayList<Node>();
    if( n.x + 1 < dim && getNode(n.x+1,n.y,n.z).free ) {
      out.add( getNode(n.x+1,n.y,n.z) );
    }
    if( n.y + 1 < dim && getNode(n.x,n.y+1,n.z).free ) {
      out.add( getNode(n.x,n.y+1,n.z) );
    }
    if( n.z + 1 < dim && getNode(n.x,n.y,n.z+1).free ) {
      out.add( getNode(n.x,n.y,n.z+1) );
    }
    return out;
  }
  
  ArrayList<Node> occupiedWithFreeMoves() {
    ArrayList out = new ArrayList<Node>();
    for( int xi = 0 ; xi < dim ; xi++ ) {
      for( int yi = 0 ; yi < dim ; yi++ ) {
        for( int zi = 0 ; zi < dim ; zi++ ) {
          Node n = getNode( xi , yi , zi );
          if( n.free == false && freeMoves(n).size() > 0 ) {
            out.add(n);
          }
        }
      }
    }
    return out;
  }
  
  
  void crawl() {
    boolean done = false;
    ArrayList<Node> nodePath = new ArrayList<Node>();
    nodePath.add( getNode(0,0,0) );
    getNode(0,0,0).free = false;
    while( !done ) {
      // current node
      Node currentNode = nodePath.get( nodePath.size() - 1 );
      // get possible moves
      ArrayList<Node> moves = freeMoves( currentNode );
      if( moves.size() > 0 ) {
        // if there are moves
        // choose a move randomly
        Node nextNode = moves.get( floor(random( 0 , moves.size() )) );
        // occupy next node (not free)
        nextNode.free = false;
        // connect current node to next node
        if( nextNode.x == currentNode.x + 1 ) { currentNode.cx = true; }
        if( nextNode.y == currentNode.y + 1 ) { currentNode.cy = true; }
        if( nextNode.z == currentNode.z + 1 ) { currentNode.cz = true; }
        // add next node to node path
        nodePath.add( nextNode );
      } else {
        // if there are no free moves
        if( nodePath.size() > 1 ) {
          // if we can still backtrack, do so (remove last node from node path)
          nodePath.remove( nodePath.size() - 1 );
        } else {
          // we cannot backtrack any more - at start of the path. DONE!
          done = true;
        }
      }
    }
    
  }
  
  void crawl2() {
    boolean done = false;
    ArrayList<Node> nodePath = new ArrayList<Node>();
    nodePath.add( getNode(0,0,0) );
    getNode(0,0,0).free = false;
    while( !done ) {
      // current node
      Node currentNode = nodePath.get( nodePath.size() - 1 );
      // get possible moves
      ArrayList<Node> moves = freeMoves( currentNode );
      if( moves.size() > 0 ) {
        // if there are moves
        // choose a move randomly
        Node nextNode = moves.get( floor(random( 0 , moves.size() )) );
        // occupy next node (not free)
        nextNode.free = false;
        // connect current node to next node
        if( nextNode.x == currentNode.x + 1 ) { currentNode.cx = true; }
        if( nextNode.y == currentNode.y + 1 ) { currentNode.cy = true; }
        if( nextNode.z == currentNode.z + 1 ) { currentNode.cz = true; }
        // add next node to node path
        nodePath.add( nextNode );
      } else {
        // if there are no free moves
        // parse from end of path to find earliest path node that has a free move
        int lastFreeInd = nodePath.size()-1;
        Node lastFreeNode = currentNode;
        for( int i = nodePath.size()-1 ; i >=0 ; i-- ) {
          if( freeMoves( nodePath.get(i) ).size() > 0 ) {
            lastFreeInd = i;
            lastFreeNode = nodePath.get(i);
          }
        }
        if( lastFreeInd < nodePath.size()-1 ) {
          nodePath.clear();
          nodePath.add( lastFreeNode );
        } else {
          done = true;
        }
      }
    }
  }
  
  void crawl3() {
    boolean done = false;
    ArrayList<Node> nodePath = new ArrayList<Node>();
    nodePath.add( getNode(0,0,0) );
    getNode(0,0,0).free = false;
    while( !done ) {
      // current node
      Node currentNode = nodePath.get( nodePath.size() - 1 );
      // get possible moves
      ArrayList<Node> moves = freeMoves( currentNode );
      if( moves.size() > 0 ) {
        // if there are moves
        // choose a move randomly
        Node nextNode = moves.get( floor(random( 0 , moves.size() )) );
        // occupy next node (not free)
        nextNode.free = false;
        // connect current node to next node
        if( nextNode.x == currentNode.x + 1 ) { currentNode.cx = true; }
        if( nextNode.y == currentNode.y + 1 ) { currentNode.cy = true; }
        if( nextNode.z == currentNode.z + 1 ) { currentNode.cz = true; }
        // add next node to node path
        nodePath.add( nextNode );
      } else {
        // if there are no free moves
        // get a list of nodes that are occupied but have free moves
        ArrayList<Node> ofm = occupiedWithFreeMoves();
        if( ofm.size() > 0 ) {
          // if there are acceptable nodes left, clear the path and start at a random one
          nodePath.clear();
          nodePath.add( ofm.get( floor(random(0,ofm.size())) ) );
        } else {
          // if no acceptable noed left, done!
          done = true;
        }
      }
    }
  }
}