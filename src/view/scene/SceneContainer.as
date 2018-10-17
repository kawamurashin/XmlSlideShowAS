package view.scene {

import a24.tween.Ease24;
import a24.tween.Tween24;
import a24.tween.events.Tween24Event;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFormat;

import model.data.ImageData;

import model.data.SceneData;

import view.events.ViewEvent;

public class SceneContainer extends Sprite {

    private var _imageCount:int = -1;
    private var _sceneData:SceneData;

    private var _bitmap:Bitmap;
    private var _removeBitmap:Bitmap;
    private var _backgroundContainer:Sprite;

    public function SceneContainer():void {
        if (stage) init();
        else addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);
        //entry point
        layout();
    }

    public function setSceneData(sceneData:SceneData):void {
        _sceneData = sceneData;
        _imageCount = 0;

        _backgroundContainer = new Sprite();
        addChild(_backgroundContainer);

        var format:TextFormat = new TextFormat();
        format.color = 0xFFFFFF;
        format.size = 64;
        format.bold = true;
        format.font = "Futura PT Book";
        //format.font = "ＭＳ ゴシック";


        var textField:TextField = new TextField();
        addChild(textField);
        textField.defaultTextFormat = format;
        textField.text = sceneData.text;
        textField.width = 600;
        textField.height = 200;
        textField.x = 40;
        textField.embedFonts = false;


    }
    public function startTween():void
    {
        addImage();
    }

    private function addImage():void {
        var imageData:ImageData = _sceneData.imageDataList[_imageCount];
        var bitmapData:BitmapData = imageData.bitmapData;

        _bitmap = new Bitmap(bitmapData);
        _backgroundContainer.addChild(_bitmap);
        setTween();
    }

    private function setTween():void {
        var tween:Tween24;

        if (_removeBitmap) {
            tween = Tween24.parallel(
                    Tween24.prop(_bitmap).x(640),
                    Tween24.parallel(
                            Tween24.tween(_removeBitmap, 1.2, Ease24._3_CubicIn).x(-640),
                            Tween24.tween(_bitmap, 1.2, Ease24._2_QuadOut).x(0).delay(0.8)
                    )
            );

        }
        else {
            tween = Tween24.parallel(
                    Tween24.prop(_bitmap).x(640),
                    Tween24.tween(_bitmap, 1.2, Ease24._2_QuadOut).x(0)
            );
        }
        tween.addEventListener(Tween24Event.COMPLETE, tween24CompleteHandler);
        tween.play();
    }

    private function tween24CompleteHandler(event:Tween24Event):void {
        if(_removeBitmap)
        {
            _backgroundContainer.removeChild(_removeBitmap)
        }
        _removeBitmap = _bitmap;

        _imageCount++;
        if(_imageCount >= _sceneData.imageDataList.length)
        {
            //_imageCount = 0;
            var viewEvent:ViewEvent = new ViewEvent(ViewEvent.SCENE_COMPLETE);
            dispatchEvent(viewEvent);
        }
        else
        {
            addImage();
        }



    }

    private function layout():void {

    }
}
}