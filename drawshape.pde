class Drawshape{
  color fine1 = color(0,255,255);
  color fine2 = color(255,20,147);
  color fine3 = color(127,255,0);
  
  color cute1 = color(135,206,250);
  color cute2 = color(221,160,221);
  color cute3 = color(255,215,0);
  
  //ControlP5 cp5;
  //float knobValue;
  //Knob knob;
  //cp5 = new ControlP5(this);
  
  void drawline(AudioPlayer player){
    stroke(fine1);
    for(int i =0; i < player.bufferSize() -1; i++){
      float x1 = map(i,0,player.bufferSize(),0,width);
      float x2 = map(i+3, 0,player.bufferSize(),0,width);
      float y1 = height / 3;
      float y2 = height / 3 * 2;
      line( x1,y1+player.left.get(i)*100,x2,y1+player.left.get(i+1)*100);
      line( x1,y2+player.right.get(i)*100,x2,y2+player.right.get(i+1)*100);
    }
  }
  
  void drawcircle(AudioPlayer player){
    fill(fine2);
    stroke(fine2);
    float radiusL=player.left.level() * width;
    float radiusR=player.right.level() * width;
    ellipse(width/3, height/2,radiusL,radiusL);
    ellipse(width/3*2,height/2,radiusR,radiusR);
  }
  
  void drawrect(AudioPlayer player){
    float radiusL=player.left.level() * width;
    float radiusR=player.right.level() * width;
    stroke(fine2);
    fill(fine2);
    rect(width/10*2, height/10*2,radiusL,radiusL);
    stroke(255,105,180);
    fill(255,105,180);
    rect(width/10*3,height/10*3,radiusR,radiusR);
    stroke(255,192,203);
    fill(255,192,203);
    rect(width/10*4,height/10*4,radiusR,radiusR);
    stroke(255,228,225);
    fill(255,228,225);
    rect(width/10*5,height/10*5,radiusR,radiusR);
    stroke(255,20,245);
    fill(255,20,245);
    rect(width/10*6,height/10*6,radiusR,radiusR);
  }
  
  void drawwave(AudioPlayer player){
    stroke(fine3);
    fft.forward(player.mix);
    int specSize = fft.specSize();
    
    for (int i = 0; i < specSize; i++){
        // x をスペクトラム幅に応じた位置として取得します
      float x = map(i, 0, specSize, 0, width);
        // fft.getBand(i) で、個別のスペクトラムの値を取得し、
        // 取得した値に応じた線を描きます。
      line(x, height, x, height - fft.getBand(i) * 8);
    }
  }
  
  
}
