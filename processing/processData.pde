Serial myPort;
IntDict sensorData;
String lineString = "";
int avgHeartRate = -1;
int restingHeartRate = -1;
FloatList heartRateValues;
Boolean startedReading = true;

FloatList restingHeartRateValues; // List to store low heart rate values for resting heart rate calculation

void setupData() {
    String whichPort = Serial.list()[0];
    myPort = new Serial(this, whichPort, 115200);
    sensorData = new IntDict();    
    heartRateValues = new FloatList();
    restingHeartRateValues = new FloatList();
}

void parseLine() {
    lineString = lineString.trim();
              
    if(lineString.equals("x")) {
        if(!startedReading){
           startedReading = true;
           println("*******started reading sensor data*****");
        }
    } 
    else {
        if(startedReading) {
            println(lineString);
            int spaceIdx = lineString.indexOf(" ");
            if(spaceIdx < 0) { return; }
            String property = lineString.substring(0, spaceIdx-1);
            int value = int(lineString.substring(spaceIdx + 1, lineString.length()));
            sensorData.set(property, value);
        }
    }
}

void readSerial() {
    while (myPort.available() > 0) {
        int byteRead = myPort.read();
          
        if (char(byteRead) == '\n') {
            parseLine();
            lineString = ""; 
        } 
        else {
            lineString += (char)byteRead; 
        }
    }
}

float getAverageHeartRate() {
    if (heartRateValues.size() == 0) return 0;  // Avoid division by zero
    
    float sumOfValues = 0;
    
    for (float hrVal : heartRateValues) {
        sumOfValues += hrVal;
    }
    
    return sumOfValues / heartRateValues.size();  // Calculate the average heart rate
}

void calculateRestingHeartRate() {
    if (heartRateValues.size() == 0) return;  // Avoid empty list

    // Select the lowest 10% of heart rate values (or you can choose another threshold)
    int numLowValues = max(1, int(heartRateValues.size() * 0.1));  // Ensure at least one value is selected
    
    // Sort heartRateValues and pick the lowest values for resting heart rate
    FloatList sortedValues = heartRateValues.copy();
    sortedValues.sort();
    
    restingHeartRateValues.clear();  // Clear any old resting heart rate data
    for (int i = 0; i < numLowValues; i++) {
        restingHeartRateValues.append(sortedValues.get(i));
    }
    
    // Calculate the average of the lowest values to get resting heart rate
    float sumOfRestingValues = 0;
    for (float restHrVal : restingHeartRateValues) {
        sumOfRestingValues += restHrVal;
    }
    
    restingHeartRate = int(sumOfRestingValues / restingHeartRateValues.size());
    println("Resting Heart Rate: " + restingHeartRate);  // Display the resting heart rate
}

void dataLoop() {
    readSerial();  // Continuously read serial data
     
    // Skip resting heart rate calculation if in Fitness or Calm vs Stress Mode
    if (!mainScene.isCalmVsStressMode && !mainScene.fitnessButton.isDisabled()) {
        if (currentState == "CalcHeartRate") {
            if (sensorData.hasKey("Heartrate")) {
                float hrv = sensorData.get("Heartrate");
                heartRateValues.append(hrv);
                avgHeartRate = (int)(getAverageHeartRate());
            }

            // Calculate the resting heart rate if enough data has been collected
            if (heartRateValues.size() >= 10) {  // Ensure at least 10 heart rate values have been collected
                calculateRestingHeartRate();
            }
        }
    }
}
