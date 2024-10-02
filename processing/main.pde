import processing.serial.*;
import org.gicentre.utils.stat.*;

MainScene mainScene;
AgeScene ageScene;

// Scene management
String currentScene = "AgeScene"; // Start with AgeScene

void setup() {
    size(720, 820);
    mainScene = new MainScene();
    ageScene = new AgeScene();
    //setupData();
}

void draw() {
    // Switch between scenes
    if (currentScene == "MainScene") {
        mainScene.draw();
    } else if (currentScene == "AgeScene") {
        ageScene.draw();
    }
    
    //dataLoop();
}

// Ensure you only handle mouse clicks in the current scene
void mousePressed() {
    if (currentScene == "AgeScene") {
        ageScene.mousePressed();
    } else if (currentScene == "MainScene") {
        mainScene.mousePressed();
    }
}

void keyPressed() {
    if (currentScene == "AgeScene") {
        ageScene.keyPressed();
    }
}
