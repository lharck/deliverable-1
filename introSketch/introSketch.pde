import processing.serial.*;
import org.gicentre.utils.stat.*;

Serial myPort;

void setup(){
    size(500, 500);
    //String whichPort = Serial.list()[0];
    //myPort = new Serial(this, whichPort, 115200);
    
    setupGraph();
}

void readSerial(){
  while (myPort.available() > 0) {
    int inByte = myPort.read();
    println(inByte);
  }
}

void drawTitle(){
  textSize(30);
  text("Processing Sample Graph", 0, 20); 
  fill(0, 408, 612);
}

void draw(){
  background(51);
  
  drawTitle();
  drawGraph();
  //readSerial();
}
