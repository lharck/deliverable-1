Timer timer;  

class MainScene {
    UIButton fitnessButton;
    UIButton stopButton;
    UIButton calmButton;   // Button for Calm Mode
    UIButton stressedButton;  // Button for Stressed Mode
    boolean isCalmMode = false;
    boolean isStressedMode = false;
    
    MainScene() {
        fitnessButton = new UIButton(90, 30, 120, 40, "Fitness Mode");
        stopButton = new UIButton(480, 30, 100, 40, "Stop");
        calmButton = new UIButton(220, 30, 120, 40, "Calm Mode");
        stressedButton = new UIButton(350, 30, 120, 40, "Stressed Mode");
        stopButton.setDisabled(true); // Stop button initially disabled

        timer = new Timer(); // Initialize the Timer class

        setupGraph();
        setupBarChart();
    }
    
    void showAverageHeartRate(){
        if(!sensorData.hasKey("Heartrate")) { return; }
        println("hi");
        int currentHeartRate = sensorData.get("Heartrate");
        
        text("Average Heart Rate: " + getAverageHeartRate(), .8*width, .125 * height);
        text("Current Heart Rate: " + currentHeartRate, .8*(width), .225 * height);
    }

    void draw() {
        background(220);
        fill(32, 92, 122);
        rect(0, 0, width, .1*height);
        drawTitle();
        drawBarChart();
        drawGraph();
        timer.drawTimer();  // Display timer using the Timer class
        fitnessButton.draw();   // Draw Start button
        stopButton.draw();    // Draw Stop button
        calmButton.draw();    // Draw Calm Mode button
        stressedButton.draw(); // Draw Stressed Mode button
        //showAverageHeartRate();
    }

    void mousePressed() {
        // Start fitness mode
        if (fitnessButton.isClicked(mouseX, mouseY)) {
            startFitnessMode();
            
        }
        
        // Stop modes
        if (stopButton.isClicked(mouseX, mouseY)) {
            timer.stopTimer();
            stopButton.setDisabled(true);
            fitnessButton.setDisabled(false);
            calmButton.setDisabled(false);
            stressedButton.setDisabled(false);
        }
        
        // Start Calm Mode
        if (calmButton.isClicked(mouseX, mouseY)) {
            startCalmMode();
        }
        
        // Start Stressed Mode
        if (stressedButton.isClicked(mouseX, mouseY)) {
            startStressedMode();
        }

    }

    void drawTitle() {
        String title1 = "Heart Rate Monitor";
        fill(32, 92, 122);
        textSize(30);
        text(title1, (width - textWidth(title1)) / 2, .480 * height);
        String title2 = "Exercise Zones";
        fill(32, 92, 122);
        textSize(30);
        text(title2, (width - textWidth(title2)) / 2, .125 * height);
    }
    
    // Method to handle fitness mode
    void startFitnessMode() {
        timer.startTimer();  // Track time
        fitnessButton.setDisabled(true);
        stopButton.setDisabled(false);
        calmButton.setDisabled(false);
        stressedButton.setDisabled(false);
        isCalmMode = false;  // Ensure calm mode is off
        isStressedMode = false;  // Ensure stressed mode is off
        
    }
    
    // Method to handle calm mode
    void startCalmMode() {
        isCalmMode = true;
        isStressedMode = false;
        timer.startTimer();  // Track time
        calmButton.setDisabled(true);
        stopButton.setDisabled(false);
        fitnessButton.setDisabled(false);
        stressedButton.setDisabled(false);
        
    }
    
    // Method to handle stressed mode
    void startStressedMode() {
        isStressedMode = true;
        isCalmMode = false;
        timer.startTimer();  // Track time
        stressedButton.setDisabled(true);
        stopButton.setDisabled(false);
        fitnessButton.setDisabled(false);
        calmButton.setDisabled(false);
        
    }

}
