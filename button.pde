class Button {
  float x, y;
  float sizeX, sizeY;
  int state;

  color baseCol;
  float nb;
  float sb;
  float pb;

  String str;
  
  PImage img;

  Button(float x, float y, float sizeX, float sizeY, color baseCol, String str) {
    this.x=x;
    this.y=y;
    this.sizeX=sizeX;
    this.sizeY=sizeY;
    this.baseCol=baseCol;
    this.str=str;

    nb=1.0; //normalBrightness
    sb=0.8; //selectBrightness
    pb=0.6; //pushBrightness
  }
  
  Button(float x, float y, PImage img) {
    this.x=x;
    this.y=y;
    this.img=img;
    this.sizeX=img.width;
    this.sizeY=img.height;
  }

  void run() {
    rogic();
    display();
  }

  /*void display() {
    noStroke();
    changeColor();
    rect(x, y, sizeX, sizeY);

    fill(0, 0, 0);
    textSize(30);
    text(str, x+sizeX/2, y+sizeY/2);
  }*/
  
  void display(){
    //changeColor();
    //PImage img = getimg();
    //image(img,x,y);
    switch(state){
      case 0:
        tint(255,126);
        break;
      case 1:
        tint(255,70);
        break;
      case 2:
        tint(255,40);
        break;
      default:
        tint(255,126);
        break;
    }
    //tint(255,126);
    image(img,x,y);
    noTint();
  }

  void rogic() {
    state=checkState();
  }

  //===================================================================
  boolean isPush() {
    if (checkState()==2) return true;
    return false;
  }

  int checkState() {
    if (!checkInMouse()) return 0;
    if (!mousePressed) return 1;
    return 2;
  }

  boolean checkInMouse() {
    if (mouseX>x&&mouseX<x+sizeX) {
      if (mouseY>y&&mouseY<y+sizeY) {
        return true;
      }
    }
    return false;
  }

  /*void changeColor() {
    switch(state) {
    case 0:
      fill(red(baseCol)*nb, green(baseCol)*nb, blue(baseCol)*nb);
      break;

    case 1:
      fill(red(baseCol)*sb, green(baseCol)*sb, blue(baseCol)*sb);
      break;

    case 2:
      fill(red(baseCol)*pb, green(baseCol)*pb, blue(baseCol)*pb);
      break;

    default:
      fill(0, 0, 0);
      break;
    }
  }*/
}
