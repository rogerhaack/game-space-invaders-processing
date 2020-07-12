protection blocs[] = new protection[100];
boolean blocIs[] = new boolean[100];

aliens aliens[] = new aliens[55];
boolean alienIs[] = new boolean[55];

shot tirs[] = new shot[100];
boolean tirIs[] = new boolean[100];

PImage images[] = new PImage[19];
PFont font = new PFont();

int playerPos = 0;

int score = 0;
int best = 0;

int lostCycle = 0;
boolean lost = false;

int cycle = 0;
int cyclePos = 0;
int cycleSpeed = 40;

boolean tir = false;
int tirX = 0;
int tirY = 0;

int lives = 3;

boolean aliensRight = true;
int downIterations = 0;
int alienPosX = 76;
float speedShotAlien = 0.2;

boolean over = false;

boolean left = false;
boolean right = false;
boolean up = false;

images img = new images();
protection prot = new protection();
aliens ali = new aliens();

void setup() {
  size(600, 600);
  img.chargeData();
  prot.setupBlocs();
  ali.setupAliens();
  best = int(loadStrings("score.txt")[0]);  
  playerPos = width/2-13;
}

void keyPressed() {
  if (keyCode == LEFT) left = true;
  if (keyCode == RIGHT) right = true;
  if (keyCode == UP) up = true;
}

void keyReleased() {
  if (keyCode == LEFT) left = false;
  if (keyCode == RIGHT) right = false;
  if (keyCode == UP) up = false;
}

