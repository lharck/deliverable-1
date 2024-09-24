import processing.serial.*;
import org.gicentre.utils.stat.*;

Serial myPort;
IntDict sensorData;
String lineString = "";
Boolean startedReading = false; 
int startTime; // Variable to track the start time
String elapsedTime; // String to store the formatted elapsed time
boolean timerStarted = false; // Variable to check if timer started
boolean timerStopped = false; // Variable to check if timer stopped

UIButton startButton;
UIButton stopButton;

void setup(){
    size(500, 500);
    startButton = new UIButton(50, 50, 100, 40, "Start"); //Initialize StartButton
    stopButton = new UIButton(200, 50, 100, 40, "Stop"); //Initialize StopButton
    stopButton.setDisabled(true); // Disable stop button initially
    String whichPort = Serial.list()[0];
    myPort = new Serial(this, whichPort, 115200);
    sensorData = new IntDict();    
    setupGraph();
}

void mousePressed() {
    // Check if start button is clicked
    if (startButton.isClicked(mouseX, mouseY)) {
        startTimer();
    }
    
    // Check if stop button is clicked
    if (stopButton.isClicked(mouseX, mouseY)) {
        stopTimer();
    }
}

void startTimer() {
    startTime = millis();
    timerStarted = true; 
    timerStopped = false; 
    
    stopButton.setDisabled(false); 
    startButton.setDisabled(true); 
}

void stopTimer() {
    timerStopped = true; 
    stopButton.setDisabled(true); 
    startButton.setDisabled(false); 
}

void drawTimer(){
    if(timerStarted && !timerStopped){
        int currentTime = millis() - startTime; // Calculate elapsed time
        elapsedTime = formatTime(currentTime);
    
        textSize(30);
        fill(255);
        text(elapsedTime, (width - textWidth(elapsedTime)) / 2, 120); // Position below buttons
    }
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
    println(sensorData);
    startButton.draw();
    stopButton.draw();
    drawTimer();
    drawTitle();
    drawProperties();
    drawGraph();
    readSerial();
}
