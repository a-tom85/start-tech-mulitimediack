import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import controlP5.*;



AudioOutput out;
ControlP5 ctrlp5;
  color fine2;
  float circlex, circley;
  float attack, decay, sustain, release;
  float knobRadius = 40;


class Keyinst{
  //AudioOutput out;

  
  
  void setup(){
    out = minim.getLineOut();
  }
  
  void draw(){
    fill(fine2);
    stroke(fine2);
    strokeWeight(10);
    float radiusL=out.left.level() * width/3;
    line(circlex-radiusL/2,circley,circlex+radiusL/2,circley);
    line(circlex,circley-radiusL/2,circlex,circley+radiusL/2);
    line(circlex-radiusL/2.8,circley-radiusL/2.8,circlex+radiusL/2.8,circley+radiusL/2.8);
    line(circlex-radiusL/2.8,circley+radiusL/2.8,circlex+radiusL/2.8,circley-radiusL/2.8);
  }
  
  void setpitch(){
    String pitchName = "";
  switch(key){
  case 'z':
    pitchName += "C4"; break;
  case 's':
    pitchName += "C#4"; break;
  case 'x':
    pitchName += "D4"; break;
  case 'd':
    pitchName += "D#4"; break;
  case 'c':
    pitchName += "E4"; break;
  case 'v':
    pitchName += "F4"; break;
  case 'g':
    pitchName += "F#4"; break;
  case 'b':
    pitchName += "G4"; break;
  case 'h':
    pitchName += "G#4"; break;
  case 'n':
    pitchName += "A4"; break;
  case 'j':
    pitchName += "A#4"; break;
  case 'm':
    pitchName += "B4"; break;
  case ',':
    pitchName += "C5"; break;
  case 'l':
    pitchName += "C#5"; break;
  case '.':
    pitchName += "D5"; break;
  case ';':
    pitchName += "D#5"; break;
  case '/':
    pitchName += "E5"; break;
  case '_':
    pitchName += "F5"; break;
  }
  if(pitchName != ""){
    out.playNote(0.0, 0.2, new Keyboard(Frequency.ofPitch(pitchName).asHz()));
    fine2 = color(random(255),random(255),random(255));
    circlex = random(width-150);
    circley = random(height);
  }
  }
  
}

class Keyboard implements Instrument {
  Oscil osc;
  ADSR adsr;
  
  Keyboard(float pitch){
    osc = new Oscil(pitch, 1.0, Waves.TRIANGLE);
    adsr = new ADSR(1.0, attack, decay, sustain, release);
    osc.patch(adsr);
  }
  
  void noteOn(float duration){
    adsr.noteOn();
    adsr.patch(out);   
  }
  
  void noteOff(){
     adsr.unpatchAfterRelease(out);
    adsr.noteOff();

  }
  
}
