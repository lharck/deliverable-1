XYChart lineChart;
FloatList lineChartX;
FloatList lineChartY;
import org.gicentre.utils.colour.ColourTable;
ColourTable cTable;

int x = 0;
int y = 50;

void setupGraph(){
  lineChart = new XYChart(this);
  lineChartX = new FloatList();
  lineChartY = new FloatList();
  
  lineChart.showXAxis(true); 
  lineChart.showYAxis(true); 
  lineChart.setMaxY(maxHeartRate);
  lineChart.setMinY(0);
  lineChart.setMinX(x);
  lineChart.setXAxisLabel("time");
  lineChart.setYAxisLabel("heart rate");
  
  cTable = new ColourTable();
  
  cTable.addContinuousColourRule(0,255,0,0);
  //cTable.addColor(0.5, color(255, 255, 0));
  //cTable.addColor(1, color(0, 255, 0));
   
  // Symbol colors
  lineChart.setPointSize(5);
  lineChart.setLineWidth(2);
}



void drawGraph(){
    if(!startedReading){return;}
    
    if(timer.isRunning) {
        float heartRatePercent = (y/maxHeartRate) * 100;
        
        if(sensorData.hasKey("Heartrate")) {
            float currentHeartRate = sensorData.get("Heartrate");
            x += 1;
            lineChartY.append(currentHeartRate);
            lineChartX.append(x);

            color chosenColor = color(0, 255, 0);  // Default to green

            if (currentHeartRate > 130) {
                // Gradient from orange t red
                float ratio = map(currentHeartRate, 130, maxHeartRate, 0, 1);
                chosenColor = lerpColor(color(255, 165, 0), color(255, 0, 0), ratio);
            } else if (currentHeartRate > 100) {
                // Gradient from yellow to orange
                float ratio = map(currentHeartRate, 100, 130, 0, 1);
                chosenColor = lerpColor(color(255, 255, 0), color(255, 165, 0), ratio);
            } else {
                // Green for below 100 bpm
                chosenColor = color(0, 255, 0);
            }

            lineChart.setPointColour(chosenColor);
        }

        lineChart.setData(lineChartX.toArray(), lineChartY.toArray());
        lineChart.setLineColour(color(255, 0, 0));  // Set default line color (e.g., red)

    } else {
        // Reset the graph when the timer stops
        lineChartX.clear();
        lineChartY.clear();
        x = 0;
        y = 50;
    }
    
    textSize(20);
    lineChart.draw(0.05 * width, 0.5 * height, 0.9 * width, 0.45 * height);
}
