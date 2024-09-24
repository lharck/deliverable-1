XYChart lineChart;

FloatList lineChartX;
FloatList lineChartY;

void setupGraph(){
  lineChart = new XYChart(this);
  
  //lineChartX = new FloatList();
  //lineChartY = new FloatList();

  ////lineChartX.append(10.0);
  ////lineChartX.append(20.0);
  
  ////lineChartY.append(30.0);
  ////lineChartY.append(5.0);
  lineChart.setData(new float[]{1,2,3}, new float[]{1,2,3});
  
  
  
  // Axis formatting and labels.
  lineChart.showXAxis(true); 
  lineChart.showYAxis(true); 
  lineChart.setMinY(0);
     
  //lineChart.setYFormat("$###,###");  // Monetary value in $US
  //lineChart.setXFormat("0000");      // Year
   
  // Symbol colours
  lineChart.setPointColour(color(180,50,50,100));
  lineChart.setPointSize(5);
  lineChart.setLineWidth(2);
}

void drawGraph(){
    textSize(20);
    lineChart.draw(width/4,height/4, width/2, height/2);
}
