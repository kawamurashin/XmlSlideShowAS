package model.events {
import flash.events.Event;

public class ModelEvent extends Event {

    public static const Image_LOADCOMPLETE:String = "image_loadcomplete";
    public function ModelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);

    }

    public override function clone():Event {
        return new ModelEvent(type, bubbles, cancelable);
    }

    public override function toString():String {
        return formatToString("ModelEvent", "type", "bubbles", "cancelable", "eventPhase");
    }

}
}