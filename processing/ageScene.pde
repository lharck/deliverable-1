class AgeScene {
    UIButton inputButton;

    AgeScene() {  
        inputButton = new UIButton(50, 50, 100, 40, "Click Me");

        // initalizing stuff goes here
    } 
    
 
    void draw(){
        background(0);
        inputButton.draw();        
        // anything you want to draw goes here
       
    }

}
