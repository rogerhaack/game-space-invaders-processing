class images {

  images() {
  }

  void chargeData() {
    font = createFont("data/font.ttf", 20);

    images[0] = loadImage("data/alien 1 1.png");
    images[1] = loadImage("data/alien 1 2.png");
    images[2] = loadImage("data/alien 2 1.png");
    images[3] = loadImage("data/alien 2 2.png");
    images[4] = loadImage("data/alien 3 1.png");
    images[5] = loadImage("data/alien 3 2.png");

    images[6] = loadImage("data/bloc 1.png");
    images[7] = loadImage("data/bloc 2.png");
    images[8] = loadImage("data/bloc 3.png");
    images[9] = loadImage("data/bloc 4.png");

    images[10] = loadImage("data/explosion.png");
    images[13] = loadImage("data/player tir.png");
    images[14] = loadImage("data/player.png");

    images[15] = loadImage("data/tir 1.png");
    images[16] = loadImage("data/tir 2.png");
    images[17] = loadImage("data/tir 3.png");
  }
}