package view.scene {

import a24.tween.Ease24;
import a24.tween.Tween24;
import a24.tween.events.Tween24Event;

import flash.display.Sprite;
import flash.events.Event;

import model.ModelManager;
import model.data.SceneData;

import view.events.ViewEvent;

public class SceneManager extends Sprite {
    private var _count:int = -1;
    private var _modelManager:ModelManager;
    private var _sceneContainer:SceneContainer;
    private var _removeSceneContainer:SceneContainer;

    public function SceneManager():void {
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

    public function start():void {
        _count = 0;
        _modelManager = ModelManager.getInstance();

        addScene();
    }

    private function addScene():void {
        var sceneData:SceneData = _modelManager.sceneDataList[_count];
        _sceneContainer = new SceneContainer();
        _sceneContainer.setSceneData(sceneData);
        _sceneContainer.addEventListener(ViewEvent.SCENE_COMPLETE, viewEventCompleteHandler)
        addChild(_sceneContainer);

        setTween();
    }

    private function viewEventCompleteHandler(event:ViewEvent):void {
        nextScene();
    }

    private function setTween():void {
        var tween:Tween24;

        if (_removeSceneContainer) {
            tween = Tween24.parallel(
                    Tween24.prop(_sceneContainer).y(-480),
                    Tween24.parallel(
                            Tween24.tween(_removeSceneContainer, 1.2, Ease24._3_CubicIn).y(-640),
                            Tween24.tween(_sceneContainer, 1.2, Ease24._2_QuadOut).y(0).delay(0.8)
                    )
            );
        }
        else {
            tween = Tween24.parallel(
                    Tween24.prop(_sceneContainer).y(-480),
                    Tween24.tween(_sceneContainer, 1.2, Ease24._2_QuadOut).y(0)
            );

        }
        tween.addEventListener(Tween24Event.COMPLETE, tween24CompleteHandler);
        tween.play();
    }

    private function tween24CompleteHandler(event:Tween24Event):void {
        _sceneContainer.startTween();

        if (_removeSceneContainer) {
            removeChild(_removeSceneContainer)
        }
        _removeSceneContainer = _sceneContainer;
    }

    private function nextScene():void {
        _count++;
        if (_count >= _modelManager.sceneDataList.length) {
            _count = 0;
        }
        addScene();
    }
}
}