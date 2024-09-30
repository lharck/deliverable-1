class Timer {
    int startTime;           // Variable to track the start time
    String elapsedTime = "00:00"; // String to store the formatted elapsed time
    boolean timerStarted = false; // Variable to check if timer started
    boolean timerStopped = false; // Variable to check if timer stopped

    Timer() {
        // Timer constructor
    }

    // Start the timer and set the initial time
    void startTimer() {
        startTime = millis(); // Record the start time
        timerStarted = true;
        timerStopped = false;
    }

    // Stop the timer
    void stopTimer() {
        timerStopped = true;
    }

    // Draw the timer on the screen, showing elapsed time in MM:SS format
    void drawTimer() {
        if (timerStarted && !timerStopped) {
            int currentTime = millis() - startTime; // Calculate elapsed time
            elapsedTime = formatTime(currentTime);  // Format the time into MM:SS
        }
        textSize(30);
        fill(255);
        text(elapsedTime, 420, 75); // Display the elapsed time
    }

    // Format the elapsed time into MM:SS format
    String formatTime(int milliseconds) {
        int seconds = (milliseconds / 1000) % 60;
        int minutes = (milliseconds / 60000);
        return nf(minutes, 2) + ":" + nf(seconds, 2);
    }
}
