class Life {

  PVector pos;
  String[] text;
  int alive = 0;

  float size;

  color[] palette;

  int animState = -1;
  float animScale = 1;

  Life(String a, color colA, String b, color colB, float x, float y, float size) {
    pos = new PVector(x, y);
    this.size = size;

    text = new String[]{a, b};
    palette = new color[]{colA, colB};
  }

  void show() {
    noStroke();
    fill(palette[alive]);
    textSize(size*animScale);
    text(text[alive], pos.x, pos.y);
  }

  void update() {
    switch(animState) {
    case -1:
      // STOP
      break;
    case 0:
      animScale = 2;
      animState = 1;
      break;
    case 1:
      if (animScale > 1) {
        animScale -= 0.1;
      } else {
        animState = -1;
      }
      break;
    }
  }

  boolean isAlive() {
    return alive == 0;
  }

  void kill() {
    alive = 1;
    animState = 0;
  }

  void revive() {
    alive = 0;
    animState = 0;
  }
}
