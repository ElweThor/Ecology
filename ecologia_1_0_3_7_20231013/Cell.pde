class Cell { //<>//
  ArrayList<Body> bodies;
//  int elem;

  Cell() { //<>//
    bodies = new ArrayList<Body>();
//    elem = new Body();
  } //<>//
  
  void addBody(Body body) {
    bodies.add(body);
  } //<>//

  void removeBody(Body body) {
    bodies.remove(body);
  } //<>//

  void update() {
    for (int i = bodies.size() - 1; i >= 0; i--) {
      Body body = bodies.get(i);
      body.update();
      if (!body.isAlive()) {
        bodies.remove(i);
      }
    }
  } //<>//

  void show() {
    for (Body body : bodies) {
      body.show();
    }
  }
}
