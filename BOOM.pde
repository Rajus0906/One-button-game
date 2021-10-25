class Explosion {
 
  PVector position;
  boolean alive = true;
  int timestamp;
  int lifetime = 200;
  
  Explosion(float x, float y) {
    timestamp = millis();
    position = new PVector(x, y);
  }
  
  void update() {
    if (alive && millis() > timestamp + lifetime) alive = false;
  }
  
  void draw() {
    pushMatrix();
    translate(position.x, position.y);
    image(BOOM, 0, 0);
    popMatrix();
  }
  
  void run() {
    update();
    draw();
  }
  
}
