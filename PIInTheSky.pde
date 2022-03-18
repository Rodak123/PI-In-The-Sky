
static color BGC = #81D4FA;
static color FGC = #FFFFFF;
static color[] PIEC = new color[]{#3F51B5, #FFE082, #eeeeee};
static color GREEN = #399339;
static color RED = #933939;

String pi = "";
ArrayList<Digit> digits;

int currentDigitIndex = 0;
int currentDigit;

PVector G;
ArrayList<Pie> pies;

Plate plate;

int maxMisses = 3;
int misses = 0;
Life[] lives;

int gameState = 0;

void setup() {
  size(600,800);
  
  G = new PVector(0, height*0.0005);

  pi = loadStrings("pi-million.txt")[0];
  incCurrentDigit();

  digits = new ArrayList<Digit>();

  pies = new ArrayList<Pie>();

  plate = new Plate(width*0.5, width*0.25, width*0.05);

  lives = new Life[maxMisses];
  float lifeTextSize = width*0.2;
  for (int i=0; i<lives.length; i++) {
    float x = (i * lifeTextSize)-((maxMisses) * lifeTextSize * 0.5)+(lifeTextSize*0.5);
    lives[i] = new Life("π", GREEN, "X", RED, width*0.5+x, lifeTextSize*0.5, lifeTextSize);
  }
}

void draw() {
  background(BGC);

  // UI

  for (int i=digits.size()-1; i>=0; i--) {
    Digit digit = digits.get(i);
    digit.update();
    digit.show();

    if (digit.remove())
      digits.remove(i);
  }

  textAlign(CENTER, CENTER);
  String currentDigitText = currentDigit + "";
  float currentDigitTextSize = width*0.75;
  fill(FGC);
  if (gameState == 0) {
    currentDigitText = "Tap\nTo\nPlay";
    currentDigitTextSize = width*0.1;
    fill(FGC);
  }else if(gameState == 2){
    currentDigitTextSize = width*0.175;
    textSize(currentDigitTextSize*2);
    fill(GREEN);
    noStroke();
    text(digits.size(),width*0.5,height*0.75);
    
    currentDigitText = "Game Over\nTotal digits:";
    fill(RED);
  }
  noStroke();
  textSize(currentDigitTextSize);
  text(currentDigitText, width*0.5, height*0.5);

  for (int i=0; i<lives.length; i++) {
    lives[i].show();
    lives[i].update();
  }

  // Game 

  if (frameCount % 20 == 0 && gameState == 1)
    spawnPie();

  for (int i=pies.size()-1; i>=0; i--) {
    Pie pie = pies.get(i);

    boolean remove = false;

    if (plate.collide(pie)) {
      if (pie.digit == currentDigit) {
        addNewDigit();
        incCurrentDigit();

        for (Pie p : pies)
          if (p.pos.y > 0)
            p.missable = false;

        if (misses > 0)
          misses--;
      } else {
        misses = maxMisses;
        break;
      }
      remove = true;
    }

    if (pie.pos.y > height+pie.r) {
      if (pie.missable && pie.digit == currentDigit) {
        misses++;
      }
      remove = true;
    }

    if (remove) {
      pies.remove(i);
      continue;
    }


    pie.show();
    pie.update();
    pie.applyForce(G);
  }

  for (int i=0; i<lives.length; i++) {
    Life life = lives[i];
    if (i >= misses && !life.isAlive()) {
      life.revive();
    } else if (i < misses && life.isAlive()) {
      life.kill();
    }
  }

  if (misses >= maxMisses) {
    pies.clear();
    gameState = 2;
  }

  if (gameState == 1) {
    plate.show();
    if (mousePressed)
      plate.pos.x = mouseX;
  }
}

void mousePressed() {
  if (gameState == 0 || gameState == 2)
    gameState = 1;
  if (misses >= maxMisses) {
    misses = 0;
    for (Digit digit : digits) {
      digit.flyAway();
    }
    resetCurrentDigit();
  }
}

void incCurrentDigit() {
  setCurrentDigit();
  currentDigitIndex++;
}

void resetCurrentDigit() {
  currentDigitIndex = 0;
  incCurrentDigit();
}

void setCurrentDigit() {
  currentDigit = int(pi.substring(currentDigitIndex, currentDigitIndex+1));
}

void addNewDigit() {
  float size = width*0.1;

  float x = random(size, width-size);
  float y = random(size*3, height-size*2);

  Digit digit = new Digit(currentDigit, x, y, size, FGC);
  digits.add(digit);
}

void spawnPie() {
  float r = width*0.1*random(0.65, 0.75);

  float x = random(r, width-r);

  float y = -random(r, r*4);

  int digit = floor(random(0, 10));

  pies.add(new Pie(x, y, r, digit, PIEC));
}


// Helper functions

color addRGB(color col, float amt) {
  return color(red(col)+amt, green(col)+amt, blue(col)+amt);
}
