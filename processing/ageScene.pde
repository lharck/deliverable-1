class TimerScene {
    void dr(){
        String title = "Heart Rate Monitor";
        fill(255,255,255);
        textSize(30);
        text(title, (width-textWidth(title))/2, .075*height); 
        fill(0, 408, 612);
    }

    MainScene() {  
        setupGraph();
        setupBarChart();
        setupTimer();
    } 
 
    void draw(){
        background(220);
        fill(32, 92, 122);
        rect(0, 0, width, .1*height);
        drawTitle();
        drawBarChart();
        drawGraph();
        drawTimer();
    }

}
