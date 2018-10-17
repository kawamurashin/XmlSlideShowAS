package model {
import events.CustomEvent;

import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLRequest;

import model.data.SceneData;
import model.events.ModelEvent;
import model.imageLoader.ImageLoadManager;

public class ModelManager extends EventDispatcher {
    private static var _instance:ModelManager;
    //
    private var _sceneDataList:Array;

    public function ModelManager(block:SingletonBlock) {

    }
    public static function getInstance():ModelManager
    {
        if(_instance == null)
        {
            _instance = new ModelManager(new SingletonBlock());
        }
        return _instance;
    }
    public function loadStart():void
    {
        loadXmlStart();
    }
    private function loadXmlStart():void
    {
        var urlRequest:URLRequest = new URLRequest("data.xml")
        var urlLoader:URLLoader = new URLLoader();
        urlLoader.addEventListener(ErrorEvent.ERROR , errorEventHandler);
        urlLoader.addEventListener(Event.COMPLETE, loadXmlCompleteHandler);
        urlLoader.load(urlRequest);
    }

    private function errorEventHandler(event:ErrorEvent):void {

    }
    private function loadXmlCompleteHandler(event:Event):void
    {
        _sceneDataList = [];
        //
        var xml:XML = new XML(event.target.data);
        var sceneNodeList:XMLList = xml.scenes[0].scene;
        var n:uint = sceneNodeList.length();
        for(var i:uint = 0;i<n;i++)
        {
            var sceneNode:XML = sceneNodeList[i];
            var sceneData:SceneData = new SceneData();
            sceneData.setXml(sceneNode);
            //
            _sceneDataList.push(sceneData);
        }

        var imageLoadManager:ImageLoadManager = new ImageLoadManager();
        imageLoadManager.loadStart();
        imageLoadManager.addEventListener(ModelEvent.Image_LOADCOMPLETE ,imageLoadCompleteHandler)
    }

    private function imageLoadCompleteHandler(event:ModelEvent):void {
        loadComplete();
    }


    private function loadComplete():void
    {
        var customEvent:CustomEvent = new CustomEvent(CustomEvent.MODEL_LOADCOMPLETE);
        dispatchEvent(customEvent);
    }

    public function get sceneDataList():Array {
        return _sceneDataList;
    }
}
}
class SingletonBlock{

}