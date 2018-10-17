package {

import controller.ControllerManager;

import flash.display.Sprite;
import flash.text.TextField;
[SWF(width=640, height=480, backgroundColor=0x222222, frameRate=60)]
public class Main extends Sprite {
    public function Main() {
        var textField:TextField = new TextField();
        textField.text = "Hello, World";
        addChild(textField);

        var controllerManager:ControllerManager = ControllerManager.getInstance();
        addChild(controllerManager);
    }
}
}
