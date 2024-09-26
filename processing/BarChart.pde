BarChart barChart;

void setupBarChart(){
  println("Hello world");
  
  barChart = new BarChart(this);
  barChart.setData(new float[] {0.76, 0.24, 0.39});
     
  // Scaling
  barChart.setMinValue(0);
  barChart.setMaxValue(1);
   
  // Axis appearance
  textFont(createFont("Serif",10),10);
   
  barChart.showValueAxis(false);
  barChart.setValueFormat("#%");
  barChart.setBarLabels(new String[] {"Peak","Cardio","Fat Burn"});
  barChart.showCategoryAxis(true);
 
  // Bar colours and appearance
  barChart.setBarColour(color(200,80,80,150));
  barChart.setBarGap(4);
   
  // Bar layout
  barChart.transposeAxes(true);
}


void drawBarChart(){
    textSize(20);
    barChart.draw(0.1*width, .1*height, .8 * width, .3*height);
    //barChart.draw(10,(0.20*height),(width-30),(0.30*height)); 
}
