// arraylist untuk menyimpan posisi setiap bagian ular
ArrayList<PVector> snake = new ArrayList<PVector>();
// vektor yang menyimpan posisi kepala ular
PVector headPosition;
// vektor yang menyimpan posisi makanan
PVector foodPosition;
// vektor yang menyimpan arah gerakan ular
PVector direction = new PVector(0, 0);

// ukuran sel ular dan makanan
int cellSize = 40;
// lebar dan tinggi grid dalam sel
int gridWidth, gridHeight;

// kecepatan gerak ular
int speed = 20;
// panjang awal ular
int initialLength = 4;
// skor pemain
int score = 0;
// status apakah permainan sedang berjalan atau tidak
boolean isGameRunning = false;

// gambar makanan dan kepala ular
PImage foodImage;
PImage headImage;

void setup() {
  // inisialisasi ukuran layar
  size(1080, 720);
  // menghitung jumlah sel horizontal dan vertikal dalam grid
  gridWidth = width / cellSize;
  gridHeight = height / cellSize;

  // inisialisasi posisi awal kepala ular dan posisi makanan
  headPosition = new PVector(gridWidth / 2, gridHeight / 2);
  foodPosition = new PVector(int(random(gridWidth)), int(random(gridHeight)));

  // memuat gambar makanan dan kepala ular
  foodImage = loadImage("mouse.png"); // Ganti dengan nama gambar makanan yang sesuai
  headImage = loadImage("snakeHead.png");
  
  // mengatur penggambaran
  noStroke();
  fill(0);
}

void draw() {
  // logika utama permainan
  if (isGameRunning) {
    background(200);
    drawSnake();
    drawFood();
    drawScore();

    // pembaruan ular setiap beberapa frame
    if (frameCount % speed == 0) {
      updateSnake();
    }
  } else {
    // Tampilan menu transparan
    background(255);
    fill(0);
    textSize(40);
    textAlign(CENTER, CENTER); 
    text("Snake Game", width / 2, height / 2 - 40);
    textSize(20);
    text("Klik untuk memulai", width / 2, height / 2 + 20);
  }
}

void drawScore() {
  // menggambar skor pemain
  fill(0);
  textSize(20);
  text("Skor: " + score, 50, 20);
}

void drawFood() {
  // menggambar makanan pada posisi yang tepat
  float foodX = foodPosition.x * cellSize + cellSize / 2;
  float foodY = foodPosition.y * cellSize + cellSize / 2;
  
  imageMode(CENTER);
  image(foodImage, foodX, foodY, cellSize, cellSize);
}

void newFood() {
  // menghasilkan posisi makanan baru secara acak
  foodPosition = new PVector(int(random(gridWidth)), int(random(gridHeight)));
}

void drawSnake() {
  // menggambar kepala ular
  float headX = headPosition.x * cellSize + cellSize / 2;
  float headY = headPosition.y * cellSize + cellSize / 2;

  // menghitung sudut rotasi berdasarkan arah kepala ular
  float angle = 0;
  if (direction.x == 1) {
    angle = PI / 2;
  } else if (direction.x == -1) {
    angle = -PI / 2;
  } else if (direction.y == 1) {
    angle = PI;
  }

  // menerapkan rotasi gambar kepala ular
  pushMatrix();
  translate(headX, headY);
  rotate(angle);

  imageMode(CENTER);
  image(headImage, 0, 0, cellSize, cellSize);

  popMatrix();

  // menggambar bagian tubuh ular
  for (int i = 0; i < snake.size(); i++) {
    float snakeX = snake.get(i).x * cellSize + cellSize / 2;
    float snakeY = snake.get(i).y * cellSize + cellSize / 2;
    
    // menggambar sel tubuh ular berupa lingkaran berwarna hijau gelap
    fill(63, 133, 44);
    ellipse(snakeX, snakeY, cellSize, cellSize);
  }
}

void updateSnake() {
  // menambah posisi kepala ular ke dalam arraylist
  if (direction.x != 0 || direction.y != 0) {
    snake.add(new PVector(headPosition.x, headPosition.y));
  }
  // membatasi panjang ular sesuai dengan panjang awal
  while (snake.size() > initialLength) {
    snake.remove(0);
  }
  // memperbarui posisi kepala ular berdasarkan arah gerakan
  headPosition.add(direction);

  // logika saat ular makan makanan
  if (headPosition.x == foodPosition.x && headPosition.y == foodPosition.y) {
    newFood();
    initialLength += 1;
    // mengurangi kecepatan dan meningkatkan skor saat ular makan makanan
    speed = constrain(speed - 1, 0, 20);
    score += 1;
  }

  // logika saat ular menabrak dirinya sendiri
  for (int i = 0; i < snake.size(); i++) {
    if (headPosition.x == snake.get(i).x && headPosition.y == snake.get(i).y) {
      //gameOver();
      resetGame();
    }
  }

  // logika saat ular menabrak dinding
  if (headPosition.x < 0) {
    headPosition.x = gridWidth - 1;
  }
  if (headPosition.x > gridWidth) {
    headPosition.x = 0;
  }
  if (headPosition.y < 0) {
    headPosition.y = gridHeight - 1;
  }
  if (headPosition.y > gridHeight) {
    headPosition.y = 0;
  }
}

void resetGame() {
  // mengatur ulang kondisi permainan saat pemain kalah
  speed = 20;
  initialLength = 4;
  headPosition = new PVector(gridWidth / 2, gridHeight / 2);
  direction = new PVector(0, 0);
  newFood();
  snake = new ArrayList<PVector>();
  score = 0;
}

void mousePressed() {
  // memulai permainan saat pemain mengklik layar
  if (!isGameRunning) {
    isGameRunning = true;
  }
}

void keyPressed() {
  // mengubah arah gerakan ular berdasarkan tombol yang ditekan
  if (key == CODED) {
    if (keyCode == UP && direction.y == 0) {
      direction.set(0, -1);
    } else if (keyCode == DOWN && direction.y == 0) {
      direction.set(0, 1);
    } else if (keyCode == LEFT && direction.x == 0) {
      direction.set(-1, 0);
    } else if (keyCode == RIGHT && direction.x == 0) {
      direction.set(1, 0);
    }
  }
}
