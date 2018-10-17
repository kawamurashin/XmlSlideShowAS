package controller {

import events.CustomEvent;

import flash.display.Sprite;
import flash.events.Event;

import model.ModelManager;

import view.ViewManager;

public class ControllerManager extends Sprite {
    private static var _instance:ControllerManager;
    private var _modelManager:ModelManager;
    private var _viewManager:ViewManager;

    public function ControllerManager(block:SingletonBlock):void {
        if (stage) init();
        else addEventListener(Event.ADDED_TO_STAGE, init);
    }

    public static function getInstance():ControllerManager {
        if (_instance == null) {
            _instance = new ControllerManager(new SingletonBlock());
        }
        return _instance;
    }

    private function init(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);
        //entry point
        layout();
    }

    private function layout():void {
        _modelManager = ModelManager.getInstance();
        _modelManager.addEventListener(CustomEvent.MODEL_LOADCOMPLETE, modelLoadCompleteHandler)

        _viewManager = new ViewManager();
        addChild(_viewManager);

        _modelManager.loadStart();
    }

    private function modelLoadCompleteHandler(event:CustomEvent):void {
        _viewManager.loadComplete();

    }
}
}
class SingletonBlock {

}