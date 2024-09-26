import processing.serial.*;
import org.gicentre.utils.stat.*;

MainScene mainScene;

// maybe make Scene class eventually which can hold both scene instances;
// so we can do currentScene.draw()
String currentScene = "MainScene";

void setup(){
    size(500, 600);
    
    mainScene = new MainScene();
}

void draw(){
    if(currentScene == "MainScene") {
        mainScene.draw();   
    }
    
    delay(100);
}
