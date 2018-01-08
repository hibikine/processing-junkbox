import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer jingle;
FFT         fft;
int bands = 1024;
float[] output = new float[bands];
float[] spectrum = new float[bands];

int ringSize = 3;
int ringNum = 20;
float[] ring = new float[ringSize*ringNum];

void setup() {
  size(640, 360);
  minim = new Minim(this);
  jingle = minim.loadFile("sample.mp3", bands);
  jingle.loop();
  fft = new FFT( jingle.bufferSize(), jingle.sampleRate() );
  background(255);
  colorMode(HSB, 255, 255, 255);

}      
float d = 0.0;
void draw() {
  d+=0.01;
  background(255);
  color(0);
  stroke(0);
  fft.forward( jingle.mix );
  for(int i = 0; i < fft.specSize(); ++i){
    output[i] = (output[i] + fft.getBand(i) / 10) / 1.1;
    //line(i, height, i, height - output[i] * height / 20);
  }
  pushMatrix();
  strokeWeight(height/100);
  translate(width/2, height/2);
  for(int i = 0; i< ringSize; i++) {
    float space = height/10;
    float r = (height/2-space)*(i*2+1)/(ringSize*2);
    fill(color(255*i/ringSize, 255, 255));
    pushMatrix();
    for(int j = 0; j < ringNum; j++) {
      rotate(PI*2.0/ringNum+d);
      pushMatrix();
      translate(r,0);
      scale(output[bands*i*j/ringSize/ringNum]);
      popMatrix();
    }
    popMatrix();
  }
  popMatrix();
}