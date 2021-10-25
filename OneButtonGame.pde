String gameScreen;

import gifAnimation.*;
Gif city;
Gif Start;
Gif End;
PImage BOOM;
PImage GoodGuy;
PImage PewPew;
PImage BadGuys;

Bugs bug;
Plane Plane;
ArrayList<Bugs> enemy;
ArrayList<Explosion> explosions;
int bugInterval = 1000;
int markTime = 0;
boolean debug = true;
color debugColor = color(255, 127, 0);

PFont font;
int fontSize = 40;
int enemiesKilled = 0;

void setup() {
  
  size(800, 600, P2D);
  gameScreen = "START";
  
  city = new Gif(this, "city.gif"); //https://wallpaperaccess.com/full/2825722.gif
  city.loop();
  
  Start = new Gif(this, "Start.gif"); //https://c.tenor.com/hEQj4yw2vmkAAAAC/start-game.gif
  Start.loop();
  
  End = new Gif(this, "End.gif"); //https://gifer.com/en/QeMS
  End.loop();
  
  font = createFont("Arial", fontSize);
  textFont(font, fontSize);
  
  Plane = new Plane(width/2, height - 100);
  enemy = new ArrayList<Bugs>();
  explosions = new ArrayList<Explosion>();

  GoodGuy = loadImage("plane.png"); //https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/94b3686e-2727-4e07-9636-a78eb964d019/d9m9jgh-23966393-cf4d-4509-b7ad-eeed1d070033.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzk0YjM2ODZlLTI3MjctNGUwNy05NjM2LWE3OGViOTY0ZDAxOVwvZDltOWpnaC0yMzk2NjM5My1jZjRkLTQ1MDktYjdhZC1lZWVkMWQwNzAwMzMucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.NsKRHPTX_aYIqAyj_bAXYZWWJTJpBZM5FUFnWBbo9Uw
  GoodGuy.resize(width/5, height/2);
  
  PewPew = loadImage("bullets.png"); //https://lh3.googleusercontent.com/proxy/Mv8ldze0FiJgNdZjxPVRmLwS0IJUYz849S3wyvR4FRD2uoOwaxJ-GCGUUHcTnIDw8jjL7H308x0gV_4zlSmKyaCah-adz_KP
  PewPew.resize(width/15, height/9);
  
  BadGuys = loadImage("badguy.png");//https://static.wikia.nocookie.net/charactercommunity/images/b/b5/Galaga-ship-png-4.png/revision/latest?cb=20200212151654

  
  BOOM = loadImage("explosion.png"); //https://www.vhv.rs/dpng/d/455-4553493_pixel-art-explosion-png-transparent-png.png
  BOOM.resize(width/6, height/5);
  imageMode(CENTER);
}


void draw() {
  if (gameScreen == "START") {
    initScreen() ;
  } else if (gameScreen == "PLAY") {
    gameScreen();
  } else if (gameScreen == "LOSE") {
    gameOverScreen();
  }
}
  
void initScreen () {
  background(0);
  image(Start,400,264,300,200);
}  

void startGame() {
  gameScreen="PLAY";
}


void gameScreen() {  
  background(127);
  image(city,400,304,800,620);
  
  int t = millis();
  
  if (t > markTime + bugInterval) {
    enemy.add(new Bugs());
    markTime = t;
  }
    
  Plane.run();
    
  for (int i=enemy.size()-1; i>=0; i--) {
    Bugs plane = enemy.get(i);
    
    if (plane.alive) {
      plane.run();
    } else {
      enemy.remove(i);
    }
  }
  
  for (int i=explosions.size()-1; i>=0; i--) {
    Explosion explosion = explosions.get(i);
    
    if (explosion.alive) {
      explosion.run();
    } else {
      explosions.remove(i);
    }
  }
  
  println("KILL THEM ALL");
  
  fill(255);
  text(enemiesKilled, 10, fontSize);
  
  surface.setTitle("" + frameRate);
}

void gameOverScreen() {
  background(0);
  image(End,400,264,300,200);
  if(keyPressed) {
    gameScreen = "START";
  }
}


boolean hitDetectRect(PVector p1, PVector p2, PVector hitbox) {
  hitbox = hitbox.copy().div(2);
  
  if (p1.x >= p2.x - hitbox.x && p1.x <= p2.x + hitbox.x && p1.y >= p2.y - hitbox.y && p1.y <= p2.y + hitbox.y) {
    return true;
  } else {
    return false;
  }
}
