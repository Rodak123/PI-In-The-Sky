class Pie {

  PVector pos;
  PVector vel;
  PVector acc;
  float maxSpeed;

  float r;

  int digit;

  boolean missable = true;

  color[] palette;

  Pie(float x, float y, float r, int digit, color[] palette) {
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    this.r = r;
    maxSpeed = r*1.5;
    this.digit = digit;
    this.palette = new color[palette.length];
    for (int i=0; i<palette.length; i++)
      this.palette[i] = color(palette[i]);
  }

  void show() {
    pushMatrix();
    translate(pos.x, pos.y);

    noStroke();
    fill(palette[2]);
    ellipse(0, 0, r*2.5, r*2.5);

    
    fill(palette[0]);
    stroke(palette[1]);
    float strokeWeight = r*0.1;
    strokeWeight(strokeWeight);
    //ellipse(0, 0, r*2-strokeWeight*0.5, r*2-strokeWeight*0.5);
    
    float size = r*2-strokeWeight*0.5;
    float anglePart = TWO_PI / 9;
    for(int i=0;i<digit;i++){
      arc(0,0,size, size,anglePart*i,anglePart*i+1,PIE);
    }
    
    fill(palette[1]);
    noStroke();
    textSize(r);
    textAlign(CENTER, CENTER);
    //text(digit, 0, 0);

    popMatrix();
  }

  void update() {
    vel.add(acc);
    acc.mult(0);
    vel.limit(maxSpeed);
    pos.add(vel);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }
}
