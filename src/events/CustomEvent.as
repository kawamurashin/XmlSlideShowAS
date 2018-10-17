package events {
import flash.events.Event;

public class CustomEvent extends Event {

    public static const MODEL_LOADCOMPLETE:String = "model_loadcomplete";
    public function CustomEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);

    }

    public override function clone():Event {
        return new CustomEvent(type, bubbles, cancelable);
    }

    public override function toString():String {
        return formatToString("CustomEvent", "type", "bubbles", "cancelable", "eventPhase");
    }

}
}