Serial myPort;
IntDict sensorData;
String lineString = "";

void setupData(){
    String whichPort = Serial.list()[0];
    myPort = new Serial(this, whichPort, 115200);
    sensorData = new IntDict();    
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

//void drawProperties(){
//    textSize(20);
    
//    String[] properties = sensorData.keyArray();
    
//    for (int i = 0; i < properties.length; i++) {
//        String propertyName = properties[i];
//        text(propertyName + ": " + sensorData.get(propertyName), 0, 30+(20*i));
//    }
//}

void d(){
     readSerial();
}
