package model.imageLoader {
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.net.URLRequest;

import model.ModelManager;
import model.data.ImageData;
import model.data.SceneData;
import model.events.ModelEvent;

public class ImageLoadManager extends EventDispatcher {
    private var _modelManager:ModelManager;
    //
    private var _sceneCount:uint = 0;
    private var _imageCount:uint = 0;

    public function ImageLoadManager(target:IEventDispatcher = null) {
        super(target);
    }

    public function loadStart():void {
        _modelManager = ModelManager.getInstance();
        initSceneLoad()

    }

    private function initSceneLoad():void {
        _sceneCount = 0;
        setSceneLoad();
    }

    private function setSceneLoad():void {
        //_modelManager.sceneDataList[_sceneCount];
        initImageLoad();
    }

    private function initImageLoad():void {
        _imageCount = 0;
        setImageLoad();
    }

    private function setImageLoad():void {
        //_modelManager.sceneDataList[_sceneCount];
        var path:String = _modelManager.sceneDataList[_sceneCount].imageDataList[_imageCount].path;

        var urlRequest:URLRequest = new URLRequest(path);
        var loader:Loader = new Loader();
        var info:LoaderInfo = loader.contentLoaderInfo;
        info.addEventListener(ErrorEvent.ERROR, errorEventHandler)
        info.addEventListener(Event.COMPLETE, imageLoadCompleteHandler);
        loader.load(urlRequest);

    }

    private function errorEventHandler(event:ErrorEvent):void {
        trace(event);
    }


    private function imageLoadCompleteHandler(event:Event):void {
        var info:LoaderInfo = event.target as LoaderInfo;
        var loader:Loader = info.loader;
        var bitmapData:BitmapData = new BitmapData(loader.width, loader.height, true);
        bitmapData.draw(loader);

        var imageData:ImageData = _modelManager.sceneDataList[_sceneCount].imageDataList[_imageCount];
        imageData.setBitmapData(bitmapData);


        _imageCount++;
        var sceneData:SceneData = _modelManager.sceneDataList[_sceneCount];
        if (_imageCount >= sceneData.imageDataList.length) {
            sceneLoadComplete();
        }
        else {
            setImageLoad();
        }
    }

    private function sceneLoadComplete():void {
        _sceneCount++;
        if (_sceneCount >= _modelManager.sceneDataList.length) {
            loadComplete();
        }
        else {
            setSceneLoad();
        }
    }

    private function loadComplete():void {
        var modelEvent:ModelEvent = new ModelEvent(ModelEvent.Image_LOADCOMPLETE);
        dispatchEvent(modelEvent);
    }
}
}
