import javax.swing.*;
import ddf.minim.analysis.*;
import ddf.minim.*;
import controlP5.*;

Audio audio1 = new Audio();
Audio audio2 = new Audio();
Button btnplayboth, btnpauseboth, btnstopboth;

Minim minim;
FFT fft;
Keyinst keyinst = new Keyinst();
Drawshape draw = new Drawshape();
ParticleSystem ps;
ControlP5 cp5;
float knobValue1, knobValue2;
Knob knob1, knob2;

int fftSize;


void setup()
{
size(1200, 700, P2D);
minim=new Minim(this);
//textAlign(CENTER, CENTER);

//ボタン作成
audio1.makeButton(0);
audio2.makeButton(1200-64);
btnplayboth = new Button(width/2-64,700-64,loadImage("play.png"));
btnpauseboth = new Button(width/2-64,700-64,loadImage("pause.png"));
btnstopboth = new Button(width/2,700-64,loadImage("stop.png"));

//fft = new FFT(player.bufferSize(), player.sampleRate());

keyinst.setup();
ps = new ParticleSystem(new PVector(width/2, 50));

//つまみbase
cp5 = new ControlP5(this);
knob1 = cp5.addKnob("knobValue1")
           .setLabel("volume1")
           .setRange(-25, 25)
           .setValue(0)
           .setPosition(20, 600)
           .setRadius(50);
//つまみplus
knob2 = cp5.addKnob("knobValue2")
           .setLabel("volume2")
           .setRange(-25, 25)
           .setValue(0)
           .setPosition(1080, 600)
           .setRadius(50);
           
cp5.addKnob("attack")
       .setRange(0.01, 0.5)
       .setValue(0.25)
       .setPosition(width / 5.0 * 1.0 - knobRadius, height / 3.0 * 1.0 - knobRadius)
       .setRadius(knobRadius);
cp5.addKnob("decay")
   .setRange(0.01, 0.5)
   .setValue(0.25)
   .setPosition(width / 5.0 * 2.0 - knobRadius, height / 3.0 * 1.0 - knobRadius)
   .setRadius(knobRadius);
cp5.addKnob("sustain")
   .setRange(0.0, 1.0)
   .setValue(0.5)
   .setPosition(width / 5.0 * 3.0 - knobRadius, height / 3.0 * 1.0 - knobRadius)
   .setRadius(knobRadius);
cp5.addKnob("release")
   .setRange(0.01, 0.5)
   .setValue(0.25)
   .setPosition(width / 5.0 * 4.0 - knobRadius, height / 3.0 * 1.0 - knobRadius)
   .setRadius(knobRadius);    

background(255);
fill(0);

}

void draw()
{
  
//一時停止されていなければ画面を更新
if(audio1.pause != 2 || audio2.pause != 2) {
  fill(0);
  rect(0,0,1200,700);
}

//スピーカー
fill(29, 49, 86);
stroke(29, 49, 86);
rect(200, 300, 250, 500);
rect(750, 300, 250, 500);

//Audio1の音を描画
if(audio1.pause != 2) {
  if(audio1.player!=null){
    
    //音量調節base
  audio1.player.setGain(knobValue1);
    
  //音量の可視化
  float radiusLV1 = audio1.player.left.level() * 650 ;//左側の音量
  float radiusRV1 = audio1.player.right.level() * 650 ;//右側の音量
  stroke(255);
  strokeWeight(2);
  fill(29, 49, 86, 200);
  ellipse(325, 600, radiusLV1, radiusLV1);
  ellipse(1200-325, 600, radiusRV1, radiusRV1);
  
  //draw.drawline(audio1.player);
  //draw.drawcircle(audio1.player);
  draw.drawrect(audio1.player);
  //draw.drawwave(audio1.player);
  ps.addParticle();
  ps.run();
  }

}

//Audio2の音を描画
if(audio2.pause != 2) {
  if(audio2.player!=null){
  //音量調節
  audio2.player.setGain(knobValue2);
  
  //音量の可視化
  float radiusLV2 = audio2.player.left.level() * 650 ;//左側の音量
  float radiusRV2 = audio2.player.right.level() * 650 ;//右側の音量
  stroke(255);
  strokeWeight(2);
  fill(29, 49, 86, 200);
  ellipse(325, 400, radiusLV2/1.5, radiusLV2/1.5);
  ellipse(1200-325, 400, radiusRV2/1.5, radiusRV2/1.5);
  
  draw.drawline(audio2.player);
  ps.addParticle();
  ps.run();  
  
  //draw.drawcircle(audio2.player);
  //draw.drawrect(audio2.player);
  //draw.drawwave(audio2.player);
  }
}

//キーボードからの音を描画
keyinst.draw();

//Audio1のファイルが選択されていたら表示
audio1.writeFileName(70,32);
//Audio2のファイルが選択されていたら表示
audio2.writeFileName(1000,32);

//ボタンを表示
audio1.setButton();
audio2.setButton();
if(audio1.pause!=1 || audio2.pause!=1) btnplayboth.run();
else btnpauseboth.run();
btnstopboth.run();

}

//ボタンが押された時の処理
void mousePressed() {
  audio1.buttonPressed();
  audio2.buttonPressed();
  //playbothボタンが押されたら両方を再生
  if(btnplayboth.isPush()){
    if(audio1.getFile!=null && audio1.pause !=1 && audio2.getFile!=null && audio2.pause !=1) {
      audio1.fileLoader();
      audio2.fileLoader();
      audio1.playingtitle = audio1.choosetitle;
      audio2.playingtitle = audio2.choosetitle;
      audio1.pause = 1;
      audio2.pause = 1;
    }
    else if(audio1.player!=null && audio2.player!=null){
      audio1.player.pause();
      audio2.player.pause();
      audio1.playingtitle = audio1.choosetitle;
      audio2.playingtitle = audio2.choosetitle;
      audio1.pause = 2;
      audio2.pause = 2;
    }
  }
    
  if(btnstopboth.isPush()) {
    if(audio1.player!=null && audio2.player!=null){   
      audio1.player.close();
      audio2.player.close();
      audio1.player=null;
      audio2.player=null;
      audio1.pause=0;
      audio2.pause=0;
      audio1.playingtitle="";
      audio2.playingtitle="";
    }
    
  }
  
}

void keyPressed(){
  keyinst.setpitch();
}
