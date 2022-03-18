class Digit {

  PVector pos;
  float size;

  int animState = -1;
  float animScale = 0;
  float animVel = 0;

  int value;

  color col;

  Digit(int value, float x, float y, float size, color col) {
    this.value = value;
    this.pos = new PVector(x, y);
    this.size = size;
    this.col = col;
    animState = 0;
  }

  void show() {
    fill(col);
    noStroke();
    textAlign(CENTER, CENTER);
    textSize(size*animScale);
    text(value, pos.x, pos.y);
  }

  void update() {
    switch(animState) {
    case -1:
      // STOP
      break;
    case 0:
      if (animScale < 2) {
        animScale += 0.25;
      } else {
        animState = 1;
      }
      break;
    case 1:
      if (animScale > 1.5) {
        animScale -= 0.01;
      } else {
        animState = -1;
      }
      break;
    case 2:
      if (pos.x - size < width) {
        if (animVel < size*0.75)
          animVel += 0.4;
        pos.x += animVel;
      } else {
        animState = -1;
      }
      break;
    }
  }

  void flyAway() {
    animScale = 1.5;
    animState = 2;
  }

  boolean remove() {
    return (pos.x - size > width);
  }
}
