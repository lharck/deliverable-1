Serial myPort;
IntDict sensorData;
String lineString = "";
int avgHeartRate = -1;
int restingHeartRate = -1;
FloatList heartRateValues;
Boolean startedReading = true;

void setupData(){
    String whichPort = Serial.list()[0];
    myPort = new Serial(this, whichPort, 115200);
    sensorData = new IntDict();    
    heartRateValues = new FloatList();
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
            println(lineString);
            int spaceIdx = lineString.indexOf(" ");
            if(spaceIdx < 0){return;}
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

float getAverageHeartRate(){
    float sumOfValues = 0;
    
    for(float hrVal : heartRateValues){
        sumOfValues += hrVal;
    }
    
    return sumOfValues/heartRateValues.size();
}


//void drawProperties(){
//    textSize(20);
    
//    String[] properties = sensorData.keyArray();
    
//    for (int i = 0; i < properties.length; i++) {
//        String propertyName = properties[i];
//        text(propertyName + ": " + sensorData.get(propertyName), 0, 30+(20*i));
//    }
//}



void dataLoop(){
     readSerial();
     if(currentState == "CalcHeartRate"){
         float hrv = sensorData.get("Heartrate");
         heartRateValues.append(hrv);
         avgHeartRate = (int)(getAverageHeartRate());
     }
}
