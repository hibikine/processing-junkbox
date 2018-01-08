int t = 0;
void setup(){
  size(640, 480);
  colorMode(HSB, 255,255,255);
}
void draw(){
  background(t++, 255,255);
  t %= 255;
}