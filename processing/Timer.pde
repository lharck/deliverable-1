Boolean startedReading = false; 
int startTime; // Variable to track the start time
String elapsedTime; // String to store the formatted elapsed time
boolean timerStarted = false; // Variable to check if timer started
boolean timerStopped = false; // Variable to check if timer stopped

UIButton startButton;
UIButton stopButton;
    
void setupTimer(){
    startButton = new UIButton(50, 50, 100, 40, "Start"); //Initialize StartButton
    stopButton = new UIButton(200, 50, 100, 40, "Stop"); //Initialize StopButton   
    stopButton.setDisabled(true); // Disable stop button initially
}

void mousePressed() {
    
    if (startButton.isClicked(mouseX, mouseY)) {
        println("clicked on button");
        currentScene = "MainScene";
    }
    
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
    startButton.draw();
    stopButton.draw();   
    
    if(timerStarted && !timerStopped){
        int currentTime = millis() - startTime; // Calculate elapsed time
        elapsedTime = formatTime(currentTime);
    
        textSize(30);
        fill(255);
        text(elapsedTime, (width - textWidth(elapsedTime)) / 2, 120); // Position below buttons
    }
}
