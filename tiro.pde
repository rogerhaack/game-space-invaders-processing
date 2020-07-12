class shot {
  int x, y;
  int tex = 0;

  shot(int x_, int y_) {
    x = x_;
    y = y_;
  }
  int getX() {
    return x;
  }
  int getY() {
    return y;
  }
  int getTex() {
    return tex;
  }

  void setX(int v) {
    x = v;
  }
  void setY(int v) {
    y = v;
  }
  void setTex(int v) {
    tex = v;
  }
}