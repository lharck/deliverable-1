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
        if(!startedReading){
           startedReading = true;
           println("*******started reading sensor data*****");
        }
    } 
    else {
        if(startedReading){
            int spaceIdx = lineString.indexOf(" ");
            String property = lineString.substring(0,spaceIdx-1);
            int value = int(lineString.substring(spaceIdx+1, lineString.length()));
            sensorData.set(property, value);
        }
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
    String title = "Heart Rate Monitor";
    textSize(30);
    text(title, (width-textWidth(title))/2, 30); 
    fill(0, 408, 612);
}

void drawProperties(){
    textSize(20);
    
    String[] properties = sensorData.keyArray();
    
    for (int i = 0; i < properties.length; i++) {
        String propertyName = properties[i];
        text(propertyName + ": " + sensorData.get(propertyName), 0, 30+(20*i));
    }
}

void draw(){
    background(51);
    drawTitle();

    //drawGrap?h();
    //readSerial();
    
    delay(100);
}
