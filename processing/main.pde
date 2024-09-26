import processing.serial.*;
import org.gicentre.utils.stat.*;

MainScene mainScene;
AgeScene ageScene;


// maybe make Scene class eventually which can hold both scene instances;
// so we can do currentScene.draw()
String currentScene = "AgeScene";

void setup(){
    size(500, 600);
    
    mainScene = new MainScene();
    ageScene = new AgeScene();
}

void draw(){
    if(currentScene == "MainScene") {
        mainScene.draw();   
    }
    else if(currentScene == "AgeScene"){
        ageScene.draw();
    }
    
    delay(100);
}
