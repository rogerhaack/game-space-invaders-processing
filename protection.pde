class protection {
  int x, y;
  int damages = 0;

  protection() {
  }

  protection(int x_, int y_) {
    x = x_;
    y = y_;
  }
  int getX() {
    return x;
  }
  int getY() {
    return y;
  }
  int getDamages() {
    return damages;
  }

  void setDamages(int v) {
    damages = v;
  }

  void setupBlocs() {
    int blocNbre = 0;
    for (int i = 0; i < 100; i++) {
      for (int j = 0; j < 1; j++) { //Quantidade de camadas de proteção      
        if (int(i/3)%4 == 0) {      
          blocs[blocNbre] = new protection(45+i*12, 470+j*12);
          blocIs[blocNbre] = true;
          blocNbre++;
        }
      }
    }
  }
}