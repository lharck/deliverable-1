import processing.serial.*;
import org.gicentre.utils.stat.*;

Serial myPort;
IntDict sensorData;
String lineString = "";
Boolean startedReading = false; 

void setup(){
    size(500, 500);
    String whichPort = Serial.list()[0];
    myPort = new Serial(this, whichPort, 115200);
    sensorData = new IntDict();    
    setupGraph();
}

void parseLine(){
    lineString = lineString.trim();
            
    if(lineString.equals("x")) {
        startedReading = true;
        println("*******started reading sensor data*****");
    } 
    else if(startedReading){
        int spaceIdx = lineString.indexOf(" ");
        String property = lineString.substring(0,spaceIdx-1);
        int value = int(lineString.substring(spaceIdx+1, lineString.length()));
        sensorData.set(property, value);
    }
}

void readSerial(){
    while (myPort.available() > 0) {
        int byteRead = myPort.read();
          
        if (char(byteRead) == '\n') {
            parseLine();
            lineString = ""; 
        } 
        else {
            lineString += (char(byteRead)); 
        }
    }
}

void drawTitle(){
    textSize(30);
    text("Processing Sample Graph", 0, 20); 
    fill(0, 408, 612);
}

void draw(){
    background(51);
    println(sensorData);

    //drawTitle();
    //drawGraph();
    readSerial();
}
