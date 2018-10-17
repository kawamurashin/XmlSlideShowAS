package model.data {
public class SceneData {
    private var _id:String;
    private var _text:String;
    private var _imageDataList:Array;
    public function SceneData() {
    }
    public function setXml(xml:XML):void
    {
        _id = xml.@["id"];
        _text = xml.text;
        trace(_text)

        _imageDataList = [];
        var childs:XMLList = xml.images[0].image;
        var n:uint = childs.length();
        for(var i:uint = 0;i<n;i++)
        {
            var child:XML = childs[i]
            var imageData:ImageData = new ImageData();
            imageData.setXml(child);

            _imageDataList.push(imageData);
        }

    }

    public function get text():String {
        return _text;
    }

    public function get imageDataList():Array {
        return _imageDataList;
    }
}
}
