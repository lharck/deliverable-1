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

color[] zoneColors = {
    color(173, 173, 173),
    color(0, 0, 255),
    color(0, 255, 0),
    color(255,255,0),
    color(255, 0, 0) 
};

int getUserZone(float heartRatePercent){
    for(int i = 0; i < zones.length; i++){
        if (heartRatePercent <= zones[i]){
            return i;
        }
    }
    
    return -1;
}

void drawGraph(){
    if(!startedReading){return;}
    
    if(timer.isRunning) {
        float heartRatePercent = (y/maxHeartRate)*100;
        int userZoneIdx = getUserZone(heartRatePercent);
        
        if(sensorData.hasKey("Heartrate")) {
            x+=1;
            lineChartY.append(sensorData.get("Heartrate"));
            lineChartX.append(x);

        }
        color chosenColor = color(255,255,255);
        
        if (userZoneIdx != -1){
            chosenColor = zoneColors[userZoneIdx];
        }
        
        lineChart.setPointColour(chosenColor);
    
        lineChart.setData(lineChartX.toArray(), lineChartY.toArray());
    } else{
        lineChartX.clear();
        lineChartY.clear();
        x = 0;
        y = 50;
    }
    
    textSize(20);
    lineChart.draw(0.05*width, .5*height, .9 * width, .45*height);
}
