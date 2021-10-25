class Plane {

  PVector position;
  float rot = 0;
  float rotDelta = 2;
  ArrayList<Bullet> bullets;
  boolean alive;
  
  Plane(float x, float y) {
    position = new PVector(x, y);
    bullets = new ArrayList<Bullet>();
  }
  
  void update() {
    for (int i=bullets.size()-1; i>=0; i--) {
      Bullet bullet = bullets.get(i);
      if (bullet.alive) {
        bullet.run();
      } else {
        bullets.remove(i);
      }
    }
  }
  
  void fire() {
    bullets.add(new Bullet(mouseX,mouseY, rot));
  }
  
  void draw() {
    pushMatrix(); 
    translate(mouseX,mouseY);
    image(GoodGuy, 0,0);
    rotate(radians(rot));
    popMatrix();
  }
  
  void run() {
    update();
    draw();
  }

}
