ArrayList<PVector> snake = new ArrayList<PVector>();
PVector pos;

PVector food;

PVector dir = new PVector(0, 0);

int size = 40;
int w, h;

int spd = 20;
int len = 4;
int score = 0;
boolean gameJalan = false;

PImage snakeTexture; // Ini hapus ajah klo gmw make texture
PImage foodTexture; // Ini hapus ajah klo gmw make texture

void setup() {
  size(1080, 720);
  w = width / size;
  h = height / size;

  pos = new PVector(w / 2, h / 2);
  food = new PVector(int(random(w)), int(random(h)));

  snakeTexture = loadImage("snakeskin.jpeg"); // Ini hapus ajah klo gmw make texture
  foodTexture = loadImage("Tikus.jpg"); // Ini hapus ajah klo gmw make texture

  noStroke();
  fill(0);
}

void draw() {
  if (gameJalan) {
    background(200);
    drawSnake();
    drawFood();
    drawScore();

    if (frameCount % spd == 0) {
      updateSnake();
    }
  } else {
    // Tampilan menu transparan
    background(255);
    fill(0);
    textSize(40);
    textAlign(CENTER, CENTER);
    text("Gem uler", width / 2, height / 2 - 40);
    textSize(20);
    text("klik buat start coi", width / 2, height / 2 + 20);
  }
}

void drawScore() {
  fill(0);
  textSize(20);
  text("Score: " + score, 50, 20);
}

void drawFood() {
  float foodX = food.x * size + size / 2;
  float foodY = food.y * size + size / 2;

  imageMode(CENTER);
  image(foodTexture, foodX, foodY, size, size);
}

void newFood() {
  food = new PVector(int(random(w)), int(random(h)));
}

void drawSnake() {
  float headX = pos.x * size + size / 2;
  float headY = pos.y * size + size / 2;

  imageMode(CENTER);
  image(snakeTexture, headX, headY, size, size / 2);

  for (int i = 0; i < snake.size(); i++) {
    float snakeX = snake.get(i).x * size + size / 2;
    float snakeY = snake.get(i).y * size + size / 2;
    image(snakeTexture, snakeX, snakeY, size, size);
  }
}

void updateSnake() {
  if (dir.x != 0 || dir.y != 0) {
    snake.add(new PVector(pos.x, pos.y));
  }
  while (snake.size() > len) {
    snake.remove(0);
  }
  pos.add(dir);

  if (pos.x == food.x && pos.y == food.y) {
    newFood();
    len += 1;
    spd = constrain(spd - 1, 0, 20);
    score += 1;
  }

  for (int i = 0; i < snake.size(); i++) {
    if (pos.x == snake.get(i).x && pos.y == snake.get(i).y) {
      reset();
    }
  }

  if (pos.x < 0) {
    pos.x = w - 1;
  }
  if (pos.x > w) {
    pos.x = 0;
  }
  if (pos.y < 0) {
    pos.y = h - 1;
  }
  if (pos.y > h) {
    pos.y = 0;
  }
}

void reset() {
  spd = 20;
  len = 5;
  pos = new PVector(w / 2, h / 2);
  dir = new PVector(0, 0);
  newFood();
  snake = new ArrayList<PVector>();
  score = 0;
}

void mousePressed() {
  if (!gameJalan) {
    gameJalan = true;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && dir.y == 0) {
      dir.set(0, -1);
    } else if (keyCode == DOWN && dir.y == 0) {
      dir.set(0, 1);
    } else if (keyCode == LEFT && dir.x == 0) {
      dir.set(-1, 0);
    } else if (keyCode == RIGHT && dir.x == 0) {
      dir.set(1, 0);
    }
  }
}
