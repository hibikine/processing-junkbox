import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer jingle;
FFT         fft;
int bands = 1024;
float[] output = new float[bands];
float[] spectrum = new float[bands];

int ringSize = 3;
int ringNum = 100;
float[] ring = new float[ringSize*ringNum];

void setup() {
  size(1024, 720);
  minim = new Minim(this);
  jingle = minim.loadFile("sample.mp3", bands);
  jingle.loop();
  fft = new FFT( jingle.bufferSize(), jingle.sampleRate() );
  background(255);
  colorMode(HSB, 255, 255, 255);

}      
float d = 0.0;
void draw() {
  d+=0.001;
  background(230, 250,80);
  color(0);
  stroke(0);
  fft.forward( jingle.mix );
  for(int i = 0; i < fft.specSize(); ++i){
    output[i] = (output[i] + fft.getBand(i) / 10) / 1.1;
    //line(i, height, i, height - output[i] * height / 20);
  }
  pushMatrix();
  strokeCap(SQUARE);
  strokeWeight(height/200);
  translate(width/2, height/2);
  rotate(d);
  for(int i = 0; i< ringSize; i++) {
    float space = height/10;
    float r = (height/2-space)*(i*2+1)/(ringSize*2);
    pushMatrix();
    for(int j = 0; j < ringNum; j++) {
      rotate(PI*2.0/ringNum);
      pushMatrix();
      translate(r,0);
      //scale(log(output[bands*((ringSize-1-i)*ringNum+j)/ringSize/ringNum]+1));
      float val = log(output[((ringSize-1-i)*ringNum+j)]/3+1)*1.5;
      //scale(val);
      stroke(color(255*(i/4.0)/ringSize+180, 100, 255));
      float scl=50;
      line(-height/scl*val, 0, height/scl*val,0);
      popMatrix();
    }
    popMatrix();
  }
  popMatrix();
}