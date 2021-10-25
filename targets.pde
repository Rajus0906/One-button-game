class Bugs {
  
  boolean isLeft;
  PVector position, target;
  float movementSpeed = 0.01;
  float xMargin = 500;
  float yMargin = 150;
  boolean alive = true;
  PVector BugsSize = new PVector(width/6, height/6);

  Bugs() {
    float pickSide = random(1);
    float y = random(yMargin, height-yMargin*2);
    float x1, x2;
    if (pickSide < 0.5) {
      isLeft = true;
      x1 = -xMargin;
      x2 = width + xMargin;
    } else {
      isLeft = false;
      x1 = width + xMargin;
      x2 = -xMargin;
    }
    position = new PVector(x1, y);  
    target = new PVector(x2, y);  
  }
  
  void update() {
    if (position.dist(target) < 5) alive = false;
    
    for (Bullet bullet : Plane.bullets) {
      if (alive && hitDetectRect(position, bullet.position, BugsSize)) {
        enemiesKilled++;
        alive = false;
        explosions.add(new Explosion(position.x, position.y));
      }
    }
    
    if (alive) position.lerp(target, movementSpeed);
  }
  
  void draw() {
    image(BadGuys,position.x, position.y, BugsSize.x, BugsSize.y);
    }
  
  void run() {
    update();
    draw();
  }
    
}