void draw() {
  background(0);
  //Verifica se não jogador não foi atingido exibe nave, se foi exibe imagem nave atingida. 
  if (!lost) {
    image(images[14], playerPos, 550);
  } else {    
    image(images[14], playerPos-2, 550);    
    lostCycle--;
    if (lostCycle == 0 && !over) lost = false;
  }
  //-->

  //Verifica se houve danos nas proteções.
  for (int i = 0; i < 12; i++) {
    if (blocIs[i]) {
      image(images[6+blocs[i].getDamages()], blocs[i].getX(), blocs[i].getY());
      if (!over && tir && tirX < blocs[i].getX()+12 && tirX+2 > blocs[i].getX() && tirY < blocs[i].getY()+12 && tirY+6 > blocs[i].getY()) {
        blocs[i].setDamages(blocs[i].getDamages()+1);
        if (blocs[i].getDamages() > 3) blocIs[i] = false;
        tir = false;
      }
    }
  }
  //-->

  //Testa se alien foram atingidos / Tiro alien
  int c = 0;
  for (int i = 0; i < 55; i++) {

    if (alienIs[i]) {
      c++;        
      if (aliens[i].getExplode() > 0) {//Verifica se inimigo está morto                
        image(images[10], aliens[i].getX(), aliens[i].getY());        
        aliens[i].setExplode(aliens[i].getExplode()-1);        
        if (aliens[i].getExplode() == 0) alienIs[i] = false;
      } else {
        image(images[aliens[i].getType()*2+cyclePos], aliens[i].getX(), aliens[i].getY());        
        int size = 24;
        if (aliens[i].getType() == 1) size = 22;
        if (aliens[i].getType() == 2) size = 16;
        if (!over && tir && tirX < aliens[i].getX()+size && tirX+2 > aliens[i].getX() && tirY < aliens[i].getY()+16 && tirY+6 > aliens[i].getY()) {//Verifica se tiro acertou inimigo
          aliens[i].explode();
          if (aliens[i].getType() == 0) score+=10;
          else if (aliens[i].getType() == 1) score+=20;
          else score+=40;
          tir = false;
        }        
        if (!over && random(1000) < speedShotAlien) {//Tiro alien
          int ind = 0;          
          while (tirIs[ind]) ind++;
          tirs[ind] = new shot(aliens[i].getX()+size/2-1, aliens[i].getY()+16);
          tirIs[ind] = true;
        }
      }
    }
  }
  //-->

  //Se não houver mais alien gera mais / Aumeta nivel de dificuldade.
  if (c == 0) {    
    ali.setupAliens();
    if (cycleSpeed <= 0) {
      cycleSpeed += 40;
      speedShotAlien = 1;
      aliensRight = true;
    } else {
      cycleSpeed -= 10; //Velocidade dos alien
      speedShotAlien += 0.5; //Velocidade dos tiros alien
      aliensRight = true;
    }
  }
  //-->

  for (int i = 0; i < 100; i++) {
    if (tirIs[i]) {
      image(images[15+tirs[i].getTex()], tirs[i].getX(), tirs[i].getY());     
      tirs[i].setTex(tirs[i].getTex()+1);       
      if (tirs[i].getTex() > 2) tirs[i].setTex(0);
      tirs[i].setY(tirs[i].getY()+6);
      if (tirs[i].getY() > 590) tirIs[i] = false;
      for (int j = 0; j < 12; j++) {//Testa se tiro alien acertou proteção
        if (blocIs[j]) {
          if (tirs[i].getX() < blocs[j].getX()+12 && tirs[i].getX()+6 > blocs[j].getX() && tirs[i].getY() < blocs[j].getY()+12 && tirs[i].getY()+10 > blocs[j].getY()) {
            blocs[j].setDamages(blocs[j].getDamages()+1);
            if (blocs[j].getDamages() > 3) blocIs[j] = false;
            tirIs[i] = false;
          }
        }
      }
      if (!over && !lost && tirs[i].getX() < playerPos+26 && tirs[i].getX()+6 > playerPos && tirs[i].getY() < 564 && tirs[i].getY()+10 > 550) {//Verifica se tiro alien acertou jogador
        lost = true;
        lostCycle = 60;
        lives--;
        if (lives == 0) {
          over = true;
          if (score > best) {
            String d[] = {Integer.toString(score)};
            saveStrings("score.txt", d);
            best = score;
          }
        }
        tirIs[i] = false;
      }
    }
  }

  ///Movimentação aliens
  cycle++;

  if (cycle > cycleSpeed) {    
    cycle = 0;
    if (!over) {      
      int delta = -4;
      if (aliensRight) delta = 4;
      for (int i = 0; i < 55; i++) {
        if (alienIs[i]) {
          aliens[i].setX(aliens[i].getX()+delta);
        }
      }
      alienPosX+=delta;
      if (aliensRight && alienPosX >= 250) {
        downIterations++;        
        aliensRight = false;
        for (int i = 0; i < 55; i++) {
          if (alienIs[i]) {
            aliens[i].setY(aliens[i].getY()+8);
          }
        }
      }

      if (!aliensRight && alienPosX <= 20) {        
        downIterations++;
        aliensRight = true;
        for (int i = 0; i < 55; i++) {
          if (alienIs[i]) {
            aliens[i].setY(aliens[i].getY()+8);
          }
        }
      }      

      if (downIterations > 57) {
        downIterations = 0;
        for (int i = 0; i < 55; i++) {
          if (alienIs[i]) {
            aliens[i].setY(aliens[i].getY()-4*57);
          }
        }
      }
    }
    cyclePos++;
    if (cyclePos > 1) cyclePos = 0;
  }

  //Movimenta Jogador
  if (!over && !lost) {
    if (left && playerPos > 30) playerPos-=2;
    if (right && playerPos < width-56) playerPos+=2;

    if (!tir && up) {
      tir = true;
      tirX = playerPos+12;
      tirY = 544;
    }
  }

  //Atira jogador
  if (tir) {
    image(images[13], tirX, tirY);
    tirY-=15; //Velocidade do tiro
    if (tirY < 60) tir = false;
  }

  //Verifica se o jogo terminou exibe a pontuaçao se não exibe informações do jogo pontuação,melhor pontuação e as vidas.
  if (over) {
    fill(0, 200);
    rect(0, 0, width, height);
    textFont(font, 50);
    textAlign(CENTER, CENTER);
    fill(255);
    text("GAME OVER", width/2, height/2);
    textFont(font, 30);
    text("Pontuacao : "+score, width/2, height/2+50);
  } else {
    textFont(font, 20);
    textAlign(LEFT, UP);
    fill(255);
    text("Pontuacao : "+score, 30, 30);
    textAlign(RIGHT, UP);
    text("Melhor : "+max(best, score), width-30, 30);
    for (int i = 0; i < lives; i++) {      
      image(images[14], 250+i*30, 20);
    }
  }
}