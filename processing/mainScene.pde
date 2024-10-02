Timer timer;  

class MainScene {
    UIButton startButton;
    UIButton stopButton;
    
    MainScene() {
        startButton = new UIButton(265, 15, 100, 40, "Start");
        stopButton = new UIButton(365, 15, 100, 40, "Stop");
        stopButton.setDisabled(true); // Stop button initially disabled

        timer = new Timer(); // Initialize the Timer class

        setupGraph();
        setupBarChart();
    }

    void draw() {
        background(220);
        fill(32, 92, 122);
        rect(0, 0, width, .1*height);
        rect(365,50,150,50);
        drawTitle();
        drawBarChart();
        drawGraph();
        timer.drawTimer();  // Display timer using the Timer class
        startButton.draw(); // Draw "Start" button
        stopButton.draw();  // Draw "Stop" button
    }

    void mousePressed() {
        // Handle start button click
        if (startButton.isClicked(mouseX, mouseY)) {
            timer.startTimer();  // Start the timer via the Timer class
            startButton.setDisabled(true);
            stopButton.setDisabled(false);
        }

        // Handle stop button click
        if (stopButton.isClicked(mouseX, mouseY)) {
            timer.stopTimer();  // Stop the timer via the Timer class
            stopButton.setDisabled(true);
            startButton.setDisabled(false);
        }
    }

    void drawTitle() {
        String title = "Heart Rate Monitor";
        fill(255, 255, 255);
        textSize(30);
        text(title, (width - textWidth(title)) / 2, .075 * height);
        fill(0, 408, 612);

    }
}
