class Plate {

  PVector pos;
  PVector dim;

  Plate(float x, float w, float h) {
    pos = new PVector(x, height*0.95-h);
    dim = new PVector(w, h);
  }

  void show() {
    fill(255);
    noStroke();
    rectMode(CENTER);
    rect(pos.x, pos.y, dim.x, dim.y);
  }

  boolean collide(Pie pie) {
    if (((pie.pos.y+pie.r > pos.y-dim.y*0.5) &&
      (pie.pos.y-pie.r*0.5 < pos.y+dim.y*0.5)) &&
      ((pie.pos.x+pie.r > pos.x-dim.x*0.5) &&
      (pie.pos.x-pie.r < pos.x+dim.x*0.5)))
      return true;
    return false;
  }
}
