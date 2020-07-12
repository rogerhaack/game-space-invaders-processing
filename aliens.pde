class aliens {
  int x, y, type;
  int explode = 0;

  aliens() {
  }

  aliens(int x_, int y_, int type_) {
    x = x_;
    y = y_;
    type = type_;
  }
  void explode() {
    explode = 10;
  }

  int getX() {
    return x;
  }
  int getY() {
    return y;
  }
  int getType() {
    return type;
  }
  int getExplode() {
    return explode;
  }

  void setX(int v) {
    x = v;
  }
  void setY(int v) {
    y = v;
  }
  void setExplode(int v) {
    explode = v;
  }

  public void setupAliens() {
    int alienNbre = 0;
    for (int i = 0; i < 11; i++) {//Numero de inimigos por linha
      for (int j = 0; j < 5; j++) {//Numero de inimigos por coluna
        int type = 0;
        int deltaX = 0;
        if (j == 0) {
          type = 2;
          deltaX = 8;
        } else if (j < 3) {
          type = 1;
          deltaX = 6;
        } else {
          type = 0;
          deltaX = 4;
        }
        aliens[alienNbre] = new aliens(100+i*28+deltaX, 100+j*28, type);
        alienIs[alienNbre] = true;
        alienNbre++;
      }
    }
  }
}