class Bullet {
  
  PVector position;
  float rot;
  int timestamp;
  float velocity = 6;
  boolean alive = true;
  int lifetime = 2000;
  
  Bullet(float x, float y, float _rot) {
    position = new PVector(x, y);
    rot = _rot;
    timestamp = millis();
  }
   
  void update() {
    // https://www.emanueleferonato.com/2007/04/28/create-a-flash-artillery-game-step-1/
    position.x += velocity * sin(radians(rot));
    position.y -= velocity * cos(radians(rot));
    
    if (alive && millis() > timestamp + lifetime) alive = false;
  }
  
  void draw() {
    image(PewPew,position.x,position.y);
  }
  
  void run() {
    update();
    draw();  
  }
}
