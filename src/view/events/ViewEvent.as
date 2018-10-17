package view.events {
import flash.events.Event;

public class ViewEvent extends Event {
    public static const SCENE_COMPLETE:String = "scene_complete";

    public function ViewEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);

    }

    public override function clone():Event {
        return new ViewEvent(type, bubbles, cancelable);
    }

    public override function toString():String {
        return formatToString("ViewEvent", "type", "bubbles", "cancelable", "eventPhase");
    }

}
}