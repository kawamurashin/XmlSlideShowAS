package view {

import flash.display.Sprite;
import flash.events.Event;

import view.scene.SceneManager;

public class ViewManager extends Sprite {
    private var _sceneManager:SceneManager;
    public function ViewManager():void {
        if (stage) init();
        else addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);
        //entry point
        layout();
    }

    private function layout():void {
        _sceneManager = new SceneManager();
        addChild(_sceneManager);
    }

    public function loadComplete():void {

        _sceneManager.start();
    }
}
}