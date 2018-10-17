package view {

import flash.display.Sprite;
import flash.events.Event;

public class ViewManager extends Sprite {
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

    }

    public function loadComplete():void {

    }
}
}